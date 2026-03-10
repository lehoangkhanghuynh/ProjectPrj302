<%-- 
    Document   : forgotPassword
    Created on : Mar 10, 2026, 7:32:40 PM
    Author     : HOANG KHANG PC
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h2>Quên mật khẩu</h2>
        <form action="mainController" method="POST">
            <input type="hidden" name="action" value="forgotpassword"/>
            <input type="email" name="email" required>
            <button type="submit">Gửi link reset</button>
        </form>
        <c:if test="${not empty msg}">
            <span style="color: red">${msg}
            </c:if>
    </body>
</html>
