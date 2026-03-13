package controller;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;
import model.PasswordResetDAO;
import model.UserDAO;
import org.mindrot.jbcrypt.BCrypt;

public class ResetPasswordController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String token    = request.getParameter("token");
        String password = request.getParameter("password");
        String confirm  = request.getParameter("confirmPassword");

        if (token == null || password == null || confirm == null) {
            request.setAttribute("msg", "Dữ liệu không hợp lệ!");
            request.getRequestDispatcher("resetPassword.jsp").forward(request, response);
            return;
        }

        if (!password.equals(confirm)) {
            request.setAttribute("msg", "Mật khẩu xác nhận không khớp!");
            request.getRequestDispatcher("resetPassword.jsp?token=" + token).forward(request, response);
            return;
        }

        PasswordResetDAO dao = new PasswordResetDAO();
        String email = dao.getEmailByToken(token);

        if (email != null) {
            // ── Hash password mới trước khi lưu ──
            String hashed = BCrypt.hashpw(password, BCrypt.gensalt(12));

            UserDAO userDao = new UserDAO();
            userDao.updatePasswordByEmail(email, hashed);
            dao.deleteToken(token);

            request.setAttribute("msg", "Đổi mật khẩu thành công!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            request.setAttribute("msg", "Token không hợp lệ hoặc đã hết hạn!");
            request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);
        }
    }
}