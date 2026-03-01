<%-- 
    Document   : homePage
    Created on : Feb 23, 2026, 10:11:54 PM
    Author     : HOANG KHANG PC
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>DUKedu - Home</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&family=DM+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
        <link rel="icon" type="favicon" href="img/page/favicon.jpg">
        <style>
            :root {
                --purple:      #6C3FC5;
                --purple-dark: #4E2C96;
                --purple-deep: #1E0A4A;
                --purple-light:#F3EEFF;
                --purple-mid:  #9B72E8;
                --gold:        #D4A843;
                --text:        #1A1A2E;
                --muted:       #6B6B8A;
                --border:      #E2D9F3;
                --white:       #FFFFFF;
            }
            *, *::before, *::after {
                box-sizing: border-box;
                margin: 0;
                padding: 0;
            }
            body {
                font-family: 'DM Sans', sans-serif;
                color: var(--text);
                background: #fff;
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
                letter-spacing: 0.3px;
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
            .nav-right {
                display: flex;
                align-items: center;
                gap: 12px;
            }

            .search-bar {
                display: flex;
                align-items: center;
                background: rgba(255,255,255,0.1);
                border: 1px solid rgba(255,255,255,0.15);
                border-radius: 8px;
                padding: 7px 14px;
                gap: 8px;
                transition: background 0.15s;
            }
            .search-bar:hover {
                background: rgba(255,255,255,0.15);
            }
            .search-bar input {
                background: none;
                border: none;
                outline: none;
                color: #fff;
                font-size: 0.875rem;
                font-family: 'DM Sans', sans-serif;
                width: 180px;
            }
            .search-bar input::placeholder {
                color: rgba(255,255,255,0.5);
            }
            .search-bar i {
                color: rgba(255,255,255,0.6);
                font-size: 0.9rem;
            }

            /* ===== BALANCE PILL ===== */
            .balance-pill {
                display: flex;
                align-items: center;
                gap: 7px;
                background: rgba(212,168,67,0.12);
                border: 1px solid rgba(212,168,67,0.35);
                border-radius: 8px;
                padding: 7px 14px;
                text-decoration: none;
                transition: background 0.15s;
                cursor: pointer;
            }
            .balance-pill:hover {
                background: rgba(212,168,67,0.22);
            }
            .balance-pill i {
                color: var(--gold);
                font-size: 0.95rem;
            }
            .balance-label {
                font-size: 0.75rem;
                font-weight: 500;
                color: rgba(255,255,255,0.6);
            }
            .balance-amount {
                font-size: 0.875rem;
                font-weight: 700;
                color: var(--gold);
                letter-spacing: 0.2px;
            }

            .user-menu {
                display: flex;
                align-items: center;
                gap: 10px;
                cursor: pointer;
                padding: 6px 12px;
                border-radius: 8px;
                transition: background 0.15s;
                border: 1px solid rgba(255,255,255,0.15);
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
                color: #fff;
                flex-shrink: 0;
            }
            .user-name {
                font-size: 0.875rem;
                font-weight: 600;
                color: #fff;
                max-width: 120px;
                overflow: hidden;
                text-overflow: ellipsis;
                white-space: nowrap;
            }

            .dropdown-menu-custom {
                position: absolute;
                top: 76px;
                right: 48px;
                background: #fff;
                border: 1px solid var(--border);
                border-radius: 10px;
                padding: 8px;
                min-width: 200px;
                box-shadow: 0 8px 32px rgba(0,0,0,0.15);
                display: none;
                z-index: 200;
            }
            .dropdown-menu-custom.show {
                display: block;
            }
            .dropdown-menu-custom a {
                display: flex;
                align-items: center;
                gap: 10px;
                padding: 10px 14px;
                border-radius: 7px;
                font-size: 0.875rem;
                color: var(--text);
                text-decoration: none;
                font-weight: 500;
                transition: background 0.12s;
            }
            .dropdown-menu-custom a:hover {
                background: var(--purple-light);
                color: var(--purple);
            }
            .dropdown-menu-custom .divider-drop {
                height: 1px;
                background: var(--border);
                margin: 6px 0;
            }
            .dropdown-menu-custom .logout-link {
                color: #CC0000;
            }
            .dropdown-menu-custom .logout-link:hover {
                background: #FFF3F3;
                color: #CC0000;
            }

            /* ===== HERO ===== */
            .hero {
                background: linear-gradient(145deg, var(--purple-deep) 0%, #3A1A7A 50%, #5B2DC5 100%);
                padding: 88px 80px 0;
                display: flex;
                align-items: center;
                gap: 64px;
                overflow: hidden;
                min-height: 500px;
                position: relative;
            }
            .hero::before {
                content: '';
                position: absolute;
                width: 600px;
                height: 600px;
                border-radius: 50%;
                background: rgba(212,168,67,0.05);
                top: -200px;
                right: -100px;
            }
            .hero-content {
                flex: 1;
                padding-bottom: 40px;
                position: relative;
                z-index: 1;
                animation: fadeUp 0.6s ease both;
                display: flex;
                flex-direction: column;
                align-items: flex-start;
            }
            .hero-eyebrow {
                display: inline-flex;
                align-items: center;
                gap: 8px;
                background: rgba(212,168,67,0.15);
                border: 1px solid rgba(212,168,67,0.3);
                color: var(--gold);
                font-size: 0.78rem;
                font-weight: 700;
                padding: 6px 14px;
                border-radius: 20px;
                margin-bottom: 22px;
                letter-spacing: 1px;
                text-transform: uppercase;
                align-self: flex-start;
            }
            .welcome-badge {
                display: inline-flex;
                align-items: center;
                gap: 10px;
                background: rgba(255,255,255,0.08);
                border: 1px solid rgba(255,255,255,0.15);
                border-radius: 10px;
                padding: 10px 18px;
                margin-bottom: 22px;
                color: rgba(255,255,255,0.9);
                font-size: 0.9rem;
                font-weight: 500;
                align-self: flex-start;
            }
            .welcome-badge strong {
                color: var(--gold);
            }
            .hero h1 {
                font-family: 'Playfair Display', serif;
                font-size: 3.4rem;
                font-weight: 700;
                color: #fff;
                line-height: 1.15;
                margin-bottom: 20px;
            }
            .hero h1 em {
                font-style: normal;
                color: var(--gold);
            }
            .hero p {
                font-size: 1.05rem;
                color: rgba(255,255,255,0.78);
                max-width: 500px;
                line-height: 1.7;
                margin-bottom: 36px;
            }
            .hero-actions {
                display: flex;
                gap: 14px;
                flex-wrap: wrap;
            }
            .btn-hero-primary {
                background: var(--gold);
                color: var(--purple-deep);
                font-weight: 700;
                font-size: 0.95rem;
                padding: 13px 32px;
                border-radius: 8px;
                border: none;
                text-decoration: none;
                transition: opacity 0.15s, transform 0.1s;
                box-shadow: 0 4px 16px rgba(212,168,67,0.4);
                display: inline-flex;
                align-items: center;
                gap: 8px;
            }
            .btn-hero-primary:hover {
                opacity: 0.9;
                transform: translateY(-1px);
                color: var(--purple-deep);
            }
            .btn-hero-secondary {
                background: transparent;
                color: #fff;
                font-weight: 600;
                font-size: 0.95rem;
                padding: 13px 28px;
                border-radius: 8px;
                border: 1.5px solid rgba(255,255,255,0.35);
                text-decoration: none;
                transition: border-color 0.15s, background 0.15s;
                display: inline-flex;
                align-items: center;
                gap: 8px;
            }
            .btn-hero-secondary:hover {
                border-color: #fff;
                background: rgba(255,255,255,0.06);
                color: #fff;
            }

            .hero-right {
                flex: 0 0 360px;
                padding-bottom: 40px;
                position: relative;
                z-index: 1;
                animation: fadeUp 0.6s 0.2s ease both;
            }
            .instructor-panel {
                background: rgba(255,255,255,0.06);
                border: 1px solid rgba(255,255,255,0.12);
                border-radius: 14px;
                padding: 20px;
                backdrop-filter: blur(12px);
            }
            .instructor-panel-title {
                font-size: 0.72rem;
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: 1.5px;
                color: var(--gold);
                margin-bottom: 14px;
                display: flex;
                align-items: center;
                gap: 6px;
            }
            .instructor-card {
                background: #fff;
                border-radius: 10px;
                padding: 12px 14px;
                margin-bottom: 10px;
                box-shadow: 0 4px 16px rgba(0,0,0,0.12);
                display: flex;
                align-items: center;
                gap: 12px;
                transition: transform 0.15s;
            }
            .instructor-card:last-child {
                margin-bottom: 0;
            }
            .instructor-card:hover {
                transform: translateX(3px);
            }
            .instructor-avatar {
                width: 46px;
                height: 46px;
                min-width: 46px;
                border-radius: 50%;
                object-fit: cover;
                object-position: center top;
                flex-shrink: 0;
                border: 2px solid var(--border);
                display: block;
            }
            .instructor-avatar-placeholder {
                width: 46px;
                height: 46px;
                min-width: 46px;
                border-radius: 50%;
                flex-shrink: 0;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1.1rem;
                font-weight: 700;
                color: #fff;
                border: 2px solid rgba(255,255,255,0.3);
            }
            .av1 {
                background: linear-gradient(135deg, #6C3FC5, #9B72E8);
            }
            .av2 {
                background: linear-gradient(135deg, #D4A843, #F5CC6A);
                color: #1E0A4A;
            }
            .av3 {
                background: linear-gradient(135deg, #1B5E20, #43A047);
            }
            .instructor-info {
                flex: 1;
                min-width: 0;
            }
            .instructor-info h4 {
                font-size: 0.84rem;
                font-weight: 700;
                color: var(--text);
                margin-bottom: 2px;
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
            }
            .instructor-info .ins-subject {
                font-size: 0.72rem;
                color: var(--purple);
                font-weight: 600;
                margin-bottom: 3px;
            }
            .instructor-info .ins-meta {
                font-size: 0.7rem;
                color: var(--muted);
                display: flex;
                align-items: center;
                gap: 6px;
            }
            .ins-stars {
                color: var(--gold);
                font-size: 0.68rem;
            }
            .ins-badge {
                background: var(--purple-light);
                color: var(--purple);
                font-size: 0.6rem;
                font-weight: 700;
                padding: 2px 7px;
                border-radius: 4px;
                text-transform: uppercase;
                letter-spacing: 0.3px;
                flex-shrink: 0;
            }

            /* ===== COURSES ===== */
            .courses {
                background: #F8F5FF;
                padding: 72px 80px;
            }
            .section-eyebrow {
                font-size: 0.75rem;
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: 2px;
                color: var(--purple);
                margin-bottom: 8px;
            }
            .section-title {
                font-family: 'Playfair Display', serif;
                font-size: 2rem;
                font-weight: 700;
                color: var(--text);
                margin-bottom: 8px;
            }
            .section-sub {
                font-size: 0.95rem;
                color: var(--muted);
                margin-bottom: 40px;
                max-width: 520px;
            }
            .course-grid {
                display: grid;
                grid-template-columns: repeat(4, 1fr);
                gap: 20px;
            }
            .course-card {
                background: #fff;
                border: 1px solid var(--border);
                border-radius: 12px;
                overflow: hidden;
                text-decoration: none;
                color: var(--text);
                transition: box-shadow 0.2s, transform 0.2s;
                display: block;
            }
            .course-card:hover {
                box-shadow: 0 10px 32px rgba(108,63,197,0.14);
                transform: translateY(-4px);
                color: var(--text);
            }
            .course-thumb {
                height: 148px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 3rem;
                overflow: hidden;
                position: relative;
            }
            .course-thumb img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                object-position: center;
                display: block;
                position: absolute;
                top: 0;
                left: 0;
            }
            .th1 {
                background: linear-gradient(135deg, #1E0A4A, #6C3FC5);
            }
            .th2 {
                background: linear-gradient(135deg, #3A1A7A, #9B72E8);
            }
            .th3 {
                background: linear-gradient(135deg, #4E2C96, #D4A843);
            }
            .th4 {
                background: linear-gradient(135deg, #1A0D35, #5B2DC5);
            }
            .course-body {
                padding: 16px 18px 18px;
            }
            .course-org {
                font-size: 0.72rem;
                font-weight: 700;
                color: var(--purple);
                text-transform: uppercase;
                letter-spacing: 0.5px;
                margin-bottom: 6px;
            }
            .course-body h3 {
                font-size: 0.9rem;
                font-weight: 700;
                line-height: 1.45;
                margin-bottom: 10px;
                color: var(--text);
            }
            .course-meta {
                display: flex;
                align-items: center;
                gap: 6px;
                font-size: 0.78rem;
            }
            .course-stars {
                color: var(--gold);
            }
            .course-score {
                font-weight: 700;
                color: var(--text);
            }
            .course-count {
                color: var(--muted);
            }
            .course-tag {
                display: inline-block;
                background: var(--purple-light);
                color: var(--purple);
                font-size: 0.68rem;
                font-weight: 700;
                padding: 3px 9px;
                border-radius: 4px;
                margin-top: 10px;
            }

            /* ===== FOOTER ===== */
            footer {
                background: var(--purple-deep);
                padding: 56px 80px 24px;
            }
            .footer-grid {
                display: grid;
                grid-template-columns: 2fr 1fr 1fr 1fr;
                gap: 48px;
                margin-bottom: 40px;
            }
            .footer-brand-text {
                font-family: 'Playfair Display', serif;
                font-size: 1.5rem;
                font-weight: 700;
                color: #fff;
                display: block;
                margin-bottom: 10px;
            }
            .footer-brand-text span {
                color: var(--gold);
            }
            .footer-desc {
                font-size: 0.875rem;
                color: rgba(255,255,255,0.5);
                line-height: 1.7;
                margin-bottom: 20px;
            }
            .footer-social {
                display: flex;
                gap: 10px;
            }
            .footer-social a {
                width: 34px;
                height: 34px;
                border-radius: 8px;
                background: rgba(255,255,255,0.07);
                border: 1px solid rgba(255,255,255,0.1);
                display: flex;
                align-items: center;
                justify-content: center;
                color: rgba(255,255,255,0.6);
                font-size: 0.9rem;
                text-decoration: none;
                transition: background 0.15s, color 0.15s;
            }
            .footer-social a:hover {
                background: var(--purple);
                color: #fff;
                border-color: var(--purple);
            }
            .footer-col h4 {
                font-size: 0.8rem;
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: 1px;
                color: rgba(255,255,255,0.5);
                margin-bottom: 16px;
            }
            .footer-col a {
                display: block;
                font-size: 0.875rem;
                color: rgba(255,255,255,0.65);
                text-decoration: none;
                margin-bottom: 10px;
                transition: color 0.15s;
            }
            .footer-col a:hover {
                color: var(--gold);
            }
            .footer-bottom {
                border-top: 1px solid rgba(255,255,255,0.08);
                padding-top: 20px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                font-size: 0.78rem;
                color: rgba(255,255,255,0.35);
            }

            @keyframes fadeUp {
                from {
                    opacity: 0;
                    transform: translateY(28px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            @media (max-width: 1100px) {
                .course-grid {
                    grid-template-columns: repeat(2, 1fr);
                }
            }
            @media (max-width: 900px) {
                .hero {
                    flex-direction: column;
                    padding: 48px 24px 0;
                }
                .hero-right {
                    flex: none;
                    width: 100%;
                }
                .courses, footer {
                    padding: 48px 24px;
                }
                .footer-grid {
                    grid-template-columns: 1fr;
                    gap: 32px;
                }
                .navbar-main {
                    padding: 0 20px;
                }
                .search-bar, .balance-pill {
                    display: none;
                }
            }
        </style>
    </head>
    <body>
        <c:if test="${empty sessionScope.user}">
            <jsp:forward page="login.jsp"/>
        </c:if>

        <!-- NAVBAR -->
        <nav class="navbar-main" style="position:relative;">
            <a href="homePage.jsp" class="brand">DUK<span>Academy</span></a>

            <ul class="nav-links">
                <li><a href="Search.jsp"><i class="bi bi-compass me-1"></i>Khám phá</a></li>
                <li><a href="mainController?action=ExploreCourse">Khóa học</a></li>
                <li><a href="instructors.jsp">Giảng viên</a></li>
                <li><a href="#">Về chúng tôi</a></li>
            </ul>

            <div class="nav-right">
                <form action="search.jsp" method="GET">
                    <div class="search-bar">
                        <i class="bi bi-search"></i>
                        <input type="text" name="q" placeholder="Tìm khóa học..." />
                    </div>
                </form>

                <%-- BALANCE PILL - chỉ hiện khi đã đăng nhập --%>
                <c:if test="${not empty sessionScope.user}">
                    <a href="payment.jsp" class="balance-pill">
                        <i class="bi bi-wallet2"></i>
                        <span class="balance-label">Số dư</span>
                        <span class="balance-amount">${sessionScope.user.balance != null ? sessionScope.user.balance : '0'} ₫</span>
                    </a>
                </c:if>

                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <div class="user-menu" onclick="toggleDropdown()">
                            <div class="user-avatar">
                                ${fn:substring(user.fullname, 0, 1)}
                            </div>
                            <span class="user-name">${sessionScope.user.fullname}</span>
                            <i class="bi bi-chevron-down" style="color:rgba(255,255,255,0.6); font-size:0.75rem;"></i>
                        </div>
                        <div class="dropdown-menu-custom" id="userDropdown">
                            <a href="myCourses"><i class="bi bi-person"></i> Hồ sơ của tôi</a>
                            <a href="myCourses"><i class="bi bi-book"></i> Khóa học của tôi</a>
                            <a href="Certificates.jsp"><i class="bi bi-award"></i> Chứng chỉ</a>
                            <a href="#"><i class="bi bi-gear"></i> Cài đặt</a>
                            <div class="divider-drop"></div>
                            <a href="mainController?action=logout" class="logout-link">
                                <i class="bi bi-box-arrow-right"></i> Đăng xuất
                            </a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <a href="login.jsp" style="color:rgba(255,255,255,0.75); text-decoration:none; font-size:0.875rem; font-weight:500;">Đăng nhập</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </nav>

        <!-- HERO -->
        <div class="hero">
            <div class="hero-content">
                <c:if test="${not empty sessionScope.user}">
                    <div class="welcome-badge">
                        <i class="bi bi-hand-wave" style="color:var(--gold);"></i>
                        Chào mừng trở lại, <strong>${user.fullname}</strong>!
                    </div>
                </c:if>
                <div class="hero-eyebrow">✦ Nền tảng học trực tuyến hàng đầu</div>
                <h1>Chinh phục<br>tri thức, <em>định hình</em><br>tương lai</h1>
                <p>Hàng nghìn khóa học từ các chuyên gia hàng đầu đang chờ bạn. Học bất cứ lúc nào, bất cứ nơi đâu.</p>
                <div class="hero-actions">
                    <a href="mainController?action=ExploreCourse" class="btn-hero-primary">
                        <i class="bi bi-play-fill"></i> Khám phá khóa học
                    </a>
                    <a href="myCourses" class="btn-hero-secondary">
                        <i class="bi bi-book"></i> Khóa học của tôi
                    </a>
                </div>
            </div>

            <!-- INSTRUCTOR PANEL -->
            <div class="hero-right">
                <div class="instructor-panel">
                    <div class="instructor-panel-title">
                        <i class="bi bi-mortarboard-fill"></i> Giảng viên nổi bật
                    </div>
                    <div class="instructor-card">
                        <img class="instructor-avatar" src="${pageContext.request.contextPath}/img/instructors/gv1t.jpg" alt="Lê Hoàng Khang"
                             onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';">
                        <div class="instructor-avatar-placeholder av1" style="display:none;">LHK</div>
                        <div class="instructor-info">
                            <h4>Lê Hoàng Khang</h4>
                            <div class="ins-subject">Machine Learning · AI</div>
                            <div class="ins-meta">
                                <span class="ins-stars">★★★★★</span>
                                <span>4.9 · 125K học viên</span>
                            </div>
                        </div>
                        <span class="ins-badge">Top GV</span>
                    </div>
                    <div class="instructor-card">
                        <img class="instructor-avatar" src="${pageContext.request.contextPath}/img/instructors/gv2.jpg" alt="Trần Lê Phương Uyên"
                             onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';">
                        <div class="instructor-avatar-placeholder av2" style="display:none;">PU</div>
                        <div class="instructor-info">
                            <h4>Trần Lê Phương Uyên</h4>
                            <div class="ins-subject">UI/UX Design</div>
                            <div class="ins-meta">
                                <span class="ins-stars">★★★★★</span>
                                <span>4.9 · 89K học viên</span>
                            </div>
                        </div>
                        <span class="ins-badge">Mới nổi</span>
                    </div>
                    <div class="instructor-card">
                        <img class="instructor-avatar" src="${pageContext.request.contextPath}/img/instructors/gv3.jpg" alt="Nguyễn Ngọc Huyền Diệu"
                             onerror="this.style.display='none'; this.nextElementSibling.style.display='flex';">
                        <div class="instructor-avatar-placeholder av3" style="display:none;">HD</div>
                        <div class="instructor-info">
                            <h4>Nguyễn Ngọc Huyền Diệu</h4>
                            <div class="ins-subject">Data Science · Python</div>
                            <div class="ins-meta">
                                <span class="ins-stars">★★★★½</span>
                                <span>4.7 · 240K học viên</span>
                            </div>
                        </div>
                        <span class="ins-badge">Giàu</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- POPULAR COURSES -->
        <section class="courses">
            <div class="section-eyebrow">Nổi bật</div>
            <div class="section-title">Khóa học được yêu thích nhất</div>
            <p class="section-sub">Hàng triệu học viên đang theo học các khóa học này</p>
            <div class="course-grid">
                <a href="#" class="course-card">
                    <div class="course-thumb th1">
                        <img src="${pageContext.request.contextPath}/img/courses/course1t1.jpg" alt="Machine Learning" onerror="this.style.display='none';">
                    </div>
                    <div class="course-body">
                        <div class="course-org">DeepLearning.AI</div>
                        <h3>Machine Learning Specialization</h3>
                        <div class="course-meta">
                            <span class="course-stars">★★★★★</span>
                            <span class="course-score">4.9</span>
                            <span class="course-count">(125K)</span>
                        </div>
                        <span class="course-tag">Dành cho người mới</span>
                    </div>
                </a>
                <a href="#" class="course-card">
                    <div class="course-thumb th2">
                        <img src="${pageContext.request.contextPath}/img/courses/course2.jpg" alt="Python Data Science" onerror="this.style.display='none';">
                    </div>
                    <div class="course-body">
                        <div class="course-org">Đại học Bách Khoa</div>
                        <h3>Python cho Khoa học Dữ liệu</h3>
                        <div class="course-meta">
                            <span class="course-stars">★★★★★</span>
                            <span class="course-score">4.8</span>
                            <span class="course-count">(240K)</span>
                        </div>
                        <span class="course-tag">Nhiều người học nhất</span>
                    </div>
                </a>
                <a href="#" class="course-card">
                    <div class="course-thumb th3">
                        <img src="${pageContext.request.contextPath}/img/courses/course3.jpg" alt="UX Design" onerror="this.style.display='none';">
                    </div>
                    <div class="course-body">
                        <div class="course-org">Google · UX Design</div>
                        <h3>Google UX Design Professional</h3>
                        <div class="course-meta">
                            <span class="course-stars">★★★★½</span>
                            <span class="course-score">4.7</span>
                            <span class="course-count">(89K)</span>
                        </div>
                        <span class="course-tag">Chứng chỉ chuyên nghiệp</span>
                    </div>
                </a>
                <a href="#" class="course-card">
                    <div class="course-thumb th4">
                        <img src="${pageContext.request.contextPath}/img/courses/course4t.jpg" alt="Data Science" onerror="this.style.display='none';">
                    </div>
                    <div class="course-body">
                        <div class="course-org">IBM · Data Science</div>
                        <h3>IBM Data Science Professional</h3>
                        <div class="course-meta">
                            <span class="course-stars">★★★★★</span>
                            <span class="course-score">4.6</span>
                            <span class="course-count">(67K)</span>
                        </div>
                        <span class="course-tag">Cầu nghề cao</span>
                    </div>
                </a>
            </div>
        </section>

        <!-- FOOTER -->
        <footer>
            <div class="footer-grid">
                <div>
                    <span class="footer-brand-text">DUK<span>Academy</span></span>
                    <p class="footer-desc">Nền tảng học trực tuyến hàng đầu, kết nối học viên với kiến thức và cơ hội nghề nghiệp tốt nhất.</p>
                    <div class="footer-social">
                        <a href="#"><i class="bi bi-facebook"></i></a>
                        <a href="#"><i class="bi bi-youtube"></i></a>
                        <a href="#"><i class="bi bi-linkedin"></i></a>
                        <a href="#"><i class="bi bi-instagram"></i></a>
                    </div>
                </div>
                <div class="footer-col">
                    <h4>Công ty</h4>
                    <a href="#">Về chúng tôi</a>
                    <a href="#">Blog</a>
                    <a href="#">Tuyển dụng</a>
                    <a href="#">Báo chí</a>
                </div>
                <div class="footer-col">
                    <h4>Cộng đồng</h4>
                    <a href="#">Học viên</a>
                    <a href="#">Giảng viên</a>
                    <a href="#">Đối tác</a>
                    <a href="#">Diễn đàn</a>
                </div>
                <div class="footer-col">
                    <h4>Hỗ trợ</h4>
                    <a href="#">Trung tâm trợ giúp</a>
                    <a href="#">Liên hệ</a>
                    <a href="#">Điều khoản</a>
                    <a href="#">Chính sách</a>
                </div>
            </div>
            <div class="footer-bottom">
                <span>© 2026 DUK Academy. All rights reserved.</span>
                <span>Được làm với ❤️ tại Việt Nam</span>
            </div>
        </footer>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                            function toggleDropdown() {
                                const dd = document.getElementById('userDropdown');
                                dd.classList.toggle('show');
                            }
                            document.addEventListener('click', function (e) {
                                const menu = document.querySelector('.user-menu');
                                const dd = document.getElementById('userDropdown');
                                if (dd && menu && !menu.contains(e.target) && !dd.contains(e.target)) {
                                    dd.classList.remove('show');
                                }
                            });
        </script>
    </body>
</html>
