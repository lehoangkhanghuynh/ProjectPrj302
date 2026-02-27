<%-- 
    Document   : index
    Created on : Jan 9, 2026, 11:42:23 AM
    Author     : USER
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="Description" content="Khóa học coursera trường đại học fptu">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Khóa Học FPTU</title>
        <link rel="icon" href="images/favicon.png" type="image/png">
        <style>
            /* Reset */
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: Arial, sans-serif;
            }

            .container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 0 20px;
                display: flex;
                align-items: center;
                justify-content: space-between;
            }

            /* Top Bar */
            #top-bar {
                background-color: #f5f5f5;
                padding: 10px 0;
                border-bottom: 1px solid #ddd;
            }

            .search-box input {
                padding: 8px 15px;
                border: 1px solid #ccc;
                border-radius: 4px;
                width: 250px;
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
            /* Main Header */
            #main-header {
                background-color: white;
                padding: 15px 0;
                box-shadow: 0 2px 5px rgba(0,0,0,0.1);
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

            .main-nav a {
                text-decoration: none;
                color: #333;
                font-size: 14px;
                font-weight: 500;
            }

            .main-nav a:hover {
                color: #ff6600;
            }

            /* Auth Buttons */
            .auth-buttons {
                display: flex;
                gap: 10px;
            }

            .btn {
                padding: 8px 16px;
                border-radius: 6px;
                border: none;
                cursor: pointer;
                font-size: 14px;
            }

            .btn-login {
                background-color: white;
                color: #ff6600;
                border: 2px solid #ff6600;
            }

            .btn-login:hover {
                background-color: #ff6600;
                color: white;
            }

            .btn-register {
                background-color: #ff6600;
                color: white;
                border: 2px solid #ff6600;
            }

            .btn-register:hover {
                background-color: #ff8800;
            }

            /* Banner */
            .banner {
                width: 100%;
                margin: 0;
                padding: 0;
            }

            .banner img {
                width: 100%;
                height: auto;
                display: block;
            }

            /* Overlay */
            #overlay {
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0,0,0,0.5);
                opacity: 0;
                visibility: hidden;
                transition: opacity 0.3s ease, visibility 0.3s ease;
                z-index: 998;
            }

            #overlay.active {
                opacity: 1;
                visibility: visible;
            }

            /* Modal Styles */
            #loginModal, #registerModal {
                z-index: 999;
                position: fixed;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                background: white;
                opacity: 0;
                visibility: hidden;
                transition: opacity 0.3s ease, visibility 0.3s ease;
                border-radius: 12px;
                padding: 30px;
                width: 400px;
                max-width: 90%;
                box-shadow: 0 10px 40px rgba(0,0,0,0.2);
            }

            #loginModal.active, #registerModal.active {
                opacity: 1;
                visibility: visible;
            }

            #registerModal h3, #loginModal h3 {
                text-align: center;
                margin-bottom: 25px;
                color: #ff6600;
                font-size: 24px;
                font-weight: bold;
            }

            #registerModal input, #loginModal input {
                width: 100%;
                padding: 12px 15px;
                border: 2px solid #e0e0e0;
                margin-bottom: 15px;
                border-radius: 8px;
                display: block;
                font-size: 14px;
                transition: border-color 0.3s ease;
                box-sizing: border-box;
            }

            #registerModal input:focus, #loginModal input:focus {
                outline: none;
                border-color: #ff6600;
            }

            #registerModal input[type="submit"], #loginModal input[type="submit"] {
                background-color: #ff6600;
                color: white;
                border: none;
                cursor: pointer;
                font-weight: bold;
                margin-top: 10px;
                padding: 14px;
            }

            #registerModal input[type="submit"]:hover, #loginModal input[type="submit"]:hover {
                background-color: #ff8800;
            }

            /* Nút đóng modal */
            .modal-close-btn {
                background-color: #f5f5f5;
                color: #666;
                border: none;
                padding: 10px 20px;
                border-radius: 8px;
                cursor: pointer;
                width: 100%;
                margin-top: 10px;
                font-size: 14px;
            }

            .modal-close-btn:hover {
                background-color: #e0e0e0;
            }

            /* Thông báo lỗi/thành công */
            #registerMessage, #loginMessage {
                border-radius: 8px;
                padding: 12px;
                margin-bottom: 15px;
                text-align: center;
            }

            #registerMessage span, #loginMessage span {
                font-size: 14px;
                font-weight: 500;
            }

            /* Footer */
            #tailer {
                background-color: #f5f5f5;
                padding: 30px 20px;
                margin-top: 50px;
                text-align: center;
            }

            .contribute {
                font-style: italic;
                font-weight: normal;
                margin-top: 0.32em;
                margin-bottom: 0.32em;
            }

            .supporter {
                margin-top: 0.1em;
                margin-bottom: 0.1em;
            }

            /* Responsive */
            @media (max-width: 768px) {
                .container {
                    flex-wrap: wrap;
                }

                .campus-links {
                    display: none;
                }

                .main-nav {
                    display: none;
                }

                .auth-buttons {
                    margin-top: 10px;
                    width: 100%;
                    justify-content: center;
                }

                .banner img {
                    max-height: 300px;
                    object-fit: cover;
                }
            }

            @media (max-width: 480px) {
                .banner img {
                    max-height: 200px;
                }

                .search-box input {
                    width: 180px;
                }
            }
            /* Nút scroll to top test*/
            #scrollToTop {
                position: fixed;
                bottom: 30px;
                right: 30px;
                width: 50px;
                height: 50px;
                background-color: #ff6600;
                color: white;
                border: none;
                border-radius: 50%;
                font-size: 24px;
                cursor: pointer;
                box-shadow: 0 4px 10px rgba(0,0,0,0.3);
                opacity: 0;
                visibility: hidden;
                transition: all 0.3s ease;
                z-index: 997;
            }

            #scrollToTop.show {
                opacity: 1;
                visibility: visible;
            }

            #scrollToTop:hover {
                background-color: #ff8800;
                transform: translateY(-5px);
            }
        </style>
    </head>
    <body>
        <div id="top-bar">
            <div class="container">
                <div class="search-box">
                    <input type="text" placeholder="Search">
                </div>
                <div class="language">
                    <span class="active">VN</span> | <span>EN</span>
                </div>
            </div>
        </div>

        <div id="main-header">
            <div class="container">
                <div class="logo">
                    <img src="images/banner-png2.webp" alt="FPT Education">
                    <span>FPT Course</span>
                </div>
                <nav class="main-nav">
                    <a href="#">Course</a>
                    <a href="#">Forums</a>
                    <a href="#">Learning Progess</a>
                    <a href="#">Danh mục khóa học</a>
                    <a href="#">Liên hệ</a>
                </nav>
                <div class="auth-buttons">
                    <button class="btn btn-login" onclick="openLogin()">
                        Đăng Nhập
                    </button>
                    <button class="btn btn-register" onclick="openRegister()">
                        Đăng ký
                    </button>
                </div>
            </div>
        </div>

        <div class="banner">
            <img src="images/banner-jpg2.jpg" alt="FPT banner" class="banner-img">
        </div>

        <div id="overlay" onclick="closeAll()"></div>

        <!-- Modal đăng nhập -->
        <div id="loginModal">
            <h3>Đăng Nhập</h3>
            <div id="loginMessage" style="display: none;">
                <%
                    String logmsg = (String) request.getAttribute("errorLogin");
                    if (logmsg != null) {
                %>
                <span style="color: #e74c3c;"><%= logmsg%></span>
                <% } %>
            </div>

            <form action="LoginController" method="post">
                <input type="text" name="UserName" placeholder="Tên đăng nhập" required>
                <input type="password" name="PassWord" placeholder="Mật khẩu" required>
                <input type="submit" value="Đăng Nhập">
            </form>
            <button class="modal-close-btn" onclick="closeLogin()">Đóng</button>
        </div>

        <!-- Modal đăng ký -->
        <div id="registerModal">
            <h3>Đăng Ký Tài Khoản</h3>
            <div id="registerMessage" style="display:none;">
                <%
                    String msg = (String) request.getAttribute("errorMessage");
                    String success = (String) request.getAttribute("successMessage");
                    if (msg != null) {
                %>
                <span style="color:#e74c3c;"><%= msg%></span>
                <% } else if (success != null) {%>
                <span style="color:#27ae60;"><%= success%></span>
                <% }%>
            </div>
            <form action="RegisterController" method="post">
                <input type="text" name="UserName" placeholder="Tên đăng nhập" required>
                <input type="password" name="PassWord" placeholder="Mật khẩu" required>
                <input type="password" name="Confirm" placeholder="Xác nhận mật khẩu" required>
                <input type="submit" value="Đăng Ký">
            </form>
            <button class="modal-close-btn" onclick="closeRegister()">Đóng</button>
        </div>
        <!-- Nút scroll to top -->
        <button id="scrollToTop" onclick="scrollToTop()">
            ↑
        </button>
        <script>
            window.onload = function () {
                    // Hiển thị register message nếu có
                    var registerMsg = document.getElementById("registerMessage");
                    <% if (request.getAttribute("errorMessage") != null || request.getAttribute("successMessage") != null) { %>
            registerMsg.style.display = "block";
            openRegister();
                    <% } %>

            // Hiển thị login message nếu có
            var loginMsg = document.getElementById("loginMessage");
                    <% if (request.getAttribute("errorLogin") != null) { %>
            loginMsg.style.display = "block";
            openLogin();
                    <% }%>
                }
                        // Tách riêng window.onscroll
                        window.onscroll = function () {                     var scrollBtn = document.getElementById("scrollToTop");
            if (document.body.scrollTop > 300 || document.documentElement.scrollTop > 300) {
            scrollBtn.classList.add("show");
            } else {
            scrollBtn.classList.remove("show");
            }
                };
                
                        function showOverlay() {
                    document.getElementById("overlay").classList.add("active");
                }
                
                        function hideOverlay() {
                    document.getElementById("overlay").classList.remove("active");
                }
                
                function closeAll() {
                        closeLogin();
            closeRegister();
            hideOverlay();
                }
                
                function openLogin() {
                        closeRegister();
            showOverlay();
            document.getElementById("loginModal").classList.add("active");
                }
                
                function closeLogin() {
                        document.getElementById("loginModal").classList.remove("active");
                }
                
                function openRegister() {
                    closeLogin();
                        showOverlay();
            document.getElementById("registerModal").classList.add("active");
                }
                
            function closeRegister() {
                        document.getElementById("registerModal").classList.remove("active");
                }
                
                function scrollToTop() {
                    window.scrollTo({
                        top: 0,
                            behavior: 'smooth'
                    });
                }
</script>

        <div id="tailer">
            <p><span class="inf">Liên Hệ:</span> 0******9</p>
            <p><span class="inf">Mail: 
                    <a class="text-red" href="mailto:lonhkim85@gmail.com?subject=phản hồi từ web&body=Xin chào, tôi muốn liên hệ bạn để đăng ký khóa học">Gửi mail</a>
                </span></p>
            <h4 class="contribute">Tài trợ bởi</h4>
            <p class="supporter">Lê Hoàng Khang</p>
            <p class="supporter">Trần Lê PU</p>
            <p class="supporter">Nguyễn Huyền Diệu</p>
        </div>
    </body>
</html>