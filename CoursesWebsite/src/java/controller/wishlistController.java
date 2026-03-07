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
import model.WishlistDAO;

/**
 *
 * @author ASUS
 */
public class wishlistController extends HttpServlet {

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
        WishlistDAO dao = new WishlistDAO();

        if (action == null) {
            response.sendRedirect("homePage.jsp");
            return;
        }

        if (action.equals("add")) {

            String userId = request.getParameter("userId");
            int courseId = Integer.parseInt(request.getParameter("courseId"));

            dao.addWishlist(userId, courseId);

            response.sendRedirect("homePage.jsp");
        } else if (action.equals("view")) {

            String userId = request.getParameter("userId");

            request.setAttribute("wishlist", dao.getWishlistByUser(userId));

            request.getRequestDispatcher("wishlist.jsp").forward(request, response);
        } else if (action.equals("remove")) {

            int wishlistId = Integer.parseInt(request.getParameter("wishlistId"));
            String userId = request.getParameter("userId");

            dao.deleteWishlist(wishlistId);

            response.sendRedirect("wishlistController?action=view&userId=" + userId);
        }

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
