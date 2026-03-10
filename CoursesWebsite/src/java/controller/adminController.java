/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.CourseDAO;
import model.CourseDTO;
import model.EnrollDAO;
import model.PaymentDAO;
import model.UserDAO;
import model.UserDTO;

/**
 *
 * @author ASUS
 */
public class adminController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // Kiểm tra quyền admin
        HttpSession session = request.getSession(false);
        UserDTO user = (session != null) ? (UserDTO) session.getAttribute("user") : null;
        if (user == null || user.getRole() != 1) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) {
            action = "dashboard";
        }
        String url = "administrator.jsp";

        try {
            switch (action) {
                case "manageUsers":
                    url = manageUsers(request);
                    break;
                case "blockUser":
                    url = blockUser(request);
                    break;
                case "unblockUser":
                    url = unblockUser(request);
                    break;
                case "manageCourses":
                    url = manageCourses(request);
                    break;
                case "viewPayments":
                    url = viewPayments(request);
                    break;
                case "confirmPayment":
                    url = confirmPayment(request);
                    break;
                case "cancelPayment":
                    url = cancelPayment(request);
                    break;
                case "viewTopups":
                    url = viewTopups(request);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (url.startsWith("redirect:")) {
            response.sendRedirect(url.substring(9));
        } else {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    // ================= USER =================
    private String manageUsers(HttpServletRequest request) {
        UserDAO dao = new UserDAO();
        List<UserDTO> list = dao.getAllUsers();
        request.setAttribute("USER_LIST", list);
        return "adminUsers.jsp";
    }

    private String blockUser(HttpServletRequest request) {
        String userId = request.getParameter("userId");
        new UserDAO().blockUser(userId);
        return "redirect:adminController?action=manageUsers";
    }

    private String unblockUser(HttpServletRequest request) {
        String userId = request.getParameter("userId");
        new UserDAO().unblockUser(userId);
        return "redirect:adminController?action=manageUsers";
    }

    // ================= COURSE =================
    private String manageCourses(HttpServletRequest request) {
        CourseDAO dao = new CourseDAO();
        List<CourseDTO> list = dao.getCoursesWithStudents();
        request.setAttribute("COURSE_LIST", list);
        return "adminCourses.jsp";
    }

    // ================= PAYMENT (Enrollment) =================
    // Giữ nguyên - dùng EnrollDAO để xem user có vào khóa học không
    private String viewPayments(HttpServletRequest request) {
        EnrollDAO dao = new EnrollDAO();
        request.setAttribute("ENROLL_LIST", dao.getAllEnrollments());
        return "adminPayments.jsp";
    }

    // ================= TOPUP (Nạp ví) =================
    // Xem danh sách nạp tiền chờ xác nhận
    private String viewTopups(HttpServletRequest request) throws Exception {
        request.setAttribute("TOPUP_LIST", PaymentDAO.getPendingConfirm());
        return "adminTopups.jsp";
    }

    // Admin duyệt nạp tiền → cộng tiền vào ví user
    private String confirmPayment(HttpServletRequest request) throws Exception {
        int paymentId = Integer.parseInt(request.getParameter("paymentId"));
        PaymentDAO.confirm(paymentId);
        return "redirect:adminController?action=viewTopups";
    }

    // Admin hủy giao dịch nạp tiền
    private String cancelPayment(HttpServletRequest request) throws Exception {
        int paymentId = Integer.parseInt(request.getParameter("paymentId"));
        PaymentDAO.cancel(paymentId);
        return "redirect:adminController?action=viewTopups";
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
        return "Admin Controller";
    }
}
