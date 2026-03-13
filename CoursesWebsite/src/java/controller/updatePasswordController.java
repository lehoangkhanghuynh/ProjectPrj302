package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import model.UserDAO;
import model.UserDTO;
import org.mindrot.jbcrypt.BCrypt;

public class updatePasswordController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();

        String userId          = request.getParameter("userId");
        String oldPassword     = request.getParameter("oldPassword");
        String newPassword     = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("ERRORpass", "Mật khẩu xác nhận không khớp!");
            request.getRequestDispatcher("myprofile.jsp").forward(request, response);
            return;
        }

        UserDAO udao = new UserDAO();
        try {
            // ── Lấy user hiện tại để verify old password ──
            UserDTO current = udao.searchById(userId);
            if (current == null) {
                request.setAttribute("ERRORpass", "Không tìm thấy tài khoản!");
                request.getRequestDispatcher("myprofile.jsp").forward(request, response);
                return;
            }

            // ── Verify old password (hỗ trợ cả plain text cũ lẫn BCrypt) ──
            boolean oldMatch;
            try {
                oldMatch = BCrypt.checkpw(oldPassword, current.getPassword());
            } catch (Exception e) {
                oldMatch = oldPassword.equals(current.getPassword());
            }

            if (!oldMatch) {
                request.setAttribute("ERRORpass", "Mật khẩu cũ không đúng!");
                request.getRequestDispatcher("myprofile.jsp").forward(request, response);
                return;
            }

            // ── Hash password mới ──
            String hashed = BCrypt.hashpw(newPassword, BCrypt.gensalt(12));

            // ── Update DB với password đã hash ──
            boolean result = udao.updatePassWord(userId, hashed, current.getPassword());
            if (result) {
                // Cập nhật session
                UserDTO user = (UserDTO) session.getAttribute("user");
                if (user != null) user.setPassword(hashed);
                request.setAttribute("MSGpass", "Đổi mật khẩu thành công!");
            } else {
                request.setAttribute("ERRORpass", "Lỗi hệ thống khi cập nhật!");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("ERRORpass", "Lỗi hệ thống!");
        }

        request.getRequestDispatcher("myprofile.jsp").forward(request, response);
    }

    @Override protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException { processRequest(req, res); }
    @Override protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException { processRequest(req, res); }
    @Override public String getServletInfo() { return "updatePasswordController"; }
}