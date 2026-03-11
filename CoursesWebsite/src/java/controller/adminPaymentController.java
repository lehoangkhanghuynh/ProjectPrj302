package controller;
import model.PaymentDAO;
import model.PaymentDTO;
import model.UserDTO;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;
public class adminPaymentController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        UserDTO user = (session != null) ? (UserDTO) session.getAttribute("user") : null;
        if (user == null || user.getRole() != 1) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        try {
            List<PaymentDTO> list = PaymentDAO.getPendingConfirm();
            System.out.println(">>> pendingList size = " + list.size());
            request.setAttribute("pendingList", list);
            request.getRequestDispatcher("/adminPayments.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/adminLogin.jsp");
        }
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        UserDTO admin = (session != null) ? (UserDTO) session.getAttribute("user") : null;
        if (admin == null || admin.getRole() != 1) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        String action = request.getParameter("action");
        String pidStr  = request.getParameter("paymentId");
        if (pidStr == null || pidStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/adminPaymentController");
            return;
        }
        try {
            int paymentId = Integer.parseInt(pidStr);
            if ("approve".equals(action)) {
                PaymentDTO p = PaymentDAO.getById(paymentId);
                if (p != null && "PENDING_CONFIRM".equals(p.getPaymentStatus())) {
                    PaymentDAO.addBalanceToUser(p.getUserId(), p.getAmount());
                    PaymentDAO.confirm(paymentId);
                }
            } else if ("reject".equals(action)) {
                PaymentDAO.cancel(paymentId);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect(request.getContextPath() + "/adminPaymentController");
    }
}