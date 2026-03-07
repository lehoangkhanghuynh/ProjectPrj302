/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.UserDAO;
import model.UserDTO;

/**
 *
 * @author HOANG KHANG PC
 */
@WebServlet("/updateUser")  // <-- thêm dòng này

public class updateUserController extends HttpServlet {

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
        HttpSession session = request.getSession();

        String userId = request.getParameter("userId");
        String fullname = request.getParameter("fullname");
        String email = request.getParameter("email");
        String age = request.getParameter("age");
        String location = request.getParameter("location");
        String sex = request.getParameter("sex");
        String maritalStatus = request.getParameter("maritalStatus"); // khớp với name= trong JSP

        UserDAO udao = new UserDAO();
        try {
            int ages = Integer.parseInt(age);
            boolean result = udao.updateUser(userId, fullname, email, ages, location, sex, maritalStatus);
            if (result) {
                UserDTO user = (UserDTO) session.getAttribute("user");
                if (user != null) {
                    user.setFullname(fullname);
                    user.setEmail(email);
                    user.setAge(ages);
                    user.setLocation(location);
                    user.setSex(sex);
                    user.setMarital_status(maritalStatus);
                }
                request.setAttribute("MSG", "Cập nhật thành công!");
            } else {
                request.setAttribute("ERROR", "Cập nhật thất bại!");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("ERROR", "Lỗi hệ thống!");
        }
        request.getRequestDispatcher("myprofile.jsp").forward(request, response);
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
