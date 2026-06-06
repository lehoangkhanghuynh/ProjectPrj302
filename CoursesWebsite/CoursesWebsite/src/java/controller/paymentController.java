package controller;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import model.PaymentDAO;
import model.PaymentDTO;
import model.UserDAO;
import model.UserDTO;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.stream.Collectors;
import utils.DbiUtils;

public class paymentController extends HttpServlet {

    private static final Map<String, String[]> BANK_MAP = new LinkedHashMap<>();

    static {
        BANK_MAP.put("MB", new String[]{"MB", "0332144439", "LE HOANG KHANG"});
    }

    private static final String DEFAULT_BANK = "MB";
    private static final String SEPAY_API_TOKEN = "DUKAcademy2026@secret";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        // ===== SEPAY WEBHOOK =====
        if ("sepayWebhook".equals(action)) {
            handleWebhook(request, response);
            return;
        }

        HttpSession session = request.getSession(false);
        UserDTO user = (session != null) ? (UserDTO) session.getAttribute("user") : null;

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // reload user
        try {
            UserDTO freshUser = new UserDAO().searchById(user.getUserId());
            if (freshUser != null) {
                session.setAttribute("user", freshUser);
                user = freshUser;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        if ("createQR".equals(action)) {
            handleCreateQR(request, response, user);

        } else if ("confirmPending".equals(action)) {
            handleConfirmPending(request, response, user);

        } else {
            request.getRequestDispatcher("/payment.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("sepayWebhook".equals(action)) {
            handleWebhook(request, response);
        } else {
            doGet(request, response);
        }
    }

    // =========================
    // CREATE VIETQR
    // =========================
    private void handleCreateQR(HttpServletRequest request, HttpServletResponse response, UserDTO user)
            throws ServletException, IOException {

        String amtStr = request.getParameter("amount");
        String bankKey = request.getParameter("bank");

        int amount;
        try {
            if (amtStr == null || amtStr.trim().isEmpty()) {
                throw new NumberFormatException();
            }
            amount = Integer.parseInt(amtStr.trim());

            if (amount < 10000) {
                request.setAttribute("payError", "Số tiền tối thiểu là 10.000đ");
                request.getRequestDispatcher("/payment.jsp").forward(request, response);
                return;
            }

        } catch (NumberFormatException e) {

            request.setAttribute("payError", "Số tiền không hợp lệ");
            request.getRequestDispatcher("/payment.jsp").forward(request, response);
            return;
        }

        if (bankKey == null || !BANK_MAP.containsKey(bankKey)) {
            bankKey = DEFAULT_BANK;
        }

        String[] bankInfo = BANK_MAP.get(bankKey);

        try {

            PaymentDTO p = new PaymentDTO(
                    0,
                    user.getUserId(),
                    amount,
                    "VIETQR",
                    new java.sql.Timestamp(System.currentTimeMillis()),
                    "PENDING",
                    true
            );

            int paymentId = PaymentDAO.create(p);

            if (paymentId == -1) {
                request.setAttribute("payError", "Lỗi hệ thống, vui lòng thử lại.");
                request.getRequestDispatcher("/payment.jsp").forward(request, response);
                return;
            }

            String orderId = "QR" + paymentId;

            String note = URLEncoder.encode(
                    "NAP TIEN DUK " + orderId,
                    StandardCharsets.UTF_8.name()
            );

            String accName = URLEncoder.encode(
                    bankInfo[2],
                    StandardCharsets.UTF_8.name()
            );

            String qrUrl = "https://img.vietqr.io/image/"
                    + bankInfo[0] + "-" + bankInfo[1] + "-qr_only.png"
                    + "?amount=" + amount
                    + "&addInfo=" + note
                    + "&accountName=" + accName;

            request.setAttribute("qrUrl", qrUrl);
            request.setAttribute("orderId", orderId);
            request.setAttribute("qrAmount", amount);
            request.setAttribute("selBank", bankKey);

        } catch (Exception e) {

            e.printStackTrace();
            request.setAttribute("payError", "Lỗi hệ thống: " + e.getMessage());
        }

        request.getRequestDispatcher("/payment.jsp").forward(request, response);
    }

    // =========================
    // USER CONFIRM PAYMENT
    // =========================
    private void handleConfirmPending(HttpServletRequest request, HttpServletResponse response, UserDTO user)
            throws ServletException, IOException {

        String orderIdStr = request.getParameter("orderId");

        if (orderIdStr == null || !orderIdStr.startsWith("QR")) {

            request.setAttribute("payError", "Mã giao dịch không hợp lệ.");
            request.getRequestDispatcher("/payment.jsp").forward(request, response);
            return;
        }

        try {

            int paymentId = Integer.parseInt(orderIdStr.substring(2));

            PaymentDTO p = PaymentDAO.getById(paymentId);

            if (p == null) {
                request.setAttribute("payError", "Không tìm thấy giao dịch.");
                request.getRequestDispatcher("/payment.jsp").forward(request, response);
                return;
            }

            if (!p.getUserId().equals(user.getUserId())) {

                request.setAttribute("payError", "Bạn không có quyền thực hiện thao tác này.");
                request.getRequestDispatcher("/payment.jsp").forward(request, response);
                return;
            }

            if ("PENDING".equals(p.getPaymentStatus())) {
                PaymentDAO.setPendingConfirm(paymentId);
            }

            request.setAttribute("waitingConfirm", true);
            request.setAttribute("confirmedOrderId", orderIdStr);

        } catch (Exception e) {

            e.printStackTrace();
            request.setAttribute("payError", "Lỗi hệ thống: " + e.getMessage());
        }

        request.getRequestDispatcher("/payment.jsp").forward(request, response);
    }

    // =========================
    // SEPAY WEBHOOK
    // =========================
    private void handleWebhook(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json;charset=UTF-8");
        PrintWriter out = response.getWriter();

        String authHeader = request.getHeader("Authorization");

        if (authHeader == null || !authHeader.equals("Apikey " + SEPAY_API_TOKEN)) {

            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            out.print("{\"error\":1}");
            return;
        }

        String body = request.getReader().lines().collect(Collectors.joining());

        try {

            JsonObject json = JsonParser.parseString(body).getAsJsonObject();

            String transferType = getStr(json, "transferType");

            if (!"in".equals(transferType)) {
                out.print("{\"error\":0}");
                return;
            }

            String content = getStr(json, "content");

            if (content == null) {
                content = getStr(json, "description");
            }

            String orderId = extractOrderId(content);

            if (orderId == null) {
                out.print("{\"error\":0}");
                return;
            }

            int paymentId = Integer.parseInt(orderId.substring(2));

            PaymentDTO payment = PaymentDAO.getById(paymentId);

            if (payment == null) {
                out.print("{\"error\":1}");
                return;
            }

            if ("SUCCESS".equals(payment.getPaymentStatus())) {
                out.print("{\"error\":0}");
                return;
            }

            UserDTO user = new UserDAO().searchById(payment.getUserId());

            double balanceBefore = user.getBalance();

            PaymentDAO.confirmAndAddBalance(
                    paymentId,
                    payment.getUserId(),
                    payment.getAmount()
            );

            try {

                if (user != null && user.getEmail() != null) {

                    double newBalance = balanceBefore + payment.getAmount();

                    service.EmailService.sendPaymentConfirm(
                            user.getEmail(),
                            user.getFullname(),
                            payment.getAmount(),
                            newBalance
                    );
                }

            } catch (Exception mailEx) {

                System.out.println("Mail error");
            }

            out.print("{\"error\":0}");

        } catch (Exception e) {

            e.printStackTrace();

            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.print("{\"error\":1}");
        }
    }

    private String extractOrderId(String content) {

        if (content == null) {
            return null;
        }

        java.util.regex.Matcher m
                = java.util.regex.Pattern
                        .compile("QR(\\d+)", java.util.regex.Pattern.CASE_INSENSITIVE)
                        .matcher(content.toUpperCase());

        if (m.find()) {
            return "QR" + m.group(1);
        }

        return null;
    }

    private String getStr(JsonObject json, String key) {

        return (json.has(key) && !json.get(key).isJsonNull())
                ? json.get(key).getAsString()
                : null;
    }
    
    public static double getTotalRevenue() throws Exception {
    String sql = "SELECT ISNULL(SUM(amount), 0) FROM Payment WHERE paymentStatus = 'SUCCESS'";
    try (Connection con = DbiUtils.getConnection();
         PreparedStatement ps = con.prepareStatement(sql);
         ResultSet rs = ps.executeQuery()) {
        if (rs.next()) return rs.getDouble(1);
    }
    return 0;
}
}
