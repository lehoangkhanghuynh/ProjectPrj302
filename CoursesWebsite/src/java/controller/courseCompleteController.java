package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.CourseDAO;
import model.CourseDTO;
import model.ReviewDAO;
import model.ReviewDTO;
import model.UserDTO;

@WebServlet("/courseComplete")
public class courseCompleteController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserDTO user = (UserDTO) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        try {
            String courseIdParam = request.getParameter("courseId");
            if (courseIdParam == null) {
                response.sendRedirect("courseController?action=ExploreCourse");
                return;
            }
            int courseId = Integer.parseInt(courseIdParam);

            CourseDAO courseDAO = new CourseDAO();
            CourseDTO course = courseDAO.searchByIDc(courseId);

            // Load review data
            ReviewDAO reviewDAO = new ReviewDAO();
            ReviewDTO myReview = reviewDAO.getByUserAndCourse(user.getUserId(), courseId);

            request.setAttribute("course",    course);
            request.setAttribute("courseId",  courseId);
            request.setAttribute("MY_REVIEW", myReview); // null = chưa review

            request.getRequestDispatcher("completeCourse.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("courseController?action=ExploreCourse");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}