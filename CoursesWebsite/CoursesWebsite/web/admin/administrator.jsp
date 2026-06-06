<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <base href="${pageContext.request.contextPath}/">
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Dashboard - DUK Academy</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
        <style>
            :root {
                --purple:#6C3FC5;
                --purple-dark:#4E2C96;
                --purple-deep:#1E0A4A;
                --purple-light:#F3EEFF;
                --gold:#D4A843;
                --text:#1A1A2E;
                --muted:#6B6B8A;
                --border:#E2D9F3;
                --bg:#F4F0FC;
                --sidebar-w:240px;
            }
            * {
                box-sizing:border-box;
                margin:0;
                padding:0;
            }
            body {
                font-family:'DM Sans',sans-serif;
                background:var(--bg);
                color:var(--text);
                display:flex;
                min-height:100vh;
            }

            /* SIDEBAR */
            .sidebar {
                width:var(--sidebar-w);
                background:var(--purple-deep);
                min-height:100vh;
                position:fixed;
                left:0;
                top:0;
                display:flex;
                flex-direction:column;
                z-index:100;
            }
            .sidebar-logo {
                padding:22px 20px 18px;
                border-bottom:1px solid rgba(255,255,255,0.08);
                font-size:1.3rem;
                font-weight:700;
                color:#fff;
                text-decoration:none;
                display:block;
            }
            .sidebar-logo span {
                color:var(--gold);
            }
            .sidebar-logo small {
                display:block;
                font-size:0.65rem;
                font-weight:600;
                color:#ff8080;
                text-transform:uppercase;
                letter-spacing:1.5px;
                margin-top:4px;
            }
            .sidebar-user {
                padding:16px 20px;
                border-bottom:1px solid rgba(255,255,255,0.08);
                display:flex;
                align-items:center;
                gap:10px;
            }
            .s-avatar {
                width:40px;
                height:40px;
                border-radius:50%;
                background:linear-gradient(135deg,#ff6b6b,var(--gold));
                display:flex;
                align-items:center;
                justify-content:center;
                font-weight:700;
                color:#fff;
                font-size:1rem;
                flex-shrink:0;
            }
            .s-name {
                font-size:0.82rem;
                font-weight:700;
                color:#fff;
            }
            .s-role {
                font-size:0.68rem;
                color:rgba(255,255,255,0.45);
            }
            .sidebar-nav {
                flex:1;
                padding:12px;
            }
            .nav-section-label {
                font-size:0.58rem;
                font-weight:700;
                text-transform:uppercase;
                letter-spacing:2px;
                color:rgba(255,255,255,0.3);
                padding:10px 10px 5px;
            }
            .s-link {
                display:flex;
                align-items:center;
                gap:10px;
                padding:9px 12px;
                border-radius:8px;
                color:rgba(255,255,255,0.6);
                text-decoration:none;
                font-size:0.83rem;
                font-weight:500;
                transition:all 0.15s;
                margin-bottom:2px;
            }
            .s-link i {
                width:18px;
                text-align:center;
                font-size:0.95rem;
                flex-shrink:0;
            }
            .s-link:hover {
                background:rgba(255,255,255,0.08);
                color:#fff;
            }
            .s-link.active {
                background:var(--purple);
                color:#fff;
            }
            .sidebar-footer {
                padding:12px;
                border-top:1px solid rgba(255,255,255,0.08);
            }
            .s-link.logout {
                color:rgba(255,120,120,0.7);
            }
            .s-link.logout:hover {
                background:rgba(220,38,38,0.12);
                color:#ff8080;
            }

            /* MAIN */
            .main {
                margin-left:var(--sidebar-w);
                flex:1;
                display:flex;
                flex-direction:column;
            }
            .topbar {
                background:#fff;
                border-bottom:1px solid var(--border);
                padding:0 28px;
                height:58px;
                display:flex;
                align-items:center;
                justify-content:space-between;
                position:sticky;
                top:0;
                z-index:90;
            }
            .topbar-title {
                font-size:1rem;
                font-weight:700;
            }
            .btn-outline {
                display:inline-flex;
                align-items:center;
                gap:6px;
                color:var(--muted);
                text-decoration:none;
                font-size:0.8rem;
                font-weight:500;
                padding:7px 14px;
                border-radius:8px;
                border:1px solid var(--border);
                transition:all 0.15s;
                background:#fff;
            }
            .btn-outline:hover {
                background:var(--purple-light);
                color:var(--purple);
                border-color:var(--purple);
            }

            .page-content {
                padding:28px;
            }
            .breadcrumb-bar {
                display:flex;
                align-items:center;
                gap:8px;
                font-size:0.78rem;
                color:var(--muted);
                margin-bottom:22px;
            }
            .breadcrumb-bar i {
                font-size:0.65rem;
            }

            /* STAT CARDS */
            .stats-grid {
                display:grid;
                grid-template-columns:repeat(4,1fr);
                gap:16px;
                margin-bottom:28px;
            }
            .stat-card {
                background:#fff;
                border:1px solid var(--border);
                border-radius:14px;
                padding:20px;
                display:flex;
                align-items:center;
                gap:14px;
            }
            .stat-icon {
                width:46px;
                height:46px;
                border-radius:12px;
                display:flex;
                align-items:center;
                justify-content:center;
                font-size:1.3rem;
                flex-shrink:0;
            }
            .icon-purple {
                background:var(--purple-light);
                color:var(--purple);
            }
            .icon-gold   {
                background:#FEF9EC;
                color:var(--gold);
            }
            .icon-green  {
                background:#DCFCE7;
                color:#16A34A;
            }
            .icon-red    {
                background:#FEE2E2;
                color:#DC2626;
            }
            .stat-num {
                font-size:1.3rem;
                font-weight:700;
                color:var(--text);
                line-height:1;
            }
            .stat-lbl {
                font-size:0.72rem;
                color:var(--muted);
                margin-top:3px;
            }

            /* MENU CARDS */
            .section-title {
                font-size:0.95rem;
                font-weight:700;
                color:var(--text);
                margin-bottom:14px;
                display:flex;
                align-items:center;
                gap:8px;
            }
            .section-title::before {
                content:'';
                width:4px;
                height:16px;
                background:var(--purple);
                border-radius:2px;
            }
            .menu-grid {
                display:grid;
                grid-template-columns:repeat(4,1fr);
                gap:16px;
            }
            .menu-card {
                background:#fff;
                border:1.5px solid var(--border);
                border-radius:14px;
                padding:24px 20px;
                display:flex;
                flex-direction:column;
                align-items:center;
                gap:10px;
                text-decoration:none;
                transition:all 0.18s;
                text-align:center;
            }
            .menu-card:hover {
                border-color:var(--purple);
                transform:translateY(-3px);
                box-shadow:0 8px 28px rgba(108,63,197,0.14);
            }
            .menu-icon {
                width:52px;
                height:52px;
                border-radius:14px;
                display:flex;
                align-items:center;
                justify-content:center;
                font-size:1.4rem;
                margin-bottom:4px;
            }
            .menu-label {
                font-size:0.88rem;
                font-weight:700;
                color:var(--text);
            }
            .menu-desc  {
                font-size:0.72rem;
                color:var(--muted);
            }
            .menu-badge {
                font-size:0.65rem;
                font-weight:700;
                padding:2px 8px;
                border-radius:10px;
                background:var(--purple-light);
                color:var(--purple);
            }

            @media(max-width:1024px){
                .stats-grid,.menu-grid{
                    grid-template-columns:repeat(2,1fr);
                }
            }
        </style>
    </head>
    <body>

        <!-- SIDEBAR -->
        <aside class="sidebar">
            <a href="homePage.jsp" class="sidebar-logo">
                DUK<span>Academy</span>
                <small>⚙ Admin Portal</small>
            </a>
            <div class="sidebar-user">
                <div class="s-avatar">${fn:substring(sessionScope.user.fullname, 0, 1)}</div>
                <div>
                    <div class="s-name">${sessionScope.user.fullname}</div>
                    <div class="s-role">Administrator</div>
                </div>
            </div>
            <nav class="sidebar-nav">
                <div class="nav-section-label">Tổng quan</div>
                <a href="adminController?action=dashboard" class="s-link active">
                    <i class="bi bi-grid-1x2-fill"></i> Dashboard
                </a>
                <div class="nav-section-label">Quản lý</div>
                <a href="mainController?action=manageUsers" class="s-link">
                    <i class="bi bi-people-fill"></i> Quản lý Users
                </a>
                <a href="mainController?action=manageCourses" class="s-link">
                    <i class="bi bi-collection-play-fill"></i> Quản lý Khóa học
                </a>
                <a href="mainController?action=viewTopups" class="s-link">
                    <i class="bi bi-wallet2"></i> Duyệt nạp tiền
                </a>
                <a href="mainController?action=viewPayments" class="s-link">
                    <i class="bi bi-receipt"></i> Lịch sử giao dịch
                </a>
            </nav>
            <div class="sidebar-footer">
                <a href="homePage.jsp" class="s-link">
                    <i class="bi bi-house-fill"></i> Trang chủ
                </a>
                <a href="mainController?action=logout" class="s-link logout">
                    <i class="bi bi-box-arrow-right"></i> Đăng xuất
                </a>
            </div>
        </aside>

        <!-- MAIN -->
        <div class="main">
            <div class="topbar">
                <div class="topbar-title">Admin Dashboard</div>
                <a href="homePage.jsp" class="btn-outline">
                    <i class="bi bi-house"></i> Trang chủ
                </a>
            </div>

            <div class="page-content">
                <div class="breadcrumb-bar">
                    <i class="bi bi-shield-check" style="color:var(--purple);"></i>
                    <span>Administrator Panel</span>
                </div>

                <!-- STAT CARDS -->
                <div class="stats-grid">
                    <div class="stat-card">
                        <div class="stat-icon icon-purple"><i class="bi bi-people-fill"></i></div>
                        <div>
                            <div class="stat-num">${not empty totalUsers ? totalUsers : '—'}</div>
                            <div class="stat-lbl">Tổng Users</div>
                        </div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon icon-gold"><i class="bi bi-collection-play-fill"></i></div>
                        <div>
                            <div class="stat-num">${not empty totalCourses ? totalCourses : '—'}</div>
                            <div class="stat-lbl">Khóa học</div>
                        </div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon icon-green"><i class="bi bi-cash-stack"></i></div>
                        <div>
                            <div class="stat-num">
                                <fmt:formatNumber value="${totalRevenue}" 
                                                  type="number" maxFractionDigits="0"/> ₫
                            </div>
                            <div class="stat-lbl">Doanh thu</div>
                        </div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon icon-red"><i class="bi bi-clock-history"></i></div>
                        <div>
                            <div class="stat-num">${not empty pendingCount ? pendingCount : '0'}</div>
                            <div class="stat-lbl">Chờ duyệt</div>
                        </div>
                    </div>
                </div>

                <!-- MENU -->
                <div class="section-title">Chức năng quản lý</div>
                <div class="menu-grid">
                    <a href="mainController?action=manageUsers" class="menu-card">
                        <div class="menu-icon" style="background:#EDE7FF;color:var(--purple);">
                            <i class="bi bi-people-fill"></i>
                        </div>
                        <div class="menu-label">Quản lý Users</div>
                        <div class="menu-desc">Block, unblock tài khoản</div>
                    </a>
                    <a href="mainController?action=manageCourses" class="menu-card">
                        <div class="menu-icon" style="background:#FEF9EC;color:var(--gold);">
                            <i class="bi bi-collection-play-fill"></i>
                        </div>
                        <div class="menu-label">Quản lý Khóa học</div>
                        <div class="menu-desc">Xem toàn bộ khóa học</div>
                    </a>
                    <a href="mainController?action=viewTopups" class="menu-card">
                        <div class="menu-icon" style="background:#DCFCE7;color:#16A34A;">
                            <i class="bi bi-wallet2"></i>
                        </div>
                        <div class="menu-label">Duyệt nạp tiền</div>
                        <div class="menu-desc">Xét duyệt yêu cầu nạp</div>
                        <c:if test="${not empty pendingCount && pendingCount > 0}">
                            <span class="menu-badge" style="background:#FEE2E2;color:#DC2626;">
                                ${pendingCount} chờ duyệt
                            </span>
                        </c:if>
                    </a>
                    <a href="mainController?action=viewPayments" class="menu-card">
                        <div class="menu-icon" style="background:#EFF6FF;color:#2563EB;">
                            <i class="bi bi-receipt"></i>
                        </div>
                        <div class="menu-label">Lịch sử giao dịch</div>
                        <div class="menu-desc">Xem toàn bộ thanh toán</div>
                    </a>
                </div>
            </div>
        </div>

    </body>
</html>
