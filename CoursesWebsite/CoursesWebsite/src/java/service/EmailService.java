package service;

import java.text.NumberFormat;
import java.util.Locale;
import java.util.Properties;
import javax.mail.*;
import javax.mail.internet.*;

public class EmailService {

    private static final String FROM = "lonhkim85@gmail.com";
    private static final String PASSWORD = "nwoweomjhvfzattr";
    private static final String SITE_URL = "http://localhost:8080/CoursesWebsite";

    private static Session getSession() {
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        return Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM, PASSWORD);
            }
        });
    }

    // Format số tiền: 100000 → 100.000đ
    private static String formatMoney(double amount) {
        NumberFormat nf = NumberFormat.getInstance(new Locale("vi", "VN"));
        return nf.format((long) amount) + "đ";
    }

    private static String parseUserAgent(String userAgent) {
        if (userAgent == null) return "Không xác định";
        String browser = "Không xác định";
        String os = "Không xác định";
        if (userAgent.contains("Edg/"))         browser = "Microsoft Edge";
        else if (userAgent.contains("Chrome"))  browser = "Google Chrome";
        else if (userAgent.contains("Firefox")) browser = "Mozilla Firefox";
        else if (userAgent.contains("Safari"))  browser = "Safari";
        else if (userAgent.contains("Opera"))   browser = "Opera";
        if (userAgent.contains("Windows NT 10"))    os = "Windows 10/11";
        else if (userAgent.contains("Windows"))     os = "Windows";
        else if (userAgent.contains("Mac OS"))      os = "MacOS";
        else if (userAgent.contains("Android"))     os = "Android";
        else if (userAgent.contains("iPhone"))      os = "iPhone";
        else if (userAgent.contains("Linux"))       os = "Linux";
        return browser + " / " + os;
    }

    // Reset password
    public static void sendResetPassword(String toEmail, String fullname,
            String resetLink, String logoPath) throws Exception {
        Message message = new MimeMessage(getSession());
        message.setFrom(new InternetAddress(FROM));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
        message.setSubject(MimeUtility.encodeText("Reset Password - DUKAcademy", "UTF-8", "B"));
        MimeMultipart multipart = new MimeMultipart("related");
        MimeBodyPart htmlPart = new MimeBodyPart();
        htmlPart.setContent(
                "<div style='font-family:Arial;max-width:500px;margin:auto;'>"
                + "<div style='text-align:center'><img src='cid:logo' width='120'></div>"
                + "<h2 style='text-align:center'>DUKAcademy</h2>"
                + "<p>Xin chào <b>" + fullname + "</b>,</p>"
                + "<p>Bạn vừa yêu cầu đặt lại mật khẩu.</p>"
                + "<p style='color:red;'>Nếu đây không phải bạn, hãy bỏ qua email này.</p>"
                + "<div style='text-align:center;margin:20px;'>"
                + "<a href='" + resetLink + "' style='background:#4CAF50;color:white;"
                + "padding:12px 20px;text-decoration:none;border-radius:6px;'>Reset Password</a>"
                + "</div>"
                + "<p>Link sẽ hết hạn sau <b>10 phút</b>.</p>"
                + "<hr><p style='font-size:12px;color:gray;text-align:center'>© 2026 DUKAcademy</p>"
                + "</div>", "text/html; charset=UTF-8");
        MimeBodyPart imagePart = new MimeBodyPart();
        imagePart.attachFile(logoPath);
        imagePart.setContentID("<logo>");
        imagePart.setDisposition(MimeBodyPart.INLINE);
        multipart.addBodyPart(htmlPart);
        multipart.addBodyPart(imagePart);
        message.setContent(multipart);
        Transport.send(message);
    }

    // Xác thực đăng ký
    public static void sendVerifyEmail(String toEmail, String fullname,
            String verifyLink, String logoPath) throws Exception {
        Message message = new MimeMessage(getSession());
        message.setFrom(new InternetAddress(FROM));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
        message.setSubject(MimeUtility.encodeText("Xác thực tài khoản - DUKAcademy", "UTF-8", "B"));
        MimeMultipart multipart = new MimeMultipart("related");
        MimeBodyPart htmlPart = new MimeBodyPart();
        htmlPart.setContent(
                "<div style='font-family:Arial;max-width:500px;margin:auto;'>"
                + "<div style='text-align:center'><img src='cid:logo' width='120'></div>"
                + "<h2 style='text-align:center'>DUKAcademy</h2>"
                + "<p>Xin chào <b>" + fullname + "</b>,</p>"
                + "<p>Cảm ơn bạn đã đăng ký tài khoản!</p>"
                + "<div style='text-align:center;margin:20px;'>"
                + "<a href='" + verifyLink + "' style='background:#4CAF50;color:white;"
                + "padding:12px 20px;text-decoration:none;border-radius:6px;'>Xác thực tài khoản</a>"
                + "</div>"
                + "<p style='color:red;'>Link sẽ hết hạn sau <b>24 giờ</b>.</p>"
                + "<hr><p style='font-size:12px;color:gray;text-align:center'>© 2026 DUKAcademy</p>"
                + "</div>", "text/html; charset=UTF-8");
        MimeBodyPart imagePart = new MimeBodyPart();
        imagePart.attachFile(logoPath);
        imagePart.setContentID("<logo>");
        imagePart.setDisposition(MimeBodyPart.INLINE);
        multipart.addBodyPart(htmlPart);
        multipart.addBodyPart(imagePart);
        message.setContent(multipart);
        Transport.send(message);
    }

    // Xác nhận enroll khóa học
    public static void sendEnrollConfirm(String toEmail, String fullname,
            String courseName, String logoPath) throws Exception {
        Message message = new MimeMessage(getSession());
        message.setFrom(new InternetAddress(FROM));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
        message.setSubject(MimeUtility.encodeText("Đăng ký khóa học thành công - DUKAcademy", "UTF-8", "B"));
        MimeMultipart multipart = new MimeMultipart("related");
        MimeBodyPart htmlPart = new MimeBodyPart();
        htmlPart.setContent(
                "<div style='font-family:Arial;max-width:500px;margin:auto;'>"
                + "<div style='text-align:center'><img src='cid:logo' width='120'></div>"
                + "<h2 style='text-align:center'>DUKAcademy</h2>"
                + "<p>Xin chào <b>" + fullname + "</b>,</p>"
                + "<p>Bạn đã đăng ký thành công khóa học <b>" + courseName + "</b>!</p>"
                + "<p>Chúc bạn học tốt 🎉</p>"
                + "<div style='text-align:center;margin:24px;'>"
                + "<a href='" + SITE_URL + "/homePage.jsp' style='background:#4CAF50;color:white;"
                + "padding:12px 28px;text-decoration:none;border-radius:6px;font-size:15px;'>📚 Học ngay</a>"
                + "</div>"
                + "<hr><p style='font-size:12px;color:gray;text-align:center'>© 2026 DUKAcademy</p>"
                + "</div>", "text/html; charset=UTF-8");
        MimeBodyPart imagePart = new MimeBodyPart();
        imagePart.attachFile(logoPath);
        imagePart.setContentID("<logo>");
        imagePart.setDisposition(MimeBodyPart.INLINE);
        multipart.addBodyPart(htmlPart);
        multipart.addBodyPart(imagePart);
        message.setContent(multipart);
        Transport.send(message);
    }

    // Cảnh báo đăng nhập thiết bị lạ
    public static void sendNewDeviceAlert(String toEmail, String fullname,
            String ip, String userAgent,
            String loginAt, String logoPath) throws Exception {
        Message message = new MimeMessage(getSession());
        message.setFrom(new InternetAddress(FROM));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
        message.setSubject(MimeUtility.encodeText("Cảnh báo đăng nhập thiết bị lạ - DUKAcademy", "UTF-8", "B"));
        MimeMultipart multipart = new MimeMultipart("related");
        MimeBodyPart htmlPart = new MimeBodyPart();
        htmlPart.setContent(
                "<div style='font-family:Arial;max-width:500px;margin:auto;'>"
                + "<div style='text-align:center'><img src='cid:logo' width='120'></div>"
                + "<h2 style='text-align:center;color:red;'>⚠️ Cảnh báo bảo mật</h2>"
                + "<p>Xin chào <b>" + fullname + "</b>,</p>"
                + "<p>Tài khoản của bạn vừa đăng nhập từ thiết bị mới:</p>"
                + "<table style='width:100%;border-collapse:collapse;'>"
                + "<tr><td style='padding:8px;background:#f5f5f5;'><b>Thời gian</b></td><td style='padding:8px;'>" + loginAt + "</td></tr>"
                + "<tr><td style='padding:8px;background:#f5f5f5;'><b>IP</b></td><td style='padding:8px;'>" + ip + "</td></tr>"
                + "<tr><td style='padding:8px;background:#f5f5f5;'><b>Thiết bị</b></td><td style='padding:8px;'>" + parseUserAgent(userAgent) + "</td></tr>"
                + "</table>"
                + "<p style='color:red;'>Nếu không phải bạn, hãy đổi mật khẩu ngay!</p>"
                + "<hr><p style='font-size:12px;color:gray;text-align:center'>© 2026 DUKAcademy</p>"
                + "</div>", "text/html; charset=UTF-8");
        MimeBodyPart imagePart = new MimeBodyPart();
        imagePart.attachFile(logoPath);
        imagePart.setContentID("<logo>");
        imagePart.setDisposition(MimeBodyPart.INLINE);
        multipart.addBodyPart(htmlPart);
        multipart.addBodyPart(imagePart);
        message.setContent(multipart);
        Transport.send(message);
    }

    // Nạp tiền thành công
    public static void sendPaymentConfirm(String toEmail, String fullname,
            double amount, double newBalance) throws Exception {
        Message message = new MimeMessage(getSession());
        message.setFrom(new InternetAddress(FROM));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
        message.setSubject(MimeUtility.encodeText("Nạp tiền thành công - DUKAcademy", "UTF-8", "B"));

        String html = "<div style='font-family:Arial;max-width:500px;margin:auto;'>"
                + "<h2 style='text-align:center'>DUKAcademy</h2>"
                + "<p>Xin chào <b>" + fullname + "</b>,</p>"
                + "<p>Tài khoản của bạn vừa được nạp tiền thành công!</p>"
                + "<table style='width:100%;border-collapse:collapse;margin-bottom:16px;'>"
                + "<tr><td style='padding:10px 12px;background:#f5f5f5;'><b>Số tiền nạp</b></td>"
                + "<td style='padding:10px 12px;color:green;font-size:16px;'><b>+" + formatMoney(amount) + "</b></td></tr>"
                + "<tr><td style='padding:10px 12px;background:#f5f5f5;'><b>Số dư hiện tại</b></td>"
                + "<td style='padding:10px 12px;font-size:16px;'><b>" + formatMoney(newBalance) + "</b></td></tr>"
                + "</table>"
                + "<div style='text-align:center;margin:24px;'>"
                + "<a href='" + SITE_URL + "/homePage.jsp' style='background:#4CAF50;color:white;"
                + "padding:12px 28px;text-decoration:none;border-radius:6px;font-size:15px;'>🎓 Khám phá khóa học</a>"
                + "</div>"
                + "<hr><p style='font-size:12px;color:gray;text-align:center'>© 2026 DUKAcademy</p>"
                + "</div>";

        message.setContent(html, "text/html; charset=UTF-8");
        Transport.send(message);
    }
}