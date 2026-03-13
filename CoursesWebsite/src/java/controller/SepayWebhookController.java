package controller;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import model.PaymentDAO;
import model.PaymentDTO;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.stream.Collectors;

/**
 * Nhận webhook từ SePay khi có giao dịch vào TK VietinBank.
 *
 * URL mapping (web.xml): /sepay-webhook
 *
 * SePay POST body (JSON):
 * {
 *   "id": 12345,
 *   "gateway": "VietinBank",
 *   "transactionDate": "2026-03-13 10:00:00",
 *   "accountNumber": "106879806456",
 *   "code": "NAP TIEN DUK QR27",        ← nội dung chuyển khoản
 *   "content": "NAP TIEN DUK QR27",
 *   "transferType": "in",
 *   "transferAmount": 100000,
 *   "accumulated": 100000,
 *   "referenceCode": "FT26072...",
 *   "description": "..."
 * }
 */
public class SepayWebhookController extends HttpServlet {

    // ── Lấy từ SePay Dashboard → Webhook → API Token ──────────────────
    private static final String SEPAY_API_TOKEN = "DUKAcademy2026@secret";
    // ──────────────────────────────────────────────────────────────────

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();

        // 1. Xác thực token từ header Authorization
        String authHeader = request.getHeader("Authorization");
        if (authHeader == null || !authHeader.equals("Apikey " + SEPAY_API_TOKEN)) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            out.print("{\"error\": 1, \"message\": \"Unauthorized\"}");
            return;
        }

        // 2. Đọc body JSON
        String body = request.getReader().lines().collect(Collectors.joining());
        System.out.println("[SePay Webhook] Body: " + body);

        try {
            JsonObject json = JsonParser.parseString(body).getAsJsonObject();

            // 3. Chỉ xử lý giao dịch TIỀN VÀO
            String transferType = getStr(json, "transferType");
            if (!"in".equals(transferType)) {
                out.print("{\"error\": 0, \"message\": \"Ignored (not transfer in)\"}");
                return;
            }

            // 4. Parse nội dung chuyển khoản → tìm orderId
            // Nội dung mẫu: "NAP TIEN DUK QR27" hoặc có thể có thêm ký tự
            String content = getStr(json, "content");
            if (content == null) content = getStr(json, "description");
            String orderId = extractOrderId(content);

            if (orderId == null) {
                // Giao dịch không liên quan đến DUK Academy
                out.print("{\"error\": 0, \"message\": \"No matching order\"}");
                return;
            }

            // 5. Lấy paymentId từ orderId (QR27 → 27)
            int paymentId = Integer.parseInt(orderId.substring(2));
            PaymentDTO payment = PaymentDAO.getById(paymentId);

            if (payment == null) {
                out.print("{\"error\": 1, \"message\": \"Payment not found: " + orderId + "\"}");
                return;
            }

            // 6. Kiểm tra trạng thái — tránh xử lý 2 lần
            String status = payment.getPaymentStatus();
            if ("SUCCESS".equals(status)) {
                out.print("{\"error\": 0, \"message\": \"Already processed\"}");
                return;
            }

            // 7. Validate số tiền khớp
            int webhookAmount = json.has("transferAmount")
                    ? json.get("transferAmount").getAsInt() : 0;
            if (webhookAmount != payment.getAmount()) {
                System.out.println("[SePay] Amount mismatch: webhook=" + webhookAmount
                        + " expected=" + payment.getAmount());
                // Vẫn xử lý nhưng log lại — hoặc reject tùy policy
                // Uncomment dòng dưới nếu muốn strict:
                // out.print("{\"error\": 1, \"message\": \"Amount mismatch\"}"); return;
            }

            // 8. Cộng balance + set SUCCESS trong 1 transaction
            PaymentDAO.confirmAndAddBalance(paymentId, payment.getUserId(), payment.getAmount());

            System.out.println("[SePay] SUCCESS: orderId=" + orderId
                    + " userId=" + payment.getUserId()
                    + " amount=" + payment.getAmount());

            // 9. Trả về success cho SePay (bắt buộc, nếu không SePay sẽ retry)
            out.print("{\"error\": 0, \"message\": \"Success\"}");

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"error\": 1, \"message\": \"" + e.getMessage() + "\"}");
        }
    }

    /**
     * Tìm orderId dạng "QR{số}" trong nội dung chuyển khoản.
     * Ví dụ: "NAP TIEN DUK QR27" → "QR27"
     *        "CHUYEN KHOAN QR123 DUK" → "QR123"
     */
    private String extractOrderId(String content) {
        if (content == null) return null;
        // Tìm pattern QR + số trong chuỗi (case insensitive)
        java.util.regex.Matcher m = java.util.regex.Pattern
                .compile("QR(\\d+)", java.util.regex.Pattern.CASE_INSENSITIVE)
                .matcher(content.toUpperCase());
        if (m.find()) {
            return "QR" + m.group(1);
        }
        return null;
    }

    private String getStr(JsonObject json, String key) {
        return (json.has(key) && !json.get(key).isJsonNull())
                ? json.get(key).getAsString() : null;
    }

    // SePay cũng có thể gọi GET để verify endpoint
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        response.setContentType("application/json");
        response.getWriter().print("{\"status\": \"DUK Academy webhook active\"}");
    }
}