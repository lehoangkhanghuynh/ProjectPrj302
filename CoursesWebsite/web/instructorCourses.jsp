<%-- 
    Document   : instructorCourses
    Created on : Mar 9, 2026, 10:51:29 PM
    Author     : ASUS
--%>

<%@page import="java.util.List"%>
<%@page import="model.CourseDTO"%>

<h2>My Courses</h2>

<table border="1">

<tr>
<th>ID</th>
<th>Topic</th>
<th>Name</th>
<th>Fee</th>
<th>Action</th>
</tr>

<%

List<CourseDTO> list = (List<CourseDTO>)request.getAttribute("COURSE_LIST");

if(list != null){
for(CourseDTO c : list){

%>

<tr>

<td><%=c.getCourseId()%></td>
<td><%=c.getTopic()%></td>
<td><%=c.getCourseName()%></td>
<td><%=c.getFee()%></td>

<td>

<a href="mainController?action=viewReviews&courseId=<%=c.getCourseId()%>">
Reviews
</a>

</td>

</tr>

<%
}
}
%>

</table>

<br>

<a href="instructorCreateCourse.jsp">Create New Course</a>

<br><br>

<a href="instructorDashboard.jsp">Back</a>
