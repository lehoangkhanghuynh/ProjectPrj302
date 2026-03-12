package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.UserDAO;
import model.UserDTO;
import java.util.List;

/**
 * UserController - MVC2 Front Controller cho toàn bộ chức năng User
 *
 * Các action được hỗ trợ:
 * ┌─────────────────────┬─────────────────────────────────────────────────┐
 * │ Action              │ Mô tả                                           │
 * ├─────────────────────┼─────────────────────────────────────────────────┤
 * │ login               │ Đăng nhập                                       │
 * │ logout              │ Đăng xuất                                       │
 * │ register            │ Đăng ký tài khoản mới                           │
 * │ viewProfile         │ Xem trang hồ sơ cá nhân                        │
 * │ updateUser          │ Cập nhật thông tin cá nhân                      │
 * │ updatePassword      │ Đổi mật khẩu (cần nhập mật khẩu cũ)            │
 * │ updatePasswordByEmail│ Đặt lại mật khẩu qua email (quên mật khẩu)   │
 * │ getBalance          │ Lấy số dư tài khoản (JSON)                      │
 * │ deductBalance       │ Trừ tiền tài khoản                              │
 * │ getAllUsers          │ Lấy danh sách tất cả user (Admin)               │
 * │ blockUser           │ Khoá tài khoản user (Admin)                     │
 * │ unblockUser         │ Mở khoá tài khoản user (Admin)                  │
 * │ searchUser          │ Tìm kiếm user theo ID                           │
 * └─────────────────────┴─────────────────────────────────────────────────┘
 *
 * @author Generated for DUK Academy
 */
@WebServlet("/userController")
public class UserController extends HttpServlet {

    // ────────────────────────────────────────────────────────────────────────
    // ENTRY POINT
    // ────────────────────────────────────────────────────────────────────────

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        if (action == null || action.trim().isEmpty()) {
            action = "viewProfile";
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

    // ────────────────────────────────────────────────────────────────────────
    // AUTH HANDLERS
    // ────────────────────────────────────────────────────────────────────────

    /**
     * Đăng nhập: kiểm tra userId + password, tạo session nếu thành công.
     * POST params: userId, password
     */
    private void handleLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userId   = request.getParameter("userId");
        String password = request.getParameter("password");

        // Validate đầu vào
        if (isBlank(userId) || isBlank(password)) {
            request.setAttribute("ERROR", "Vui lòng nhập đầy đủ tên đăng nhập và mật khẩu!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        UserDAO udao = new UserDAO();
        UserDTO user = udao.login(userId.trim(), password.trim());

        if (user == null) {
            request.setAttribute("ERROR", "Tên đăng nhập hoặc mật khẩu không đúng!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        if (!user.isStatus()) {
            request.setAttribute("ERROR", "Tài khoản của bạn đã bị khoá. Vui lòng liên hệ quản trị viên!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // Tạo session
        HttpSession session = request.getSession();
        session.setAttribute("user", user);
        session.setMaxInactiveInterval(30 * 60); // 30 phút

        // Điều hướng theo role
        switch (user.getRole()) {
            case 1:  // Admin
                response.sendRedirect("administrator.jsp");
                break;
            case 2:  // Instructor
                response.sendRedirect("instructorDashboard.jsp");
                break;
            default: // Student
                response.sendRedirect("homePage.jsp");
                break;
        }
    }

    /**
     * Đăng xuất: huỷ session, redirect về trang login.
     */
    private void handleLogout(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        response.sendRedirect("login.jsp");
    }

    /**
     * Đăng ký tài khoản mới.
     * POST params: userId, fullname, email, password, confirmPassword,
     *              age, location, sex, maritalStatus
     */
    private void handleRegister(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userId          = request.getParameter("userId");
        String fullname        = request.getParameter("fullname");
        String email           = request.getParameter("email");
        String password        = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String ageStr          = request.getParameter("age");
        String location        = request.getParameter("location");
        String sex             = request.getParameter("sex");
        String maritalStatus   = request.getParameter("maritalStatus");

        UserDAO udao = new UserDAO();

        try {
            // ── Validate ──────────────────────────────────────────────────
            if (isBlank(userId) || isBlank(fullname) || isBlank(email) || isBlank(password)) {
                request.setAttribute("ERROR", "Vui lòng điền đầy đủ thông tin bắt buộc!");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }

            if (!password.equals(confirmPassword)) {
                request.setAttribute("ERROR", "Mật khẩu xác nhận không khớp!");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }

            if (password.length() < 6) {
                request.setAttribute("ERROR", "Mật khẩu phải có ít nhất 6 ký tự!");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }

            if (udao.checkUsernameExist(userId.trim())) {
                request.setAttribute("ERROR", "Tên đăng nhập đã tồn tại!");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }

            if (udao.checkEmailExist(email.trim())) {
                request.setAttribute("ERROR", "Email đã được sử dụng!");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }

            // ── Tạo đối tượng & lưu DB ────────────────────────────────────
            int age = 0;
            try { age = Integer.parseInt(ageStr); } catch (Exception ignored) {}

            UserDTO newUser = new UserDTO(
                    userId.trim(),
                    fullname.trim(),
                    email.trim(),
                    password.trim(),
                    (byte) 0,   // role: 0 = student
                    true,       // status: active
                    0.0,        // balance: 0
                    age,
                    location  != null ? location.trim()       : "",
                    sex       != null ? sex.trim()            : "",
                    maritalStatus != null ? maritalStatus.trim() : ""
            );

            boolean success = udao.insertUser(newUser);

            if (success) {
                request.setAttribute("MSG", "Đăng ký thành công! Vui lòng đăng nhập.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            } else {
                request.setAttribute("ERROR", "Đăng ký thất bại! Vui lòng thử lại.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("ERROR", "Lỗi hệ thống: " + e.getMessage());
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }

    // ────────────────────────────────────────────────────────────────────────
    // PROFILE HANDLERS
    // ────────────────────────────────────────────────────────────────────────

    /**
     * Xem trang hồ sơ cá nhân (chuyển hướng đến myprofile.jsp).
     * Yêu cầu đã đăng nhập.
     */
    private void handleViewProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!isLoggedIn(request)) {
            response.sendRedirect("login.jsp");
            return;
        }
        request.getRequestDispatcher("myprofile.jsp").forward(request, response);
    }

    /**
     * Cập nhật thông tin cá nhân.
     * POST params: userId, fullname, email, age, location, sex, maritalStatus
     */
    private void handleUpdateUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!isLoggedIn(request)) {
            response.sendRedirect("login.jsp");
            return;
        }

        HttpSession session = request.getSession();
        String userId      = request.getParameter("userId");
        String fullname    = request.getParameter("fullname");
        String email       = request.getParameter("email");
        String ageStr      = request.getParameter("age");
        String location    = request.getParameter("location");
        String sex         = request.getParameter("sex");
        String maritalStatus = request.getParameter("maritalStatus");

        if (isBlank(fullname) || isBlank(email)) {
            request.setAttribute("ERROR", "Họ tên và email không được để trống!");
            request.getRequestDispatcher("myprofile.jsp").forward(request, response);
            return;
        }

        UserDAO udao = new UserDAO();
        try {
            int age = 0;
            try { age = Integer.parseInt(ageStr); } catch (Exception ignored) {}

            boolean result = udao.updateUser(userId, fullname, email, age, location, sex, maritalStatus);

            if (result) {
                // Cập nhật lại session
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

        request.getRequestDispatcher("myprofile.jsp").forward(request, response);
    }

    /**
     * Đổi mật khẩu (yêu cầu nhập mật khẩu cũ).
     * POST params: userId, oldPassword, password, confirmPassword
     */
    private void handleUpdatePassword(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!isLoggedIn(request)) {
            response.sendRedirect("login.jsp");
            return;
        }

        HttpSession session    = request.getSession();
        String userId          = request.getParameter("userId");
        String oldPassword     = request.getParameter("oldPassword");
        String password        = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // ── Client-side validation lại ở server ──────────────────────────
        if (isBlank(oldPassword) || isBlank(password) || isBlank(confirmPassword)) {
            request.setAttribute("ERRORpass", "Vui lòng điền đầy đủ các trường mật khẩu!");
            request.getRequestDispatcher("myprofile.jsp").forward(request, response);
            return;
        }

        if (password.length() < 6) {
            request.setAttribute("ERRORpass", "Mật khẩu mới phải có ít nhất 6 ký tự!");
            request.getRequestDispatcher("myprofile.jsp").forward(request, response);
            return;
        }

        if (!password.equals(confirmPassword)) {
            request.setAttribute("ERRORpass", "Mật khẩu xác nhận không khớp!");
            request.getRequestDispatcher("myprofile.jsp").forward(request, response);
            return;
        }

        UserDAO udao = new UserDAO();
        try {
            boolean result = udao.updatePassWord(userId, password, oldPassword);

            if (result) {
                UserDTO user = (UserDTO) session.getAttribute("user");
                if (user != null) user.setPassword(password);
                request.setAttribute("MSGpass", "Đổi mật khẩu thành công!");
            } else {
                request.setAttribute("ERRORpass", "Mật khẩu cũ không đúng!");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("ERRORpass", "Lỗi hệ thống!");
        }

        request.getRequestDispatcher("myprofile.jsp").forward(request, response);
    }

    /**
     * Đặt lại mật khẩu qua email (chức năng quên mật khẩu).
     * POST params: email, newPassword, confirmPassword
     */
    private void handleUpdatePasswordByEmail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email           = request.getParameter("email");
        String newPassword     = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (isBlank(email) || isBlank(newPassword)) {
            request.setAttribute("ERROR", "Email và mật khẩu mới không được để trống!");
            request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("ERROR", "Mật khẩu xác nhận không khớp!");
            request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);
            return;
        }

        if (newPassword.length() < 6) {
            request.setAttribute("ERROR", "Mật khẩu phải có ít nhất 6 ký tự!");
            request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);
            return;
        }

        UserDAO udao = new UserDAO();
        try {
            // Kiểm tra email tồn tại
            boolean emailExists = udao.checkEmailExist(email.trim());
            if (!emailExists) {
                request.setAttribute("ERROR", "Email không tồn tại trong hệ thống!");
                request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);
                return;
            }

            boolean result = udao.updatePasswordByEmail(email.trim(), newPassword.trim());

            if (result) {
                request.setAttribute("MSG", "Đặt lại mật khẩu thành công! Vui lòng đăng nhập.");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            } else {
                request.setAttribute("ERROR", "Đặt lại mật khẩu thất bại! Vui lòng thử lại.");
                request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("ERROR", "Lỗi hệ thống!");
            request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);
        }
    }

    // ────────────────────────────────────────────────────────────────────────
    // BALANCE HANDLERS
    // ────────────────────────────────────────────────────────────────────────

    /**
     * Lấy số dư tài khoản.
     * Trả về JSON: {"balance": 123456.0}
     * GET/POST param: userId
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
            // Lấy từ session nếu không truyền params
            UserDTO user = (UserDTO) request.getSession().getAttribute("user");
            if (user != null) userId = user.getUserId();
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
     * Trừ tiền khỏi tài khoản (dùng khi mua khoá học).
     * POST params: userId, amount
     */
    private void handleDeductBalance(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!isLoggedIn(request)) {
            response.sendRedirect("login.jsp");
            return;
        }

        String userId   = request.getParameter("userId");
        String amountStr = request.getParameter("amount");
        String redirectUrl = request.getParameter("redirect");
        if (isBlank(redirectUrl)) redirectUrl = "homePage.jsp";

        UserDAO udao = new UserDAO();
        try {
            double amount = Double.parseDouble(amountStr);

            if (amount <= 0) {
                request.setAttribute("ERROR", "Số tiền không hợp lệ!");
                response.sendRedirect(redirectUrl);
                return;
            }

            // Kiểm tra số dư trước
            double currentBalance = udao.getBalance(userId);
            if (currentBalance < amount) {
                request.setAttribute("ERROR", "Số dư không đủ! Vui lòng nạp thêm tiền.");
                request.getRequestDispatcher(redirectUrl).forward(request, response);
                return;
            }

            boolean result = udao.deductBalance(userId, amount);

            if (result) {
                // Cập nhật balance trong session
                HttpSession session = request.getSession();
                UserDTO user = (UserDTO) session.getAttribute("user");
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

    // ────────────────────────────────────────────────────────────────────────
    // ADMIN HANDLERS
    // ────────────────────────────────────────────────────────────────────────

    /**
     * Lấy danh sách tất cả user - chỉ dành cho Admin (role = 1).
     */
    private void handleGetAllUsers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!isAdmin(request)) {
            response.sendRedirect("homePage.jsp");
            return;
        }

        UserDAO udao = new UserDAO();
        List<UserDTO> userList = udao.getAllUsers();
        request.setAttribute("userList", userList);
        request.getRequestDispatcher("administrator.jsp").forward(request, response);
    }

    /**
     * Khoá tài khoản user - chỉ dành cho Admin (role = 1).
     * POST param: userId
     */
    private void handleBlockUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!isAdmin(request)) {
            response.sendRedirect("homePage.jsp");
            return;
        }

        String userId = request.getParameter("userId");
        UserDAO udao  = new UserDAO();
        boolean result = udao.blockUser(userId);

        if (result) {
            request.setAttribute("MSG", "Đã khoá tài khoản: " + userId);
        } else {
            request.setAttribute("ERROR", "Khoá tài khoản thất bại!");
        }

        // Reload danh sách
        request.setAttribute("userList", udao.getAllUsers());
        request.getRequestDispatcher("administrator.jsp").forward(request, response);
    }

    /**
     * Mở khoá tài khoản user - chỉ dành cho Admin (role = 1).
     * POST param: userId
     */
    private void handleUnblockUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!isAdmin(request)) {
            response.sendRedirect("homePage.jsp");
            return;
        }

        String userId = request.getParameter("userId");
        UserDAO udao  = new UserDAO();
        boolean result = udao.unblockUser(userId);

        if (result) {
            request.setAttribute("MSG", "Đã mở khoá tài khoản: " + userId);
        } else {
            request.setAttribute("ERROR", "Mở khoá tài khoản thất bại!");
        }

        // Reload danh sách
        request.setAttribute("userList", udao.getAllUsers());
        request.getRequestDispatcher("administrator.jsp").forward(request, response);
    }

    /**
     * Tìm kiếm user theo ID.
     * GET/POST param: userId
     */
    private void handleSearchUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!isAdmin(request)) {
            response.sendRedirect("homePage.jsp");
            return;
        }

        String userId = request.getParameter("userId");
        UserDAO udao  = new UserDAO();
        UserDTO found = udao.searchById(userId);

        if (found != null) {
            request.setAttribute("foundUser", found);
        } else {
            request.setAttribute("ERROR", "Không tìm thấy user với ID: " + userId);
        }

        request.setAttribute("userList", udao.getAllUsers());
        request.getRequestDispatcher("administrator.jsp").forward(request, response);
    }

    // ────────────────────────────────────────────────────────────────────────
    // HELPER METHODS
    // ────────────────────────────────────────────────────────────────────────

    /** Kiểm tra string rỗng hoặc null */
    private boolean isBlank(String s) {
        return s == null || s.trim().isEmpty();
    }

    /** Kiểm tra đã đăng nhập chưa */
    private boolean isLoggedIn(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return session != null && session.getAttribute("user") != null;
    }

    /** Kiểm tra có phải Admin (role = 1) không */
    private boolean isAdmin(HttpServletRequest request) {
        if (!isLoggedIn(request)) return false;
        UserDTO user = (UserDTO) request.getSession().getAttribute("user");
        return user != null && user.getRole() == 1;
    }

    // ────────────────────────────────────────────────────────────────────────
    // SERVLET BOILERPLATE
    // ────────────────────────────────────────────────────────────────────────

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