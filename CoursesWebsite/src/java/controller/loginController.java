package controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import model.LoginHistoryDAO;
import model.UserDAO;
import model.UserDTO;
import model.WishlistDAO;
import org.mindrot.jbcrypt.BCrypt;
import utils.EmailService;

public class loginController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();

        String userName = request.getParameter("userName");
        String password = request.getParameter("password");

        UserDAO udao = new UserDAO();

        // ── Lấy user theo username (không verify password trong SQL nữa) ──
        UserDTO user = udao.searchById(userName);

        // ── Verify password bằng BCrypt ──
        boolean passwordMatch = false;
        if (user != null && user.getPassword() != null) {
            try {
                passwordMatch = BCrypt.checkpw(password, user.getPassword());
            } catch (Exception e) {
                // Nếu password trong DB chưa hash (plain text cũ) → so sánh trực tiếp
                passwordMatch = password.equals(user.getPassword());
            }
        }

        if (user != null && passwordMatch) {
            if (!user.isStatus()) {
                request.setAttribute("message", "Account is locked!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }

            String ip        = getClientIP(request);
            String userAgent = request.getHeader("User-Agent");
            String userId    = user.getUserId();

            try {
                LoginHistoryDAO historyDAO = new LoginHistoryDAO();
                if (historyDAO.isNewDevice(userId, ip, userAgent)) {
                    String loginAt  = new SimpleDateFormat("HH:mm:ss dd/MM/yyyy").format(new Date());
                    String logoPath = getServletContext().getRealPath("/img/logo/DUK.png");
                    EmailService.sendNewDeviceAlert(
                            user.getEmail(), user.getFullname(),
                            ip, userAgent, loginAt, logoPath);
                }
                historyDAO.insertLogin(userId, ip, userAgent);
            } catch (Exception e) {
                e.printStackTrace();
            }

            session.setAttribute("user", user);

            WishlistDAO wDao = new WishlistDAO();
            session.setAttribute("WISHLIST_IDS",     wDao.getWishlistIds(userId));
            session.setAttribute("WISHLIST_COURSES", wDao.getWishlistCourses(userId));

            response.sendRedirect("homePage.jsp");

        } else {
            request.setAttribute("message", "Account or Password is Wrong!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    private String getClientIP(HttpServletRequest request) {
        String ip = request.getHeader("X-Forwarded-For");
        if (ip == null || ip.isEmpty()) ip = request.getHeader("X-Real-IP");
        if (ip == null || ip.isEmpty()) ip = request.getRemoteAddr();
        return ip.split(",")[0].trim();
    }

    @Override protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException { processRequest(req, res); }
    @Override protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException { processRequest(req, res); }
    @Override public String getServletInfo() { return "loginController"; }
}