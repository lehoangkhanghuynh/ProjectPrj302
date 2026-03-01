<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Courses</title>
</head>
<body>
    <h1>My Courses</h1>

    <c:if test="${empty MY_COURSES}">
        <p>Bạn chưa đăng ký khóa học nào.</p>
    </c:if>

    <c:if test="${not empty MY_COURSES}">
        <table border="1">
            <tr>
                <th>Course ID</th>
                <th>Course Name</th>
                <th>Fee</th>
            </tr>

            <c:forEach var="course" items="${MY_COURSES}">
                <tr>
                    <td>${course.courseId}</td>
                    <td>${course.courseName}</td>
                    <td>${course.fee}</td>
                </tr>
            </c:forEach>

        </table>
    </c:if>

</body>
</html>