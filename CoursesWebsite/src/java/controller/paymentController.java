package controller;

import model.PaymentDAO;
import model.PaymentDTO;
import model.UserDTO;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class paymentController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        UserDTO user = (session != null) ? (UserDTO) session.getAttribute("user") : null;
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        String action = request.getParameter("action");
        if ("createQR".equals(action)) {
            createQR(request, response, user);
        } else if ("confirmPending".equals(action)) {
            confirmPending(request, response, user);
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
    private void createQR(HttpServletRequest request, HttpServletResponse response, UserDTO user)
            throws IOException {
        response.setContentType("application/json;charset=UTF-8");
        try {
            String amtStr = request.getParameter("amount");
            if (amtStr == null || amtStr.isEmpty()) {
                response.getWriter().print("{\"status\":\"error\",\"message\":\"Missing amount\"}");
                return;
            }
            int amount = Integer.parseInt(amtStr);
            if (amount < 10000) {
                response.getWriter().print("{\"status\":\"error\",\"message\":\"So tien toi thieu 10.000 VND\"}");
                return;
            }
            PaymentDTO p = new PaymentDTO(user.getUserId(), amount, "VIETQR", "PENDING");
            int paymentId = PaymentDAO.create(p);
            if (paymentId == -1) {
                response.getWriter().print("{\"status\":\"error\",\"message\":\"Loi database\"}");
                return;
            }
            String orderId = "QR" + paymentId;
            response.getWriter().print(
                "{\"status\":\"success\",\"orderId\":\"" + orderId + "\",\"paymentId\":" + paymentId + "}"
            );
        } catch (NumberFormatException e) {
            response.getWriter().print("{\"status\":\"error\",\"message\":\"So tien khong hop le\"}");
        } catch (Exception e) {
            e.printStackTrace();
            String msg = e.getMessage() != null ? e.getMessage().replace("\"", "'") : "Unknown";
            response.getWriter().print("{\"status\":\"error\",\"message\":\"" + msg + "\"}");
        }
    }

    // ===== USER BẤM "ĐÃ THANH TOÁN" =====
    private void confirmPending(HttpServletRequest request, HttpServletResponse response, UserDTO user)
            throws IOException {
        response.setContentType("application/json;charset=UTF-8");
        try {
            String orderIdStr = request.getParameter("orderId");
            if (orderIdStr == null || !orderIdStr.startsWith("QR")) {
                response.getWriter().print("{\"status\":\"error\",\"message\":\"orderId khong hop le\"}");
                return;
            }
            int paymentId = Integer.parseInt(orderIdStr.substring(2));
            PaymentDTO p = PaymentDAO.getById(paymentId);
            if (p == null) {
                response.getWriter().print("{\"status\":\"error\",\"message\":\"Khong tim thay giao dich\"}");
                return;
            }
            if (!p.getUserId().equals(user.getUserId())) {
                response.getWriter().print("{\"status\":\"error\",\"message\":\"Khong co quyen\"}");
                return;
            }
            if (!"PENDING".equals(p.getPaymentStatus())) {
                response.getWriter().print(
                    "{\"status\":\"already\",\"currentStatus\":\"" + p.getPaymentStatus() + "\"}"
                );
                return;
            }
            PaymentDAO.setPendingConfirm(paymentId);
            response.getWriter().print("{\"status\":\"success\"}");
        } catch (Exception e) {
            e.printStackTrace();
            String msg = e.getMessage() != null ? e.getMessage().replace("\"", "'") : "Unknown";
            response.getWriter().print("{\"status\":\"error\",\"message\":\"" + msg + "\"}");
        }
    }
}
