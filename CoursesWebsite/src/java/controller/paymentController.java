package controller;

import model.PaymentDAO;
import model.PaymentDTO;
import model.UserDTO;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/payment")
public class paymentController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("createQR".equals(action)) {
            createQR(request, response);
        } else {
            response.sendRedirect("homePage.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    // ===== TẠO VIETQR =====
    private void createQR(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        UserDTO user = (UserDTO) session.getAttribute("user");

        if (user == null) {
            response.getWriter().print("{\"status\":\"error\",\"message\":\"Not logged in\"}");
            return;
        }

        try {
            int amount = Integer.parseInt(request.getParameter("amount"));
            int courseId = Integer.parseInt(request.getParameter("courseId"));

            PaymentDTO p = new PaymentDTO(
                    user.getUserId(),
                    courseId,
                    amount,
                    "VIETQR",
                    "PENDING"
            );

            int paymentId = PaymentDAO.create(p);

            if (paymentId == -1) {
                response.getWriter().print("{\"status\":\"error\",\"message\":\"DB error\"}");
                return;
            }

            String orderId = "QR" + paymentId;

            response.getWriter().print(
                    "{\"status\":\"success\",\"orderId\":\"" + orderId + "\"}"
            );

        } catch (NumberFormatException e) {
            response.getWriter().print("{\"status\":\"error\",\"message\":\"Invalid amount\"}");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().print("{\"status\":\"error\",\"message\":\"Server error\"}");
        }
    }
} 