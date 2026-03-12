<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>My Certificates</title>

        <link rel="stylesheet"
              href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

        <style>

            body{
                margin:0;
                font-family:Segoe UI;
                background:#f3f4f6;
            }

            /* NAVBAR */

            .navbar{
                background:#1f2937;
                color:white;
                padding:15px 40px;
                display:flex;
                justify-content:space-between;
                align-items:center;
            }

            .logo{
                font-size:20px;
                font-weight:bold;
            }

            .nav-links a{
                color:white;
                margin-left:20px;
                text-decoration:none;
            }

            /* PAGE */

            .container{
                width:1100px;
                margin:auto;
                padding:40px 0;
            }

            .title{
                font-size:30px;
                font-weight:700;
                margin-bottom:30px;
            }

            /* CERTIFICATE */

            .cert-list{
                display:grid;
                grid-template-columns:repeat(3,1fr);
                gap:25px;
            }

            .cert-card{
                background:white;
                border-radius:12px;
                padding:25px;
                box-shadow:0 5px 15px rgba(0,0,0,0.1);
                transition:0.2s;
            }

            .cert-card:hover{
                transform:translateY(-6px);
            }

            .cert-icon{
                font-size:40px;
                color:#6366f1;
            }

            .cert-title{
                font-size:18px;
                font-weight:600;
                margin-top:10px;
            }

            .cert-date{
                color:#777;
                font-size:14px;
                margin-top:5px;
            }

            .btn-view{
                display:inline-block;
                margin-top:15px;
                background:#6366f1;
                color:white;
                padding:8px 15px;
                border-radius:6px;
                text-decoration:none;
            }

            .empty{
                text-align:center;
                padding:80px;
                color:#777;
                font-size:18px;
            }

        </style>

    </head>

    <body>

        <!-- NAVBAR -->

        <div class="navbar">

            <div class="logo">
                DUK Academy
            </div>

            <div class="nav-links">

                <c:if test="${not empty sessionScope.user}">

                    <span>Welcome ${sessionScope.user.fullname}</span>

                    <a href="homePage.jsp">Home</a>

                    <a href="myCourses">My Courses</a>

                    <a href="myCertificates">Certificates</a>

                    <a href="mainController?action=logout">Logout</a>

                </c:if>

                <c:if test="${empty sessionScope.user}">
                    <a href="login.jsp">Login</a>
                </c:if>

            </div>

        </div>

        <!-- CONTENT -->

        <div class="container">

            <div class="title">
                <i class="bi bi-award"></i>
                My Certificates
            </div>


            <c:choose>

                <c:when test="${not empty certList}">

                    <div class="cert-list">

                        <c:forEach var="c" items="${certList}">

                            <div class="cert-card">

                                <div class="cert-icon">
                                    <i class="bi bi-patch-check-fill"></i>
                                </div>

                                <div class="cert-title">
                                    Course ID: ${c.courseId}
                                </div>

                                <div class="cert-date">
                                    Issued: ${c.issueDate}
                                </div>

                                <a class="btn-view"
                                   href="certificate?courseId=${c.courseId}">
                                    View Certificate
                                </a>

                            </div>

                        </c:forEach>

                    </div>

                </c:when>


                <c:otherwise>

                    <div class="empty">

                        <i class="bi bi-award" style="font-size:70px;"></i>

                        <p>You have no certificates yet</p>

                    </div>

                </c:otherwise>

            </c:choose>

        </div>

    </body>
</html>