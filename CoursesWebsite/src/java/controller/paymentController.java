package controller;

import model.PaymentDAO;
import model.PaymentDTO;
import model.UserDTO;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.LinkedHashMap;
import java.util.Map;

public class paymentController extends HttpServlet {

    private static final Map<String, String[]> BANK_MAP = new LinkedHashMap<>();

    static {
        BANK_MAP.put("MB", new String[]{"MB", "0332144439", "LE HOANG KHANG"});
    }
    private static final String DEFAULT_BANK = "MB";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        UserDTO user = (session != null) ? (UserDTO) session.getAttribute("user") : null;
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        // Reload user từ DB để balance luôn mới nhất
        try {
            UserDTO freshUser = new model.UserDAO().searchById(String.valueOf(user.getUserId()));
            if (freshUser != null) {
                session.setAttribute("user", freshUser);
                user = freshUser;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        String action = request.getParameter("action");
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
        doGet(request, response);
    }

    // ===== TẠO VIETQR =====
    private void handleCreateQR(HttpServletRequest request, HttpServletResponse response, UserDTO user)
            throws ServletException, IOException {

        String amtStr = request.getParameter("amount");
        String bankKey = request.getParameter("bank");

        // Validate amount
        int amount;
        try {
            if (amtStr == null || amtStr.trim().isEmpty()) {
                throw new NumberFormatException();
            }
            amount = Integer.parseInt(amtStr.trim());
            if (amount < 10000) {
                request.setAttribute("payError", "So tien toi thieu la 10.000 d");
                request.getRequestDispatcher("/payment.jsp").forward(request, response);
                return;
            }
        } catch (NumberFormatException e) {
            request.setAttribute("payError", "So tien khong hop le");
            request.getRequestDispatcher("/payment.jsp").forward(request, response);
            return;
        }

        if (bankKey == null || !BANK_MAP.containsKey(bankKey)) {
            bankKey = DEFAULT_BANK;
        }
        String[] bankInfo = BANK_MAP.get(bankKey);

        // Bọc toàn bộ DB + QR logic trong try-catch
        try {
            PaymentDTO p = new PaymentDTO(0, String.valueOf(user.getUserId()), amount,
                    "VIETQR", null, "PENDING", true);
            int paymentId = PaymentDAO.create(p);
            if (paymentId == -1) {
                request.setAttribute("payError", "Loi he thong, vui long thu lai.");
                request.getRequestDispatcher("/payment.jsp").forward(request, response);
                return;
            }

            String orderId = "QR" + paymentId;
            String note = URLEncoder.encode("NAP TIEN DUK " + orderId, StandardCharsets.UTF_8.name());
            String accName = URLEncoder.encode(bankInfo[2], StandardCharsets.UTF_8.name());
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
            request.setAttribute("payError", "Loi he thong: " + e.getMessage());
        }

        request.getRequestDispatcher("/payment.jsp").forward(request, response);
    }

    // ===== USER BẤM "ĐÃ THANH TOÁN" =====
    private void handleConfirmPending(HttpServletRequest request, HttpServletResponse response, UserDTO user)
            throws ServletException, IOException {

        String orderIdStr = request.getParameter("orderId");

        if (orderIdStr == null || !orderIdStr.startsWith("QR")) {
            request.setAttribute("payError", "Ma giao dich khong hop le.");
            request.getRequestDispatcher("/payment.jsp").forward(request, response);
            return;
        }

        try {
            int paymentId = Integer.parseInt(orderIdStr.substring(2));
            PaymentDTO p = PaymentDAO.getById(paymentId);

            if (p == null) {
                request.setAttribute("payError", "Khong tim thay giao dich.");
                request.getRequestDispatcher("/payment.jsp").forward(request, response);
                return;
            }
            if (!p.getUserId().equals(String.valueOf(user.getUserId()))) {
                request.setAttribute("payError", "Ban khong co quyen thuc hien thao tac nay.");
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
            request.setAttribute("payError", "Loi he thong: " + e.getMessage());
        }

        request.getRequestDispatcher("/payment.jsp").forward(request, response);
    }
}
