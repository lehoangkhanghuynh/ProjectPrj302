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
            <h2>Thông Tin Của Bạn<h2><!-- gioi thieu thong tin user -->
                    <p>    Họ và Tên:   ${sessionScope.user.fullname} <br />
                        Email:   ${sessionScope.user.email} <br /> <!--thêm thông tin tuoi,... -->
                        Tuổi:    ${sessionScope.user.age} <br /> <!-- int 255 -->
                        Quê Quán:   ${sessionScope.user.location} <br /> <!-- nvarchar(50) -->
                        Giới Tính:   ${sessionScope.user.sex} <br /> <!-- nvarchar(10) -->
                        Tình Trạng Hôn Nhân:   ${sessionScope.user.maritalStatus} <br/></p>
                        <c:choose>
                            <c:when test="${user.age >= 16}">
                            <form action="mainController" method="POST">
                                <input type="hidden" name="action" value="dating" />
                                <input type="submit" value="hẹn hò nhưng không yêu" />
                            </form>
                        </c:when>
                        <c:otherwise>
                            <span style=" color: red">Bạn chưa đủ tuổi cố gắng ăn mau chống lớn đi nhé</span>
                        </c:otherwise>
                    </c:choose>
                </c:if>
                </body>
                </html>
