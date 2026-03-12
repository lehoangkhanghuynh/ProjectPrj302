package controller;
import java.io.IOException;
import java.util.ArrayList;
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
import model.WishlistDAO;

/**
 *
 * @author HOANG KHANG PC
 */
@WebServlet(name = "courseController", urlPatterns = {"/courseController"})
public class courseController extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        CourseDAO dao = new CourseDAO();
        try {
            if (action == null || action.equals("ExploreCourse")) {
                List<CourseDTO> list = dao.getAll();
                request.setAttribute("COURSE_LIST", list);

                // ===== RATING STATS (1 query cho toàn bộ danh sách) =====
                Map<Integer, double[]> courseStats = ReviewDAO.getAllCourseStats();
                Map<Integer, Double>  avgRatingMap   = new HashMap<>();
                Map<Integer, Integer> reviewCountMap = new HashMap<>();
                for (Map.Entry<Integer, double[]> e : courseStats.entrySet()) {
                    avgRatingMap.put(e.getKey(),   e.getValue()[0]);
                    reviewCountMap.put(e.getKey(), (int) e.getValue()[1]);
                }
                request.setAttribute("AVG_RATING_MAP",   avgRatingMap);
                request.setAttribute("REVIEW_COUNT_MAP", reviewCountMap);
                // =========================================================

                HttpSession session = request.getSession();
                UserDTO user = (UserDTO) session.getAttribute("user");
                if (user != null) {
                    EnrollDAO enrollDAO = new EnrollDAO();
                    List<Integer> enrolledIds = enrollDAO.getEnrolledCourseIds(user.getUserId());
                    request.setAttribute("ENROLLED_IDS", enrolledIds);
                    List<Integer> completedIds = enrollDAO.getCompletedCourseIds(user.getUserId());
                    request.setAttribute("COMPLETED_IDS", completedIds);
                    // Wishlist: chỉ load lại nếu session chưa có
                    if (session.getAttribute("WISHLIST_IDS") == null) {
                        WishlistDAO wDao = new WishlistDAO();
                        String userId = user.getUserId();
                        session.setAttribute("WISHLIST_IDS", wDao.getWishlistIds(userId));
                        session.setAttribute("WISHLIST_COURSES", wDao.getWishlistCourses(userId));
                    }
                }
                request.getRequestDispatcher("listCourse.jsp").forward(request, response);

            } else if (action.equals("detail")) {
                int courseId = Integer.parseInt(request.getParameter("courseId"));

                // Lấy thông tin course
                CourseDTO course = dao.searchByIDc(courseId);
                if (course == null) {
                    response.sendRedirect("courseController?action=ExploreCourse");
                    return;
                }

                // Lấy reviews & thống kê
                List<ReviewDTO> reviews   = ReviewDAO.getByCourse(courseId);
                double avgRating          = ReviewDAO.getAvgRating(courseId);
                int    reviewCount        = ReviewDAO.countByCourse(courseId);
                Map<Integer, Integer> dist = ReviewDAO.getRatingDistribution(courseId);
                System.out.println("DIST map: " + dist);
                System.out.println("DIST key types: " + dist.keySet().stream()
                .map(k -> k + " (" + k.getClass().getSimpleName() + ")")
                .collect(java.util.stream.Collectors.joining(", ")));
                request.setAttribute("COURSE",        course);
                request.setAttribute("REVIEWS",       reviews);
                request.setAttribute("AVG_RATING",    avgRating);
                request.setAttribute("REVIEW_COUNT",  reviewCount);
                request.setAttribute("DIST",          dist);

                // Kiểm tra trạng thái enroll nếu đã đăng nhập
                HttpSession session = request.getSession();
                UserDTO user = (UserDTO) session.getAttribute("user");
                if (user != null) {
                    EnrollDAO enrollDAO   = new EnrollDAO();
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
}
