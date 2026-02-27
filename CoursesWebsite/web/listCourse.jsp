<%@ page import="java.util.ArrayList" %>
<%@ page import="model.CourseDTO" %>
<%@ page import="model.UserDTO" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Course List</title>

        <style>
            body {
                font-family: Arial, sans-serif;
                background: #f4f6f9;
                margin: 0;
                padding: 40px;
            }

            h2 {
                text-align: center;
                color: #333;
            }

            .container {
                width: 85%;
                margin: auto;
                background: white;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            }

            .back-btn {
                display: inline-block;
                margin-bottom: 20px;
                padding: 8px 15px;
                background: #6c757d;
                color: white;
                text-decoration: none;
                border-radius: 5px;
            }

            .back-btn:hover {
                background: #5a6268;
            }

            .register-btn {
                padding: 6px 12px;
                background: #28a745;
                color: white;
                text-decoration: none;
                border-radius: 5px;
                font-size: 14px;
            }

            .register-btn:hover {
                background: #218838;
            }

            table {
                width: 100%;
                border-collapse: collapse;
            }

            table thead {
                background: #007bff;
                color: white;
            }

            table th, table td {
                padding: 12px;
                text-align: center;
            }

            table tr {
                border-bottom: 1px solid #ddd;
            }

            table tr:nth-child(even) {
                background: #f2f2f2;
            }

            table tr:hover {
                background: #e9f5ff;
            }

            .fee {
                color: #28a745;
                font-weight: bold;
            }

            .no-data {
                text-align: center;
                padding: 20px;
                color: red;
                font-weight: bold;
            }
        </style>
    </head>

    <tbody>

        <c:choose>
            <c:when test="${not empty COURSE_LIST}">
                <c:forEach var="c" items="${COURSE_LIST}">
                    <tr>
                        <td>${c.courseId}</td>
                        <td>${c.topic}</td>
                        <td>${c.courseName}</td>
                        <td class="fee">
                            <fmt:formatNumber value="${c.fee}" type="number" pattern="#,###"/> VND
                        </td>
                        <td>
                            <input type="submit" value="Buy"/>
                        </td>
                    </tr>
                </c:forEach>
            </c:when>

            <c:otherwise>
                <tr>
                    <td colspan="5" class="no-data">
                        No course found
                    </td>
                </tr>
            </c:otherwise>
        </c:choose>

    </tbody>
</html>