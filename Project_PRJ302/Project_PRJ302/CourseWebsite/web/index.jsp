<%-- 
    Document   : index
    Created on : Jan 25, 2026, 9:16:36 PM
    Author     : USER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Home</title>
    </head>
    <body>

        <c:choose>

            <%-- ĐÃ LOGIN --%>
            <c:when test="${not empty sessionScope.LOGIN_USER}">
                <p>
                    WELCOME <b>${LOGIN_USER.userName}</b>
                </p>

                <%-- ADMIN ROLE = 1 --%>
                <c:if test="${LOGIN_USER.role == 1}">
                    <a href="admin/course.jsp">Quản lý khóa học</a><br>
                    <a href="admin/user.jsp">Quản lý người dùng</a><br>
                </c:if>

                <%-- USER ROLE = 3 --%>
                <c:if test="${LOGIN_USER.role == 3}">
                    <a href="UserCourseController">Danh sách khóa học</a><br>
                    <a href="my-course.jsp">Khóa học của tôi</a><br>
                </c:if>

                <br>
                <a href="MainController?action=logout&">Logout</a>
            </c:when>

            <%-- CHƯA LOGIN --%>
            <c:otherwise>
                <h3>Log in with your email account</h3>
                <form action="MainController" method="post">
                    <input type="hidden" name="action" value="login"/>

                    Email: <input type="text" name="email"/><br><br>
                    Password: <input type="password" name="password"/><br><br>

                    <input type="submit" value="Login"/>
                </form>

                <c:if test="${not empty ERROR}">
                    <p style="color:red">${ERROR}</p>
                </c:if>
                <hr>

                <p>Don't have an account yet?</p>
                <a href="register.jsp"> Sign up</a>
            </c:otherwise>

        </c:choose>

    </body>
</html>
