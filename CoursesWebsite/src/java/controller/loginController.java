/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import model.LoginHistoryDAO;
import model.UserDAO;
import model.UserDTO;
import model.WishlistDAO;
import utils.EmailService;

/**
 *
 * @author HOANG KHANG PC
 */
public class loginController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();

        String userName = request.getParameter("userName");
        String password = request.getParameter("password");

        UserDAO udao = new UserDAO();
        UserDTO user = udao.login(userName, password);

        if (user != null) {
            // 1. Kiểm tra account bị khóa
            if (!user.isStatus()) {
                request.setAttribute("message", "Account is locked!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return;
            }

            // 2. Lấy IP + UserAgent
            String ip = getClientIP(request);
            String userAgent = request.getHeader("User-Agent");
            String userId = user.getUserId();

            // 3. Kiểm tra thiết bị lạ → gửi mail cảnh báo
            try {
                LoginHistoryDAO historyDAO = new LoginHistoryDAO();
                if (historyDAO.isNewDevice(userId, ip, userAgent)) {
                    String loginAt = new SimpleDateFormat("HH:mm:ss dd/MM/yyyy").format(new Date());
                    String logoPath = getServletContext().getRealPath("/img/logo/DUK.png");
                    EmailService.sendNewDeviceAlert(
                            user.getEmail(),
                            user.getFullname(),
                            ip, userAgent, loginAt, logoPath
                    );
                }
                // 4. Lưu lịch sử login
                historyDAO.insertLogin(userId, ip, userAgent);
            } catch (Exception e) {
                e.printStackTrace(); // Lỗi gửi mail không chặn login
            }

            // 5. Lưu session
            session.setAttribute("user", user);

            // 6. Load wishlist
            WishlistDAO wDao = new WishlistDAO();
            session.setAttribute("WISHLIST_IDS", wDao.getWishlistIds(userId));
            session.setAttribute("WISHLIST_COURSES", wDao.getWishlistCourses(userId));

            // 7. Phân quyền
            if (user.getRole() == 1) {
                response.sendRedirect("homePage.jsp");
            } else if (user.getRole() == 2) {
                response.sendRedirect("homePage.jsp");
            } else {
                response.sendRedirect("homePage.jsp");
            }

        } else {
            request.setAttribute("message", "Account or Password is Wrong!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    // Lấy IP thật kể cả khi dùng proxy/VPN
    private String getClientIP(HttpServletRequest request) {
        String ip = request.getHeader("X-Forwarded-For");
        if (ip == null || ip.isEmpty()) {
            ip = request.getHeader("X-Real-IP");
        }
        if (ip == null || ip.isEmpty()) {
            ip = request.getRemoteAddr();
        }
        return ip.split(",")[0].trim();
    }

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
        return "Short description";
    }
}
