package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
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
        } // ================= LOGIN =================
        else if (action.equals("login")) {
            url = "loginController";
        } // ================= LOGOUT =================
        else if (action.equals("logout")) {
            url = "logoutController";
        } // ================= ADD COURSE (ADMIN) =================
        else if (action.equals("AddCourse")) {

            try {
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

            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("message", "Error while adding course!");
            }

            url = "addCourse.jsp";
        } // ================= REGISTER COURSE (USER) =================
        else if (action.equals("RegisterCourse")) {

            HttpSession session = request.getSession();
            UserDTO loginUser = (UserDTO) session.getAttribute("user");

            if (loginUser != null) {
                String courseId = request.getParameter("courseId");
                UserCourseDAO dao = new UserCourseDAO();
                dao.registerCourse(loginUser.getUserId(), courseId);
            }

            url = "mainController?action=ViewCourse";
        } 

        // ================= EXPLORE COURSE (ALL COURSE) =================
        else if (action.equals("ExploreCourse")) {
            CourseDAO dao = new CourseDAO();
            List<CourseDTO> list = dao.getAll();
            request.setAttribute("COURSE_LIST", list);
            url = "listCourse.jsp";   // đổi lại chỗ này
        } 

        // ================= MY COURSE (USER REGISTERED COURSE) =================
        else if (action.equals("MyCourse")) {

            HttpSession session = request.getSession();
            UserDTO loginUser = (UserDTO) session.getAttribute("user");

            if (loginUser != null) {

                CourseDAO dao = new CourseDAO();
                ArrayList<CourseDTO> list
                        = dao.getCoursesByUser(loginUser.getUserId());

                request.setAttribute("COURSE_LIST", list);
            }

            url = "myCourse.jsp";
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
