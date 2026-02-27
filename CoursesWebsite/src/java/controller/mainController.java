package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.CourseDAO;
import model.CourseDTO;
import model.UserCourseDAO;
import model.UserDTO;

public class mainController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        String action = request.getParameter("action");
        String url = "login.jsp";

        if (action == null) {
            url = "login.jsp";
        } // ================= LOGIN =================
        else if (action.equals("login")) {
            url = "loginController";
        } // ================= LOGOUT =================
        else if (action.equals("logout")) {
            url = "logoutController";
        } // ================= ADD COURSE (ADMIN) =================
        else if (action.equals("AddCourse")) {
            url = "addCourse.jsp";
        } else if (action.equals("RegisterCourse")) {
            url = "mainController?action=ViewCourse";
        } else if (action.equals("ExploreCourse")) {
            url = "listCourse.jsp";
        } else if (action.equals("MyCourse")) {
            url = "myCourse.jsp";
        }
        RequestDispatcher rd = request.getRequestDispatcher(url);
        rd.forward(request, response);
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
        return "Main Controller";
    }
}
