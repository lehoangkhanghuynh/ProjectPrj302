package controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.CourseDAO;
import model.CourseDTO;
import model.LessonDAO;
import model.LessonDTO;
import model.UserDTO;

@WebServlet("/lesson")
public class lessonController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserDTO user = (UserDTO) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            int courseId = Integer.parseInt(request.getParameter("courseId"));

            LessonDAO lessonDAO = new LessonDAO();
            CourseDAO courseDAO = new CourseDAO();

            List<LessonDTO> lessons = lessonDAO.getLessonsByCourse(courseId);
            CourseDTO course        = courseDAO.searchByID(String.valueOf(courseId));

            // Lesson đang xem: ưu tiên param lessonId, không có thì lấy bài đầu
            LessonDTO currentLesson = null;
            String lessonIdParam = request.getParameter("lessonId");
            if (lessonIdParam != null) {
                currentLesson = lessonDAO.getLessonById(Integer.parseInt(lessonIdParam));
            } else if (!lessons.isEmpty()) {
                currentLesson = lessons.get(0);
            }

            request.setAttribute("courseId",       courseId);
            request.setAttribute("course",         course);
            request.setAttribute("lessons",        lessons);
            request.setAttribute("currentLesson",  currentLesson);
            request.getRequestDispatcher("lesson.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống!");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException { processRequest(request, response); }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException { processRequest(request, response); }

    @Override
    public String getServletInfo() { return "Lesson Controller"; }
}