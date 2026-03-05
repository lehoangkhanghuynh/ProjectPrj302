<%-- 
    Document   : dating.jsp
    Created on : Mar 2, 2026, 11:04:08 AM
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
        <c:if test="${empty sessionScope.user}">
            <c:redirect url="login.jsp" />
        </c:if>

        <c:if test="${not empty sessionScope.user}">
            <form action="mainController" method="POST">
                <h2>Thông Tin Của Bạn<h2><!-- gioi thieu thong tin user -->
                        ${user.fullname} <br />
                        ${user.email} <br /> <!--thêm thông tin tuoi,... -->
                        ${user.age} <br /> <!-- int 255 -->
                        ${user.location} <br /> <!-- nvarchar(50) -->
                        ${user.sex} <br /> <!-- nvarchar(10) -->
                        <c:choose>
                            <c:when test="${user.age >= 16}">
                                <input type="submit" value="hẹn hò nhưng không yêu" />
                            </c:when>
                            <c:otherwise>
                                <span style=" color: red">Bạn chưa đủ tuổi cố gắng ăn mau chống lớn đi nhé</span>
                            </c:otherwise>
                        </c:choose>
                        </form>
                    </c:if>
                    </body>
                    </html>
