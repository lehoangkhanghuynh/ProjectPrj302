package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.CommentDAO;
import model.CommentDTO;
import model.CourseDAO;
import model.CourseDTO;
import model.EnrollDAO;
import model.LessonDAO;
import model.LessonDTO;
import model.UserDTO;

@WebServlet("/lesson")
public class lessonController extends HttpServlet {

    /** GET: hiển thị bài học + danh sách comment */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        loadLesson(request, response);
    }

    /** POST: gửi comment rồi redirect lại (PRG pattern) */
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
                int    lessonId = Integer.parseInt(request.getParameter("lessonId"));
                int    courseId = Integer.parseInt(request.getParameter("courseId"));
                String content  = request.getParameter("commentContent");

                if (content != null && !content.trim().isEmpty()) {
                    CommentDAO dao = new CommentDAO();
                    dao.addComment(lessonId, user.getUserId(), content.trim());
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

                CommentDAO dao = new CommentDAO();
                dao.deleteComment(commentId, user.getUserId());
                response.sendRedirect("lesson?courseId=" + courseId + "&lessonId=" + lessonId + "#comments");
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("courseController?action=ExploreCourse");
            }
        } else {
            loadLesson(request, response);
        }
    }

    /** Dùng chung để load dữ liệu rồi forward sang lesson.jsp */
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

            // Admin (role=1) và Instructor (role=2) bypass kiểm tra enroll
            // Student (role=3) vẫn phải enroll và thanh toán mới vào được
            if (user.getRole() != 1 && user.getRole() != 2) {
                EnrollDAO enrollDAO = new EnrollDAO();
                int enrollStatus = enrollDAO.getEnrollStatus(user.getUserId(), courseId);
                if (enrollStatus != 1) {
                    response.sendRedirect("courseController?action=ExploreCourse");
                    return;
                }
            }

            LessonDAO lessonDAO = new LessonDAO();
            CourseDAO courseDAO = new CourseDAO();

            List<LessonDTO> lessons = lessonDAO.getLessonsByCourse(courseId);
            CourseDTO course        = courseDAO.searchByID(String.valueOf(courseId));

            LessonDTO currentLesson = null;
            String lessonIdParam = request.getParameter("lessonId");
            if (lessonIdParam != null && !lessonIdParam.trim().isEmpty()) {
                currentLesson = lessonDAO.getLessonById(Integer.parseInt(lessonIdParam));
            } else if (!lessons.isEmpty()) {
                currentLesson = lessons.get(0);
            }

            // Load comments
            List<CommentDTO> comments = null;
            if (currentLesson != null) {
                CommentDAO commentDAO = new CommentDAO();
                comments = commentDAO.getCommentsByLesson(currentLesson.getLessonId());
            }

            request.setAttribute("courseId",      courseId);
            request.setAttribute("course",        course);
            request.setAttribute("lessons",       lessons);
            request.setAttribute("currentLesson", currentLesson);
            request.setAttribute("comments",      comments);

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

    @Override
    public String getServletInfo() { return "Lesson Controller"; }
}