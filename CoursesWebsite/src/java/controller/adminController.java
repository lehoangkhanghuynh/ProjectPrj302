/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.CourseDAO;
import model.CourseDTO;
import model.EnrollDAO;
import model.UserDAO;
import model.UserDTO;

/**
 *
 * @author ASUS
 */
public class adminController extends HttpServlet {

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
        String action = request.getParameter("action");
        String url = "administrator.jsp";

        try {

            if (action == null) {
                action = "dashboard";
            }

            switch (action) {

                case "manageUsers":
                    url = manageUsers(request);
                    break;

                case "blockUser":
                    url = blockUser(request);
                    break;

                case "unblockUser":
                    url = unblockUser(request);
                    break;

                case "manageCourses":
                    url = manageCourses(request);
                    break;

                case "viewPayments":
                    url = viewPayments(request);
                    break;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        if (url.startsWith("redirect:")) {
            response.sendRedirect(url.substring(9));
        } else {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    // ================= USER =================
    private String manageUsers(HttpServletRequest request) {

        UserDAO dao = new UserDAO();

        List<UserDTO> list = dao.getAllUsers();

        request.setAttribute("USER_LIST", list);

        return "adminUsers.jsp";
    }

    private String blockUser(HttpServletRequest request) {

        String userId = request.getParameter("userId");

        UserDAO dao = new UserDAO();

        dao.blockUser(userId);

        return "redirect:adminController?action=manageUsers";
    }

    private String unblockUser(HttpServletRequest request) {

        String userId = request.getParameter("userId");

        UserDAO dao = new UserDAO();

        dao.unblockUser(userId);

        return "redirect:adminController?action=manageUsers";
    }

    // ================= COURSE =================
    private String manageCourses(HttpServletRequest request) {

        CourseDAO dao = new CourseDAO();

        List<CourseDTO> list = dao.getCoursesWithStudents();

        request.setAttribute("COURSE_LIST", list);

        return "adminCourses.jsp";
    }

    // ================= PAYMENT =================
    private String viewPayments(HttpServletRequest request) {
        EnrollDAO dao = new EnrollDAO();

        request.setAttribute("ENROLL_LIST", dao.getAllEnrollments());
        return "adminPayments.jsp";
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
