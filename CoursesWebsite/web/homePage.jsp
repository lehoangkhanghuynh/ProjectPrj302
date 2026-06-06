<%--
    Document   : homePage
    Created on : Feb 23, 2026, 10:11:54 PM
    Author     : HOANG KHANG PC
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<fmt:setLocale value="vi_VN"/>
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
*, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
body { font-family: 'DM Sans', sans-serif; color: var(--text); background: #fff; }

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
.brand { font-family: 'Playfair Display', serif; font-size: 1.55rem; font-weight: 700; color: #fff; text-decoration: none; letter-spacing: 0.3px; }
.brand span { color: var(--gold); }
.nav-links { display: flex; align-items: center; gap: 4px; list-style: none; }
.nav-links a { font-size: 0.9rem; font-weight: 500; color: rgba(255,255,255,0.75); text-decoration: none; padding: 7px 14px; border-radius: 6px; transition: background 0.15s, color 0.15s; }
.nav-links a:hover, .nav-links a.active { background: rgba(255,255,255,0.08); color: #fff; }
.nav-right { display: flex; align-items: center; gap: 12px; }

/* HAMBURGER */
.hamburger {
    display: none;
    flex-direction: column;
    gap: 5px;
    cursor: pointer;
    padding: 6px;
    border: none;
    background: none;
    z-index: 110;
}
.hamburger span {
    display: block;
    width: 24px;
    height: 2px;
    background: #fff;
    border-radius: 2px;
    transition: all 0.3s;
}
.hamburger.open span:nth-child(1) { transform: translateY(7px) rotate(45deg); }
.hamburger.open span:nth-child(2) { opacity: 0; }
.hamburger.open span:nth-child(3) { transform: translateY(-7px) rotate(-45deg); }

/* MOBILE NAV DRAWER */
.mobile-nav {
    display: none;
    position: fixed;
    top: 0; left: 0; right: 0; bottom: 0;
    background: var(--purple-deep);
    z-index: 105;
    flex-direction: column;
    padding: 88px 24px 32px;
    overflow-y: auto;
    animation: slideDown 0.25s ease;
}
.mobile-nav.open { display: flex; }
@keyframes slideDown { from { opacity:0; transform:translateY(-10px); } to { opacity:1; transform:translateY(0); } }
.mobile-nav a {
    color: rgba(255,255,255,0.85);
    text-decoration: none;
    font-size: 1.1rem;
    font-weight: 600;
    padding: 16px 0;
    border-bottom: 1px solid rgba(255,255,255,0.08);
    display: flex;
    align-items: center;
    gap: 12px;
    transition: color 0.15s;
}
.mobile-nav a:hover { color: var(--gold); }
.mobile-nav a i { font-size: 1.1rem; color: var(--gold); }
.mobile-nav-divider { height: 1px; background: rgba(255,255,255,0.08); margin: 8px 0; }

/* ===== BALANCE PILL ===== */
.balance-pill { display: flex; align-items: center; gap: 7px; background: rgba(212,168,67,0.12); border: 1px solid rgba(212,168,67,0.35); border-radius: 8px; padding: 7px 14px; text-decoration: none; transition: background 0.15s; cursor: pointer; }
.balance-pill:hover { background: rgba(212,168,67,0.22); }
.balance-pill i { color: var(--gold); font-size: 0.95rem; }
.balance-label { font-size: 0.75rem; font-weight: 500; color: rgba(255,255,255,0.6); }
.balance-amount { font-size: 0.875rem; font-weight: 700; color: var(--gold); letter-spacing: 0.2px; }

/* ===== WISHLIST PILL ===== */
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

/* ===== USER MENU ===== */
.user-menu { display: flex; align-items: center; gap: 10px; cursor: pointer; padding: 6px 12px; border-radius: 8px; transition: background 0.15s; border: 1px solid rgba(255,255,255,0.15); }
.user-menu:hover { background: rgba(255,255,255,0.08); }
.user-avatar { width: 34px; height: 34px; border-radius: 50%; background: linear-gradient(135deg, var(--purple-mid), var(--gold)); display: flex; align-items: center; justify-content: center; font-size: 0.9rem; font-weight: 700; color: #fff; flex-shrink: 0; }
.user-name { font-size: 0.875rem; font-weight: 600; color: #fff; max-width: 120px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }
.dropdown-menu-custom { position: absolute; top: 76px; right: 48px; background: #fff; border: 1px solid var(--border); border-radius: 10px; padding: 8px; min-width: 200px; box-shadow: 0 8px 32px rgba(0,0,0,0.15); display: none; z-index: 200; }
.dropdown-menu-custom.show { display: block; }
.dropdown-menu-custom a { display: flex; align-items: center; gap: 10px; padding: 10px 14px; border-radius: 7px; font-size: 0.875rem; color: var(--text); text-decoration: none; font-weight: 500; transition: background 0.12s; }
.dropdown-menu-custom a:hover { background: var(--purple-light); color: var(--purple); }
.dropdown-menu-custom .divider-drop { height: 1px; background: var(--border); margin: 6px 0; }
.dropdown-menu-custom .logout-link { color: #CC0000; }
.dropdown-menu-custom .logout-link:hover { background: #FFF3F3; color: #CC0000; }

/* ===== HERO ===== */
.hero { background: linear-gradient(145deg, var(--purple-deep) 0%, #3A1A7A 50%, #5B2DC5 100%); padding: 88px 80px 0; display: flex; align-items: center; gap: 64px; overflow: hidden; min-height: 500px; position: relative; }
.hero::before { content: ''; position: absolute; width: 600px; height: 600px; border-radius: 50%; background: rgba(212,168,67,0.05); top: -200px; right: -100px; }
.hero-content { flex: 1; padding-bottom: 40px; position: relative; z-index: 1; animation: fadeUp 0.6s ease both; display: flex; flex-direction: column; align-items: flex-start; }
.hero-eyebrow { display: inline-flex; align-items: center; gap: 8px; background: rgba(212,168,67,0.15); border: 1px solid rgba(212,168,67,0.3); color: var(--gold); font-size: 0.78rem; font-weight: 700; padding: 6px 14px; border-radius: 20px; margin-bottom: 22px; letter-spacing: 1px; text-transform: uppercase; align-self: flex-start; }
.welcome-badge { display: inline-flex; align-items: center; gap: 10px; background: rgba(255,255,255,0.08); border: 1px solid rgba(255,255,255,0.15); border-radius: 10px; padding: 10px 18px; margin-bottom: 22px; color: rgba(255,255,255,0.9); font-size: 0.9rem; font-weight: 500; align-self: flex-start; }
.welcome-badge strong { color: var(--gold); }
.hero h1 { font-family: 'Playfair Display', serif; font-size: 3.4rem; font-weight: 700; color: #fff; line-height: 1.15; margin-bottom: 20px; }
.hero h1 em { font-style: normal; color: var(--gold); }
.hero p { font-size: 1.05rem; color: rgba(255,255,255,0.78); max-width: 500px; line-height: 1.7; margin-bottom: 36px; }
.hero-actions { display: flex; gap: 14px; flex-wrap: wrap; }
.btn-hero-primary { background: var(--gold); color: var(--purple-deep); font-weight: 700; font-size: 0.95rem; padding: 13px 32px; border-radius: 8px; border: none; text-decoration: none; transition: opacity 0.15s, transform 0.1s; box-shadow: 0 4px 16px rgba(212,168,67,0.4); display: inline-flex; align-items: center; gap: 8px; }
.btn-hero-primary:hover { opacity: 0.9; transform: translateY(-1px); color: var(--purple-deep); }
.btn-hero-secondary { background: transparent; color: #fff; font-weight: 600; font-size: 0.95rem; padding: 13px 28px; border-radius: 8px; border: 1.5px solid rgba(255,255,255,0.35); text-decoration: none; transition: border-color 0.15s, background 0.15s; display: inline-flex; align-items: center; gap: 8px; }
.btn-hero-secondary:hover { border-color: #fff; background: rgba(255,255,255,0.06); color: #fff; }
.hero-right { flex: 0 0 360px; padding-bottom: 40px; position: relative; z-index: 1; animation: fadeUp 0.6s 0.2s ease both; }
.instructor-panel { background: rgba(255,255,255,0.06); border: 1px solid rgba(255,255,255,0.12); border-radius: 14px; padding: 20px; backdrop-filter: blur(12px); }
.instructor-panel-title { font-size: 0.72rem; font-weight: 700; text-transform: uppercase; letter-spacing: 1.5px; color: var(--gold); margin-bottom: 14px; display: flex; align-items: center; gap: 6px; }
.instructor-card { background: #fff; border-radius: 10px; padding: 12px 14px; margin-bottom: 10px; box-shadow: 0 4px 16px rgba(0,0,0,0.12); display: flex; align-items: center; gap: 12px; transition: transform 0.15s; }
.instructor-card:last-child { margin-bottom: 0; }
.instructor-card:hover { transform: translateX(3px); }
.instructor-avatar { width: 46px; height: 46px; min-width: 46px; border-radius: 50%; object-fit: cover; object-position: center top; flex-shrink: 0; border: 2px solid var(--border); display: block; }
.instructor-avatar-placeholder { width: 46px; height: 46px; min-width: 46px; border-radius: 50%; flex-shrink: 0; display: flex; align-items: center; justify-content: center; font-size: 1.1rem; font-weight: 700; color: #fff; border: 2px solid rgba(255,255,255,0.3); }
.av1 { background: linear-gradient(135deg, #6C3FC5, #9B72E8); }
.av2 { background: linear-gradient(135deg, #D4A843, #F5CC6A); color: #1E0A4A; }
.av3 { background: linear-gradient(135deg, #1B5E20, #43A047); }
.instructor-info { flex: 1; min-width: 0; }
.instructor-info h4 { font-size: 0.84rem; font-weight: 700; color: var(--text); margin-bottom: 2px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
.instructor-info .ins-subject { font-size: 0.72rem; color: var(--purple); font-weight: 600; margin-bottom: 3px; }
.instructor-info .ins-meta { font-size: 0.7rem; color: var(--muted); display: flex; align-items: center; gap: 6px; }
.ins-stars { color: var(--gold); font-size: 0.68rem; }
.ins-badge { background: var(--purple-light); color: var(--purple); font-size: 0.6rem; font-weight: 700; padding: 2px 7px; border-radius: 4px; text-transform: uppercase; letter-spacing: 0.3px; flex-shrink: 0; }

/* ===== COURSES ===== */
.courses { background: #F8F5FF; padding: 72px 80px; }
.section-eyebrow { font-size: 0.75rem; font-weight: 700; text-transform: uppercase; letter-spacing: 2px; color: var(--purple); margin-bottom: 8px; }
.section-title { font-family: 'Playfair Display', serif; font-size: 2rem; font-weight: 700; color: var(--text); margin-bottom: 8px; }
.section-sub { font-size: 0.95rem; color: var(--muted); margin-bottom: 40px; max-width: 520px; }
.course-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 20px; }
.course-card { background: #fff; border: 1px solid var(--border); border-radius: 12px; overflow: hidden; text-decoration: none; color: var(--text); transition: box-shadow 0.2s, transform 0.2s; display: block; }
.course-card:hover { box-shadow: 0 10px 32px rgba(108,63,197,0.14); transform: translateY(-4px); color: var(--text); }
.course-thumb { height: 148px; display: flex; align-items: center; justify-content: center; font-size: 3rem; overflow: hidden; position: relative; }
.course-thumb img { width: 100%; height: 100%; object-fit: cover; object-position: center; display: block; position: absolute; top: 0; left: 0; }
.th1 { background: linear-gradient(135deg, #1E0A4A, #6C3FC5); }
.th2 { background: linear-gradient(135deg, #3A1A7A, #9B72E8); }
.th3 { background: linear-gradient(135deg, #4E2C96, #D4A843); }
.th4 { background: linear-gradient(135deg, #1A0D35, #5B2DC5); }
.course-body { padding: 16px 18px 18px; }
.course-org { font-size: 0.72rem; font-weight: 700; color: var(--purple); text-transform: uppercase; letter-spacing: 0.5px; margin-bottom: 6px; }
.course-body h3 { font-size: 0.9rem; font-weight: 700; line-height: 1.45; margin-bottom: 10px; color: var(--text); }
.course-meta { display: flex; align-items: center; gap: 6px; font-size: 0.78rem; }
.course-stars { color: var(--gold); }
.course-score { font-weight: 700; color: var(--text); }
.course-count { color: var(--muted); }
.course-tag { display: inline-block; background: var(--purple-light); color: var(--purple); font-size: 0.68rem; font-weight: 700; padding: 3px 9px; border-radius: 4px; margin-top: 10px; }

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

/* ===== ANIMATIONS ===== */
@keyframes fadeUp { from { opacity: 0; transform: translateY(28px); } to { opacity: 1; transform: translateY(0); } }

/* ===== RESPONSIVE ===== */
@media (max-width: 1100px) {
    .course-grid { grid-template-columns: repeat(2, 1fr); }
}

@media (max-width: 900px) {
    .navbar-main { padding: 0 20px; }
    .nav-links { display: none; }
    .hamburger { display: flex; }
    .balance-pill { display: none; }
    .wishlist-pill-label { display: none; }
    .dropdown-menu-custom { right: 16px; top: 68px; }

    .hero { flex-direction: column; padding: 40px 20px 32px; gap: 24px; min-height: unset; }
    .hero-content { padding-bottom: 0; }
    .hero-right { flex: none; width: 100%; padding-bottom: 0; }
    .hero h1 { font-size: 2.4rem; }
    .hero p { font-size: 0.95rem; }

    .courses { padding: 48px 20px; }
    footer { padding: 48px 20px 24px; }
    .footer-grid { grid-template-columns: 1fr; gap: 28px; }
    .footer-bottom { flex-direction: column; gap: 8px; text-align: center; }
}

@media (max-width: 600px) {
    .navbar-main { padding: 0 16px; height: 60px; }
    .brand { font-size: 1.25rem; }
    .user-name { display: none; }
    .user-menu { padding: 6px 8px; gap: 6px; }
    .wishlist-pill { padding: 6px 10px; }
    .dropdown-menu-custom { right: 8px; left: 8px; min-width: unset; top: 60px; }
    .wishlist-dropdown { right: -40px; min-width: 260px; max-width: calc(100vw - 32px); }

    .hero { padding: 28px 16px 28px; gap: 20px; }
    .hero-eyebrow { font-size: 0.68rem; padding: 5px 10px; }
    .welcome-badge { font-size: 0.82rem; padding: 8px 14px; }
    .hero h1 { font-size: 1.9rem; line-height: 1.2; }
    .hero p { font-size: 0.88rem; margin-bottom: 24px; }
    .btn-hero-primary, .btn-hero-secondary { font-size: 0.875rem; padding: 11px 20px; width: 100%; justify-content: center; }
    .hero-actions { flex-direction: column; gap: 10px; width: 100%; }

    .instructor-panel { padding: 14px; }
    .instructor-card { padding: 10px 12px; }

    .courses { padding: 32px 16px; }
    .section-title { font-size: 1.5rem; }
    .section-sub { font-size: 0.875rem; margin-bottom: 24px; }
    .course-grid { grid-template-columns: 1fr; gap: 14px; }
    .course-thumb { height: 180px; }

    footer { padding: 32px 16px 20px; }
    .footer-brand-text { font-size: 1.25rem; }
    .footer-grid { gap: 20px; }
    .footer-bottom { font-size: 0.72rem; }
}
        </style>
    </head>
    <body>
        <!-- MOBILE NAV DRAWER -->
        <div class="mobile-nav" id="mobileNav">
            <a href="${pageContext.request.contextPath}/homePage.jsp"><i class="bi bi-house-fill"></i> Trang chủ</a>
            <a href="${pageContext.request.contextPath}/mainController?action=ExploreCourse"><i class="bi bi-grid-fill"></i> Khóa học</a>
            <a href="${pageContext.request.contextPath}/instructors.jsp"></i> Giảng viên</a>
            <c:if test="${sessionScope.user.role == 1}">
                    <li><a href="adminController?action=dashboard">Administrator Manager</a></li>
            </c:if>
            <c:if test="${sessionScope.user != null && sessionScope.user.role == 2}">
                <a href="${pageContext.request.contextPath}/instructorController?action=dashboard"><i class="bi bi-easel-fill"></i> Instructor Manager</a>
            </c:if>
            <a href="${pageContext.request.contextPath}/about.jsp"><i class="bi bi-info-circle-fill"></i> Thông tin Chung</a>
            <div class="mobile-nav-divider"></div>
            <c:if test="${not empty sessionScope.user}">
                <a href="${pageContext.request.contextPath}/mainController?action=viewProfile"><i class="bi bi-person-fill"></i> Hồ sơ của tôi</a>
                <a href="${pageContext.request.contextPath}/mainController?action=myCourses"><i class="bi bi-book-fill"></i> Khóa học của tôi</a>
                <a href="${pageContext.request.contextPath}/mainController?action=payment"><i class="bi bi-wallet2"></i> Nạp tiền</a>
                <div class="mobile-nav-divider"></div>
                <a href="${pageContext.request.contextPath}/mainController?action=logout" style="color:#FF6B6B;"><i class="bi bi-box-arrow-right" style="color:#FF6B6B;"></i> Đăng xuất</a>
            </c:if>
            <c:if test="${empty sessionScope.user}">
                <a href="${pageContext.request.contextPath}/login.jsp"><i class="bi bi-box-arrow-in-right"></i> Đăng nhập</a>
            </c:if>
        </div>

        <!-- NAVBAR -->
        <c:if test="${not empty sessionScope.user}">
            <input type="hidden" id="currentUserId" value="${sessionScope.user.userId}">
        </c:if>
        <nav class="navbar-main" style="position:relative;">
            <a href="${pageContext.request.contextPath}/homePage.jsp" class="brand">DUK<span>Academy</span></a>

            <!-- Desktop nav links -->
            <ul class="nav-links">
                <li><a href="${pageContext.request.contextPath}/homePage.jsp" class="active">Trang chủ</a></li>
                <li><a href="${pageContext.request.contextPath}/mainController?action=ExploreCourse">Khóa học</a></li>
                <li><a href="${pageContext.request.contextPath}/instructors.jsp">Giảng viên</a></li>
                <c:if test="${sessionScope.user.role == 1}">
                    <li><a href="adminController?action=dashboard">Administrator Manager</a></li>
                </c:if>
                <c:if test="${sessionScope.user != null && sessionScope.user.role == 2}">
                    <li><a href="${pageContext.request.contextPath}/instructorController?action=dashboard">Instructor Manager</a></li>
                </c:if>
                <li><a href="${pageContext.request.contextPath}/about.jsp">Thông tin Chung</a></li>
            </ul>

            <div class="nav-right">
                <!-- Hamburger (mobile only) -->
                <button class="hamburger" id="hamburger" onclick="toggleMobileNav()" aria-label="Menu">
                    <span></span><span></span><span></span>
                </button>

                <c:if test="${not empty sessionScope.user}">
                    <!-- Balance -->
                    <a href="${pageContext.request.contextPath}/mainController?action=payment" class="balance-pill">
                        <i class="bi bi-wallet2"></i>
                        <span class="balance-label">Số dư</span>
                        <span class="balance-amount"><fmt:formatNumber value="${sessionScope.user.balance}" type="number" groupingUsed="true" maxFractionDigits="0"/> ₫</span>
                    </a>

                    <!-- Wishlist -->
                    <div class="wishlist-pill-wrap" id="wishlistWrap">
                        <div class="wishlist-pill" onclick="toggleWishlistDD(event)">
                            <i class="bi bi-heart-fill"></i>
                            <span class="wishlist-pill-label">Yêu thích</span>
                            <span class="wishlist-pill-count" id="wishCount">${not empty WISHLIST_IDS ? WISHLIST_IDS.size() : 0}</span>
                        </div>
                        <div class="wishlist-dropdown" id="wishlistDD">
                            <div class="wishlist-dd-header">
                                <span class="wishlist-dd-title"><i class="bi bi-heart-fill"></i> Khóa học yêu thích</span>
                                <a href="${pageContext.request.contextPath}/wishlistController?action=view&userId=${sessionScope.user.userId}" class="wishlist-dd-link">Xem tất cả</a>
                            </div>
                            <div class="wishlist-dd-list" id="wishlistDDList">
                                <c:choose>
                                    <c:when test="${not empty WISHLIST_COURSES}">
                                        <c:forEach var="wc" items="${WISHLIST_COURSES}">
                                            <div class="wishlist-dd-item" id="wish-item-${wc.courseId}">
                                                <div class="wishlist-dd-thumb">
                                                    <c:choose>
                                                        <c:when test="${not empty wc.img}">
                                                            <img src="${pageContext.request.contextPath}/${wc.img}" alt="${wc.courseName}" onerror="this.style.display='none';">
                                                        </c:when>
                                                        <c:otherwise>
                                                            <img src="${pageContext.request.contextPath}/img/courses/course${wc.courseId}.jpg" alt="${wc.courseName}" onerror="this.style.display='none';">
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                                <div class="wishlist-dd-info">
                                                    <div class="wishlist-dd-name">${wc.courseName}</div>
                                                    <div class="wishlist-dd-price">
                                                        <c:choose>
                                                            <c:when test="${wc.fee == 0}">Miễn phí</c:when>
                                                            <c:otherwise>${wc.fee} ₫</c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </div>
                                                <button class="wishlist-dd-remove" title="Xóa" onclick="removeWishItem(event, '${wc.courseId}')">
                                                    <i class="bi bi-x"></i>
                                                </button>
                                            </div>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="wishlist-dd-empty" id="wishEmptyMsg">
                                            <i class="bi bi-heart"></i>
                                            Chưa có khóa học yêu thích
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </c:if>

                <!-- User menu -->
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <div class="user-menu" onclick="toggleDropdown()">
                            <div class="user-avatar">${fn:substring(sessionScope.user.fullname, 0, 1)}</div>
                            <span class="user-name">${sessionScope.user.fullname}</span>
                            <i class="bi bi-chevron-down" style="color:rgba(255,255,255,0.6); font-size:0.75rem;"></i>
                        </div>
                        <div class="dropdown-menu-custom" id="userDropdown">
                            <a href="${pageContext.request.contextPath}/mainController?action=viewProfile"><i class="bi bi-person"></i> Hồ sơ của tôi</a>
                            <a href="${pageContext.request.contextPath}/mainController?action=myCourses"><i class="bi bi-book"></i> Khóa học của tôi</a>
                            <a href="${pageContext.request.contextPath}/mainController?action=payment"><i class="bi bi-wallet2"></i> Nạp tiền</a>
                            <a href="${pageContext.request.contextPath}/certificateController?action=myCertificates"><i class="bi bi-award"></i> Chứng chỉ</a>
                            <a href="${pageContext.request.contextPath}/wishlistController?action=view&userId=${sessionScope.user.userId}"><i class="bi bi-heart"></i> Yêu thích</a>
                            <div class="divider-drop"></div>
                            <a href="${pageContext.request.contextPath}/mainController?action=logout" class="logout-link"><i class="bi bi-box-arrow-right"></i> Đăng xuất</a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/login.jsp" style="color:rgba(255,255,255,0.75); text-decoration:none; font-size:0.875rem; font-weight:500;">Đăng nhập</a>
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
                        Chào mừng trở lại, <strong>${sessionScope.user.fullname}</strong>!
                    </div>
                </c:if>
                <div class="hero-eyebrow">✦ Nền tảng học trực tuyến hàng đầu</div>
                <h1>Chinh phục<br>tri thức, <em>định hình</em><br>tương lai</h1>
                <p>Hàng nghìn khóa học từ các chuyên gia hàng đầu đang chờ bạn. Học bất cứ lúc nào, bất cứ nơi đâu.</p>
                <div class="hero-actions">
                    <a href="${pageContext.request.contextPath}/mainController?action=ExploreCourse" class="btn-hero-primary">
                        <i class="bi bi-play-fill"></i> Khám phá khóa học
                    </a>
                    <a href="${pageContext.request.contextPath}/course/myCourses" class="btn-hero-secondary">
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
                            <div class="ins-meta"><span class="ins-stars">★★★★★</span><span>4.9 · 125K học viên</span></div>
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
                            <div class="ins-meta"><span class="ins-stars">★★★★★</span><span>4.9 · 89K học viên</span></div>
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
                            <div class="ins-meta"><span class="ins-stars">★★★★½</span><span>4.7 · 240K học viên</span></div>
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
                <a href="${pageContext.request.contextPath}/mainController?action=ExploreCourse" class="course-card">
                    <div class="course-thumb th1">
                        <img src="${pageContext.request.contextPath}/img/courses/course1t1.jpg" alt="Machine Learning" onerror="this.style.display='none';">
                    </div>
                    <div class="course-body">
                        <div class="course-org">DeepLearning.AI</div>
                        <h3>Machine Learning Specialization</h3>
                        <div class="course-meta"><span class="course-stars">★★★★★</span><span class="course-score">4.9</span><span class="course-count">(125K)</span></div>
                        <span class="course-tag">Dành cho người mới</span>
                    </div>
                </a>
                <a href="${pageContext.request.contextPath}/mainController?action=ExploreCourse" class="course-card">
                    <div class="course-thumb th2">
                        <img src="${pageContext.request.contextPath}/img/courses/course2.jpg" alt="Python Data Science" onerror="this.style.display='none';">
                    </div>
                    <div class="course-body">
                        <div class="course-org">Đại học Bách Khoa</div>
                        <h3>Python cho Khoa học Dữ liệu</h3>
                        <div class="course-meta"><span class="course-stars">★★★★★</span><span class="course-score">4.8</span><span class="course-count">(240K)</span></div>
                        <span class="course-tag">Nhiều người học nhất</span>
                    </div>
                </a>
                <a href="${pageContext.request.contextPath}/mainController?action=ExploreCourse" class="course-card">
                    <div class="course-thumb th3">
                        <img src="${pageContext.request.contextPath}/img/courses/course3.jpg" alt="UX Design" onerror="this.style.display='none';">
                    </div>
                    <div class="course-body">
                        <div class="course-org">Google · UX Design</div>
                        <h3>Google UX Design Professional</h3>
                        <div class="course-meta"><span class="course-stars">★★★★½</span><span class="course-score">4.7</span><span class="course-count">(89K)</span></div>
                        <span class="course-tag">Chứng chỉ chuyên nghiệp</span>
                    </div>
                </a>
                <a href="${pageContext.request.contextPath}/mainController?action=ExploreCourse" class="course-card">
                    <div class="course-thumb th4">
                        <img src="${pageContext.request.contextPath}/img/courses/course4t.jpg" alt="Data Science" onerror="this.style.display='none';">
                    </div>
                    <div class="course-body">
                        <div class="course-org">IBM · Data Science</div>
                        <h3>IBM Data Science Professional</h3>
                        <div class="course-meta"><span class="course-stars">★★★★★</span><span class="course-score">4.6</span><span class="course-count">(67K)</span></div>
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
            /* ── HAMBURGER / MOBILE NAV ── */
            function toggleMobileNav() {
                const nav = document.getElementById('mobileNav');
                const btn = document.getElementById('hamburger');
                nav.classList.toggle('open');
                btn.classList.toggle('open');
                document.body.style.overflow = nav.classList.contains('open') ? 'hidden' : '';
            }

            /* ── USER DROPDOWN ── */
            function toggleDropdown() {
                document.getElementById('userDropdown').classList.toggle('show');
            }

            /* ── WISHLIST DROPDOWN ── */
            function toggleWishlistDD(e) {
                e.stopPropagation();
                document.getElementById('wishlistDD').classList.toggle('show');
                document.getElementById('userDropdown') && document.getElementById('userDropdown').classList.remove('show');
            }

            function removeWishItem(e, courseId) {
                e.stopPropagation();
                const userId = document.getElementById('currentUserId') ? document.getElementById('currentUserId').value : '';
                fetch('wishlistController?action=remove&courseId=' + courseId + '&userId=' + userId + '&ajax=1')
                    .then(() => {
                        const item = document.getElementById('wish-item-' + courseId);
                        if (item) item.remove();
                        const el = document.getElementById('wishCount');
                        if (el) el.textContent = Math.max(0, parseInt(el.textContent || '0') - 1);
                        const list = document.getElementById('wishlistDDList');
                        if (list && list.querySelectorAll('.wishlist-dd-item').length === 0)
                            list.innerHTML = '<div class="wishlist-dd-empty"><i class="bi bi-heart"></i> Chưa có khóa học yêu thích</div>';
                    });
            }

            /* ── CLOSE DROPDOWNS ON OUTSIDE CLICK ── */
            document.addEventListener('click', function(e) {
                const userMenu = document.querySelector('.user-menu');
                const userDD   = document.getElementById('userDropdown');
                const wWrap    = document.getElementById('wishlistWrap');
                const wDD      = document.getElementById('wishlistDD');
                const mobileNav = document.getElementById('mobileNav');
                const hamburger = document.getElementById('hamburger');

                if (userDD && userMenu && !userMenu.contains(e.target) && !userDD.contains(e.target))
                    userDD.classList.remove('show');
                if (wDD && wWrap && !wWrap.contains(e.target))
                    wDD.classList.remove('show');
                if (mobileNav && hamburger && !mobileNav.contains(e.target) && !hamburger.contains(e.target) && mobileNav.classList.contains('open')) {
                    mobileNav.classList.remove('open');
                    hamburger.classList.remove('open');
                    document.body.style.overflow = '';
                }
            });
        </script>
    </body>
</html>
