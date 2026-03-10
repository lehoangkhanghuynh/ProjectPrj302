<%-- 
    Document   : instructorCreateCourse
    Created on : Mar 9, 2026, 10:50:45 PM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<h2>Create Course</h2>

<form action="mainController" method="post">

    <input type="hidden" name="action" value="createCourse">

    Topic<br>
    <input type="text" name="topic" required>
    <br><br>

    Course Name<br>
    <input type="text" name="courseName" required>
    <br><br>

    Fee<br>
    <input type="number" name="fee" required>
    <br><br>

    <input type="submit" value="Create Course">

</form>

<br>

<a href="instructorDashboard.jsp">Back</a>
