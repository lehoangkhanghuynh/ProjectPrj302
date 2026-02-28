<%@ page import="java.util.ArrayList" %>
<%@ page import="model.CourseDTO" %>
<%@ page import="model.UserDTO" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <title>Course List</title>
</head>
<body>

<h2>Course List</h2>

<table border="1">
    <thead>
        <tr>
            <th>ID</th>
            <th>Topic</th>
            <th>Name</th>
            <th>Fee</th>
        </tr>
    </thead>

    <tbody>
        <c:choose>
            <c:when test="${not empty COURSE_LIST}">
                <c:forEach var="course" items="${COURSE_LIST}">
                    <tr>
                        <td>${course.courseId}</td>
                        <td>${course.topic}</td>
                        <td>${course.courseName}</td>
                        <td>${course.fee}</td>
                    </tr>
                </c:forEach>
            </c:when>

            <c:otherwise>
                <tr>
                    <td colspan="4">No course found</td>
                </tr>
            </c:otherwise>
        </c:choose>
    </tbody>
</table>

</body>
</html>