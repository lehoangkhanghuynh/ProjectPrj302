package controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import model.CertificateDAO;
import model.CertificateDTO;
import model.CourseDAO;
import model.CourseDTO;
import model.UserDTO;

@WebServlet("/certificateController") 
public class certificateController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("certificate".equals(action)) {
            generateCertificate(request, response);
        }

        if ("myCertificates".equals(action)) {
            viewCertificates(request, response);
        }
    }

    private void generateCertificate(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        UserDTO user = (UserDTO) session.getAttribute("user");

        // Kiểm tra đăng nhập
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String courseIdRaw = request.getParameter("courseId");
        int courseId = Integer.parseInt(courseIdRaw);

        CertificateDAO certDAO = new CertificateDAO();
        CertificateDTO cert = certDAO.getCertificate(user.getUserId(), courseId);

        if (cert == null) {
            String code = "DUK-" + System.currentTimeMillis();
            cert = new CertificateDTO(
                    0,
                    user.getUserId(),
                    courseId,
                    new java.sql.Timestamp(System.currentTimeMillis()),
                    code
            );
            certDAO.createCertificate(cert);
        }

        CourseDAO courseDAO = new CourseDAO();
        CourseDTO course = courseDAO.searchByIDc(courseId);

        request.setAttribute("certificate", cert);
        request.setAttribute("course", course);
        request.getRequestDispatcher("/certificate/certificates.jsp").forward(request, response);
    }

    private void viewCertificates(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        UserDTO user = (UserDTO) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        CertificateDAO dao = new CertificateDAO();
        List<CertificateDTO> list = dao.getCertificatesByUser(user.getUserId());

        request.setAttribute("certList", list);
        request.getRequestDispatcher("/certificate/myCertificates.jsp").forward(request, response);
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
}