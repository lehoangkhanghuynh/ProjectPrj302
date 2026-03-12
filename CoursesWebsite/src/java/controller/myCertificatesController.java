package controller;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import model.CertificateDAO;
import model.CertificateDTO;
import model.UserDTO;

@WebServlet("/myCertificates")
public class myCertificatesController extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
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

        request.getRequestDispatcher("/myCertificates.jsp").forward(request, response);
    }
}
