<%-- 
    Document   : wishlist
    Created on : Mar 7, 2026, 10:01:21 PM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib  uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
    <head>
        <title>My Wishlist</title>

    </head>

    <body>

        <div class="container">

            

            <h2>My Wishlist</h2>

            <table>

                <tr>
                    <th>Wishlist ID</th>
                    <th>User ID</th>
                    <th>Course ID</th>
                    <th>Created Date</th>
                    <th>Action</th>
                </tr>

                <c:forEach var="w" items="${wishlist}">

                    <tr>

                        <td>${w.wishlistId}</td>

                        <td>${w.userId}</td>

                        <td>${w.courseId}</td>

                        <td>
                    <fmt:formatDate value="${w.createdAt}" pattern="dd-MM-yyyy HH:mm"/>
                    </td>

                    <td>

                        <a class="remove-btn"
                           href="wishlistController?action=remove&wishlistId=${w.wishlistId}&userId=${sessionScope.user.userId}">
                            Remove
                        </a>

                    </td>

                    </tr>

                </c:forEach>

            </table>
            <a class="back" href="homePage.jsp">Back to HomePage</a>

        </div>

    </body>
</html>
