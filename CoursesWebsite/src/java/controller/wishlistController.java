/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.CourseDAO;
import model.CourseDTO;
import model.EnrollDAO;
import model.WishlistDAO;
import model.WishlistDTO;

/**
 *
 * @author ASUS
 */
public class wishlistController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String action = request.getParameter("action");
        String ajax = request.getParameter("ajax");
        WishlistDAO dao = new WishlistDAO();

        if (action == null) {
            response.sendRedirect("homePage.jsp");
            return;
        }

        if (action.equals("add")) {
            String userId = request.getParameter("userId");
            int courseId = Integer.parseInt(request.getParameter("courseId"));
            dao.addWishlist(userId, courseId);
            refreshWishlistSession(request, userId, dao);
            if ("1".equals(ajax)) {
                response.setStatus(200);
                return;
            }
            response.sendRedirect("courseController?action=ExploreCourse");

        } else if (action.equals("remove")) {
            String userId = request.getParameter("userId");
            String wishlistIdStr = request.getParameter("wishlistId");
            String courseIdStr = request.getParameter("courseId");

            if (wishlistIdStr != null) {
                dao.deleteWishlist(Integer.parseInt(wishlistIdStr));
            } else if (courseIdStr != null && userId != null) {
                dao.deleteByUserAndCourse(userId, Integer.parseInt(courseIdStr));
            }

            if (userId != null) {
                refreshWishlistSession(request, userId, dao);
            }

            if ("1".equals(ajax)) {
                response.setStatus(200);
                return;
            }
            String from = request.getParameter("from");
            if ("wishlist".equals(from)) {
                response.sendRedirect("wishlistController?action=view&userId=" + userId);
            } else {
                response.sendRedirect("courseController?action=ExploreCourse");
            }

        } else if (action.equals("view")) {
            String userId = request.getParameter("userId");
            List<WishlistDTO> wishlist = dao.getWishlistByUser(userId);
            request.setAttribute("wishlist", wishlist);

            // feeMap
            Map<Integer, Double> feeMap = new HashMap<>();
            CourseDAO courseDAO = new CourseDAO();
            for (WishlistDTO w : wishlist) {
                try {
                    CourseDTO c = courseDAO.searchByID(String.valueOf(w.getCourseId()));
                    if (c != null) feeMap.put(w.getCourseId(), c.getFee());
                } catch (Exception e) { e.printStackTrace(); }
            }
            request.setAttribute("feeMap", feeMap);

            // enrolledIds
            try {
                EnrollDAO enrollDAO = new EnrollDAO();
                List<Integer> enrolledIds = enrollDAO.getEnrolledCourseIds(userId);
                request.setAttribute("enrolledIds", enrolledIds);
            } catch (Exception e) {
                e.printStackTrace();
            }

            request.getRequestDispatcher("wishlist.jsp").forward(request, response);
            // QUAN TRỌNG: return sau forward để không chạy tiếp
            return;
        }
    }

    private void refreshWishlistSession(HttpServletRequest request, String userId, WishlistDAO dao) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            List<Integer> wishIds = dao.getWishlistIds(userId);
            List<CourseDTO> wishCourses = dao.getWishlistCourses(userId);
            session.setAttribute("WISHLIST_IDS", wishIds);
            session.setAttribute("WISHLIST_COURSES", wishCourses);
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

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}