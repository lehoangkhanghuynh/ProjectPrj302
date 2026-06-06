package controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Properties;
import java.util.UUID;
import javax.mail.*;
import javax.mail.internet.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import model.LoginHistoryDAO;
import model.PasswordResetDAO;
import model.UserDAO;
import model.UserDTO;
import model.WishlistDAO;
import org.mindrot.jbcrypt.BCrypt;
import service.EmailService;

/**
 * UserController - MVC2 Front Controller cho toàn bộ chức năng User
 *
 * Các action được hỗ trợ:
 * ┌──────────────────────────┬───────────────────────────────────────────────────┐
 * │ Action │ Mô tả │
 * ├──────────────────────────┼───────────────────────────────────────────────────┤
 * │ login │ Đăng nhập (BCrypt + ghi LoginHistory + Wishlist) │ │ logout │ Đăng
 * xuất │ │ register │ Đăng ký tài khoản mới (BCrypt hash password) │ │
 * viewProfile │ Xem trang hồ sơ cá nhân │ │ updateUser │ Cập nhật thông tin cá
 * nhân │ │ updatePassword │ Đổi mật khẩu (cần nhập mật khẩu cũ) │ │
 * updatePasswordByEmail │ Đặt lại mật khẩu qua email (quên mật khẩu) │ │
 * forgotPassword │ Gửi link reset password qua email │ │ resetPassword │ Đặt
 * lại mật khẩu bằng token từ email │ │ getBalance │ Lấy số dư tài khoản (JSON)
 * │ │ deductBalance │ Trừ tiền tài khoản │ │ getAllUsers │ Lấy danh sách tất cả
 * user (Admin) │ │ blockUser │ Khoá tài khoản user (Admin) │ │ unblockUser │ Mở
 * khoá tài khoản user (Admin) │ │ searchUser │ Tìm kiếm user theo ID │
 * └──────────────────────────┴───────────────────────────────────────────────────┘
 *
 * @author DUK Academy
 */

public class UserController extends HttpServlet {

    // ════════════════════════════════════════════════════════════════════════
    // ENTRY POINT
    // ════════════════════════════════════════════════════════════════════════
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        if (isBlank(action)) {
            // Suy luận action từ URL nếu không có param
            String uri = request.getRequestURI();
            if (uri.contains("/register")) {
                action = "register";
            } else if (uri.contains("/updateUser")) {
                action = "updateUser";
            } else if (uri.contains("/auth")) {
                action = "login";
            } else {
                action = "viewProfile";
            }
        }

        switch (action) {

            // ── AUTH ──────────────────────────────────────────────────────
            case "login":
                handleLogin(request, response);
                break;
            case "logout":
                handleLogout(request, response);
                break;
            case "register":
                handleRegister(request, response);
                break;

            // ── PROFILE ───────────────────────────────────────────────────
            case "viewProfile":
                handleViewProfile(request, response);
                break;
            case "updateUser":
                handleUpdateUser(request, response);
                break;
            case "updatePassword":
                handleUpdatePassword(request, response);
                break;
            case "updatePasswordByEmail":
                handleUpdatePasswordByEmail(request, response);
                break;

            // ── PASSWORD RESET (token-based) ──────────────────────────────
            case "forgotPassword":
                handleForgotPassword(request, response);
                break;
            case "resetPassword":
                handleResetPassword(request, response);
                break;

            // ── BALANCE ───────────────────────────────────────────────────
            case "getBalance":
                handleGetBalance(request, response);
                break;
            case "deductBalance":
                handleDeductBalance(request, response);
                break;

            // ── ADMIN ─────────────────────────────────────────────────────
            case "getAllUsers":
                handleGetAllUsers(request, response);
                break;
            case "blockUser":
                handleBlockUser(request, response);
                break;
            case "unblockUser":
                handleUnblockUser(request, response);
                break;
            case "searchUser":
                handleSearchUser(request, response);
                break;

            // ── DEFAULT ───────────────────────────────────────────────────
            default:
                response.sendRedirect("homePage.jsp");
                break;
        }
    }

    // ════════════════════════════════════════════════════════════════════════
    // AUTH HANDLERS
    // ════════════════════════════════════════════════════════════════════════
    /**
     * Đăng nhập. - Kiểm tra userId + password (BCrypt). - Phát hiện thiết bị
     * mới → gửi email cảnh báo qua EmailService. - Ghi LoginHistory. - Nạp
     * Wishlist vào session. POST params: userName, password
     */
    private void handleLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userName = request.getParameter("userName");
        String password = request.getParameter("password");

        if (isBlank(userName) || isBlank(password)) {
            request.setAttribute("message", "Vui lòng nhập đầy đủ tên đăng nhập và mật khẩu!");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        UserDAO udao = new UserDAO();
        UserDTO user = udao.searchById(userName.trim());

        // Kiểm tra password (hỗ trợ cả BCrypt và plain-text legacy)
        boolean passwordMatch = false;
        if (user != null && user.getPassword() != null) {
            try {
                passwordMatch = BCrypt.checkpw(password, user.getPassword());
            } catch (Exception e) {
                passwordMatch = password.equals(user.getPassword());
            }
        }

        if (user == null || !passwordMatch) {
            request.setAttribute("message", "Tên đăng nhập hoặc mật khẩu không đúng!");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        if (!user.isStatus()) {
            request.setAttribute("message", "Tài khoản của bạn đã bị khoá. Vui lòng liên hệ quản trị viên!");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        // ── Ghi login history & cảnh báo thiết bị mới ────────────────────
        String ip = getClientIP(request);
        String userAgent = request.getHeader("User-Agent");
        String userId = user.getUserId();
        try {
            LoginHistoryDAO historyDAO = new LoginHistoryDAO();
            if (historyDAO.isNewDevice(userId, ip, userAgent)) {
                String loginAt = new SimpleDateFormat("HH:mm:ss dd/MM/yyyy").format(new Date());
                String logoPath = getServletContext().getRealPath("/img/logo/DUK.png");
                EmailService.sendNewDeviceAlert(
                        user.getEmail(), user.getFullname(),
                        ip, userAgent, loginAt, logoPath);
            }
            historyDAO.insertLogin(userId, ip, userAgent);
        } catch (Exception e) {
            e.printStackTrace(); // Lỗi history không chặn đăng nhập
        }

        // ── Tạo session ───────────────────────────────────────────────────
        HttpSession session = request.getSession();
        session.setAttribute("user", user);
        // Thêm role vào session để RoleFilter đọc được
        String roleStr;
        switch (user.getRole()) {
            case 1:
                roleStr = "ADMIN";
                break;
            case 2:
                roleStr = "INSTRUCTOR";
                break;
            default:
                roleStr = "USER";
                break;
        }
        session.setAttribute("role", roleStr);
        
        session.setMaxInactiveInterval(30 * 60); // 30 phút

        WishlistDAO wDao = new WishlistDAO();
        session.setAttribute("WISHLIST_IDS", wDao.getWishlistIds(userId));
        session.setAttribute("WISHLIST_COURSES", wDao.getWishlistCourses(userId));

        // ── Điều hướng theo role ──────────────────────────────────────────
        String ctx = request.getContextPath();
        switch (user.getRole()) {
            case 1:
                response.sendRedirect(ctx + "/homePage.jsp");
                break;
            case 2:
                response.sendRedirect(ctx + "/homePage.jsp");
                break;
            default:
                response.sendRedirect(ctx + "/homePage.jsp");
                break;
        }
    }

    /**
     * Đăng xuất: huỷ session, redirect về login.
     */
    private void handleLogout(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }

    /**
     * Đăng ký tài khoản mới (BCrypt hash password trước khi lưu). POST params:
     * userName, fullname, email, password, confirmPassword, age, location, sex,
     * maritalStatus
     */
    private void handleRegister(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userName = request.getParameter("userName");
        String fullName = request.getParameter("fullname");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String ageStr = request.getParameter("age");
        String location = request.getParameter("location");
        String sex = request.getParameter("sex");
        String maritalStatus = request.getParameter("maritalStatus");

        UserDAO dao = new UserDAO();
        String msg = "";
        boolean isSuccess = false;

        try {
            if (isBlank(userName) || isBlank(fullName) || isBlank(email) || isBlank(password)) {
                msg = "Vui lòng nhập đầy đủ thông tin bắt buộc!";
            } else if (!password.equals(confirmPassword)) {
                msg = "Mật khẩu xác nhận không khớp!";
            } else if (password.length() < 6) {
                msg = "Mật khẩu phải có ít nhất 6 ký tự!";
            } else if (dao.checkUsernameExist(userName.trim())) {
                msg = "Tên đăng nhập '" + userName + "' đã tồn tại!";
            } else if (dao.checkEmailExist(email.trim())) {
                msg = "Email này đã được sử dụng!";
            } else {
                int age = 0;
                try {
                    age = Integer.parseInt(ageStr);
                } catch (Exception ignored) {
                }

                // Hash password trước khi lưu
                String hashed = BCrypt.hashpw(password, BCrypt.gensalt(12));

                UserDTO newUser = new UserDTO(
                        userName.trim(), fullName.trim(), email.trim(), hashed,
                        (byte) 3, true, 0.0, age,
                        location != null ? location.trim() : "",
                        sex != null ? sex.trim() : "",
                        maritalStatus != null ? maritalStatus.trim() : ""
                );

                if (dao.insertUser(newUser)) {
                    msg = "Đăng ký thành công! Vui lòng đăng nhập.";
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
            request.setAttribute("oldUser", userName);
            request.setAttribute("oldFullname", fullName);
            request.setAttribute("oldEmail", email);
        }
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    // ════════════════════════════════════════════════════════════════════════
    // PROFILE HANDLERS
    // ════════════════════════════════════════════════════════════════════════
    /**
     * Xem trang hồ sơ cá nhân.
     */
    private void handleViewProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!isLoggedIn(request)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        request.getRequestDispatcher("/user/myprofile.jsp").forward(request, response);
    }

    /**
     * Cập nhật thông tin cá nhân. POST params: userId, fullname, email, age,
     * location, sex, maritalStatus
     */
    private void handleUpdateUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!isLoggedIn(request)) {
            response.sendRedirect("login.jsp");
            return;
        }

        HttpSession session = request.getSession();
        String userId = request.getParameter("userId");
        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String ageStr = request.getParameter("age");
        String location = request.getParameter("location");
        String sex = request.getParameter("sex");
        String maritalStatus = request.getParameter("maritalStatus");

        if (isBlank(fullname) || isBlank(email)) {
            request.setAttribute("ERROR", "Họ tên và email không được để trống!");
            request.getRequestDispatcher("/user/myprofile.jsp").forward(request, response);
            return;
        }

        UserDAO udao = new UserDAO();
        try {
            int age = 0;
            try {
                age = Integer.parseInt(ageStr);
            } catch (Exception ignored) {
            }

            boolean result = udao.updateUser(userId, fullname, email, age, location, sex, maritalStatus);

            if (result) {
                UserDTO user = (UserDTO) session.getAttribute("user");
                if (user != null) {
                    user.setFullname(fullname);
                    user.setEmail(email);
                    user.setAge(age);
                    user.setLocation(location);
                    user.setSex(sex);
                    user.setMarital_status(maritalStatus);
                }
                request.setAttribute("MSG", "Cập nhật thông tin thành công!");
            } else {
                request.setAttribute("ERROR", "Cập nhật thất bại!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("ERROR", "Lỗi hệ thống!");
        }
        request.getRequestDispatcher("/user/myprofile.jsp").forward(request, response);
    }

    /**
     * Đổi mật khẩu (yêu cầu nhập mật khẩu cũ, hỗ trợ BCrypt). POST params:
     * userId, oldPassword, password, confirmPassword
     */
    private void handleUpdatePassword(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!isLoggedIn(request)) {
            response.sendRedirect("login.jsp");
            return;
        }

        HttpSession session = request.getSession();
        String userId = request.getParameter("userId");
        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        if (isBlank(oldPassword) || isBlank(newPassword) || isBlank(confirmPassword)) {
            request.setAttribute("ERRORpass", "Vui lòng điền đầy đủ các trường mật khẩu!");
            request.getRequestDispatcher("/user/myprofile.jsp").forward(request, response);
            return;
        }
        if (newPassword.length() < 6) {
            request.setAttribute("ERRORpass", "Mật khẩu mới phải có ít nhất 6 ký tự!");
            request.getRequestDispatcher("/user/myprofile.jsp").forward(request, response);
            return;
        }
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("ERRORpass", "Mật khẩu xác nhận không khớp!");
            request.getRequestDispatcher("/user/myprofile.jsp").forward(request, response);
            return;
        }

        UserDAO udao = new UserDAO();
        try {
            UserDTO current = udao.searchById(userId);

            // Kiểm tra mật khẩu cũ (hỗ trợ BCrypt & plain-text legacy)
            boolean oldMatch;
            try {
                oldMatch = BCrypt.checkpw(oldPassword, current.getPassword());
            } catch (Exception e) {
                oldMatch = oldPassword.equals(current.getPassword());
            }

            if (!oldMatch) {
                request.setAttribute("ERRORpass", "Mật khẩu cũ không đúng!");
                request.getRequestDispatcher("/user/myprofile.jsp").forward(request, response);
                return;
            }

            String hashed = BCrypt.hashpw(newPassword, BCrypt.gensalt(12));
            boolean result = udao.updatePassWord(userId, hashed, current.getPassword());

            if (result) {
                UserDTO user = (UserDTO) session.getAttribute("user");
                if (user != null) {
                    user.setPassword(hashed);
                }
                request.setAttribute("MSGpass", "Đổi mật khẩu thành công!");
            } else {
                request.setAttribute("ERRORpass", "Lỗi hệ thống!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("ERRORpass", "Lỗi hệ thống!");
        }
        request.getRequestDispatcher("/user/myprofile.jsp").forward(request, response);
    }

    /**
     * Đặt lại mật khẩu trực tiếp qua email (không cần token). POST params:
     * email, newPassword, confirmPassword
     */
    private void handleUpdatePasswordByEmail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (isBlank(email) || isBlank(newPassword)) {
            request.setAttribute("ERROR", "Email và mật khẩu mới không được để trống!");
            request.getRequestDispatcher("/password/forgotPassword.jsp").forward(request, response);
            return;
        }
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("ERROR", "Mật khẩu xác nhận không khớp!");
            request.getRequestDispatcher("/password/forgotPassword.jsp").forward(request, response);
            return;
        }
        if (newPassword.length() < 6) {
            request.setAttribute("ERROR", "Mật khẩu phải có ít nhất 6 ký tự!");
            request.getRequestDispatcher("/password/forgotPassword.jsp").forward(request, response);
            return;
        }

        UserDAO udao = new UserDAO();
        try {
            if (!udao.checkEmailExist(email.trim())) {
                request.setAttribute("ERROR", "Email không tồn tại trong hệ thống!");
                request.getRequestDispatcher("/password/forgotPassword.jsp").forward(request, response);
                return;
            }

            String hashed = BCrypt.hashpw(newPassword, BCrypt.gensalt(12));
            boolean result = udao.updatePasswordByEmail(email.trim(), hashed);

            if (result) {
                request.setAttribute("MSG", "Đặt lại mật khẩu thành công! Vui lòng đăng nhập.");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
            } else {
                request.setAttribute("ERROR", "Đặt lại mật khẩu thất bại! Vui lòng thử lại.");
                request.getRequestDispatcher("/password/forgotPassword.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("ERROR", "Lỗi hệ thống!");
            request.getRequestDispatcher("/password/forgotPassword.jsp").forward(request, response);
        }
    }

    // ════════════════════════════════════════════════════════════════════════
    // PASSWORD RESET (token-based)
    // ════════════════════════════════════════════════════════════════════════
    /**
     * Gửi link reset password qua email (tạo UUID token, lưu DB, gửi mail).
     * POST param: email
     */
    private void handleForgotPassword(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    response.setContentType("text/html;charset=UTF-8");
    String email = request.getParameter("email");
    UserDAO udao = new UserDAO();

    try {
        if (!udao.checkEmailExist(email)) {
            request.setAttribute("msg", "Email không tồn tại!");
            request.getRequestDispatcher("/password/forgotPassword.jsp").forward(request, response);
            return;
        }

        String token = UUID.randomUUID().toString();
        String userId = udao.getUserIdByEmail(email);
        String fullname = udao.getFullnameByEmail(email);

        PasswordResetDAO dao = new PasswordResetDAO();
        dao.insertToken(token, userId, email);

        String resetLink = "http://localhost:8080/CoursesWebsite/password/resetPassword.jsp?token=" + token;
        String logoPath = getServletContext().getRealPath("/img/logo/DUK.png");
        EmailService.sendResetPassword(email, fullname, resetLink, logoPath);

        request.setAttribute("msg", "success");
        request.getRequestDispatcher("/password/forgotPassword.jsp").forward(request, response);

    } catch (Exception e) {
        e.printStackTrace();
        request.setAttribute("msg", "Lỗi gửi email! Vui lòng thử lại.");
        request.getRequestDispatcher("/password/forgotPassword.jsp").forward(request, response);
    }
}


    /**
     * Đặt lại mật khẩu bằng token nhận từ email. POST params: token, password,
     * confirmPassword
     */
    private void handleResetPassword(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    String token = request.getParameter("token");
    String password = request.getParameter("password");
    String confirm = request.getParameter("confirmPassword");

    if (!password.equals(confirm)) {
        request.setAttribute("msg", "Mật khẩu xác nhận không khớp!");
        request.getRequestDispatcher("/password/resetPassword.jsp?token=" + token)
                .forward(request, response);
        return;
    }

    PasswordResetDAO dao = new PasswordResetDAO();
    String email = dao.getEmailByToken(token);

    if (email != null) {
        String hashed = BCrypt.hashpw(password, BCrypt.gensalt(12));
        new UserDAO().updatePasswordByEmail(email, hashed);
        dao.deleteToken(token);

        response.sendRedirect(request.getContextPath() + "/login.jsp?resetSuccess=1");
    } else {
        request.setAttribute("msg", "Token không hợp lệ hoặc đã hết hạn!");
        request.getRequestDispatcher("/password/forgotPassword.jsp").forward(request, response);
    }
}

    // ════════════════════════════════════════════════════════════════════════
    // BALANCE HANDLERS
    // ════════════════════════════════════════════════════════════════════════
    /**
     * Lấy số dư tài khoản. Trả về JSON: {"balance": 123456.0} GET/POST param:
     * userId (tuỳ chọn, mặc định lấy từ session)
     */
    private void handleGetBalance(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!isLoggedIn(request)) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("{\"error\":\"Chưa đăng nhập\"}");
            return;
        }

        String userId = request.getParameter("userId");
        if (isBlank(userId)) {
            UserDTO user = (UserDTO) request.getSession().getAttribute("user");
            if (user != null) {
                userId = user.getUserId();
            }
        }

        UserDAO udao = new UserDAO();
        try {
            double balance = udao.getBalance(userId);
            response.setContentType("application/json;charset=UTF-8");
            response.getWriter().write("{\"balance\":" + balance + "}");
        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\":\"Lỗi hệ thống\"}");
        }
    }

    /**
     * Trừ tiền khỏi tài khoản (dùng khi mua khoá học). POST params: userId,
     * amount, redirect (tuỳ chọn)
     */
    private void handleDeductBalance(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!isLoggedIn(request)) {
            response.sendRedirect("login.jsp");
            return;
        }

        String userId = request.getParameter("userId");
        String amountStr = request.getParameter("amount");
        String redirectUrl = request.getParameter("redirect");
        if (isBlank(redirectUrl)) {
            redirectUrl = "homePage.jsp";
        }

        UserDAO udao = new UserDAO();
        try {
            double amount = Double.parseDouble(amountStr);
            if (amount <= 0) {
                request.setAttribute("ERROR", "Số tiền không hợp lệ!");
                response.sendRedirect(redirectUrl);
                return;
            }

            double currentBalance = udao.getBalance(userId);
            if (currentBalance < amount) {
                request.setAttribute("ERROR", "Số dư không đủ! Vui lòng nạp thêm tiền.");
                request.getRequestDispatcher(redirectUrl).forward(request, response);
                return;
            }

            boolean result = udao.deductBalance(userId, amount);
            if (result) {
                UserDTO user = (UserDTO) request.getSession().getAttribute("user");
                if (user != null) {
                    user.setBalance(currentBalance - amount);
                }
                request.setAttribute("MSG", "Thanh toán thành công!");
            } else {
                request.setAttribute("ERROR", "Thanh toán thất bại! Số dư không đủ.");
            }
            response.sendRedirect(redirectUrl);

        } catch (NumberFormatException e) {
            request.setAttribute("ERROR", "Số tiền không hợp lệ!");
            response.sendRedirect(redirectUrl);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("ERROR", "Lỗi hệ thống!");
            response.sendRedirect(redirectUrl);
        }
    }

    // ════════════════════════════════════════════════════════════════════════
    // ADMIN HANDLERS
    // ════════════════════════════════════════════════════════════════════════
    /**
     * Lấy danh sách tất cả user (Admin only).
     */
    private void handleGetAllUsers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!isAdmin(request)) {
            response.sendRedirect(request.getContextPath() + "/homePage.jsp");
            return;
        }

        UserDAO udao = new UserDAO();
        request.setAttribute("userList", udao.getAllUsers());
        request.getRequestDispatcher("/admin/administrator.jsp").forward(request, response);
    }

    /**
     * Khoá tài khoản user (Admin only). POST param: userId
     */
    private void handleBlockUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!isAdmin(request)) {
            response.sendRedirect("homePage.jsp");
            return;
        }

        String userId = request.getParameter("userId");
        UserDAO udao = new UserDAO();
        boolean result = udao.blockUser(userId);

        request.setAttribute(result ? "MSG" : "ERROR",
                result ? "Đã khoá tài khoản: " + userId : "Khoá tài khoản thất bại!");
        request.setAttribute("userList", udao.getAllUsers());
        request.getRequestDispatcher("/admin/administrator.jsp").forward(request, response);
    }

    /**
     * Mở khoá tài khoản user (Admin only). POST param: userId
     */
    private void handleUnblockUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!isAdmin(request)) {
            response.sendRedirect("homePage.jsp");
            return;
        }

        String userId = request.getParameter("userId");
        UserDAO udao = new UserDAO();
        boolean result = udao.unblockUser(userId);

        request.setAttribute(result ? "MSG" : "ERROR",
                result ? "Đã mở khoá tài khoản: " + userId : "Mở khoá tài khoản thất bại!");
        request.setAttribute("userList", udao.getAllUsers());
        request.getRequestDispatcher("/admin/administrator.jsp").forward(request, response);
    }

    /**
     * Tìm kiếm user theo ID (Admin only). GET/POST param: userId
     */
    private void handleSearchUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!isAdmin(request)) {
            response.sendRedirect("homePage.jsp");
            return;
        }

        String userId = request.getParameter("userId");
        UserDAO udao = new UserDAO();
        UserDTO found = udao.searchById(userId);

        if (found != null) {
            request.setAttribute("foundUser", found);
        } else {
            request.setAttribute("ERROR", "Không tìm thấy user với ID: " + userId);
        }

        request.setAttribute("userList", udao.getAllUsers());
        request.getRequestDispatcher("/admin/administrator.jsp").forward(request, response);
    }

    // ════════════════════════════════════════════════════════════════════════
    // HELPER METHODS
    // ════════════════════════════════════════════════════════════════════════
    /**
     * Lấy IP thật của client (hỗ trợ proxy / load-balancer)
     */
    private String getClientIP(HttpServletRequest request) {
        String ip = request.getHeader("X-Forwarded-For");
        if (isBlank(ip)) {
            ip = request.getHeader("X-Real-IP");
        }
        if (isBlank(ip)) {
            ip = request.getRemoteAddr();
        }
        return ip.split(",")[0].trim();
    }

    /**
     * Kiểm tra string rỗng hoặc null
     */
    private boolean isBlank(String s) {
        return s == null || s.trim().isEmpty();
    }

    /**
     * Kiểm tra đã đăng nhập chưa
     */
    private boolean isLoggedIn(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return session != null && session.getAttribute("user") != null;
    }

    /**
     * Kiểm tra có phải Admin (role = 1) không
     */
    private boolean isAdmin(HttpServletRequest request) {
        if (!isLoggedIn(request)) {
            return false;
        }
        UserDTO user = (UserDTO) request.getSession().getAttribute("user");
        return user != null && user.getRole() == 1;
    }

    // ════════════════════════════════════════════════════════════════════════
    // SERVLET BOILERPLATE
    // ════════════════════════════════════════════════════════════════════════
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
        return "UserController - MVC2 Full User Management";
    }
}
