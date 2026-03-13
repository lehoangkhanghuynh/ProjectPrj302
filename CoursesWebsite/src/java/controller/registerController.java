package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.UserDAO;
import model.UserDTO;
import org.mindrot.jbcrypt.BCrypt;

public class registerController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String userName = request.getParameter("userName");
        String fullName = request.getParameter("fullname");
        String email    = request.getParameter("email");
        String password = request.getParameter("password");
        String confirm  = request.getParameter("confirmPassword");

        String msg = "";
        boolean isSuccess = false;
        UserDAO dao = new UserDAO();

        try {
            if (userName.isEmpty() || fullName.isEmpty() || email.isEmpty() || password.isEmpty()) {
                msg = "Vui lòng nhập đầy đủ thông tin!";
            } else if (!password.equals(confirm)) {
                msg = "Mật khẩu xác nhận không khớp!";
            } else if (dao.checkUsernameExist(userName)) {
                msg = "Tên đăng nhập '" + userName + "' đã tồn tại!";
            } else if (dao.checkEmailExist(email)) {
                msg = "Email này đã được sử dụng!";
            } else {
                // ── Hash password trước khi lưu ──
                String hashed = BCrypt.hashpw(password, BCrypt.gensalt(12));

                UserDTO user = new UserDTO(userName, fullName, email, hashed, (byte) 3, true, 0, 0, "", "", "");
                if (dao.insertUser(user)) {
                    msg = "Đăng ký thành công! Giờ bạn có thể đăng nhập.";
                    isSuccess = true;
                } else {
                    msg = "Lỗi hệ thống khi lưu dữ liệu!";
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            msg = "Lỗi kết nối cơ sở dữ liệu!";
        }

        request.setAttribute("registerMessage", msg);
        request.setAttribute("isSuccess", isSuccess);
        if (!isSuccess) {
            request.setAttribute("oldUser",     userName);
            request.setAttribute("oldFullname", fullName);
            request.setAttribute("oldEmail",    email);
        }
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException { processRequest(req, res); }
    @Override protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException { processRequest(req, res); }
    @Override public String getServletInfo() { return "registerController"; }
}