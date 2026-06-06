package controller;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class mainController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        String url    = "login.jsp";

        if (action == null || action.trim().isEmpty()) {
            url = "login.jsp";

        } else switch (action) {

            // ── USER ──────────────────────────────────────────────────────────
            case "login":
            case "logout":
            case "register":
            case "updateUser":
            case "viewProfile":
            case "updatePassword":
            case "updatePasswordByEmail":
            case "forgotPassword":
            case "resetPassword":
            case "getBalance":
            case "deductBalance":
                url = "userController";
                break;

            // ── ADMIN ──────────────────────────────────────────────────────────
            case "manageUsers":
            case "blockUser":
            case "unblockUser":
            case "manageCourses":
            case "viewPayments":
            case "viewTopups":
            case "confirmPayment":
            case "cancelPayment":
                url = "adminController";
                break;

            // ── COURSE ─────────────────────────────────────────────────────────
            case "enroll":
            case "ExploreCourse":
            case "detail":
            case "lesson":
            case "finishCourse":
            case "courseComplete":
            case "addComment":
            case "deleteComment":
            case "myCourses":           // ← MỚI THÊM
                url = "courseController";
                break;

            // ── INSTRUCTOR ─────────────────────────────────────────────────────
            case "createCourse":
            case "updateCourse":
            case "addLesson":
            case "deleteLesson":
            case "viewMyCourses":
            case "viewReviews":
            case "uploadVideo":
                url = "instructorController";
                break;

            // ── CERTIFICATE ────────────────────────────────────────────────────
            case "certificate":
            case "myCertificates":
                url = "certificateController";
                break;

            // ── PAYMENT ────────────────────────────────────────────────────────
            case "createQR":
            case "confirmPending":
            case "sepayWebhook":
            case "payment":
                url = "paymentController";
                break;

            default:
                url = "login.jsp";
                break;
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
        return "Main Controller";
    }
}
