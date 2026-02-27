<%-- 
    Document   : danhap
    Created on : Jan 9, 2026, 12:14:49 PM
    Author     : USER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Trang chủ</title>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: Arial, sans-serif;
            }
            .top-bar {
                background: #f5f5f5;
                padding: 5px;
                border: 20px;
            }
            .container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 0 20px;
                display: flex;
                align-items: center;
                justify-content: space-between;
            }
            .search-box input{
                padding: 8px 15px;
                border: 1px solid #ffffff;
                border-radius: 30px;
                width: 250px;
            }
            .logo {
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .logo img {
                height: 40px;
            }

            .logo span {
                color: #ff6600;
                font-weight: bold;
                font-size: 18px;
            }
            .main-nav {
                display: flex;
                gap: 25px;
            }
            .main-nav a{
                text-decoration: none;
                color: #333;
                font-size: 14px;
                font-weight: 500;
            }
            .text-search{
                justify-content: center;
                display: flex;
                flex: 1;
            }
            .language {
                font-size: 14px;
                color: #333;
            }

            .language .active {
                color: #ff6600;
                font-weight: bold;
            }
            .laguage {
                cursor: pointer;
                color: #ff6600;
            }
            top-bar-left {
                display: flex;
                gap: 20px;
                align-items: center;
                justify-content: space-between;
            }

            .top-bar-item {
                display: flex;
                align-items: center;
                gap: 5px;
                text-decoration: none;
                color: #333;
                transition: color 0.3s ease;
            }

            .top-bar-item svg {
                width: 18px;
                height: 18px;
                fill: #ff8800;
            }

            .top-bar-item:hover {
                color: #ff8800;
            }
            .contact-nav {
                display: flex;
                gap: 15px;
            }
            .language-select {
                padding: 2px;
                border: 1px solid #ccc;
                border-radius: 4px;
                width: 100px;
                display: flex;
            }
            .top-bar-right {
                display: flex;
                gap: 15px;
                align-items: center;
            }
            .header-center {
                padding: 15px;
                align-content: center;
            }
            .provider {
                padding: 4px;
                align-content: center;
                justify-content: space-between;
            }
            .card-content {
                
            }
            .provider-name {
                text-decoration: none;
            }
        </style>
    </head>
    <body>
        <div class="main-header">
            <div class="top-bar">
                <div class="container">
                    <div class="top-bar-left">
                        <nav class="contact-nav">
                            <a href="tel:+8433214439" class="top-bar-item">
                                <svg viewBox="0 0 24 24"><path d="M6.62 10.79c1.44 2.83 3.76 5.14 6.59 6.59l2.2-2.2c.27-.27.67-.36 1.02-.24 1.12.37 2.33.57 3.57.57.55 0 1 .45 1 1V20c0 .55-.45 1-1 1-9.39 0-17-7.61-17-17 0-.55.45-1 1-1h3.5c.55 0 1 .45 1 1 0 1.25.2 2.45.57 3.57.11.35.03.74-.25 1.02l-2.2 2.2z"></path></svg>
                                +84 33493399
                            </a>
                            <a href="mailto:loc@gmail4user.com" class="top-bar-item">
                                <svg viewBox="0 0 24 24"><path d="M20 4H4c-1.1 0-1.99.9-1.99 2L2 18c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2V6c0-1.1-.9-2-2-2zm0 4l-8 5-8-5V6l8 5 8-5v2z"></path></svg>
                                lonhkim85@gmail.com
                            </a>
                        </nav>
                    </div>
                    <div class="search-box">
                        <input type="text" placeholder="Search">
                    </div>
                    <select class="language-select">
                        <option>Vietnamese</option>
                        <option>English</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="Main-header">
            <div class="container">
                <div class="logo">
                    <img src="images/banner-png2.webp" alt="FPT Education">
                    <span>FPT Course</span>
                    <nav class="main-nav">
                        <a href="#">Courses</a>
                        <a href="#">Learning Progress</a>
                        <a href="#">Forums</a>
                    </nav>
                </div>
            </div>
        </div>
    </div>
    <div class="container">
    <div class="header-center">
        <h1>Courses</h1>
    </div>
    </div>
    <hr />
    <div class="cards-grid">
            <!-- Deep Learning Card -->
            <a href="#" target="_blank" class="card">
                <div class="card-image deep-learning">
                    <span>Deep Learning<br>Specialization</span>
                </div>
                <div class="card-content">
                    <div class="provider">
                        <image atl="Code web" src="images/course-web01.jpg">
                        </div>
                        <span class="provider-name">Code Web</span>
                </div>
            </a>
</body>

</html>
