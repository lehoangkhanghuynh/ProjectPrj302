<%-- 
    Document   : about
    Created on : Mar 10, 2026, 11:17:39 PM
    Author     : HOANG KHANG PC
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<fmt:setLocale value="vi_VN" scope="session"/>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>DUKAcademy - Về chúng tôi</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700;800&family=DM+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
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
            *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
            body { font-family: 'DM Sans', sans-serif; color: var(--text); background: #fff; }

            /* ===== NAVBAR ===== */
            .navbar-main { background: var(--purple-deep); padding: 0 48px; height: 68px; display: flex; align-items: center; justify-content: space-between; position: sticky; top: 0; z-index: 100; box-shadow: 0 2px 20px rgba(0,0,0,0.25); }
            .brand { font-family: 'Playfair Display', serif; font-size: 1.55rem; font-weight: 700; color: #fff; text-decoration: none; }
            .brand span { color: var(--gold); }
            .nav-links { display: flex; align-items: center; gap: 4px; list-style: none; }
            .nav-links a { font-size: 0.9rem; font-weight: 500; color: rgba(255,255,255,0.75); text-decoration: none; padding: 7px 14px; border-radius: 6px; transition: background 0.15s, color 0.15s; }
            .nav-links a:hover, .nav-links a.active { background: rgba(255,255,255,0.08); color: #fff; }
            .nav-right { display: flex; align-items: center; gap: 12px; }
            .nav-cta { display: flex; align-items: center; gap: 7px; background: var(--purple); color: #fff; text-decoration: none; font-size: 0.85rem; font-weight: 700; padding: 8px 18px; border-radius: 8px; transition: all 0.15s; }
            .nav-cta:hover { background: var(--purple-dark); color: #fff; transform: translateY(-1px); }

            /* ── NAV BALANCE ── */
            .balance-pill-nav { display:flex; align-items:center; gap:7px; background:rgba(212,168,67,0.12); border:1px solid rgba(212,168,67,0.35); border-radius:8px; padding:7px 14px; text-decoration:none; transition:background 0.15s; }
            .balance-pill-nav:hover { background:rgba(212,168,67,0.22); }
            .balance-pill-nav i { color:var(--gold); }
            .balance-label-nav { font-size:0.75rem; font-weight:500; color:rgba(255,255,255,0.6); }
            .balance-amount-nav { font-size:0.875rem; font-weight:700; color:var(--gold); }

            /* ── WISHLIST PILL ── */
            .wishlist-pill-wrap { position: relative; }
            .wishlist-pill { display: flex; align-items: center; gap: 7px; background: rgba(229,57,53,0.12); border: 1px solid rgba(229,57,53,0.35); border-radius: 8px; padding: 7px 14px; cursor: pointer; transition: background 0.15s; user-select: none; }
            .wishlist-pill:hover { background: rgba(229,57,53,0.2); }
            .wishlist-pill i { color: #FF6B6B; font-size: 1rem; }
            .wishlist-pill-label { font-size: 0.75rem; font-weight: 500; color: rgba(255,255,255,0.6); }
            .wishlist-pill-count { font-size: 0.875rem; font-weight: 700; color: #FF6B6B; }
            .wishlist-dropdown { position: absolute; top: calc(100% + 10px); right: 0; background: #fff; border: 1px solid var(--border); border-radius: 14px; min-width: 320px; max-width: 360px; box-shadow: 0 12px 40px rgba(0,0,0,0.18); display: none; z-index: 300; overflow: hidden; }
            .wishlist-dropdown.show { display: block; animation: ddIn 0.18s ease; }
            @keyframes ddIn { from { opacity:0; transform:translateY(-8px); } to { opacity:1; transform:translateY(0); } }
            .wishlist-dd-header { padding: 14px 18px 10px; border-bottom: 1px solid var(--border); display: flex; align-items: center; justify-content: space-between; }
            .wishlist-dd-title { font-size: 0.9rem; font-weight: 700; color: var(--text); display: flex; align-items: center; gap: 7px; }
            .wishlist-dd-title i { color: #E53935; }
            .wishlist-dd-link { font-size: 0.75rem; font-weight: 600; color: var(--purple); text-decoration: none; }
            .wishlist-dd-link:hover { text-decoration: underline; }
            .wishlist-dd-list { max-height: 320px; overflow-y: auto; padding: 8px; }
            .wishlist-dd-item { display: flex; align-items: center; gap: 10px; padding: 10px; border-radius: 10px; transition: background 0.12s; }
            .wishlist-dd-item:hover { background: var(--purple-light); }
            .wishlist-dd-thumb { width: 44px; height: 44px; border-radius: 8px; background: linear-gradient(135deg, var(--purple-deep), var(--purple)); display: flex; align-items: center; justify-content: center; font-size: 1.2rem; flex-shrink: 0; overflow: hidden; }
            .wishlist-dd-thumb img { width: 100%; height: 100%; object-fit: cover; }
            .wishlist-dd-info { flex: 1; min-width: 0; }
            .wishlist-dd-name { font-size: 0.8rem; font-weight: 700; color: var(--text); white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
            .wishlist-dd-price { font-size: 0.72rem; color: var(--purple); font-weight: 600; margin-top: 2px; }
            .wishlist-dd-remove { background: none; border: none; color: #ccc; cursor: pointer; font-size: 1rem; padding: 4px 6px; border-radius: 50%; transition: color 0.15s, background 0.15s; flex-shrink: 0; }
            .wishlist-dd-remove:hover { color: #E53935; background: #FFF3F3; }
            .wishlist-dd-empty { padding: 32px 16px; text-align: center; color: var(--muted); font-size: 0.85rem; }
            .wishlist-dd-empty i { font-size: 2rem; display: block; margin-bottom: 8px; opacity: 0.4; }

            /* ── USER MENU ── */
            .user-menu { display: flex; align-items: center; gap: 10px; cursor: pointer; padding: 6px 12px; border-radius: 8px; transition: background 0.15s; border: 1px solid rgba(255,255,255,0.15); }
            .user-menu:hover { background: rgba(255,255,255,0.08); }
            .user-avatar { width: 34px; height: 34px; border-radius: 50%; background: linear-gradient(135deg, var(--purple-mid), var(--gold)); display: flex; align-items: center; justify-content: center; font-size: 0.9rem; font-weight: 700; color: #fff; }
            .user-name { font-size: 0.875rem; font-weight: 600; color: #fff; max-width: 120px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }
            .dropdown-menu-custom { position: absolute; top: 76px; right: 48px; background: #fff; border: 1px solid var(--border); border-radius: 10px; padding: 8px; min-width: 200px; box-shadow: 0 8px 32px rgba(0,0,0,0.15); display: none; z-index: 200; }
            .dropdown-menu-custom.show { display: block; }
            .dropdown-menu-custom a { display: flex; align-items: center; gap: 10px; padding: 10px 14px; border-radius: 7px; font-size: 0.875rem; color: var(--text); text-decoration: none; font-weight: 500; transition: background 0.12s; }
            .dropdown-menu-custom a:hover { background: var(--purple-light); color: var(--purple); }
            .divider-drop { height: 1px; background: var(--border); margin: 6px 0; }
            .logout-link { color: #CC0000 !important; }
            .logout-link:hover { background: #FFF3F3 !important; }

            /* ===== HERO ===== */
            .about-hero { background: linear-gradient(145deg, var(--purple-deep) 0%, #3A1A7A 55%, #5B2DC5 100%); padding: 96px 80px 80px; text-align: center; position: relative; overflow: hidden; }
            .about-hero::before { content: ''; position: absolute; width: 700px; height: 700px; border-radius: 50%; background: rgba(212,168,67,0.05); top: -300px; left: 50%; transform: translateX(-50%); }
            .about-hero::after { content: ''; position: absolute; width: 400px; height: 400px; border-radius: 50%; background: rgba(155,114,232,0.08); bottom: -150px; right: -80px; }
            .hero-eyebrow { display: inline-flex; align-items: center; gap: 8px; background: rgba(212,168,67,0.15); border: 1px solid rgba(212,168,67,0.3); color: var(--gold); font-size: 0.78rem; font-weight: 700; padding: 6px 16px; border-radius: 20px; margin-bottom: 24px; letter-spacing: 1px; text-transform: uppercase; position: relative; z-index: 1; }
            .about-hero h1 { font-family: 'Playfair Display', serif; font-size: 3.6rem; font-weight: 800; color: #fff; line-height: 1.15; margin-bottom: 20px; position: relative; z-index: 1; }
            .about-hero h1 em { font-style: normal; color: var(--gold); }
            .about-hero p { font-size: 1.1rem; color: rgba(255,255,255,0.75); max-width: 580px; margin: 0 auto; line-height: 1.75; position: relative; z-index: 1; }

            /* ===== STATS ===== */
            .stats-bar { background: #fff; border-bottom: 1px solid var(--border); padding: 0 80px; }
            .stats-inner { display: flex; justify-content: center; gap: 0; }
            .stat-item { flex: 1; max-width: 220px; text-align: center; padding: 36px 24px; border-right: 1px solid var(--border); animation: fadeUp 0.5s ease both; }
            .stat-item:last-child { border-right: none; }
            .stat-number { font-family: 'Playfair Display', serif; font-size: 2.4rem; font-weight: 700; color: var(--purple); line-height: 1; margin-bottom: 6px; }
            .stat-number span { color: var(--gold); }
            .stat-label { font-size: 0.85rem; color: var(--muted); font-weight: 500; }

            /* ===== MISSION ===== */
            .mission { padding: 88px 80px; display: flex; align-items: center; gap: 72px; }
            .mission-left { flex: 1; }
            .section-eyebrow { font-size: 0.75rem; font-weight: 700; text-transform: uppercase; letter-spacing: 2px; color: var(--purple); margin-bottom: 10px; }
            .section-title { font-family: 'Playfair Display', serif; font-size: 2.1rem; font-weight: 700; color: var(--text); margin-bottom: 20px; line-height: 1.3; }
            .section-title em { font-style: normal; color: var(--purple); }
            .mission-text { font-size: 1rem; color: var(--muted); line-height: 1.8; margin-bottom: 16px; }
            .mission-right { flex: 0 0 420px; display: grid; grid-template-columns: 1fr 1fr; gap: 14px; }
            .value-card { background: var(--purple-light); border: 1px solid var(--border); border-radius: 14px; padding: 24px 20px; transition: transform 0.2s, box-shadow 0.2s; }
            .value-card:hover { transform: translateY(-4px); box-shadow: 0 10px 28px rgba(108,63,197,0.12); }
            .value-card:first-child { grid-column: 1 / -1; display: flex; align-items: center; gap: 18px; padding: 20px 24px; }
            .value-icon { width: 44px; height: 44px; border-radius: 10px; background: var(--purple); display: flex; align-items: center; justify-content: center; font-size: 1.2rem; color: #fff; flex-shrink: 0; }
            .value-icon.gold { background: var(--gold); }
            .value-icon.dark { background: var(--purple-deep); }
            .value-card h4 { font-size: 0.9rem; font-weight: 700; color: var(--text); margin-bottom: 6px; }
            .value-card p { font-size: 0.8rem; color: var(--muted); line-height: 1.6; margin: 0; }

            /* ===== STORY ===== */
            .story { background: var(--purple-deep); padding: 88px 80px; position: relative; overflow: hidden; }
            .story::before { content: ''; position: absolute; width: 500px; height: 500px; border-radius: 50%; background: rgba(212,168,67,0.04); top: -150px; right: -100px; }
            .story-inner { max-width: 760px; margin: 0 auto; text-align: center; position: relative; z-index: 1; }
            .story .section-eyebrow { color: var(--gold); }
            .story .section-title { color: #fff; }
            .story-text { font-size: 1.05rem; color: rgba(255,255,255,0.7); line-height: 1.85; margin-bottom: 16px; }
            .story-text strong { color: var(--gold); font-weight: 700; }

            /* ===== TEAM ===== */
            .team { padding: 88px 80px; background: #F8F5FF; }
            .team-header { text-align: center; margin-bottom: 52px; }
            .team-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 24px; max-width: 900px; margin: 0 auto; }
            .team-card { background: #fff; border: 1px solid var(--border); border-radius: 16px; padding: 32px 24px; text-align: center; transition: transform 0.2s, box-shadow 0.2s; }
            .team-card:hover { transform: translateY(-6px); box-shadow: 0 16px 40px rgba(108,63,197,0.13); }
            .team-avatar { width: 90px; height: 90px; border-radius: 50%; margin: 0 auto 16px; display: flex; align-items: center; justify-content: center; font-size: 1.8rem; font-weight: 700; color: #fff; font-family: 'Playfair Display', serif; overflow: hidden; border: 3px solid var(--border); box-shadow: 0 4px 16px rgba(108,63,197,0.15); }
            .team-avatar img { width: 100%; height: 100%; object-fit: cover; object-position: center top; display: block; }
            .av-purple { background: linear-gradient(135deg, var(--purple-deep), var(--purple)); }
            .av-gold   { background: linear-gradient(135deg, #b8851a, var(--gold)); }
            .av-teal   { background: linear-gradient(135deg, #0d5c63, #1a9aa0); }
            .team-name { font-size: 1rem; font-weight: 700; color: var(--text); margin-bottom: 4px; }
            .team-role { font-size: 0.8rem; color: var(--purple); font-weight: 600; margin-bottom: 10px; }
            .team-bio { font-size: 0.8rem; color: var(--muted); line-height: 1.6; }

            /* ===== WHY ===== */
            .why { padding: 88px 80px; }
            .why-header { text-align: center; margin-bottom: 52px; }
            .why-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 20px; }
            .why-card { border: 1px solid var(--border); border-radius: 14px; padding: 32px 24px; transition: border-color 0.2s, box-shadow 0.2s; }
            .why-card:hover { border-color: var(--purple-mid); box-shadow: 0 8px 28px rgba(108,63,197,0.1); }
            .why-icon { width: 50px; height: 50px; border-radius: 12px; background: var(--purple-light); display: flex; align-items: center; justify-content: center; font-size: 1.4rem; color: var(--purple); margin-bottom: 18px; }
            .why-card h4 { font-size: 1rem; font-weight: 700; color: var(--text); margin-bottom: 10px; }
            .why-card p { font-size: 0.875rem; color: var(--muted); line-height: 1.7; margin: 0; }

            /* ===== CTA ===== */
            .cta-join { background: linear-gradient(135deg, var(--purple-deep), #3A1A7A); padding: 80px; text-align: center; }
            .cta-join h2 { font-family: 'Playfair Display', serif; font-size: 2.4rem; font-weight: 700; color: #fff; margin-bottom: 14px; }
            .cta-join h2 em { font-style: normal; color: var(--gold); }
            .cta-join p { font-size: 1rem; color: rgba(255,255,255,0.7); margin-bottom: 36px; max-width: 500px; margin-left: auto; margin-right: auto; line-height: 1.75; }
            .cta-btns { display: flex; gap: 14px; justify-content: center; flex-wrap: wrap; }
            .btn-cta-primary { background: var(--gold); color: var(--purple-deep); font-weight: 700; font-size: 0.95rem; padding: 13px 32px; border-radius: 8px; border: none; text-decoration: none; display: inline-flex; align-items: center; gap: 8px; transition: opacity 0.15s, transform 0.1s; box-shadow: 0 4px 16px rgba(212,168,67,0.4); }
            .btn-cta-primary:hover { opacity: 0.9; transform: translateY(-1px); color: var(--purple-deep); }
            .btn-cta-secondary { background: transparent; color: #fff; font-weight: 600; font-size: 0.95rem; padding: 13px 28px; border-radius: 8px; border: 1.5px solid rgba(255,255,255,0.35); text-decoration: none; display: inline-flex; align-items: center; gap: 8px; transition: border-color 0.15s, background 0.15s; }
            .btn-cta-secondary:hover { border-color: #fff; background: rgba(255,255,255,0.06); color: #fff; }

            /* ===== FOOTER ===== */
            footer { background: var(--purple-deep); padding: 56px 80px 24px; }
            .footer-grid { display: grid; grid-template-columns: 2fr 1fr 1fr 1fr; gap: 48px; margin-bottom: 40px; }
            .footer-brand-text { font-family: 'Playfair Display', serif; font-size: 1.5rem; font-weight: 700; color: #fff; display: block; margin-bottom: 10px; }
            .footer-brand-text span { color: var(--gold); }
            .footer-desc { font-size: 0.875rem; color: rgba(255,255,255,0.5); line-height: 1.7; margin-bottom: 20px; }
            .footer-social { display: flex; gap: 10px; }
            .footer-social a { width: 34px; height: 34px; border-radius: 8px; background: rgba(255,255,255,0.07); border: 1px solid rgba(255,255,255,0.1); display: flex; align-items: center; justify-content: center; color: rgba(255,255,255,0.6); font-size: 0.9rem; text-decoration: none; transition: background 0.15s, color 0.15s; }
            .footer-social a:hover { background: var(--purple); color: #fff; border-color: var(--purple); }
            .footer-col h4 { font-size: 0.8rem; font-weight: 700; text-transform: uppercase; letter-spacing: 1px; color: rgba(255,255,255,0.5); margin-bottom: 16px; }
            .footer-col a { display: block; font-size: 0.875rem; color: rgba(255,255,255,0.65); text-decoration: none; margin-bottom: 10px; transition: color 0.15s; }
            .footer-col a:hover { color: var(--gold); }
            .footer-bottom { border-top: 1px solid rgba(255,255,255,0.08); padding-top: 20px; display: flex; justify-content: space-between; align-items: center; font-size: 0.78rem; color: rgba(255,255,255,0.35); }

            @keyframes fadeUp { from { opacity: 0; transform: translateY(24px); } to { opacity: 1; transform: translateY(0); } }
            .fade-up { animation: fadeUp 0.6s ease both; }
            .delay-1 { animation-delay: 0.1s; }
            .delay-2 { animation-delay: 0.2s; }
            .delay-3 { animation-delay: 0.3s; }

            @media (max-width: 1000px) {
                .mission { flex-direction: column; }
                .mission-right { flex: none; width: 100%; }
                .team-grid, .why-grid { grid-template-columns: 1fr 1fr; }
                .about-hero, .mission, .story, .team, .why, .cta-join, footer { padding-left: 24px; padding-right: 24px; }
                .stats-bar { padding: 0 24px; }
                .footer-grid { grid-template-columns: 1fr; gap: 32px; }
                .navbar-main { padding: 0 20px; }
                .dropdown-menu-custom { right: 20px; }
            }
            @media (max-width: 640px) {
                .about-hero h1 { font-size: 2.4rem; }
                .team-grid, .why-grid { grid-template-columns: 1fr; }
                .stats-inner { flex-wrap: wrap; }
                .stat-item { border-right: none; border-bottom: 1px solid var(--border); }
                .nav-links { display: none; }
            }
        </style>
    </head>
    <body>

        <!-- NAVBAR -->
        <nav class="navbar-main" style="position:relative;">
            <a href="homePage.jsp" class="brand">DUK<span>Academy</span></a>
            <ul class="nav-links">
                <li><a href="homePage.jsp">Trang chủ</a></li>
                <li><a href="courseController?action=ExploreCourse">Khóa học</a></li>
                <li><a href="instructors.jsp">Giảng viên</a></li>
                <li><a href="dating.jsp">Study &amp; Date</a></li>
                <c:if test="${sessionScope.user.role == 1}">
                    <li><a href="administrator.jsp">Administrator Manager</a></li>
                </c:if>
                <c:if test="${sessionScope.user != null && sessionScope.user.role == 2}">
                    <li><a href="instructorDashboard.jsp">Instructor Manager</a></li>
                </c:if>
                <li><a href="about.jsp" class="active">Thông tin Chung</a></li>
            </ul>
            <div class="nav-right">
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <a href="paymentController" class="balance-pill-nav">
                            <i class="bi bi-wallet2"></i>
                            <span class="balance-label-nav">Số dư</span>
                            <span class="balance-amount-nav">
                                <fmt:formatNumber value="${sessionScope.user.balance}" type="number" maxFractionDigits="0"/> ₫
                            </span>
                        </a>
                        <div class="wishlist-pill-wrap" id="wishlistWrap">
                            <div class="wishlist-pill" onclick="toggleWishlistDD(event)">
                                <i class="bi bi-heart-fill"></i>
                                <span class="wishlist-pill-label">Yêu thích</span>
                                <span class="wishlist-pill-count" id="wishCount">${not empty WISHLIST_IDS ? WISHLIST_IDS.size() : 0}</span>
                            </div>
                            <div class="wishlist-dropdown" id="wishlistDD">
                                <div class="wishlist-dd-header">
                                    <span class="wishlist-dd-title"><i class="bi bi-heart-fill"></i> Khóa học yêu thích</span>
                                    <a href="wishlistController?action=view&userId=${sessionScope.user.userId}" class="wishlist-dd-link">Xem tất cả</a>
                                </div>
                                <div class="wishlist-dd-list" id="wishlistDDList">
                                    <c:choose>
                                        <c:when test="${not empty WISHLIST_COURSES}">
                                            <c:forEach var="wc" items="${WISHLIST_COURSES}">
                                                <div class="wishlist-dd-item" id="wish-item-${wc.courseId}">
                                                    <div class="wishlist-dd-thumb">
                                                        <img src="${pageContext.request.contextPath}/img/courses/course${wc.courseId}.jpg" alt="${wc.courseName}" onerror="this.style.display='none';">
                                                    </div>
                                                    <div class="wishlist-dd-info">
                                                        <div class="wishlist-dd-name">${wc.courseName}</div>
                                                        <div class="wishlist-dd-price">
                                                            <c:choose>
                                                                <c:when test="${wc.fee == 0}">Miễn phí</c:when>
                                                                <c:otherwise><fmt:formatNumber value="${wc.fee}" type="number" maxFractionDigits="0"/> ₫</c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                    </div>
                                                    <button class="wishlist-dd-remove" title="Xóa" onclick="removeWishItem(event,'${wc.courseId}')">
                                                        <i class="bi bi-x"></i>
                                                    </button>
                                                </div>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="wishlist-dd-empty"><i class="bi bi-heart"></i> Chưa có khóa học yêu thích</div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                        <div class="user-menu" onclick="toggleDropdown()">
                            <div class="user-avatar">${fn:substring(sessionScope.user.fullname, 0, 1)}</div>
                            <span class="user-name">${sessionScope.user.fullname}</span>
                            <i class="bi bi-chevron-down" style="color:rgba(255,255,255,0.6); font-size:0.75rem;"></i>
                        </div>
                        <div class="dropdown-menu-custom" id="userDropdown">
                            <a href="myprofile.jsp"><i class="bi bi-person"></i> Hồ sơ của tôi</a>
                            <a href="myCourses"><i class="bi bi-book"></i> Khóa học của tôi</a>
                            <a href="paymentController"><i class="bi bi-wallet2"></i> Nạp tiền</a>
                            <a href="Certificates.jsp"><i class="bi bi-award"></i> Chứng chỉ</a>
                            <a href="wishlistController?action=view&userId=${sessionScope.user.userId}"><i class="bi bi-heart"></i> Mục Yêu thích</a>
                            <div class="divider-drop"></div>
                            <a href="mainController?action=logout" class="logout-link"><i class="bi bi-box-arrow-right"></i> Đăng xuất</a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <a href="login.jsp" style="color:rgba(255,255,255,0.75); text-decoration:none; font-size:0.875rem; font-weight:500;">Đăng nhập</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </nav>

        <!-- HERO -->
        <section class="about-hero">
            <div class="hero-eyebrow">✦ Câu chuyện của chúng tôi</div>
            <h1 class="fade-up">Nơi <em>tri thức</em> gặp<br>đam mê học hỏi</h1>
            <p class="fade-up delay-1">DUK Academy được xây dựng với một niềm tin đơn giản: ai cũng xứng đáng được tiếp cận giáo dục chất lượng cao, dù ở bất cứ đâu.</p>
        </section>

        <!-- STATS -->
        <div class="stats-bar">
            <div class="stats-inner">
                <div class="stat-item fade-up">
                    <div class="stat-number">50<span>K+</span></div>
                    <div class="stat-label">Học viên đang học</div>
                </div>
                <div class="stat-item fade-up delay-1">
                    <div class="stat-number">200<span>+</span></div>
                    <div class="stat-label">Khóa học chất lượng</div>
                </div>
                <div class="stat-item fade-up delay-2">
                    <div class="stat-number">80<span>+</span></div>
                    <div class="stat-label">Giảng viên chuyên gia</div>
                </div>
                <div class="stat-item fade-up delay-3">
                    <div class="stat-number">4.8<span>★</span></div>
                    <div class="stat-label">Đánh giá trung bình</div>
                </div>
            </div>
        </div>

        <!-- MISSION -->
        <section class="mission">
            <div class="mission-left fade-up">
                <div class="section-eyebrow">Sứ mệnh</div>
                <h2 class="section-title">Chúng tôi tin rằng<br><em>học tập không có giới hạn</em></h2>
                <p class="mission-text">DUK Academy ra đời từ mong muốn phá vỡ rào cản địa lý và tài chính trong giáo dục. Chúng tôi kết nối những học viên khát khao tri thức với các chuyên gia hàng đầu trong nhiều lĩnh vực.</p>
                <p class="mission-text">Từng khóa học được thiết kế kỹ lưỡng, thực tiễn và luôn cập nhật theo xu hướng thị trường — để bạn không chỉ học lý thuyết mà thực sự sẵn sàng cho thế giới công việc.</p>
            </div>
            <div class="mission-right">
                <div class="value-card">
                    <div class="value-icon"><i class="bi bi-lightbulb-fill"></i></div>
                    <div>
                        <h4>Học thực tế, không hàn lâm</h4>
                        <p>Mỗi khóa học được xây dựng từ kinh nghiệm thực chiến, tập trung vào kỹ năng ứng dụng ngay.</p>
                    </div>
                </div>
                <div class="value-card">
                    <div class="value-icon gold"><i class="bi bi-people-fill"></i></div>
                    <h4>Cộng đồng học tập</h4>
                    <p>Kết nối với hàng chục nghìn học viên cùng chí hướng, hỗ trợ nhau trên hành trình phát triển.</p>
                </div>
                <div class="value-card">
                    <div class="value-icon dark"><i class="bi bi-award-fill"></i></div>
                    <h4>Chứng chỉ có giá trị</h4>
                    <p>Chứng chỉ hoàn thành được nhà tuyển dụng công nhận, giúp bạn tự tin trong hồ sơ xin việc.</p>
                </div>
            </div>
        </section>

        <!-- STORY -->
        <section class="story">
            <div class="story-inner">
                <div class="section-eyebrow">Lịch sử hình thành</div>
                <h2 class="section-title">Từ một ý tưởng nhỏ đến nền tảng lớn</h2>
                <p class="story-text">DUK Academy được thành lập năm <strong>2024</strong> bởi nhóm sinh viên Đại học FPT với khát vọng tạo ra một không gian học tập trực tuyến thực sự dành cho người Việt.</p>
                <p class="story-text">Tên "<strong>DUK</strong>" được lấy cảm hứng từ tinh thần <strong>Dream – Upgrade – Knowledge</strong> ba giá trị cốt lõi mà chúng tôi muốn truyền tải đến mỗi học viên trên hành trình chinh phục tri thức.</p>
                <p class="story-text">Từ vài chục khóa học ban đầu, ngày nay DUK Academy đã phát triển thành nền tảng với hơn <strong>200 khóa học</strong>, phục vụ hơn <strong>50.000 học viên</strong> trên toàn quốc.</p>
            </div>
        </section>

        <!-- TEAM -->
        <section class="team">
            <div class="team-header">
                <div class="section-eyebrow">Đội ngũ</div>
                <h2 class="section-title">Những người xây dựng DUK Academy</h2>
            </div>
            <div class="team-grid">
                <div class="team-card fade-up">
                    <div class="team-avatar av-purple">
                        <img src="${pageContext.request.contextPath}/img/instructors/gv1t.jpg" alt="Lê Hoàng Khang" onerror="this.style.display='none';">
                    </div>
                    <div class="team-name">Lê Hoàng Khang</div>
                    <div class="team-role">Co-founder · Lead Developer</div>
                    <p class="team-bio">Sinh viên CNTT đam mê AI và Machine Learning. Kiến trúc sư chính của nền tảng DUK Academy.</p>
                </div>
                <div class="team-card fade-up delay-1">
                    <div class="team-avatar av-gold">
                        <img src="${pageContext.request.contextPath}/img/instructors/gv2.jpg" alt="Trần Lê Phương Uyên" onerror="this.style.display='none';">
                    </div>
                    <div class="team-name">Trần Lê Phương Uyên</div>
                    <div class="team-role">Co-founder · UI/UX Designer</div>
                    <p class="team-bio">Chuyên gia thiết kế trải nghiệm người dùng. Người tạo ra giao diện thân thiện và đẹp mắt của DUK Academy.</p>
                </div>
                <div class="team-card fade-up delay-2">
                    <div class="team-avatar av-teal">
                        <img src="${pageContext.request.contextPath}/img/instructors/gv3.jpg" alt="Nguyễn Ngọc Huyền Diệu" onerror="this.style.display='none';">
                    </div>
                    <div class="team-name">Nguyễn Ngọc Huyền Diệu</div>
                    <div class="team-role">Co-founder · Content Director</div>
                    <p class="team-bio">Chuyên gia Data Science và Python. Phụ trách xây dựng nội dung và chương trình học chất lượng cao.</p>
                </div>
            </div>
        </section>

        <!-- WHY US -->
        <section class="why">
            <div class="why-header">
                <div class="section-eyebrow">Tại sao chọn chúng tôi</div>
                <h2 class="section-title">DUK Academy khác biệt như thế nào?</h2>
            </div>
            <div class="why-grid">
                <div class="why-card fade-up">
                    <div class="why-icon"><i class="bi bi-play-circle-fill"></i></div>
                    <h4>Học theo tiến độ của bạn</h4>
                    <p>Không có lịch cố định. Học bất cứ lúc nào, tạm dừng rồi tiếp tục, hoàn toàn linh hoạt theo lịch của bạn.</p>
                </div>
                <div class="why-card fade-up delay-1">
                    <div class="why-icon"><i class="bi bi-patch-check-fill"></i></div>
                    <h4>Nội dung được kiểm duyệt kỹ</h4>
                    <p>Mọi khóa học đều được đội ngũ chuyên gia đánh giá trước khi xuất bản, đảm bảo chất lượng và độ chính xác.</p>
                </div>
                <div class="why-card fade-up delay-2">
                    <div class="why-icon"><i class="bi bi-currency-dollar"></i></div>
                    <h4>Học phí hợp lý</h4>
                    <p>Nhiều khóa học miễn phí. Các khóa có phí được định giá phù hợp với học viên Việt Nam, không đắt như nền tảng nước ngoài.</p>
                </div>
                <div class="why-card fade-up">
                    <div class="why-icon"><i class="bi bi-chat-dots-fill"></i></div>
                    <h4>Hỗ trợ tận tình</h4>
                    <p>Đội ngũ hỗ trợ luôn sẵn sàng giải đáp thắc mắc, cùng với diễn đàn cộng đồng năng động.</p>
                </div>
                <div class="why-card fade-up delay-1">
                    <div class="why-icon"><i class="bi bi-phone-fill"></i></div>
                    <h4>Học trên mọi thiết bị</h4>
                    <p>Giao diện tương thích hoàn toàn trên máy tính, tablet và điện thoại — học ở bất cứ đâu bạn muốn.</p>
                </div>
                <div class="why-card fade-up delay-2">
                    <div class="why-icon"><i class="bi bi-graph-up-arrow"></i></div>
                    <h4>Cập nhật liên tục</h4>
                    <p>Chương trình học được cập nhật thường xuyên theo xu hướng công nghệ và nhu cầu thị trường lao động.</p>
                </div>
            </div>
        </section>

        <!-- CTA -->
        <c:if test="${sessionScope.user != null}">
            <section class="cta-join">
                <h2>Sẵn sàng bắt đầu <em>hành trình</em> của bạn?</h2>
                <p>Tham gia cùng hơn 50.000 học viên đang học tập và phát triển mỗi ngày trên DUK Academy.</p>
                <div class="cta-btns">
                    <a href="courseController?action=ExploreCourse" class="btn-cta-primary"><i class="bi bi-play-fill"></i> Khám phá khóa học</a>
                    <a href="mailto:lonhkim82@gmail.com?subject=Đăng ký giảng dạy tại DUK Academy&body=Xin chào,%0A%0ATôi muốn đăng ký trở thành giảng viên tại DUK Academy.%0A%0AThông tin của tôi:%0A- Họ tên:%0A- Lĩnh vực chuyên môn:%0A- Kinh nghiệm:%0A%0ATôi xin đính kèm CV theo email này.%0A%0AXin cảm ơn!" class="btn-cta-secondary"><i class="bi bi-mortarboard-fill"></i> Đăng ký giảng dạy</a>
                </div>
            </section>
        </c:if>

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
                    <a href="about.jsp">Về chúng tôi</a>
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
                document.getElementById('userDropdown').classList.toggle('show');
            }
            function toggleWishlistDD(e) {
                e.stopPropagation();
                document.getElementById('wishlistDD').classList.toggle('show');
                document.getElementById('userDropdown').classList.remove('show');
            }
            function removeWishItem(e, courseId) {
                e.stopPropagation();
                fetch('wishlistController?action=remove&courseId=' + courseId + '&userId=${sessionScope.user.userId}&ajax=1')
                    .then(() => {
                        const item = document.getElementById('wish-item-' + courseId);
                        if (item) item.remove();
                        const el = document.getElementById('wishCount');
                        if (el) el.textContent = Math.max(0, parseInt(el.textContent || '0') - 1);
                        const list = document.getElementById('wishlistDDList');
                        if (list && !list.querySelector('.wishlist-dd-item'))
                            list.innerHTML = '<div class="wishlist-dd-empty"><i class="bi bi-heart"></i> Chưa có khóa học yêu thích</div>';
                    });
            }
            document.addEventListener('click', function(e) {
                const menu = document.querySelector('.user-menu');
                const dd = document.getElementById('userDropdown');
                const ww = document.getElementById('wishlistWrap');
                const wd = document.getElementById('wishlistDD');
                if (dd && menu && !menu.contains(e.target) && !dd.contains(e.target)) dd.classList.remove('show');
                if (wd && ww && !ww.contains(e.target)) wd.classList.remove('show');
            });
        </script>
    </body>
</html>
