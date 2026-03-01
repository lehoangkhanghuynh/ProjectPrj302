/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.UserDAO;
import model.UserDTO;

/**
 *
 * @author ASUS
 */
public class registerController extends HttpServlet {

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
        // 1. Lấy dữ liệu từ form
         request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String userName = request.getParameter("userName");
        String fullName = request.getParameter("fullname");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirm = request.getParameter("confirmPassword");

        String msg = "";
        boolean isSuccess = false;
        UserDAO dao = new UserDAO();

        try {
            // 2. Kiểm tra logic
            if (userName.isEmpty() || fullName.isEmpty() || email.isEmpty() || password.isEmpty()) {
                msg = "Vui lòng nhập đầy đủ thông tin!";
            } else if (!password.equals(confirm)) {
                msg = "Mật khẩu xác nhận không khớp!";
            } else if (dao.checkUsernameExist(userName)) {
                msg = "Tên đăng nhập '" + userName + "' đã tồn tại!";
            } else if (dao.checkEmailExist(email)) {
                msg = "Email này đã được sử dụng!";
            } else {
                // 3. Nếu OK -> Insert
                UserDTO user = new UserDTO(userName, fullName, email, password, (byte) 3, true, 0);
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

        // 4. Đẩy thông báo và dữ liệu cũ về lại login.jsp
        request.setAttribute("registerMessage", msg);
        request.setAttribute("isSuccess", isSuccess);

        // Giữ lại input cũ nếu thất bại để user sửa
        if (!isSuccess) {
            request.setAttribute("oldUser", userName);
            request.setAttribute("oldFullname", fullName);
            request.setAttribute("oldEmail", email);
        }

        // QUAN TRỌNG: Forward về login.jsp để hiện lỗi ngay tại đó
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
