<%-- 
    Document   : course
    Created on : Feb 4, 2026, 11:15:11 AM
    Author     : ASUS
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>

        <h2>QUẢN LÝ KHÓA HỌC</h2>

        <a href="index.jsp">Quay về trang chủ admin</a>
        <br><br>

        <table border="1" cellpadding="5">
            <tr>
                <th>Id</th>
                <th>Topic</th>
                <th>Course Name</th>
                <th>Fee</th>
                <th>Status</th>
            </tr>

            <c:forEach var="c" items="${COURSE_LIST}">
                <tr>
                    <td>${c.courseId}</td>
                    <td>${c.topic}</td>
                    <td>${c.courseName}</td>
                    <td>${c.fee}</td>
                    <td>${c.status}</td>
                </tr>
            </c:forEach>

        </table>
    </body>
</html>
