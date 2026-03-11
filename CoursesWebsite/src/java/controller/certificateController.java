package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import model.CertificateDAO;
import model.CertificateDTO;
import model.CourseDAO;
import model.CourseDTO;
import model.EnrollDAO;
import model.UserDTO;

@WebServlet("/certificate")
public class certificateController extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        UserDTO user = (UserDTO) session.getAttribute("user");

        // 1. Kiểm tra login
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // 2. Lấy courseId
        String courseIdRaw = request.getParameter("courseId");

        if (courseIdRaw == null || courseIdRaw.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/homePage.jsp");
            return;
        }

        int courseId = 0;

        try {
            courseId = Integer.parseInt(courseIdRaw);
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/homePage.jsp");
            return;
        }

        // 3. Kiểm tra status Enroll
        EnrollDAO enrollDAO = new EnrollDAO();
        int status = -1;

        try {
            status = enrollDAO.getEnrollStatus(user.getUserId(), courseId);
        } catch (Exception e) {
            e.printStackTrace();
        }

        // nếu chưa hoàn thành khóa học
        if (status != 2) {
            response.sendRedirect(request.getContextPath() + "/myCourses.jsp");
            return;
        }

        // 4. Kiểm tra certificate
        CertificateDAO certDAO = new CertificateDAO();
        CertificateDTO cert = certDAO.getCertificate(user.getUserId(), courseId);

        // 5. Nếu chưa có certificate thì tạo mới
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
        int courseIdRawd = Integer.parseInt(courseIdRaw);
        // 6. Lấy thông tin khóa học
        CourseDAO courseDAO = new CourseDAO();
        CourseDTO course = courseDAO.searchByIDc(courseIdRawd);

        if (course == null) {
            response.sendRedirect(request.getContextPath() + "/homePage.jsp");
            return;
        }

        // 7. gửi dữ liệu sang JSP
        request.setAttribute("certificate", cert);
        request.setAttribute("course", course);

        request.getRequestDispatcher("/certificates.jsp").forward(request, response);
    }
}