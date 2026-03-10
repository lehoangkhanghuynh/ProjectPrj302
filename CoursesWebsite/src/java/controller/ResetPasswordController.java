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
import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;

import model.PasswordResetDAO;
import model.UserDAO;

/**
 *
 * @author HOANG KHANG PC
 */
public class ResetPasswordController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String token = request.getParameter("token");
        String password = request.getParameter("password");
        String confirm = request.getParameter("confirmPassword");

        if (!password.equals(confirm)) {
            request.setAttribute("msg", "Mật khẩu xác nhận không khớp!");
            request.getRequestDispatcher("resetPassword.jsp").forward(request, response);
            return;
        }

        PasswordResetDAO dao = new PasswordResetDAO();
        String email = dao.getEmailByToken(token);

        if (email != null) {

            UserDAO userDao = new UserDAO();
            userDao.updatePasswordByEmail(email, password);

            dao.deleteToken(token);

            request.setAttribute("msg", "Đổi mật khẩu thành công!");
            request.getRequestDispatcher("login.jsp").forward(request, response);

        } else {

            request.setAttribute("msg", "Token không hợp lệ hoặc đã hết hạn!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
