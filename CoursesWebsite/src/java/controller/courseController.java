package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import model.CourseDAO;
import model.CourseDTO;
import model.EnrollDAO;
import model.UserDTO;
import model.WishlistDAO;
import model.WishlistDTO;

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
                HttpSession session = request.getSession();
                UserDTO user = (UserDTO) session.getAttribute("user");
                if (user != null) {
                    EnrollDAO enrollDAO = new EnrollDAO();
                    List<Integer> enrolledIds = enrollDAO.getEnrolledCourseIds(user.getUserId());
                    request.setAttribute("ENROLLED_IDS", enrolledIds);
                    List<Integer> completedIds = enrollDAO.getCompletedCourseIds(user.getUserId());
                    request.setAttribute("COMPLETED_IDS", completedIds);

                    // Wishlist: lưu vào SESSION để mọi trang đều dùng được
                    // Chỉ load lại nếu session chưa có (tránh query DB thừa)
                    if (session.getAttribute("WISHLIST_IDS") == null) {
                        WishlistDAO wDao = new WishlistDAO();
                        String userId = user.getUserId();
                        session.setAttribute("WISHLIST_IDS", wDao.getWishlistIds(userId));
                        session.setAttribute("WISHLIST_COURSES", wDao.getWishlistCourses(userId));
                    }
                }
                request.getRequestDispatcher("listCourse.jsp").forward(request, response);
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
