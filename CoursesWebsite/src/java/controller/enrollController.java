package controller;

import model.EnrollDAO;
import model.UserDAO;
import model.UserDTO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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

        String userId = user.getUserId();
        int courseId = Integer.parseInt(request.getParameter("courseId"));

        EnrollDAO enrollDAO = new EnrollDAO();
        UserDAO userDAO = new UserDAO();

        try {
            double fee = enrollDAO.getCourseFee(courseId);
            double balance = userDAO.getBalance(userId); // lấy balance mới nhất từ DB

            // Kiểm tra đã enroll và đã thanh toán chưa
            if (enrollDAO.isEnrolled(userId, courseId)) {
                int status = enrollDAO.getEnrollStatus(userId, courseId);
                if (status == 1) {
                    request.setAttribute("enrollmessage", "Bạn đã đăng ký khóa học này rồi!");
                    request.getRequestDispatcher("myCourses.jsp").forward(request, response);
                    return;
                }
            }

            // Kiểm tra số dư
            if (balance < fee) {
                request.setAttribute("enrollmessage", "Số dư không đủ! Vui lòng nạp thêm tiền.");
                request.getRequestDispatcher("listCourse.jsp").forward(request, response);
                return;
            }

            // Enroll nếu chưa có bản ghi
            if (!enrollDAO.isEnrolled(userId, courseId)) {
                enrollDAO.enrollCourse(userId, courseId);
            }

            // Trừ tiền (dùng deductBalance — an toàn hơn vì check balance >= fee trong SQL)
            boolean deducted = userDAO.deductBalance(userId, fee);
            if (!deducted) {
                request.setAttribute("enrollmessage", "Số dư không đủ! Vui lòng nạp thêm tiền.");
                request.getRequestDispatcher("listCourse.jsp").forward(request, response);
                return;
            }

            // Cập nhật status enroll = 1
            enrollDAO.updateStatus(userId, courseId, 1);

            // Cập nhật lại balance trong session
            user.setBalance(balance - fee);
            session.setAttribute("user", user);

            // Chuyển sang trang khóa học của tôi
            response.sendRedirect("myCourses");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống!");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}