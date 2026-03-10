<%-- 
    Document   : Search
    Created on : Feb 23, 2026, 10:42:15 PM
    Author     : HOANG KHANG PC
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
        <jsp:include page="listCourse.jsp"/>
        <c:if test="${not empty sessionScope.user}">
            
        </c:if>
    </body>
</html>
