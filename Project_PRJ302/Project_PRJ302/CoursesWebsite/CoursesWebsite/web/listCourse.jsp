<%@ page import="java.util.ArrayList" %>
<%@ page import="model.CourseDTO" %>
<%@ page import="model.UserDTO" %>

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

    <body>

        <div class="container">

            <h2>Course List</h2>

            <a href="welcome.jsp" class="back-btn">Back</a>

            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Topic</th>
                        <th>Name</th>
                        <th>Fee</th>
                        <th>Action</th>
                    </tr>
                </thead>

                <tbody>

                    <%
                        UserDTO loginUser = (UserDTO) session.getAttribute("user");
                        ArrayList<CourseDTO> list
                                = (ArrayList<CourseDTO>) request.getAttribute("COURSE_LIST");

                        if (list != null && !list.isEmpty()) {
                            for (CourseDTO c : list) {
                    %>
                    <tr>
                        <td><%= c.getCourseId()%></td>
                        <td><%= c.getTopic()%></td>
                        <td><%= c.getCourseName()%></td>
                        <td class="fee"><%= String.format("%,.0f", c.getFee())%> VND</td>
                        <td>
                            <% if (loginUser.getRole() != 1) {%>
                            <a class="register-btn"
                               href="mainController?action=RegisterCourse&courseId=<%= c.getCourseId()%>">
                                Register
                            </a>
                            <% } else { %>
                            Admin
                            <% } %>
                        </td>
                    </tr>
                    <%
                        }
                    } else {
                    %>
                    <tr>
                        <td colspan="5" class="no-data">
                            No course found
                        </td>
                    </tr>
                    <%
                        }
                    %>

                </tbody>
            </table>

        </div>

    </body>
</html>