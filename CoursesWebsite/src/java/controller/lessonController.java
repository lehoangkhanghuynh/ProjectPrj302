package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.CommentDAO;
import model.CommentDTO;
import model.CourseDAO;
import model.CourseDTO;
import model.EnrollDAO;
import model.LessonDAO;
import model.LessonDTO;
import model.ReviewDAO;
import model.ReviewDTO;
import model.UserDTO;

/**
 *
 * @author HOANG KHANG PC
 */
@WebServlet("/lesson")
public class lessonController extends HttpServlet {
 
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        loadLesson(request, response);
    }
 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
 
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        UserDTO user = (UserDTO) session.getAttribute("user");
 
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
 
        String action = request.getParameter("action");
 
        if ("addComment".equals(action)) {
            try {
                int lessonId = Integer.parseInt(request.getParameter("lessonId"));
                int courseId = Integer.parseInt(request.getParameter("courseId"));
                String content = request.getParameter("commentContent");
                if (content != null && !content.trim().isEmpty()) {
                    new CommentDAO().addComment(lessonId, user.getUserId(), content.trim());
                }
                response.sendRedirect("lesson?courseId=" + courseId + "&lessonId=" + lessonId + "#comments");
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("courseController?action=ExploreCourse");
            }
 
        } else if ("deleteComment".equals(action)) {
            try {
                int commentId = Integer.parseInt(request.getParameter("commentId"));
                int lessonId  = Integer.parseInt(request.getParameter("lessonId"));
                int courseId  = Integer.parseInt(request.getParameter("courseId"));
                new CommentDAO().deleteComment(commentId, user.getUserId());
                response.sendRedirect("lesson?courseId=" + courseId + "&lessonId=" + lessonId + "#comments");
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("courseController?action=ExploreCourse");
            }
 
        } else if ("finishCourse".equals(action)) {
            try {
                int courseId = Integer.parseInt(request.getParameter("courseId"));
                new EnrollDAO().updateStatusDone(user.getUserId(), courseId);
                response.sendRedirect("courseComplete?courseId=" + courseId);
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("courseController?action=ExploreCourse");
            }
 
        } else {
            loadLesson(request, response);
        }
    }
 
    private void loadLesson(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
 
        HttpSession session = request.getSession();
        UserDTO user = (UserDTO) session.getAttribute("user");
 
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
 
        try {
            String courseIdParam = request.getParameter("courseId");
            if (courseIdParam == null || courseIdParam.trim().isEmpty()) {
                response.sendRedirect("courseController?action=ExploreCourse");
                return;
            }
 
            int courseId = Integer.parseInt(courseIdParam);
 
            // Kiểm tra quyền truy cập (bỏ qua nếu là admin/instructor)
            EnrollDAO enrollDAO = new EnrollDAO();
            int status = -1;
            if (user.getRole() != 1 && user.getRole() != 2) {
                status = enrollDAO.getEnrollStatus(user.getUserId(), courseId);
                if (status < 1) {
                    response.sendRedirect("courseController?action=ExploreCourse");
                    return;
                }
            }
 
            LessonDAO lessonDAO = new LessonDAO();
            CourseDAO courseDAO = new CourseDAO();
 
            List<LessonDTO> lessons = lessonDAO.getLessonsByCourse(courseId);
            CourseDTO course        = courseDAO.searchByIDc(courseId);
 
            // Xác định bài học hiện tại
            LessonDTO currentLesson = null;
            String lessonIdParam = request.getParameter("lessonId");
            if (lessonIdParam != null && !lessonIdParam.trim().isEmpty()) {
                currentLesson = lessonDAO.getLessonById(Integer.parseInt(lessonIdParam));
            } else if (!lessons.isEmpty()) {
                currentLesson = lessons.get(0);
            }
 
            // ── currentIndex để JSP render progress bar (1-based) ─────────
            int currentIndex = 1;
            if (currentLesson != null) {
                for (int i = 0; i < lessons.size(); i++) {
                    if (lessons.get(i).getLessonId() == currentLesson.getLessonId()) {
                        currentIndex = i + 1;
                        break;
                    }
                }
            }
 
            // ── Trích YouTube video ID để JSP render iframe trực tiếp ─────
            String ytVideoId = null;
            if (currentLesson != null && currentLesson.getVideo() != null) {
                ytVideoId = extractYouTubeId(currentLesson.getVideo());
            }
 
            // Load comments
            List<CommentDTO> comments = null;
            if (currentLesson != null) {
                comments = new CommentDAO().getCommentsByLesson(currentLesson.getLessonId());
            }
 
            // ── Load review data ──────────────────────────────────────────
            ReviewDAO reviewDAO = new ReviewDAO();
            boolean isCompleted = false;
            ReviewDTO myReview  = null;
 
            if (user.getRole() != 1 && user.getRole() != 2) {
                isCompleted = reviewDAO.isCompleted(user.getUserId(), courseId);
            }
            myReview = reviewDAO.getByUserAndCourse(user.getUserId(), courseId);
 
            request.setAttribute("REVIEWS",      reviewDAO.getByCourse(courseId));
            request.setAttribute("AVG_RATING",   reviewDAO.getAvgRating(courseId));
            request.setAttribute("REVIEW_COUNT", reviewDAO.countByCourse(courseId));
            request.setAttribute("DIST",         reviewDAO.getRatingDistribution(courseId));
            request.setAttribute("IS_COMPLETED", isCompleted);
            request.setAttribute("MY_REVIEW",    myReview);
            // ─────────────────────────────────────────────────────────────
 
            request.setAttribute("status",        status);
            request.setAttribute("courseId",      courseId);
            request.setAttribute("course",        course);
            request.setAttribute("lessons",       lessons);
            request.setAttribute("currentLesson", currentLesson);
            request.setAttribute("comments",      comments);
            request.setAttribute("currentIndex",  currentIndex);  // ← mới
            request.setAttribute("ytVideoId",     ytVideoId);      // ← mới
 
            request.getRequestDispatcher("lesson.jsp").forward(request, response);
 
        } catch (Exception e) {
            e.printStackTrace();
            response.setContentType("text/html;charset=UTF-8");
            response.getWriter().println("<h2>Lỗi: " + e.getMessage() + "</h2>");
            response.getWriter().println("<pre>");
            e.printStackTrace(response.getWriter());
            response.getWriter().println("</pre>");
        }
    }
 
    // ── Trích YouTube ID từ các dạng URL phổ biến ─────────────────────────
    private String extractYouTubeId(String url) {
        if (url == null || url.trim().isEmpty()) return null;
 
        // Dạng: ?v=xxxx hoặc &v=xxxx
        if (url.contains("v=")) {
            String id = url.substring(url.indexOf("v=") + 2);
            if (id.contains("&")) id = id.substring(0, id.indexOf("&"));
            if (id.contains("#")) id = id.substring(0, id.indexOf("#"));
            if (!id.isEmpty()) return id;
        }
        // Dạng: youtu.be/xxxx
        if (url.contains("youtu.be/")) {
            String id = url.substring(url.indexOf("youtu.be/") + 9);
            if (id.contains("?")) id = id.substring(0, id.indexOf("?"));
            if (id.contains("#")) id = id.substring(0, id.indexOf("#"));
            if (!id.isEmpty()) return id;
        }
        // Dạng: /embed/xxxx
        if (url.contains("/embed/")) {
            String id = url.substring(url.indexOf("/embed/") + 7);
            if (id.contains("?")) id = id.substring(0, id.indexOf("?"));
            if (id.contains("#")) id = id.substring(0, id.indexOf("#"));
            if (!id.isEmpty()) return id;
        }
        return null; // không phải YouTube → video local
    }
 
    @Override
    public String getServletInfo() {
        return "Lesson Controller";
    }
}