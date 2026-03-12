package controller;

import java.io.IOException;
import java.time.LocalDate;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import model.CertificateDAO;
import model.CertificateDTO;
import model.CourseDAO;
import model.CourseDTO;
import model.UserDTO;

@WebServlet("/certificate")
public class certificateController extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        UserDTO user = (UserDTO) session.getAttribute("user");

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

        request.getRequestDispatcher("/certificates.jsp").forward(request, response);
    }
}