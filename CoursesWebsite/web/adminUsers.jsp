<%-- 
    Document   : adminUsers
    Created on : Mar 6, 2026, 10:20:18 PM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<h2>User Management</h2>

<table border="1">

    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Email</th>
        <th>Status</th>
        <th>Action</th>
    </tr>

    <c:forEach var="u" items="${USER_LIST}">
        <tr>

            <td>${u.userId}</td>
            <td>${u.fullname}</td>
            <td>${u.email}</td>

            <td>
                <c:choose>
                    <c:when test="${u.status}">
                        Active
                    </c:when>
                    <c:otherwise>
                        Blocked
                    </c:otherwise>
                </c:choose>
            </td>

            <td>

                <c:if test="${u.status}">
                    <a href="adminController?action=blockUser&userId=${u.userId}">
                        Block
                    </a>
                </c:if>

                <c:if test="${!u.status}">
                    <a href="adminController?action=unblockUser&userId=${u.userId}">
                        Unblock
                    </a>
                </c:if>

            </td>

        </tr>
    </c:forEach>

</table>

<br>
<a href="administrator.jsp">Back</a>