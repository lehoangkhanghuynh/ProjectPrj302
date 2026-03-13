package controller;

import java.io.IOException;
import java.util.UUID;
import java.util.Properties;

import javax.mail.*;
import javax.mail.internet.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import model.PasswordResetDAO;
import model.UserDAO;

@WebServlet("/forgotPasswordController")
public class forgotPasswordController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        String email = request.getParameter("email");
        UserDAO udao = new UserDAO();

        try {
            // 1. kiểm tra email có tồn tại
            if (!udao.checkEmailExist(email)) {
                request.setAttribute("msg", "Email không tồn tại!");
                request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);
                return;
            }

            // 2. tạo token
            String token = UUID.randomUUID().toString();

            // 3. lấy userId
            String userId = udao.getUserIdByEmail(email);

            // 4. lưu token
            PasswordResetDAO dao = new PasswordResetDAO();
            dao.insertToken(token, userId, email);

            // 5. link reset
            String link = "http://localhost:8080/CoursesWebsite/resetPassword.jsp?token=" + token;

            // 6. cấu hình SMTP
            Properties props = new Properties();
            props.put("mail.smtp.host", "smtp.gmail.com");
            props.put("mail.smtp.port", "587");
            props.put("mail.smtp.auth", "true");
            props.put("mail.smtp.starttls.enable", "true");

            Session session = Session.getInstance(props,
                    new Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(
                            "lonhkim85@gmail.com",
                            "nwoweomjhvfzattr"
                    );
                }
            });

            // 7. tạo email
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress("lonhkim85@gmail.com"));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
            message.setSubject("Reset Password");

            String fullname = udao.getFullnameByEmail(email);
            MimeMultipart multipart = new MimeMultipart("related");

            MimeBodyPart htmlPart = new MimeBodyPart();
            htmlPart.setContent(
                    "<div style='font-family:Arial;max-width:500px;margin:auto;'>"
                    + "<div style='text-align:center'>"
                    + "<img src='cid:logo' width='120'>"
                    + "</div>"
                    + "<h2 style='text-align:center'>DUKAcademy</h2>"
                    + "<p>Xin chào <b>" + fullname + "</b>,</p>"
                    + "<p>Bạn vừa yêu cầu đặt lại mật khẩu.</p>"
                    + "<p style='color:red;'>Nếu đây không phải bạn, hãy bỏ qua email này.</p>"
                    + "<div style='text-align:center;margin:20px;'>"
                    + "<a href='" + link + "' style='background:#4CAF50;color:white;padding:12px 20px;text-decoration:none;border-radius:6px;'>Reset Password</a>"
                    + "</div>"
                    + "<p>Link sẽ hết hạn sau <b>10 phút</b>.</p>"
                    + "<hr>"
                    + "<p style='font-size:12px;color:gray;text-align:center'>© 2026 DUKAcademy</p>"
                    + "</div>",
                    "text/html; charset=UTF-8"
            );

            MimeBodyPart imagePart = new MimeBodyPart();
            String path = getServletContext().getRealPath("/img/logo/DUK.png");
            imagePart.attachFile(path);
            imagePart.setContentID("<logo>");
            imagePart.setDisposition(MimeBodyPart.INLINE);

            multipart.addBodyPart(htmlPart);
            multipart.addBodyPart(imagePart);
            message.setContent(multipart);

            // 8. gửi mail
            Transport.send(message);

            request.setAttribute("msg", "Đã gửi link reset qua email!");
            request.getRequestDispatcher("login.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", "Lỗi gửi email!");
            request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);
        }
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