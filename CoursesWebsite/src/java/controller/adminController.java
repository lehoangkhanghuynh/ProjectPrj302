/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.CourseDAO;
import model.CourseDTO;
import model.PaymentDAO;
import model.PaymentDTO;
import model.UserDAO;
import model.UserDTO;

/**
 *
 * @author ASUS
 */
public class adminController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
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
        String url = loadDashboard(request);

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
                case "deleteCourse":
                    url = deleteCourse(request);
                    break;
                case "approveCourse":          // <-- MỚI
                    url = approveCourse(request);
                    break;
                case "dashboard":
                    url = loadDashboard(request);
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
        return "/admin/adminUsers.jsp";
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
        try {
            CourseDAO dao = new CourseDAO();
            List<CourseDTO> list = dao.getCoursesWithStudents();
            request.setAttribute("COURSE_LIST", list);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("COURSE_LIST", new java.util.ArrayList<>());
        }
        return "/admin/adminCourses.jsp";
    }

    private String deleteCourse(HttpServletRequest request) {
        String courseId = request.getParameter("courseId");
        if (courseId != null && !courseId.isEmpty()) {
            try {
                new CourseDAO().adminSoftDelete(courseId);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return "redirect:adminController?action=manageCourses";
    }

    // ================= APPROVE COURSE (MỚI) =================
    private String approveCourse(HttpServletRequest request) {
        String courseId = request.getParameter("courseId");
        if (courseId != null && !courseId.isEmpty()) {
            try {
                new CourseDAO().adminApprove(courseId);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return "redirect:adminController?action=manageCourses";
    }

    // ================= PAYMENT (Enrollment) =================
    private String viewPayments(HttpServletRequest request) throws Exception {
        List<PaymentDTO> list = PaymentDAO.getAllPayments();
        request.setAttribute("PAYMENT_LIST", list);
        return "/admin/adminViewPayment.jsp";
    }

    // ================= TOPUP (Nạp ví) =================
    private String viewTopups(HttpServletRequest request) throws Exception {
        request.setAttribute("pendingList", PaymentDAO.getPendingConfirm());
        return "/admin/adminPayments.jsp";
    }

    // Admin duyệt nạp tiền → cộng tiền vào ví user
    private String confirmPayment(HttpServletRequest request) throws Exception {
        int paymentId = Integer.parseInt(request.getParameter("paymentId"));
        PaymentDTO p = PaymentDAO.getById(paymentId);

        if (p != null && "PENDING_CONFIRM".equals(p.getPaymentStatus())) {
            UserDTO user = new UserDAO().searchById(p.getUserId());
            double balanceBefore = (user != null) ? user.getBalance() : 0;

            PaymentDAO.addBalanceToUser(p.getUserId(), p.getAmount());
            PaymentDAO.confirm(paymentId);

            if (user != null && user.getEmail() != null) {
                try {
                    double newBalance = balanceBefore + p.getAmount();
                    service.EmailService.sendPaymentConfirm(
                            user.getEmail(),
                            user.getFullname(),
                            p.getAmount(),
                            newBalance
                    );
                    System.out.println("Mail sent to " + user.getEmail());
                } catch (Exception e) {
                    System.out.println("Mail error: " + e.getMessage());
                }
            }
        }
        return "redirect:adminController?action=viewTopups";
    }

    // Admin hủy giao dịch nạp tiền
    private String cancelPayment(HttpServletRequest request) throws Exception {
        int paymentId = Integer.parseInt(request.getParameter("paymentId"));
        PaymentDAO.cancel(paymentId);
        return "redirect:adminController?action=viewTopups";
    }

    private String loadDashboard(HttpServletRequest request) {
        try {
            List<UserDTO> users = new UserDAO().getAllUsers();
            System.out.println(">>> totalUsers: " + (users != null ? users.size() : "NULL"));
            request.setAttribute("totalUsers", users != null ? users.size() : 0);

            List<CourseDTO> courses = new CourseDAO().getCoursesWithStudents();
            System.out.println(">>> totalCourses: " + (courses != null ? courses.size() : "NULL"));
            request.setAttribute("totalCourses", courses != null ? courses.size() : 0);

            List<PaymentDTO> pending = PaymentDAO.getPendingConfirm();
            System.out.println(">>> pendingCount: " + (pending != null ? pending.size() : "NULL"));
            request.setAttribute("pendingCount", pending != null ? pending.size() : 0);

            double revenue = PaymentDAO.getTotalRevenue();
            System.out.println(">>> totalRevenue: " + revenue);
            request.setAttribute("totalRevenue", revenue);

        } catch (Exception e) {
            System.out.println(">>> loadDashboard ERROR: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("totalUsers", 0);
            request.setAttribute("totalCourses", 0);
            request.setAttribute("pendingCount", 0);
            request.setAttribute("totalRevenue", 0);
        }
        return "/admin/administrator.jsp";
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(adminController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(adminController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public String getServletInfo() {
        return "Admin Controller";
    }

}