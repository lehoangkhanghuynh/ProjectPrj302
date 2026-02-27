<%-- 
    Document   : index
    Created on : Feb 4, 2026, 11:14:54 AM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    model.UsersDTO user = (model.UsersDTO) session.getAttribute("LOGIN_USER");
    if (user == null || user.getRole() != 1) {
        response.sendRedirect("../index.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h2>Welcome Admin: ${LOGIN_USER.userName}</h2>

        <hr>
        <a href="../CourseController">Quản lý khóa học</a><br>
        <a href="user.jsp">Quản lý người dùng</a><br>
        <a href="../logout">Đăng xuất</a>
    </body>
</html>
