<%-- 
    Document   : courseReview
    Created on : Mar 9, 2026, 10:51:51 PM
    Author     : ASUS
--%>

<%@page import="java.util.List"%>

<h2>Course Reviews</h2>

<%

    List<String> reviews = (List<String>) request.getAttribute("REVIEWS");

    if (reviews != null && reviews.size() > 0) {

        for (String r : reviews) {
%>

<p><%=r%></p>

<%
    }
} else {
%>

<p>No reviews yet</p>

<%
    }
%>

<br>

<a href="mainController?action=viewMyCourses">
    Back
</a>
