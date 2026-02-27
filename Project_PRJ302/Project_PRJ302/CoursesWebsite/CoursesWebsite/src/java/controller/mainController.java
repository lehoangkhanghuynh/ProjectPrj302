package controller;

import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.CourseDAO;
import model.CourseDTO;
import model.UserCourseDAO;
import model.UserDTO;

public class mainController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        String action = request.getParameter("action");
        String url = "login.jsp";

        if (action == null) {
            url = "login.jsp";
        }

        // ================= LOGIN =================
        else if (action.equals("login")) {
            url = "loginController";
        }

        // ================= LOGOUT =================
        else if (action.equals("logout")) {
            url = "logoutController";
        }

        // ================= ADD COURSE (ADMIN ONLY) =================
        else if (action.equals("AddCourse")) {

            String courseId = request.getParameter("courseId");
            String topic = request.getParameter("topic");
            String courseName = request.getParameter("courseName");
            double fee = Double.parseDouble(request.getParameter("fee"));

            CourseDTO c = new CourseDTO(courseId, topic, courseName, fee, 1);

            CourseDAO dao = new CourseDAO();
            boolean check = dao.add(c);

            if (check) {
                request.setAttribute("message", "Add success!");
            } else {
                request.setAttribute("message", "Add failed!");
            }

            url = "addCourse.jsp";
        }

        // ================= REGISTER COURSE (USER) =================
        else if (action.equals("RegisterCourse")) {

            HttpSession session = request.getSession();
            UserDTO loginUser = (UserDTO) session.getAttribute("user");

            String courseId = request.getParameter("courseId");

            if (loginUser != null) {
                UserCourseDAO dao = new UserCourseDAO();
                dao.registerCourse(loginUser.getUserId(), courseId);
            }

            url = "mainController?action=ViewCourse";
        }

        // ================= VIEW COURSE =================
        else if (action.equals("ViewCourse")) {

            HttpSession session = request.getSession();
            UserDTO loginUser = (UserDTO) session.getAttribute("user");

            CourseDAO dao = new CourseDAO();
            ArrayList<CourseDTO> list;

            if (loginUser != null && loginUser.getRole() == 1) {
                // ADMIN xem tất cả course
                list = dao.getAll();
            } else if (loginUser != null) {
                // USER xem course mình đã đăng ký
                list = dao.getCoursesByUser(loginUser.getUserId());
            } else {
                list = new ArrayList<>();
            }

            request.setAttribute("COURSE_LIST", list);
            url = "listCourse.jsp";
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