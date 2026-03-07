<%-- 
    Document   : adminPayments
    Created on : Mar 6, 2026, 10:22:35 PM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html>
    <head>
        <title>Enrollments</title>
    </head>

    <body>

        <h2>Course Enrollments</h2>

        <table border="1">

            <tr>
                <th>User</th>
                <th>Full Name</th>
                <th>Course ID</th>
                <th>Course Name</th>
                <th>Fee</th>
                <th>Date</th>
                <th>Status</th>
            </tr>

            <c:forEach var="e" items="${ENROLL_LIST}">

                <tr>

                    <td>${e.userId}</td>
                    <td>${e.fullname}</td>
                    <td>${e.courseId}</td>
                    <td>${e.courseName}</td>
                    <td>${e.fee}</td>

                    <td>
                        <fmt:formatDate value="${e.enrollDate}" pattern="dd-MM-yyyy HH:mm"/>
                    </td>

                    <td>

                        <c:choose>

                            <c:when test="${e.status == 1}">
                                Completed
                            </c:when>

                            <c:otherwise>
                                Pending
                            </c:otherwise>

                        </c:choose>

                    </td>

                </tr>

            </c:forEach>

        </table>
        <a href="administrator.jsp">Back</a>

    </body>
</html>