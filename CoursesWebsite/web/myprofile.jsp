<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Hồ sơ của tôi - KKKAcademy</title>
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

            *, *::before, *::after {
                box-sizing: border-box;
                margin: 0;
                padding: 0;
            }

            body {
                font-family: 'DM Sans', sans-serif;
                color: var(--text);
                background: #F8F5FF;
                min-height: 100vh;
            }

            /* ===== NAVBAR ===== */
            .navbar-main {
                background: var(--purple-deep);
                padding: 0 48px;
                height: 68px;
                display: flex;
                align-items: center;
                justify-content: space-between;
                position: sticky;
                top: 0;
                z-index: 100;
                box-shadow: 0 2px 20px rgba(0,0,0,0.25);
            }

            .brand {
                font-family: 'Playfair Display', serif;
                font-size: 1.55rem;
                font-weight: 700;
                color: #fff;
                text-decoration: none;
            }
            .brand span {
                color: var(--gold);
            }

            .nav-links {
                display: flex;
                align-items: center;
                gap: 4px;
                list-style: none;
            }
            .nav-links a {
                font-size: 0.9rem;
                font-weight: 500;
                color: rgba(255,255,255,0.75);
                text-decoration: none;
                padding: 7px 14px;
                border-radius: 6px;
                transition: background 0.15s, color 0.15s;
            }
            .nav-links a:hover {
                background: rgba(255,255,255,0.08);
                color: #fff;
            }

            .user-menu {
                display: flex;
                align-items: center;
                gap: 10px;
                cursor: pointer;
                padding: 6px 12px;
                border-radius: 8px;
                border: 1px solid rgba(255,255,255,0.15);
                transition: background 0.15s;
                text-decoration: none;
            }
            .user-menu:hover {
                background: rgba(255,255,255,0.08);
            }

            .user-avatar {
                width: 34px;
                height: 34px;
                border-radius: 50%;
                background: linear-gradient(135deg, var(--purple-mid), var(--gold));
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 0.9rem;
                font-weight: 700;
                color: transparent;
                flex-shrink: 0;
                overflow: hidden;
                text-transform: uppercase;
            }
            .user-avatar::first-letter {
                color: #fff;
            }
            .user-name {
                font-size: 0.875rem;
                font-weight: 600;
                color: #fff;
            }

            /* ===== PAGE LAYOUT ===== */
            .page-wrapper {
                max-width: 860px;
                margin: 48px auto;
                padding: 0 24px;
                animation: fadeUp 0.5s ease both;
            }

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

            /* ===== PROFILE HEADER ===== */
            .profile-header {
                background: linear-gradient(135deg, var(--purple-deep) 0%, #3A1A7A 100%);
                border-radius: 16px;
                padding: 36px 40px;
                display: flex;
                align-items: center;
                gap: 24px;
                margin-bottom: 24px;
                position: relative;
                overflow: hidden;
            }

            .profile-header::before {
                content: '';
                position: absolute;
                width: 300px;
                height: 300px;
                border-radius: 50%;
                background: rgba(212,168,67,0.05);
                top: -150px;
                right: -50px;
            }

            .profile-avatar-lg {
                width: 72px;
                height: 72px;
                border-radius: 50%;
                background: linear-gradient(135deg, var(--purple-mid), var(--gold));
                display: flex;
                align-items: center;
                justify-content: center;
                font-family: 'Playfair Display', serif;
                font-size: 1.8rem;
                font-weight: 700;
                color: transparent;
                flex-shrink: 0;
                border: 3px solid rgba(255,255,255,0.2);
                position: relative;
                z-index: 1;
                overflow: hidden;
                text-transform: uppercase;
            }
            .profile-avatar-lg::first-letter {
                color: #fff;
            }

            .profile-header-info {
                position: relative;
                z-index: 1;
            }

            .profile-header-info h1 {
                font-family: 'Playfair Display', serif;
                font-size: 1.5rem;
                font-weight: 700;
                color: #fff;
                margin-bottom: 4px;
            }

            .profile-header-info p {
                font-size: 0.85rem;
                color: rgba(255,255,255,0.55);
            }

            .profile-id-badge {
                margin-left: auto;
                background: rgba(255,255,255,0.07);
                border: 1px solid rgba(255,255,255,0.12);
                border-radius: 8px;
                padding: 10px 18px;
                text-align: center;
                position: relative;
                z-index: 1;
            }
            .profile-id-badge .label {
                font-size: 0.7rem;
                color: rgba(255,255,255,0.45);
                text-transform: uppercase;
                letter-spacing: 1px;
                display: block;
                margin-bottom: 2px;
            }
            .profile-id-badge .value {
                font-size: 1rem;
                font-weight: 700;
                color: var(--gold);
            }

            /* ===== CARDS ===== */
            .card-section {
                background: var(--white);
                border: 1px solid var(--border);
                border-radius: 14px;
                padding: 32px 36px;
                margin-bottom: 20px;
                box-shadow: 0 2px 12px rgba(108,63,197,0.06);
            }

            .card-section-title {
                display: flex;
                align-items: center;
                gap: 10px;
                font-size: 1rem;
                font-weight: 700;
                color: var(--text);
                margin-bottom: 24px;
                padding-bottom: 16px;
                border-bottom: 1px solid var(--border);
            }

            .card-section-title i {
                width: 34px;
                height: 34px;
                background: var(--purple-light);
                border-radius: 8px;
                display: flex;
                align-items: center;
                justify-content: center;
                color: var(--purple);
                font-size: 0.95rem;
                border: 1px solid var(--border);
            }

            /* ===== FORM ELEMENTS ===== */
            .form-label {
                font-size: 0.82rem;
                font-weight: 600;
                color: var(--muted);
                text-transform: uppercase;
                letter-spacing: 0.5px;
                margin-bottom: 6px;
            }

            .form-control {
                font-family: 'DM Sans', sans-serif;
                font-size: 0.9rem;
                border: 1.5px solid var(--border);
                border-radius: 9px;
                padding: 10px 14px;
                color: var(--text);
                background: #FAFAFA;
                transition: border-color 0.15s, box-shadow 0.15s, background 0.15s;
            }
            .form-control:focus {
                border-color: var(--purple);
                box-shadow: 0 0 0 3px rgba(108,63,197,0.1);
                background: #fff;
                outline: none;
            }
            .form-control::placeholder {
                color: #B0A8C8;
            }

            /* ===== BUTTONS ===== */
            .btn-purple {
                background: linear-gradient(135deg, var(--purple-dark), var(--purple));
                color: #fff;
                font-family: 'DM Sans', sans-serif;
                font-weight: 700;
                font-size: 0.875rem;
                padding: 11px 28px;
                border-radius: 9px;
                border: none;
                cursor: pointer;
                display: inline-flex;
                align-items: center;
                gap: 8px;
                transition: opacity 0.15s, transform 0.1s;
                box-shadow: 0 4px 14px rgba(108,63,197,0.3);
            }
            .btn-purple:hover {
                opacity: 0.9;
                transform: translateY(-1px);
            }

            .btn-outline-purple {
                background: transparent;
                color: var(--purple);
                font-family: 'DM Sans', sans-serif;
                font-weight: 700;
                font-size: 0.875rem;
                padding: 11px 28px;
                border-radius: 9px;
                border: 1.5px solid var(--border);
                cursor: pointer;
                display: inline-flex;
                align-items: center;
                gap: 8px;
                transition: border-color 0.15s, background 0.15s;
            }
            .btn-outline-purple:hover {
                border-color: var(--purple);
                background: var(--purple-light);
            }

            /* ===== ALERTS ===== */
            .alert-success-custom {
                display: flex;
                align-items: center;
                gap: 10px;
                background: #F0FDF4;
                border: 1px solid #BBF7D0;
                color: #15803D;
                border-radius: 9px;
                padding: 12px 16px;
                font-size: 0.875rem;
                font-weight: 500;
                margin-top: 16px;
            }

            .alert-error-custom {
                display: flex;
                align-items: center;
                gap: 10px;
                background: #FFF5F5;
                border: 1px solid #FECACA;
                color: #DC2626;
                border-radius: 9px;
                padding: 12px 16px;
                font-size: 0.875rem;
                font-weight: 500;
                margin-top: 16px;
            }

            /* ===== PASSWORD STRENGTH ===== */
            .input-password-wrapper {
                position: relative;
            }
            .toggle-pw {
                position: absolute;
                right: 12px;
                top: 50%;
                transform: translateY(-50%);
                background: none;
                border: none;
                color: var(--muted);
                cursor: pointer;
                font-size: 1rem;
                padding: 0;
                line-height: 1;
            }
            .toggle-pw:hover {
                color: var(--purple);
            }

            /* ===== RESPONSIVE ===== */
            @media (max-width: 768px) {
                .navbar-main {
                    padding: 0 20px;
                }
                .page-wrapper {
                    margin: 24px auto;
                }
                .profile-header {
                    flex-direction: column;
                    text-align: center;
                    padding: 28px 24px;
                }
                .profile-id-badge {
                    margin-left: 0;
                }
                .card-section {
                    padding: 24px 20px;
                }
            }
        </style>
    </head>
    <body>
        <c:if test="${empty sessionScope.user}">
            <c:redirect url="login.jsp" />
        </c:if>

        <!-- NAVBAR -->
        <nav class="navbar-main">
            <a href="homePage.jsp" class="brand">KKK<span>Academy</span></a>
            <ul class="nav-links">
                <li><a href="search.jsp"><i class="bi bi-compass me-1"></i>Khám phá</a></li>
                <li><a href="mainController?action=ExploreCourse">Khóa học</a></li>
                <li><a href="#">Giảng viên</a></li>
                <li><a href="#">Về chúng tôi</a></li>
            </ul>
            <a href="homePage.jsp" class="user-menu">
                <div class="user-avatar">
                    ${sessionScope.user.fullname}
                </div>
                <span class="user-name">${sessionScope.user.fullname}</span>
            </a>
        </nav>

        <!-- PAGE -->
        <div class="page-wrapper">

            <!-- PROFILE HEADER -->
            <div class="profile-header">
                <div class="profile-avatar-lg">
                    ${sessionScope.user.fullname}
                </div>
                <div class="profile-header-info">
                    <h1>${sessionScope.user.fullname}</h1>
                    <p>${sessionScope.user.email}</p>
                </div>
                <div class="profile-id-badge">
                    <span class="label">ID tài khoản</span>
                    <span class="value">#${sessionScope.user.userId}</span>
                </div>
            </div>

            <!-- FORM CẬP NHẬT THÔNG TIN -->
            <div class="card-section">
                <div class="card-section-title">
                    <i class="bi bi-person-fill"></i>
                    Cập nhật thông tin cá nhân
                </div>

                <form action="mainController" method="POST">
                    <input type="hidden" name="action" value="updateUser" />
                    <input type="hidden" name="userId" value="${sessionScope.user.userId}" />

                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label">Họ và tên</label>
                            <input type="text" class="form-control" name="fullname"
                                   placeholder="${sessionScope.user.fullname}" />
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Email</label>
                            <input type="text" class="form-control" name="email"
                                   placeholder="${sessionScope.user.email}" />
                        </div>

                        <label>Age</label>
                        <c:forEach items="list" var="u" varStatus="loop"/>
                        <select name="age">
                            <option>${loop.count}</option>
                        </select>
                        <input type="text" name="location" value="${location}" placeholder="Hometown" />
                        <select name="Sex">
                            <option>Male</option>
                            <option>Female</option>
                            <option>Lesbian</option>
                            <option>Gay</option>
                            <option>Unisex</option>
                        </select>
                    </div>

                    <div class="mt-4 d-flex gap-2">
                        <button type="submit" class="btn-purple"
                                onclick="return confirm('Bạn có chắc muốn cập nhật thông tin không?')">
                            <i class="bi bi-check-lg"></i> Lưu thay đổi
                        </button>
                        <a href="homePage.jsp" class="btn-outline-purple">
                            <i class="bi bi-arrow-left"></i> Quay lại
                        </a>
                    </div>

                </form>

                <c:if test="${not empty MSG}">
                    <div class="alert-success-custom">
                        <i class="bi bi-check-circle-fill"></i> ${MSG}
                    </div>
                </c:if>
                <c:if test="${not empty ERROR}">
                    <div class="alert-error-custom">
                        <i class="bi bi-exclamation-circle-fill"></i> ${ERROR}
                    </div>
                </c:if>
            </div>

            <!-- FORM ĐỔI MẬT KHẨU -->
            <div class="card-section">
                <div class="card-section-title">
                    <i class="bi bi-shield-lock-fill"></i>
                    Đổi mật khẩu
                </div>

                <form action="mainController" method="POST">
                    <input type="hidden" name="action" value="updatePassword" />
                    <input type="hidden" name="userId" value="${sessionScope.user.userId}" />

                    <div class="row g-3">
                        <div class="col-12">
                            <label class="form-label">Mật khẩu hiện tại</label>
                            <div class="input-password-wrapper">
                                <input type="password" class="form-control pe-5"
                                       name="oldPassword" id="oldPassword" required />
                                <button type="button" class="toggle-pw" onclick="togglePw('oldPassword', this)">
                                    <i class="bi bi-eye"></i>
                                </button>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Mật khẩu mới</label>
                            <div class="input-password-wrapper">
                                <input type="password" class="form-control pe-5"
                                       name="password" id="newPassword" required />
                                <button type="button" class="toggle-pw" onclick="togglePw('newPassword', this)">
                                    <i class="bi bi-eye"></i>
                                </button>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Xác nhận mật khẩu mới</label>
                            <div class="input-password-wrapper">
                                <input type="password" class="form-control pe-5"
                                       name="confirmPassword" id="confirmPassword" required />
                                <button type="button" class="toggle-pw" onclick="togglePw('confirmPassword', this)">
                                    <i class="bi bi-eye"></i>
                                </button>
                            </div>
                        </div>
                    </div>

                    <div class="mt-4">
                        <button type="submit" class="btn-purple" onclick="return confirmPassword()">
                            <i class="bi bi-shield-check"></i> Đổi mật khẩu
                        </button>
                    </div>
                </form>

                <c:if test="${not empty MSGpass}">
                    <div class="alert-success-custom">
                        <i class="bi bi-check-circle-fill"></i> ${MSGpass}
                    </div>
                </c:if>
                <c:if test="${not empty ERRORpass}">
                    <div class="alert-error-custom">
                        <i class="bi bi-exclamation-circle-fill"></i> ${ERRORpass}
                    </div>
                </c:if>
            </div>

        </div><!-- end page-wrapper -->

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                            function togglePw(fieldId, btn) {
                                const input = document.getElementById(fieldId);
                                const icon = btn.querySelector('i');
                                if (input.type === 'password') {
                                    input.type = 'text';
                                    icon.className = 'bi bi-eye-slash';
                                } else {
                                    input.type = 'password';
                                    icon.className = 'bi bi-eye';
                                }
                            }

                            function confirmPassword() {
                                let oldPass = document.getElementById("oldPassword").value;
                                let pass = document.getElementById("newPassword").value;
                                let confirmPass = document.getElementById("confirmPassword").value;

                                if (oldPass.trim() === "") {
                                    alert("Vui lòng nhập mật khẩu cũ!");
                                    return false;
                                }
                                if (pass.length < 6) {
                                    alert("Mật khẩu mới phải có ít nhất 6 ký tự!");
                                    return false;
                                }
                                if (pass !== confirmPass) {
                                    alert("Mật khẩu xác nhận không khớp!");
                                    return false;
                                }
                                return confirm("Bạn có chắc muốn đổi mật khẩu không?");
                            }
        </script>
    </body>
</html>
