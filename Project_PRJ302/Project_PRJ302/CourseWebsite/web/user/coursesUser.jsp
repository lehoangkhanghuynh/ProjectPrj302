<%-- 
    Document   : coursesUser.jsp
    Created on : Feb 7, 2026, 3:31:20 AM
    Author     : dell
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Courses</title>
    <style>
        table {
            border-collapse: collapse;
            width: 80%;
            margin: 30px auto;
        }
        th, td {
            border: 1px solid #ccc;
            padding: 8px 12px;
            text-align: center;
        }
        th {
            background-color: #f2f2f2;
        }
        h2 {
            text-align: center;
        }
    </style>
</head>
<body>

<h2>Danh sách khóa học của bạn</h2>

<c:if test="${empty COURSE_LIST}">
    <p style="text-align:center; color:red;">
        Bạn chưa đăng ký khóa học nào.
    </p>
</c:if>

<c:if test="${not empty COURSE_LIST}">
    <table>
        <tr>
            <th>ID</th>
            <th>Topic</th>
            <th>Tên khóa học</th>
            <th>Học phí</th>
            <th>Trạng thái</th>
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
</c:if>

</body>
</html>

