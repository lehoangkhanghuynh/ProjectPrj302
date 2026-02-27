package controller;

import java.io.IOException;
import java.sql.Timestamp;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.PaymentDAO;
import model.PaymentDTO;

@WebServlet(name = "PaymentController", urlPatterns = {"/PaymentController"})
public class PaymentController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        String url = "";

        try {
            Integer userId = (Integer) session.getAttribute("UserId");
            if (userId == null) {
                response.sendRedirect("login.jsp");
                return;
            }
            String courseIdStr = request.getParameter("CourseId");
            String amountStr = request.getParameter("Amount");
            String paymentMethod = request.getParameter("PaymentMethod");

            if (courseIdStr == null || amountStr == null || paymentMethod == null) {
                request.setAttribute("error", "Thiếu thông tin thanh toán");
                url = "payment-fail.jsp";
            } else {
                int courseId = Integer.parseInt(courseIdStr);
                int amount = Integer.parseInt(amountStr);
                Timestamp paymentDate = new Timestamp(System.currentTimeMillis());
                String paymentStatus = "PENDING";

                PaymentDAO paymentDao = new PaymentDAO();
                PaymentDTO payment = paymentDao.createPayment(
                        userId,
                        courseId,
                        amount,
                        paymentMethod,
                        paymentDate,
                        paymentStatus
                );
                if (payment != null) {
                    request.setAttribute("payment", payment);
                    session.setAttribute("currentPayment", payment);
                    url = "payment-success.jsp";
                } else {
                    request.setAttribute("error", "Thanh toán thất bại");
                    url = "payment-fail.jsp";
                }
            }

        } catch (NumberFormatException e) {
            e.printStackTrace();
            request.setAttribute("error", "Thông tin thanh toán không hợp lệ");
            url = "payment-fail.jsp";
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            url = "payment-fail.jsp";
        }

        RequestDispatcher rd = request.getRequestDispatcher(url);
        rd.forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Payment Controller";
    }
}
