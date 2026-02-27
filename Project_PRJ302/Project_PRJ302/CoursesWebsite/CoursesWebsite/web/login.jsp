<%-- 
    Document   : login
    Created on : Feb 23, 2026, 9:55:43 PM
    Author     : HOANG KHANG PC
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Đăng nhập</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&family=DM+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">

        <style>
            :root {
                --purple:       #6C3FC5;
                --purple-dark:  #4E2C96;
                --purple-deep:  #1E0A4A;
                --purple-light: #F3EEFF;
                --purple-mid:   #9B72E8;
                --gold:         #D4A843;
                --text:         #1A1A2E;
                --muted:        #6B6B8A;
                --border:       #E2D9F3;
                --white:        #FFFFFF;
            }

            * {
                box-sizing: border-box;
                margin: 0;
                padding: 0;
            }

            body {
                font-family: 'DM Sans', sans-serif;
                background: #F8F5FF;
                min-height: 100vh;
                display: flex;
                flex-direction: column;
            }

            /* ===== NAVBAR ===== */
            .navbar-top {
                background: var(--purple-deep);
                padding: 0 40px;
                height: 64px;
                display: flex;
                align-items: center;
                justify-content: space-between;
            }

            .brand {
                font-family: 'Playfair Display', serif;
                font-size: 1.5rem;
                font-weight: 700;
                color: var(--white);
                text-decoration: none;
                letter-spacing: 0.5px;
            }

            .brand span {
                color: var(--gold);
            }

            .nav-right {
                display: flex;
                align-items: center;
                gap: 20px;
                font-size: 0.875rem;
            }

            .nav-right a {
                color: rgba(255,255,255,0.75);
                text-decoration: none;
                transition: color 0.15s;
            }
            .nav-right a:hover {
                color: #fff;
            }

            .btn-nav-register {
                border: 1px solid rgba(255,255,255,0.4);
                color: #fff !important;
                padding: 7px 20px;
                border-radius: 6px;
                font-weight: 600;
                transition: background 0.15s, border-color 0.15s !important;
            }
            .btn-nav-register:hover {
                background: rgba(255,255,255,0.1) !important;
                border-color: rgba(255,255,255,0.7) !important;
            }

            /* ===== LAYOUT ===== */
            .page-body {
                flex: 1;
                display: flex;
            }

            /* LEFT DECORATIVE PANEL */
            .left-panel {
                flex: 1;
                background: linear-gradient(145deg, var(--purple-deep) 0%, #3A1A7A 50%, var(--purple) 100%);
                display: flex;
                flex-direction: column;
                justify-content: center;
                padding: 64px 56px;
                position: relative;
                overflow: hidden;
            }

            .left-panel::before {
                content: '';
                position: absolute;
                width: 500px;
                height: 500px;
                border-radius: 50%;
                background: rgba(255,255,255,0.03);
                top: -150px;
                right: -150px;
            }

            .left-panel::after {
                content: '';
                position: absolute;
                width: 300px;
                height: 300px;
                border-radius: 50%;
                background: rgba(212,168,67,0.08);
                bottom: -80px;
                left: -60px;
            }

            .left-eyebrow {
                font-size: 0.75rem;
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: 2px;
                color: var(--gold);
                margin-bottom: 16px;
            }

            .left-heading {
                font-family: 'Playfair Display', serif;
                font-size: 2.6rem;
                font-weight: 700;
                color: #fff;
                line-height: 1.2;
                margin-bottom: 20px;
            }

            .left-sub {
                font-size: 1rem;
                color: rgba(255,255,255,0.7);
                line-height: 1.7;
                margin-bottom: 48px;
                max-width: 380px;
            }

            .feature-list {
                list-style: none;
            }

            .feature-list li {
                display: flex;
                align-items: center;
                gap: 14px;
                font-size: 0.9rem;
                color: rgba(255,255,255,0.85);
                margin-bottom: 16px;
            }

            .feature-list li .icon-wrap {
                width: 32px;
                height: 32px;
                border-radius: 8px;
                background: rgba(212,168,67,0.2);
                display: flex;
                align-items: center;
                justify-content: center;
                color: var(--gold);
                font-size: 0.9rem;
                flex-shrink: 0;
            }

            /* RIGHT FORM PANEL */
            .right-panel {
                width: 480px;
                background: var(--white);
                display: flex;
                flex-direction: column;
                justify-content: center;
                padding: 56px 48px;
                overflow-y: auto;
                box-shadow: -4px 0 32px rgba(108,63,197,0.08);
            }

            .form-heading {
                font-family: 'Playfair Display', serif;
                font-size: 2rem;
                font-weight: 700;
                color: var(--text);
                margin-bottom: 4px;
            }

            .form-sub {
                font-size: 0.9rem;
                color: var(--muted);
                margin-bottom: 32px;
            }

            /* SOCIAL */
            .btn-social {
                width: 100%;
                border: 1.5px solid var(--border);
                background: var(--white);
                color: var(--text);
                font-weight: 600;
                font-size: 0.875rem;
                padding: 11px 16px;
                border-radius: 8px;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 10px;
                text-decoration: none;
                transition: border-color 0.15s, background 0.15s;
                margin-bottom: 10px;
            }
            .btn-social:hover {
                border-color: var(--purple);
                background: var(--purple-light);
                color: var(--text);
            }

            /* DIVIDER */
            .divider {
                display: flex;
                align-items: center;
                gap: 12px;
                margin: 24px 0;
                font-size: 0.8rem;
                color: var(--muted);
                font-weight: 500;
            }
            .divider::before, .divider::after {
                content: '';
                flex: 1;
                height: 1px;
                background: var(--border);
            }

            /* FORM CONTROLS */
            .form-label {
                font-size: 0.875rem;
                font-weight: 600;
                color: var(--text);
                margin-bottom: 6px;
            }

            .form-control {
                border: 1.5px solid var(--border);
                border-radius: 8px;
                padding: 12px 14px;
                font-size: 0.9rem;
                font-family: 'DM Sans', sans-serif;
                color: var(--text);
                background: #FDFCFF;
                transition: border-color 0.15s, box-shadow 0.15s;
            }
            .form-control::placeholder {
                color: #B0A8C8;
            }
            .form-control:focus {
                border-color: var(--purple);
                box-shadow: 0 0 0 3px rgba(108,63,197,0.12);
                outline: none;
                background: #fff;
            }

            .password-wrap {
                position: relative;
            }
            .toggle-pw {
                position: absolute;
                right: 13px;
                top: 50%;
                transform: translateY(-50%);
                background: none;
                border: none;
                padding: 0;
                color: var(--muted);
                font-size: 1rem;
                cursor: pointer;
                transition: color 0.15s;
            }
            .toggle-pw:hover {
                color: var(--purple);
            }

            .forgot-link {
                font-size: 0.8rem;
                font-weight: 600;
                color: var(--purple);
                text-decoration: none;
            }
            .forgot-link:hover {
                text-decoration: underline;
            }

            /* REMEMBER ME */
            .form-check-input:checked {
                background-color: var(--purple);
                border-color: var(--purple);
            }
            .form-check-input:focus {
                box-shadow: 0 0 0 3px rgba(108,63,197,0.12);
            }

            /* SUBMIT */
            .btn-login {
                width: 100%;
                background: linear-gradient(135deg, var(--purple) 0%, var(--purple-dark) 100%);
                color: #fff;
                font-weight: 700;
                font-size: 0.95rem;
                padding: 13px;
                border: none;
                border-radius: 8px;
                letter-spacing: 0.4px;
                transition: opacity 0.15s, transform 0.1s, box-shadow 0.15s;
                box-shadow: 0 4px 14px rgba(108,63,197,0.35);
            }
            .btn-login:hover {
                opacity: 0.92;
                transform: translateY(-1px);
                box-shadow: 0 6px 20px rgba(108,63,197,0.45);
            }
            .btn-login:active {
                transform: translateY(0);
            }

            /* REGISTER LINK */
            .register-row {
                text-align: center;
                margin-top: 24px;
                padding-top: 20px;
                border-top: 1px solid var(--border);
                font-size: 0.875rem;
                color: var(--muted);
            }
            .register-row a {
                color: var(--purple);
                font-weight: 700;
                text-decoration: none;
            }
            .register-row a:hover {
                text-decoration: underline;
            }

            /* ALERT */
            .alert-err {
                background: #FFF3F3;
                border: 1px solid #FFB3B3;
                color: #CC0000;
                border-radius: 8px;
                padding: 12px 16px;
                font-size: 0.875rem;
                margin-bottom: 20px;
                display: flex;
                align-items: center;
                gap: 8px;
            }

            /* FOOTER */
            .footer-bottom {
                background: var(--purple-deep);
                padding: 14px 40px;
                text-align: center;
                font-size: 0.78rem;
                color: rgba(255,255,255,0.45);
            }
            .footer-bottom a {
                color: rgba(255,255,255,0.55);
                text-decoration: none;
            }
            .footer-bottom a:hover {
                color: #fff;
            }

            /* ANIMATIONS */
            @keyframes fadeUp {
                from {
                    opacity: 0;
                    transform: translateY(20px);
                }
                to   {
                    opacity: 1;
                    transform: translateY(0);
                }
            }
            .right-panel {
                animation: fadeUp 0.5s ease both;
            }

            @media (max-width: 860px) {
                .left-panel {
                    display: none;
                }
                .right-panel {
                    width: 100%;
                    padding: 40px 24px;
                }
            }
        </style>
    </head>
    <body>

        <!-- NAVBAR -->
        <nav class="navbar-top">
            <a href="index.jsp" class="brand">KKKedu<span>Academy</span></a>
            <div class="nav-right">
                <a href="#">Khóa học</a>
                <a href="#">Giảng viên</a>
                <a href="register.jsp" class="btn-nav-register">Đăng ký ngay</a>
            </div>
        </nav>

        <!-- BODY -->
        <div class="page-body">

            <!-- LEFT -->
            <div class="left-panel">
                <div class="left-eyebrow">✦ Nền tảng học trực tuyến</div>
                <h1 class="left-heading">Chào mừng<br>trở lại với<br>KKKedu Academy</h1>
                <p class="left-sub">Tiếp tục hành trình chinh phục tri thức của bạn. Hàng nghìn khóa học đang chờ đón.</p>

                <ul class="feature-list">
                    <li>
                        <span class="icon-wrap"><i class="bi bi-play-fill"></i></span>
                        Truy cập không giới hạn mọi khóa học
                    </li>
                    <li>
                        <span class="icon-wrap"><i class="bi bi-award-fill"></i></span>
                        Chứng chỉ được công nhận rộng rãi
                    </li>
                    <li>
                        <span class="icon-wrap"><i class="bi bi-people-fill"></i></span>
                        Cộng đồng hơn 500,000 học viên
                    </li>
                    <li>
                        <span class="icon-wrap"><i class="bi bi-lightning-fill"></i></span>
                        Học theo tốc độ của riêng bạn
                    </li>
                </ul>
            </div>

            <!-- RIGHT -->
            <div class="right-panel">
                <h2 class="form-heading">Đăng nhập</h2>
                <p class="form-sub">Nhập thông tin tài khoản để tiếp tục</p>

                <!-- Error -->
                <c:if test="${not empty message}">
                    <div class="alert-err">
                        <i class="bi bi-exclamation-circle-fill"></i>
                        ${message}
                    </div>
                </c:if>

                <!-- Social -->
                <a href="#" class="btn-social">
                    <svg width="18" height="18" viewBox="0 0 48 48"><path fill="#FFC107" d="M43.6 20.1H42V20H24v8h11.3C33.7 32.7 29.2 36 24 36c-6.6 0-12-5.4-12-12s5.4-12 12-12c3.1 0 5.8 1.1 8 2.9l5.7-5.7C34 6.1 29.3 4 24 4 12.9 4 4 12.9 4 24s8.9 20 20 20 20-8.9 20-20c0-1.3-.1-2.6-.4-3.9z"/><path fill="#FF3D00" d="m6.3 14.7 6.6 4.8C14.7 16 19.1 12 24 12c3.1 0 5.8 1.1 8 2.9l5.7-5.7C34 6.1 29.3 4 24 4c-7.7 0-14.4 4.4-17.7 10.7z"/><path fill="#4CAF50" d="M24 44c5.2 0 9.9-2 13.4-5.2l-6.2-5.2C29.3 35.4 26.8 36 24 36c-5.2 0-9.6-3.3-11.3-8H6.1c3.3 6.5 10.1 11 17.9 11z"/><path fill="#1976D2" d="M43.6 20.1H42V20H24v8h11.3c-.8 2.3-2.3 4.2-4.2 5.6l6.2 5.2c-.4.4 6.7-4.9 6.7-14.8 0-1.3-.1-2.6-.4-3.9z"/></svg>
                    Đăng nhập với Google
                </a>
                <a href="#" class="btn-social">
                    <svg width="18" height="18" viewBox="0 0 24 24"><path fill="#1877F2" d="M24 12.07C24 5.41 18.63 0 12 0S0 5.4 0 12.07C0 18.1 4.39 23.1 10.13 24v-8.44H7.08v-3.49h3.04V9.41c0-3.02 1.8-4.7 4.54-4.7 1.31 0 2.68.24 2.68.24v2.97h-1.51c-1.49 0-1.95.93-1.95 1.88v2.26h3.32l-.53 3.5h-2.8V24C19.62 23.1 24 18.1 24 12.07z"/></svg>
                    Đăng nhập với Facebook
                </a>

                <div class="divider">hoặc dùng tài khoản</div>

                <!-- Form -->
                <form action="mainController" method="POST" novalidate>
                    <input type="hidden" name="action" value="login" />

                    <div class="mb-3">
                        <label for="userName" class="form-label">Tên đăng nhập</label>
                        <input type="text" class="form-control" name="userName" id="userName"
                               placeholder="Nhập tên đăng nhập" required />
                    </div>

                    <div class="mb-2">
                        <div class="d-flex justify-content-between align-items-center mb-1">
                            <label for="password" class="form-label mb-0">Mật khẩu</label>
                            <a href="#" class="forgot-link">Quên mật khẩu?</a>
                        </div>
                        <div class="password-wrap">
                            <input type="password" class="form-control pe-5" name="password" id="password"
                                   placeholder="Nhập mật khẩu" required />
                            <button type="button" class="toggle-pw" onclick="togglePassword()">
                                <i class="bi bi-eye" id="eyeIcon"></i>
                            </button>
                        </div>
                    </div>

                    <div class="mb-4 mt-2">
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" id="rememberMe">
                            <label class="form-check-label" for="rememberMe"
                                   style="font-size:0.875rem; color: var(--muted);">
                                Ghi nhớ đăng nhập
                            </label>
                        </div>
                    </div>

                    <button type="submit" class="btn-login">
                        <i class="bi bi-box-arrow-in-right me-2"></i>Đăng nhập
                    </button>
                </form>

                <div class="register-row">
                    Chưa có tài khoản? <a href="register.jsp">Tạo tài khoản miễn phí</a>
                </div>
            </div>
        </div>

        <!-- FOOTER -->
        <div class="footer-bottom">
            © 2026 LearnVerse &nbsp;·&nbsp;
            <a href="#">Điều khoản</a> &nbsp;·&nbsp;
            <a href="#">Chính sách</a>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                                function togglePassword() {
                                    const input = document.getElementById('password');
                                    const icon = document.getElementById('eyeIcon');
                                    if (input.type === 'password') {
                                        input.type = 'text';
                                        icon.className = 'bi bi-eye-slash';
                                    } else {
                                        input.type = 'password';
                                        icon.className = 'bi bi-eye';
                                    }
                                }
        </script>
    </body>
</html>
