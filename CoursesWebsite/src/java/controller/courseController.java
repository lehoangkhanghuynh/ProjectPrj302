package controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;

import model.CourseDAO;
import model.CourseDTO;
import model.EnrollDAO;
import model.ReviewDAO;
import model.ReviewDTO;
import model.UserDTO;
import model.CategoryDAO;
import model.WishlistDAO;

@WebServlet(name = "courseController", urlPatterns = {"/courseController"})
public class courseController extends HttpServlet {

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

    private void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        CourseDAO dao = new CourseDAO();

        try {
            if (action == null || "ExploreCourse".equals(action)) {

                List<CourseDTO> list = dao.getAll();
                request.setAttribute("COURSE_LIST", list);

                // Rating stats
                Map<Integer, double[]> courseStats = ReviewDAO.getAllCourseStats();
                Map<Integer, Double>  avgRatingMap   = new HashMap<>();
                Map<Integer, Integer> reviewCountMap = new HashMap<>();
                for (Map.Entry<Integer, double[]> e : courseStats.entrySet()) {
                    avgRatingMap.put(e.getKey(),   e.getValue()[0]);
                    reviewCountMap.put(e.getKey(), (int) e.getValue()[1]);
                }
                request.setAttribute("AVG_RATING_MAP",   avgRatingMap);
                request.setAttribute("REVIEW_COUNT_MAP", reviewCountMap);

                // Category map
                CategoryDAO catDAO = new CategoryDAO();
                request.setAttribute("CATEGORY_LIST",       catDAO.getAll());
                request.setAttribute("COURSE_CATEGORY_MAP", catDAO.getCourseCategoryMap());

                HttpSession session = request.getSession();
                UserDTO user = (UserDTO) session.getAttribute("user");
                if (user != null) {
                    String userId = user.getUserId();

                    EnrollDAO enrollDAO = new EnrollDAO();
                    request.setAttribute("ENROLLED_IDS",  enrollDAO.getEnrolledCourseIds(userId));
                    request.setAttribute("COMPLETED_IDS", enrollDAO.getCompletedCourseIds(userId));

                    // FIX: luôn load lại wishlist từ DB, không cache
                    WishlistDAO wDao = new WishlistDAO();
                    List<Integer> wishIds     = wDao.getWishlistIds(userId);
                    List<CourseDTO> wishCourses = wDao.getWishlistCourses(userId);
                    session.setAttribute("WISHLIST_IDS",     wishIds);
                    session.setAttribute("WISHLIST_COURSES", wishCourses);
                }

                request.getRequestDispatcher("listCourse.jsp").forward(request, response);

            } else if ("detail".equals(action)) {

                String courseIdStr = request.getParameter("courseId");
                if (courseIdStr == null) {
                    response.sendRedirect("courseController?action=ExploreCourse");
                    return;
                }

                int courseId;
                try { courseId = Integer.parseInt(courseIdStr); }
                catch (NumberFormatException e) {
                    response.sendRedirect("courseController?action=ExploreCourse");
                    return;
                }

                CourseDTO course = dao.searchByIDc(courseId);
                if (course == null) {
                    response.sendRedirect("courseController?action=ExploreCourse");
                    return;
                }

                List<ReviewDTO> reviews    = ReviewDAO.getByCourse(courseId);
                double avgRating           = ReviewDAO.getAvgRating(courseId);
                int    reviewCount         = ReviewDAO.countByCourse(courseId);
                Map<Integer, Integer> dist = ReviewDAO.getRatingDistribution(courseId);

                request.setAttribute("COURSE",       course);
                request.setAttribute("REVIEWS",      reviews);
                request.setAttribute("AVG_RATING",   avgRating);
                request.setAttribute("REVIEW_COUNT", reviewCount);
                request.setAttribute("DIST",         dist);

                HttpSession session = request.getSession();
                UserDTO user = (UserDTO) session.getAttribute("user");
                if (user != null) {
                    EnrollDAO enrollDAO     = new EnrollDAO();
                    List<Integer> enrolled  = enrollDAO.getEnrolledCourseIds(user.getUserId());
                    List<Integer> completed = enrollDAO.getCompletedCourseIds(user.getUserId());
                    request.setAttribute("IS_ENROLLED",  enrolled.contains(courseId));
                    request.setAttribute("IS_COMPLETED", completed.contains(courseId));
                }

                request.getRequestDispatcher("courseDetail.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("ERROR: " + e.getMessage());
        }
    }
}