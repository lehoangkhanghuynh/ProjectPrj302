<%-- 
    Document   : adminCourses
    Created on : Mar 6, 2026, 10:21:39 PM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>


    <table border="1">

        <tr>
            <th>ID</th>
            <th>Course</th>
            <th>Topic</th>
            <th>Fee</th>
            <th>Students</th>
        </tr>

        <c:forEach var="c" items="${COURSE_LIST}">
            <tr>
                <td>${c.courseId}</td>
                <td>${c.courseName}</td>
                <td>${c.topic}</td>
                <td>${c.fee}</td>
                <td>${c.totalStudents}</td>
            </tr>
        </c:forEach>

    </table>

  
<a href="administrator.jsp">Back</a>
