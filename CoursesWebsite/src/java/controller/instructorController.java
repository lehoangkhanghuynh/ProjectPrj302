package controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.CourseDAO;
import model.CourseDTO;
import model.LessonDAO;
import model.UserDTO;

public class instructorController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String url = "instructorDashboard.jsp";

        try {

            if ("viewMyCourses".equals(action)) {
                HttpSession session = request.getSession();
                UserDTO user = (UserDTO) session.getAttribute("user");
                CourseDAO dao = new CourseDAO();
                List<CourseDTO> list = dao.getCoursesByInstructor(user.getUserId());
                request.setAttribute("COURSE_LIST", list);
                url = "instructorCourses.jsp";
            }

            else if ("createCourse".equals(action)) {

                String topic = request.getParameter("topic");
                String courseName = request.getParameter("courseName");
                double fee = Double.parseDouble(request.getParameter("fee"));

                HttpSession session = request.getSession();
                UserDTO user = (UserDTO) session.getAttribute("user");

                CourseDAO dao = new CourseDAO();
                dao.createCourse(topic, courseName, fee, user.getUserId());

                url = "mainController?action=viewMyCourses";
            }

            else if ("updateCourse".equals(action)) {

                int courseId = Integer.parseInt(request.getParameter("courseId"));
                String topic = request.getParameter("topic");
                String courseName = request.getParameter("courseName");
                double fee = Double.parseDouble(request.getParameter("fee"));

                CourseDAO dao = new CourseDAO();
                dao.updateCourse(courseId, topic, courseName, fee);

                url = "mainController?action=viewMyCourses";
            }

            else if ("addLesson".equals(action)) {

                int courseId = Integer.parseInt(request.getParameter("courseId"));
                String lessonTitle = request.getParameter("lessonTitle");
                String videoUrl = request.getParameter("videoUrl");

                LessonDAO dao = new LessonDAO();
                dao.addLesson(courseId, lessonTitle, videoUrl);

                url = "mainController?action=viewMyCourses";
            }

            else if ("deleteLesson".equals(action)) {

                int lessonId = Integer.parseInt(request.getParameter("lessonId"));

                LessonDAO dao = new LessonDAO();
                dao.deleteLesson(lessonId);

                url = "mainController?action=viewMyCourses";
            }

            else if ("viewReviews".equals(action)) {

                int courseId = Integer.parseInt(request.getParameter("courseId"));

                CourseDAO dao = new CourseDAO();
                List<String> reviews = dao.getReviewsByCourse(courseId);

                request.setAttribute("REVIEWS", reviews);

                url = "courseReview.jsp";
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        RequestDispatcher rd = request.getRequestDispatcher(url);
        rd.forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}