<%-- 
    Document   : resetPassword
    Created on : Mar 10, 2026, 7:42:29 PM
    Author     : HOANG KHANG PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
            <h2>Đặt lại mật khẩu</h2>

            <form action="mainController" method="POST">

                <input type="hidden" name="action" value="resetpassword"/>

                <!-- lấy token từ URL -->
                <input type="hidden" name="token" value="${param.token}" />

                Mật khẩu mới:
                <input type="password" name="password" required />
                <br><br>

                Xác nhận mật khẩu:
                <input type="password" name="confirmPassword" required />
                <br><br>

                <button type="submit">Đổi mật khẩu</button>

            </form>
</body>
</html>
