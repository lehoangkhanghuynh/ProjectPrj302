<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.CourseDTO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Course List</title>
    </head>
    <body>
        <h2>Danh Sách Khóa Học</h2>

        <%-- Thông báo lỗi đặt TRÊN bảng, ngoài <table> --%>
        <c:if test="${not empty enrollmessage}">
            <p style="color: red">${enrollmessage}</p>
        </c:if>

        <%-- Thông báo từ redirect (vd: đã hoàn thành, không thể enroll) --%>
        <c:if test="${not empty msg}">
            <p style="color: orange">${msg}</p>
        </c:if>

        <table border="1">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Chủ Đề</th>
                    <th>Tên Khóa Học</th>
                    <th>Học Phí</th>
                    <th>Đăng Ký</th>
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
                                <td>
                                    <%-- Định dạng số tiền --%>
                                    <fmt:formatNumber value="${course.fee}" type="number" groupingUsed="true" /> ₫
                                </td>
                                <td>
                                    <%-- Kiểm tra đăng nhập trước khi hiện nút Enroll --%>
                                    <c:choose>
                                        <c:when test="${not empty sessionScope.user}">
                                            <form action="enroll" method="post">
                                                <input type="hidden" name="courseId" value="${course.courseId}" />
                                                <button type="submit">Đăng Ký</button>
                                            </form>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="login.jsp">Đăng nhập để đăng ký</a>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="5">Không tìm thấy khóa học nào.</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </body>
</html>
