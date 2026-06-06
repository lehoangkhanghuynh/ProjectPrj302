package controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.CourseDAO;
import model.CourseDTO;
import model.EnrollDAO;
import model.UserDTO;
import model.WishlistDAO;
import model.WishlistDTO;

@WebServlet(name = "wishlistController", urlPatterns = {"/wishlistController"})
public class wishlistController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // ── Lấy user từ session, KHÔNG tin request param ──────────────
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        UserDTO currentUser = (UserDTO) session.getAttribute("user");
        String userId = currentUser.getUserId();

        String action = request.getParameter("action");
        String ajax   = request.getParameter("ajax");
        WishlistDAO dao = new WishlistDAO();

        if (action == null) {
            response.sendRedirect(request.getContextPath() + "/homePage.jsp");
            return;
        }

        switch (action) {

            case "add": {
                String courseIdStr = request.getParameter("courseId");
                if (courseIdStr == null || courseIdStr.isEmpty()) {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing courseId");
                    return;
                }
                int courseId = Integer.parseInt(courseIdStr);

                // Tránh thêm trùng
                if (!dao.isInWishlist(userId, courseId)) {
                    dao.addWishlist(userId, courseId);
                }
                refreshWishlistSession(request, userId, dao);

                if ("1".equals(ajax)) {
                    response.setStatus(HttpServletResponse.SC_OK);
                    return;
                }
                response.sendRedirect(request.getContextPath() + "/courseController?action=ExploreCourse");
                break;
            }

            case "remove": {
                String courseIdStr  = request.getParameter("courseId");
                String wishlistIdStr = request.getParameter("wishlistId");

                if (wishlistIdStr != null && !wishlistIdStr.isEmpty()) {
                    dao.deleteWishlist(Integer.parseInt(wishlistIdStr));
                } else if (courseIdStr != null && !courseIdStr.isEmpty()) {
                    dao.deleteByUserAndCourse(userId, Integer.parseInt(courseIdStr));
                }
                refreshWishlistSession(request, userId, dao);

                if ("1".equals(ajax)) {
                    response.setStatus(HttpServletResponse.SC_OK);
                    return;
                }
                String from = request.getParameter("from");
                if ("wishlist".equals(from)) {
                    response.sendRedirect(request.getContextPath() + "/wishlistController?action=view");
                } else {
                    response.sendRedirect(request.getContextPath() + "/courseController?action=ExploreCourse");
                }
                break;
            }

            case "view": {
                List<WishlistDTO> wishlist = dao.getWishlistByUser(userId);
                request.setAttribute("wishlist", wishlist);

                CourseDAO courseDAO = new CourseDAO();
                Map<Integer, Double>  feeMap        = new HashMap<>();
                Map<Integer, String>  courseNameMap = new HashMap<>();
                Map<Integer, String>  imgMap        = new HashMap<>();

                for (WishlistDTO w : wishlist) {
                    try {
                        CourseDTO c = courseDAO.searchByIDc(w.getCourseId());
                        if (c != null) {
                            feeMap.put(w.getCourseId(), c.getFee());
                            courseNameMap.put(w.getCourseId(), c.getCourseName());
                            if (c.getImg() != null) {
                                imgMap.put(w.getCourseId(), c.getImg());
                            }
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
                request.setAttribute("feeMap",        feeMap);
                request.setAttribute("courseNameMap",  courseNameMap);
                request.setAttribute("imgMap",         imgMap);

                try {
                    EnrollDAO enrollDAO = new EnrollDAO();
                    List<Integer> enrolledIds = enrollDAO.getEnrolledCourseIds(userId);
                    request.setAttribute("enrolledIds", enrolledIds);
                } catch (Exception e) {
                    e.printStackTrace();
                }

                request.getRequestDispatcher("/user/wishlist.jsp").forward(request, response);
                return;
            }

            default:
                response.sendRedirect(request.getContextPath() + "/homePage.jsp");
        }
    }

    /**
     * Cập nhật lại WISHLIST_IDS và WISHLIST_COURSES trong session sau mỗi
     * thao tác add / remove.
     */
    private void refreshWishlistSession(HttpServletRequest request, String userId, WishlistDAO dao) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.setAttribute("WISHLIST_IDS",     dao.getWishlistIds(userId));
            session.setAttribute("WISHLIST_COURSES", dao.getWishlistCourses(userId));
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