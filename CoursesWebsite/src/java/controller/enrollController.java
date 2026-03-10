package controller;

import model.EnrollDAO;
import model.LessonDAO;
import model.LessonDTO;
import model.UserDAO;
import model.UserDTO;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * @author HOANG KHANG PC
 */
@WebServlet("/enroll")
public class enrollController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        UserDTO user = (UserDTO) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String userId   = user.getUserId();
        int    courseId = Integer.parseInt(request.getParameter("courseId"));

        EnrollDAO enrollDAO = new EnrollDAO();
        UserDAO   userDAO   = new UserDAO();
        LessonDAO lessonDAO = new LessonDAO();

        try {
            // Lấy balance mới nhất từ DB (tránh dùng session cũ)
            double fee     = enrollDAO.getCourseFee(courseId);
            double balance = userDAO.getBalance(userId);

            // Đã enroll rồi (status >= 1) → vào thẳng bài học
            if (enrollDAO.isEnrolled(userId, courseId)) {
                int status = enrollDAO.getEnrollStatus(userId, courseId);
                if (status >= 1) {
                    // ── FIX: redirect về LessonServlet kèm lessonId bài đầu ──
                    response.sendRedirect(buildLessonUrl(lessonDAO, courseId));
                    return;
                }
            }

            // Kiểm tra số dư
            if (balance < fee) {
                request.setAttribute("enrollmessage", "Số dư không đủ! Vui lòng nạp thêm tiền.");
                request.getRequestDispatcher("courseController?action=ExploreCourse")
                       .forward(request, response);
                return;
            }

            // Enroll nếu chưa có bản ghi
            if (!enrollDAO.isEnrolled(userId, courseId)) {
                enrollDAO.enrollCourse(userId, courseId);
            }

            // Trừ tiền (safe: SQL check balance >= fee)
            boolean deducted = userDAO.deductBalance(userId, fee);
            if (!deducted) {
                request.setAttribute("enrollmessage", "Số dư không đủ! Vui lòng nạp thêm tiền.");
                request.getRequestDispatcher("courseController?action=ExploreCourse")
                       .forward(request, response);
                return;
            }

            // Cập nhật status = 1 (đã thanh toán)
            enrollDAO.updateStatus(userId, courseId, 1);

            // Cập nhật lại balance trong session
            user.setBalance(balance - fee);
            session.setAttribute("user", user);

            // ── FIX: redirect về LessonServlet (không phải lesson.jsp) kèm lessonId ──
            response.sendRedirect(buildLessonUrl(lessonDAO, courseId));

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    /**
     * Tạo URL redirect đến LessonServlet với bài đầu tiên của khóa học.
     * Ví dụ: "lesson?courseId=3&lessonId=7"
     */
    private String buildLessonUrl(LessonDAO lessonDAO, int courseId) {
        try {
            List<LessonDTO> lessons = lessonDAO.getLessonsByCourse(courseId);
            if (lessons != null && !lessons.isEmpty()) {
                int firstLessonId = lessons.get(0).getLessonId();
                return "lesson?courseId=" + courseId + "&lessonId=" + firstLessonId;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        // Fallback: vẫn vào đúng servlet, để LessonServlet tự lấy bài đầu
        return "lesson?courseId=" + courseId;
    }
}
