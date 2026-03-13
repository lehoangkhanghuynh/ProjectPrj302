<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"      prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt"       prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<fmt:setLocale value="vi_VN"/>

<c:if test="${empty sessionScope.user}">
    <c:redirect url="login.jsp"/>
</c:if>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Yêu thích - DUK Academy</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&family=DM+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link rel="icon" type="image/jpeg" href="img/page/favicon.jpg">
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
            --bg:          #F4F0FC;
            --red:         #E53935;
            --red-light:   #FFF3F3;
        }
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'DM Sans', sans-serif; color: var(--text); background: var(--bg); min-height: 100vh; }

        /* ── NAVBAR ── */
        .navbar-main { background: var(--purple-deep); padding: 0 48px; height: 68px; display: flex; align-items: center; justify-content: space-between; position: sticky; top: 0; z-index: 100; box-shadow: 0 2px 20px rgba(0,0,0,0.25); }
        .brand { font-family: 'Playfair Display', serif; font-size: 1.55rem; font-weight: 700; color: #fff; text-decoration: none; }
        .brand span { color: var(--gold); }
        .nav-links { display: flex; align-items: center; gap: 4px; list-style: none; }
        .nav-links a { font-size: 0.9rem; font-weight: 500; color: rgba(255,255,255,0.75); text-decoration: none; padding: 7px 14px; border-radius: 6px; transition: background 0.15s, color 0.15s; }
        .nav-links a:hover { background: rgba(255,255,255,0.1); color: #fff; }
        .nav-right { display: flex; align-items: center; gap: 12px; }

        /* BALANCE PILL */
        .balance-pill { display: flex; align-items: center; gap: 7px; background: rgba(212,168,67,0.12); border: 1px solid rgba(212,168,67,0.35); border-radius: 8px; padding: 7px 14px; text-decoration: none; transition: background 0.15s; }
        .balance-pill:hover { background: rgba(212,168,67,0.22); }
        .balance-pill i { color: var(--gold); }
        .balance-label { font-size: 0.75rem; font-weight: 500; color: rgba(255,255,255,0.6); }
        .balance-amount { font-size: 0.875rem; font-weight: 700; color: var(--gold); }

        /* WISHLIST PILL */
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

        /* USER MENU */
        .user-menu { display: flex; align-items: center; gap: 10px; cursor: pointer; padding: 6px 12px; border-radius: 8px; border: 1px solid rgba(255,255,255,0.15); transition: background 0.15s; }
        .user-menu:hover { background: rgba(255,255,255,0.08); }
        .user-avatar { width: 34px; height: 34px; border-radius: 50%; background: linear-gradient(135deg, var(--purple-mid), var(--gold)); display: flex; align-items: center; justify-content: center; font-size: 0.9rem; font-weight: 700; color: #fff; }
        .user-name { font-size: 0.875rem; font-weight: 600; color: #fff; max-width: 120px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }
        .dropdown-menu-custom { position: absolute; top: 76px; right: 48px; background: #fff; border: 1px solid var(--border); border-radius: 10px; padding: 8px; min-width: 200px; box-shadow: 0 8px 32px rgba(0,0,0,0.15); display: none; z-index: 200; }
        .dropdown-menu-custom.show { display: block; }
        .dropdown-menu-custom a { display: flex; align-items: center; gap: 10px; padding: 10px 14px; border-radius: 7px; font-size: 0.875rem; color: var(--text); text-decoration: none; font-weight: 500; transition: background 0.12s; }
        .dropdown-menu-custom a:hover { background: var(--purple-light); color: var(--purple); }
        .dropdown-menu-custom .divider-drop { height: 1px; background: var(--border); margin: 6px 0; }
        .dropdown-menu-custom .logout-link { color: #CC0000; }
        .dropdown-menu-custom .logout-link:hover { background: #FFF3F3; color: #CC0000; }

        /* PAGE HEADER */
        .page-header { background: linear-gradient(135deg, var(--purple-deep) 0%, #3A1A7A 60%, #5B2DC5 100%); padding: 52px 80px 56px; position: relative; overflow: hidden; }
        .page-header::before { content: ''; position: absolute; width: 500px; height: 500px; border-radius: 50%; background: rgba(212,168,67,0.05); top: -200px; right: -100px; }
        .page-header::after  { content: ''; position: absolute; width: 250px; height: 250px; border-radius: 50%; background: rgba(229,57,53,0.08); bottom: -80px; left: 150px; }
        .header-hearts { position: absolute; inset: 0; pointer-events: none; overflow: hidden; }
        .header-hearts span { position: absolute; color: rgba(255,107,107,0.15); font-size: 2rem; animation: floatHeart 6s ease-in-out infinite; }
        .header-hearts span:nth-child(1) { left: 5%;  top: 20%; animation-delay: 0s;   font-size: 1.5rem; }
        .header-hearts span:nth-child(2) { left: 15%; top: 60%; animation-delay: 1s;   font-size: 2.5rem; }
        .header-hearts span:nth-child(3) { left: 80%; top: 15%; animation-delay: 0.5s; font-size: 1.8rem; }
        .header-hearts span:nth-child(4) { left: 70%; top: 65%; animation-delay: 2s;   font-size: 1.2rem; }
        .header-hearts span:nth-child(5) { left: 90%; top: 40%; animation-delay: 1.5s; font-size: 2rem;   }
        @keyframes floatHeart { 0%,100%{transform:translateY(0) rotate(-10deg);opacity:0.15;} 50%{transform:translateY(-18px) rotate(10deg);opacity:0.3;} }
        .page-header-inner { position: relative; z-index: 1; }
        .page-eyebrow { font-size: 0.72rem; font-weight: 700; text-transform: uppercase; letter-spacing: 2px; color: var(--gold); margin-bottom: 10px; display: flex; align-items: center; gap: 8px; }
        .page-title { font-family: 'Playfair Display', serif; font-size: 2.6rem; font-weight: 700; color: #fff; margin-bottom: 10px; display: flex; align-items: center; gap: 14px; }
        .page-title .heart-icon { color: #FF6B6B; font-size: 2rem; animation: heartbeat 1.5s ease-in-out infinite; }
        @keyframes heartbeat { 0%,100%{transform:scale(1);} 50%{transform:scale(1.2);} }
        .page-subtitle { font-size: 1rem; color: rgba(255,255,255,0.65); }
        .header-stat { display: inline-flex; align-items: center; gap: 8px; background: rgba(255,255,255,0.08); border: 1px solid rgba(255,255,255,0.12); border-radius: 10px; padding: 10px 18px; margin-top: 22px; }
        .header-stat-num { font-size: 1.4rem; font-weight: 700; color: #FF6B6B; }
        .header-stat-lbl { font-size: 0.8rem; color: rgba(255,255,255,0.6); }

        /* MAIN */
        .main-wrap { max-width: 960px; margin: 0 auto; padding: 48px 24px 80px; }
        .list-topbar { display: flex; align-items: center; justify-content: space-between; margin-bottom: 28px; }
        .list-title { font-family: 'Playfair Display', serif; font-size: 1.4rem; font-weight: 700; color: var(--text); display: flex; align-items: center; gap: 8px; }
        .list-title i { color: var(--red); }
        .btn-back { display: inline-flex; align-items: center; gap: 8px; background: #fff; border: 1.5px solid var(--border); color: var(--muted); font-size: 0.82rem; font-weight: 600; padding: 8px 18px; border-radius: 8px; text-decoration: none; transition: all 0.15s; }
        .btn-back:hover { border-color: var(--purple); color: var(--purple); background: var(--purple-light); }

        /* WISHLIST CARDS */
        .wishlist-list { display: flex; flex-direction: column; gap: 16px; }
        .wish-card { background: #fff; border: 1px solid var(--border); border-radius: 16px; padding: 20px 24px; display: flex; align-items: center; gap: 20px; transition: box-shadow 0.2s, transform 0.2s, border-color 0.2s; animation: slideIn 0.3s ease both; }
        .wish-card:hover { box-shadow: 0 8px 32px rgba(108,63,197,0.12); transform: translateY(-2px); border-color: var(--purple-mid); }
        @keyframes slideIn { from{opacity:0;transform:translateY(16px);} to{opacity:1;transform:translateY(0);} }
        .wish-card-thumb { width: 80px; height: 80px; border-radius: 12px; flex-shrink: 0; background: linear-gradient(135deg, var(--purple-deep), var(--purple)); display: flex; align-items: center; justify-content: center; font-size: 2rem; overflow: hidden; position: relative; }
        .wish-card-thumb img { width: 100%; height: 100%; object-fit: cover; }
        .wish-card-thumb .thumb-overlay { position: absolute; inset: 0; background: linear-gradient(to top, rgba(30,10,74,0.4), transparent); }
        .wish-card-info { flex: 1; min-width: 0; }
        .wish-card-meta { font-size: 0.68rem; font-weight: 700; color: var(--muted); text-transform: uppercase; letter-spacing: 0.5px; margin-bottom: 5px; display: flex; align-items: center; gap: 6px; }
        .wish-card-name { font-size: 1rem; font-weight: 700; color: var(--text); margin-bottom: 8px; line-height: 1.4; }
        .wish-card-details { display: flex; align-items: center; gap: 14px; flex-wrap: wrap; }
        .wish-card-badge { display: inline-flex; align-items: center; gap: 5px; font-size: 0.72rem; font-weight: 600; padding: 3px 10px; border-radius: 20px; }
        .badge-id   { background: var(--purple-light); color: var(--purple); }
        .badge-date { background: #F0FFF4; color: #2E7D32; }
        .wish-card-actions { display: flex; align-items: center; gap: 10px; flex-shrink: 0; }
        .btn-study  { display: inline-flex; align-items: center; gap: 6px; background: linear-gradient(135deg, var(--purple), var(--purple-dark)); color: #fff; font-size: 0.78rem; font-weight: 700; padding: 8px 18px; border-radius: 8px; text-decoration: none; border: none; cursor: pointer; font-family: 'DM Sans', sans-serif; transition: all 0.15s; }
        .btn-study:hover  { transform: translateY(-1px); box-shadow: 0 4px 16px rgba(108,63,197,0.35); color: #fff; }
        .btn-enroll { display: inline-flex; align-items: center; gap: 6px; background: linear-gradient(135deg, var(--gold), #B8860B); color: #fff; font-size: 0.78rem; font-weight: 700; padding: 8px 18px; border-radius: 8px; border: none; cursor: pointer; font-family: 'DM Sans', sans-serif; transition: all 0.15s; }
        .btn-enroll:hover { transform: translateY(-1px); box-shadow: 0 4px 16px rgba(212,168,67,0.45); color: #fff; }
        .btn-remove { display: inline-flex; align-items: center; gap: 6px; background: var(--red-light); color: var(--red); border: 1.5px solid rgba(229,57,53,0.2); font-size: 0.78rem; font-weight: 700; padding: 8px 16px; border-radius: 8px; text-decoration: none; cursor: pointer; font-family: 'DM Sans', sans-serif; transition: all 0.15s; }
        .btn-remove:hover { background: var(--red); color: #fff; border-color: var(--red); transform: translateY(-1px); }

        /* EMPTY */
        .empty-wrap { text-align: center; padding: 80px 20px; background: #fff; border-radius: 20px; border: 1px solid var(--border); }
        .empty-heart { font-size: 5rem; margin-bottom: 20px; animation: heartbeat 2s ease-in-out infinite; display: block; }
        .empty-title { font-family: 'Playfair Display', serif; font-size: 1.5rem; font-weight: 700; color: var(--text); margin-bottom: 10px; }
        .empty-sub   { font-size: 0.9rem; color: var(--muted); margin-bottom: 28px; }
        .btn-explore { display: inline-flex; align-items: center; gap: 8px; background: linear-gradient(135deg, var(--purple), var(--purple-dark)); color: #fff; font-size: 0.9rem; font-weight: 700; padding: 12px 28px; border-radius: 10px; text-decoration: none; transition: all 0.15s; }
        .btn-explore:hover { transform: translateY(-2px); box-shadow: 0 6px 24px rgba(108,63,197,0.4); color: #fff; }

        /* TOAST */
        .toast-noti { position: fixed; bottom: 32px; left: 50%; transform: translateX(-50%) translateY(20px); background: #1E0A4A; color: #fff; padding: 13px 24px; border-radius: 50px; font-size: 0.875rem; font-weight: 600; display: flex; align-items: center; gap: 10px; box-shadow: 0 8px 32px rgba(0,0,0,0.25); z-index: 9999; opacity: 0; transition: opacity 0.3s, transform 0.3s; pointer-events: none; }
        .toast-noti.show { opacity: 1; transform: translateX(-50%) translateY(0); }

        /* MODAL */
        .modal-overlay { display: none; position: fixed; inset: 0; background: rgba(10,5,30,0.65); backdrop-filter: blur(5px); z-index: 1000; align-items: center; justify-content: center; }
        .modal-overlay.show { display: flex; }
        .modal-box { background: #fff; border-radius: 20px; padding: 36px; width: 440px; max-width: 95vw; box-shadow: 0 24px 64px rgba(108,63,197,0.3); animation: modalIn 0.25s cubic-bezier(0.34,1.56,0.64,1); }
        @keyframes modalIn { from{transform:scale(0.88) translateY(24px);opacity:0;} to{transform:scale(1) translateY(0);opacity:1;} }
        .modal-icon  { width: 58px; height: 58px; border-radius: 16px; background: var(--purple-light); display: flex; align-items: center; justify-content: center; font-size: 1.7rem; margin-bottom: 18px; }
        .modal-title { font-family: 'Playfair Display', serif; font-size: 1.35rem; font-weight: 700; color: var(--text); margin-bottom: 6px; }
        .modal-course-name { font-size: 0.88rem; font-weight: 600; color: var(--purple); margin-bottom: 22px; line-height: 1.4; }
        .modal-info-row { display: flex; justify-content: space-between; align-items: center; background: var(--bg); border-radius: 10px; padding: 13px 16px; margin-bottom: 8px; }
        .modal-info-label { font-size: 0.82rem; color: var(--muted); font-weight: 500; display: flex; align-items: center; gap: 6px; }
        .modal-info-value { font-size: 0.9rem; font-weight: 700; }
        .fee-val     { color: var(--purple); font-size: 1rem; }
        .balance-val { color: #2E7D32; }
        .after-val   { color: var(--gold); }
        .danger-val  { color: #C62828; }
        .modal-divider { height: 1px; background: var(--border); margin: 14px 0; }
        .modal-warning { display: none; background: #FFF3F3; border: 1px solid #FFCDD2; border-radius: 8px; padding: 10px 14px; margin-top: 12px; font-size: 0.82rem; color: #C62828; font-weight: 600; }
        .modal-actions { display: flex; gap: 10px; margin-top: 22px; }
        .btn-cancel  { flex: 1; padding: 12px; border-radius: 10px; border: 1.5px solid var(--border); background: #fff; color: var(--muted); font-size: 0.88rem; font-weight: 700; cursor: pointer; font-family: 'DM Sans', sans-serif; transition: all 0.15s; }
        .btn-cancel:hover  { border-color: var(--purple); color: var(--purple); }
        .btn-confirm { flex: 2; padding: 12px; border-radius: 10px; border: none; background: linear-gradient(135deg, var(--purple), var(--purple-dark)); color: #fff; font-size: 0.88rem; font-weight: 700; cursor: pointer; font-family: 'DM Sans', sans-serif; transition: all 0.15s; display: flex; align-items: center; justify-content: center; gap: 8px; }
        .btn-confirm:hover:not(:disabled) { transform: translateY(-1px); box-shadow: 0 6px 20px rgba(108,63,197,0.4); }
        .btn-confirm:disabled { opacity: 0.5; cursor: not-allowed; }

        /* FOOTER */
        footer { background: var(--purple-deep); padding: 32px 80px; }
        footer .inner { display: flex; justify-content: space-between; align-items: center; border-top: 1px solid rgba(255,255,255,0.08); padding-top: 20px; }

        @media (max-width: 768px) {
            .navbar-main { padding: 0 20px; }
            .page-header { padding: 40px 20px 44px; }
            .page-title  { font-size: 2rem; }
            .main-wrap   { padding: 32px 16px 60px; }
            .wish-card   { flex-wrap: wrap; }
            .wish-card-actions { width: 100%; justify-content: flex-end; }
            .nav-links { display: none; }
            .dropdown-menu-custom { right: 16px; }
            footer { padding: 24px 20px; }
        }
    </style>
</head>
<body>

<!-- TOAST -->
<div class="toast-noti" id="toastNoti">
    <i class="bi bi-trash3-fill"></i>
    <span id="toastMsg">Đã xóa khỏi danh sách yêu thích</span>
</div>

<!-- NAVBAR -->
<nav class="navbar-main" style="position:relative;">
    <a href="homePage.jsp" class="brand">DUK<span>Academy</span></a>
    <ul class="nav-links">
        <li><a href="homePage.jsp">Trang chủ</a></li>
        <li><a href="mainController?action=ExploreCourse">Khóa học</a></li>
        <li><a href="instructors.jsp">Giảng viên</a></li>
        <c:if test="${sessionScope.user.role == 1}">
            <li><a href="administrator.jsp">Administrator Manager</a></li>
        </c:if>
        <c:if test="${sessionScope.user != null && sessionScope.user.role == 2}">
            <li><a href="instructorDashboard.jsp">Instructor Manager</a></li>
        </c:if>
        <li><a href="about.jsp">Thông tin Chung</a></li>
    </ul>

    <div class="nav-right">

        <%-- BALANCE PILL --%>
        <a href="paymentController" class="balance-pill">
            <i class="bi bi-wallet2"></i>
            <span class="balance-label">Số dư</span>
            <span class="balance-amount">
                <fmt:formatNumber value="${sessionScope.user.balance != null ? sessionScope.user.balance : 0}"
                                  type="number" maxFractionDigits="0"/> ₫
            </span>
        </a>

        <%-- WISHLIST PILL --%>
        <div class="wishlist-pill-wrap" id="wishlistWrap">
            <div class="wishlist-pill" onclick="toggleWishlistDD(event)">
                <i class="bi bi-heart-fill"></i>
                <span class="wishlist-pill-label">Yêu thích</span>
                <span class="wishlist-pill-count" id="wishCount">
                    ${not empty WISHLIST_IDS ? WISHLIST_IDS.size() : 0}
                </span>
            </div>
            <div class="wishlist-dropdown" id="wishlistDD">
                <div class="wishlist-dd-header">
                    <span class="wishlist-dd-title">
                        <i class="bi bi-heart-fill"></i> Khóa học yêu thích
                    </span>
                    <a href="wishlistController?action=view&userId=${sessionScope.user.userId}"
                       class="wishlist-dd-link">Xem tất cả</a>
                </div>
                <div class="wishlist-dd-list" id="wishlistDDList">
                    <c:choose>
                        <c:when test="${not empty WISHLIST_COURSES}">
                            <c:forEach var="wc" items="${WISHLIST_COURSES}">
                                <div class="wishlist-dd-item" id="wish-item-${wc.courseId}">
                                    <div class="wishlist-dd-thumb">
                                        <img src="${pageContext.request.contextPath}/img/courses/course${wc.courseId}.jpg"
                                             alt="${wc.courseName}" onerror="this.style.display='none';">
                                    </div>
                                    <div class="wishlist-dd-info">
                                        <div class="wishlist-dd-name">${wc.courseName}</div>
                                        <div class="wishlist-dd-price">
                                            <c:choose>
                                                <c:when test="${wc.fee == 0}">Miễn phí</c:when>
                                                <c:otherwise>
                                                    <fmt:formatNumber value="${wc.fee}" type="number"
                                                                      maxFractionDigits="0"/> ₫
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                    <button class="wishlist-dd-remove" title="Xóa khỏi yêu thích"
                                            onclick="removeWishItem(event, '${wc.courseId}')">
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

        <%-- USER MENU --%>
        <div class="user-menu" onclick="toggleDD()">
            <div class="user-avatar">${fn:substring(sessionScope.user.fullname, 0, 1)}</div>
            <span class="user-name">${sessionScope.user.fullname}</span>
            <i class="bi bi-chevron-down" style="color:rgba(255,255,255,0.6);font-size:0.75rem;"></i>
        </div>
        <div class="dropdown-menu-custom" id="userDD">
            <a href="myprofile.jsp"><i class="bi bi-person"></i> Hồ sơ của tôi</a>
            <a href="myCourses"><i class="bi bi-book"></i> Khóa học của tôi</a>
            <a href="paymentController"><i class="bi bi-wallet2"></i> Nạp tiền</a>
            <a href="myCertificates"><i class="bi bi-award"></i> Chứng chỉ</a>
            <a href="wishlistController?action=view&userId=${sessionScope.user.userId}">
                <i class="bi bi-heart"></i> Yêu thích
            </a>
            <div class="divider-drop"></div>
            <a href="mainController?action=logout" class="logout-link">
                <i class="bi bi-box-arrow-right"></i> Đăng xuất
            </a>
        </div>
    </div>
</nav>

<!-- PAGE HEADER -->
<div class="page-header">
    <div class="header-hearts">
        <span>♥</span><span>♥</span><span>♥</span><span>♥</span><span>♥</span>
    </div>
    <div class="page-header-inner">
        <div class="page-eyebrow">
            <i class="bi bi-heart-fill" style="color:#FF6B6B;"></i>
            Danh sách yêu thích
        </div>
        <h1 class="page-title">
            <i class="bi bi-heart-fill heart-icon"></i>
            Khóa học của tôi
        </h1>
        <p class="page-subtitle">Những khóa học bạn đã lưu lại — sẵn sàng để bắt đầu bất cứ lúc nào.</p>
        <div class="header-stat">
            <span class="header-stat-num" id="statNum">${not empty wishlist ? fn:length(wishlist) : 0}</span>
            <span class="header-stat-lbl">khóa học đang chờ bạn</span>
        </div>
    </div>
</div>

<!-- MAIN -->
<div class="main-wrap">
    <div class="list-topbar">
        <div class="list-title">
            <i class="bi bi-heart-fill"></i>
            Tất cả khóa học yêu thích
        </div>
        <a href="homePage.jsp" class="btn-back">
            <i class="bi bi-arrow-left"></i> Về trang chủ
        </a>
    </div>

    <c:choose>
        <c:when test="${not empty wishlist}">
            <div class="wishlist-list" id="wishlistList">
                <c:forEach var="w" items="${wishlist}" varStatus="st">

                    <c:set var="isEnrolled" value="false"/>
                    <c:forEach var="eid" items="${enrolledIds}">
                        <c:if test="${eid == w.courseId}">
                            <c:set var="isEnrolled" value="true"/>
                        </c:if>
                    </c:forEach>

                    <c:set var="courseFee" value="${not empty feeMap[w.courseId] ? feeMap[w.courseId] : 0}"/>

                    <div class="wish-card" id="card-${w.wishlistId}"
                         style="animation-delay:${st.index * 0.06}s">

                        <!-- THUMBNAIL -->
                        <div class="wish-card-thumb">
                            <img src="img/courses/course${w.courseId}.jpg"
                                 alt="Course ${w.courseId}"
                                 onerror="this.style.display='none';">
                            <div class="thumb-overlay"></div>
                        </div>

                        <!-- INFO -->
                        <div class="wish-card-info">
                            <div class="wish-card-meta">
                                <i class="bi bi-building"></i> DUK Academy
                            </div>
                            <div class="wish-card-name">
                                <c:choose>
                                    <c:when test="${not empty courseNameMap[w.courseId]}">
                                        ${courseNameMap[w.courseId]}
                                    </c:when>
                                    <c:otherwise>Khóa học #${w.courseId}</c:otherwise>
                                </c:choose>
                            </div>
                            <div class="wish-card-details">
                                <span class="wish-card-badge badge-id">
                                    <i class="bi bi-hash"></i> ID: ${w.wishlistId}
                                </span>
                                <span class="wish-card-badge badge-date">
                                    <i class="bi bi-calendar3"></i>
                                    <fmt:formatDate value="${w.createdAt}" pattern="dd/MM/yyyy"/>
                                </span>
                                <span class="wish-card-badge badge-date"
                                      style="background:#EFF6FF;color:#1D4ED8;">
                                    <i class="bi bi-clock"></i>
                                    <fmt:formatDate value="${w.createdAt}" pattern="HH:mm"/>
                                </span>
                                <span class="wish-card-badge"
                                      style="background:var(--purple-light);color:var(--purple);">
                                    <i class="bi bi-tag"></i>
                                    <c:choose>
                                        <c:when test="${courseFee == 0}">Miễn phí</c:when>
                                        <c:otherwise>
                                            <fmt:formatNumber value="${courseFee}" type="number"
                                                              maxFractionDigits="0"/> ₫
                                        </c:otherwise>
                                    </c:choose>
                                </span>
                            </div>
                        </div>

                        <!-- ACTIONS -->
                        <div class="wish-card-actions">
                            <c:choose>
                                <c:when test="${isEnrolled == 'true'}">
                                    <a href="lesson?courseId=${w.courseId}" class="btn-study">
                                        <i class="bi bi-play-circle-fill"></i> Học ngay
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <button type="button" class="btn-enroll"
                                            onclick="openModal(
                                                '${w.courseId}',
                                                '${not empty courseNameMap[w.courseId] ? courseNameMap[w.courseId] : "Khóa học #".concat(w.courseId)}',
                                                '${courseFee}',
                                                '${sessionScope.user.balance}')">
                                        <i class="bi bi-cart3"></i> Đăng ký học
                                    </button>
                                </c:otherwise>
                            </c:choose>

                            <button type="button" class="btn-remove"
                                    data-wishid="${w.wishlistId}"
                                    data-href="wishlistController?action=remove&wishlistId=${w.wishlistId}&userId=${sessionScope.user.userId}&from=wishlist"
                                    onclick="confirmRemove(this)">
                                <i class="bi bi-trash3"></i> Xóa
                            </button>
                        </div>

                    </div>
                </c:forEach>
            </div>

            <!-- BOTTOM CTA -->
            <div style="text-align:center;margin-top:40px;padding-top:32px;border-top:1px solid var(--border);">
                <p style="font-size:0.875rem;color:var(--muted);margin-bottom:16px;">
                    Khám phá thêm khóa học mới?
                </p>
                <a href="mainController?action=ExploreCourse" class="btn-explore">
                    <i class="bi bi-compass"></i> Khám phá khóa học
                </a>
            </div>
        </c:when>

        <c:otherwise>
            <div class="empty-wrap">
                <span class="empty-heart">🤍</span>
                <div class="empty-title">Chưa có khóa học yêu thích</div>
                <p class="empty-sub">Hãy thêm những khóa học bạn quan tâm để dễ dàng tìm lại sau này.</p>
                <a href="mainController?action=ExploreCourse" class="btn-explore">
                    <i class="bi bi-compass"></i> Khám phá khóa học ngay
                </a>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<!-- FOOTER -->
<footer>
    <div class="inner">
        <span style="font-family:'Playfair Display',serif;font-size:1.2rem;font-weight:700;color:#fff;">
            DUK<span style="color:var(--gold);">Academy</span>
        </span>
        <span style="font-size:0.78rem;color:rgba(255,255,255,0.35);">
            © 2026 DUK Academy. All rights reserved.
        </span>
    </div>
</footer>

<!-- MODAL ĐĂNG KÝ -->
<div class="modal-overlay" id="enrollModal" onclick="closeModalOutside(event)">
    <div class="modal-box">
        <div class="modal-icon">🎓</div>
        <div class="modal-title">Xác nhận đăng ký</div>
        <div class="modal-course-name" id="modalCourseName">—</div>

        <div class="modal-info-row">
            <span class="modal-info-label"><i class="bi bi-tag-fill"></i> Học phí</span>
            <span class="modal-info-value fee-val" id="modalFee">—</span>
        </div>
        <div class="modal-info-row">
            <span class="modal-info-label"><i class="bi bi-wallet2"></i> Số dư hiện tại</span>
            <span class="modal-info-value balance-val" id="modalBalance">—</span>
        </div>
        <div class="modal-divider"></div>
        <div class="modal-info-row">
            <span class="modal-info-label">
                <i class="bi bi-arrow-right-circle-fill"></i> Số dư sau đăng ký
            </span>
            <span class="modal-info-value after-val" id="modalAfter">—</span>
        </div>

        <div class="modal-warning" id="modalWarning">
            <i class="bi bi-exclamation-triangle-fill"></i>
            Số dư không đủ!
            <a href="paymentController" style="color:#C62828;font-weight:700;">Nạp tiền ngay →</a>
        </div>

        <form action="enroll" method="post">
            <input type="hidden" name="courseId" id="modalCourseId">
            <div class="modal-actions">
                <button type="button" class="btn-cancel" onclick="closeModal()">
                    <i class="bi bi-x-circle"></i> Hủy
                </button>
                <button type="submit" class="btn-confirm" id="btnConfirm">
                    <i class="bi bi-check-circle-fill"></i> Xác nhận đăng ký
                </button>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    /* ── WISHLIST DROPDOWN ── */
    function toggleWishlistDD(e) {
        e.stopPropagation();
        document.getElementById('wishlistDD').classList.toggle('show');
        const ud = document.getElementById('userDD');
        if (ud) ud.classList.remove('show');
    }
    function removeWishItem(e, courseId) {
        e.stopPropagation();
        const userId = '${sessionScope.user.userId}';
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

    /* ── USER DROPDOWN ── */
    function toggleDD() {
        document.getElementById('userDD').classList.toggle('show');
        const wd = document.getElementById('wishlistDD');
        if (wd) wd.classList.remove('show');
    }

    /* ── CLICK OUTSIDE ── */
    document.addEventListener('click', function(e) {
        const ud = document.getElementById('userDD');
        const um = document.querySelector('.user-menu');
        const ww = document.getElementById('wishlistWrap');
        const wd = document.getElementById('wishlistDD');
        if (ud && um && !um.contains(e.target) && !ud.contains(e.target))
            ud.classList.remove('show');
        if (wd && ww && !ww.contains(e.target))
            wd.classList.remove('show');
    });

    /* ── MODAL ── */
    function fmt(val) {
        return Number(val).toLocaleString('vi-VN') + ' ₫';
    }
    function openModal(courseId, courseName, fee, balance) {
        const feeNum = parseFloat(fee)     || 0;
        const balNum = parseFloat(balance) || 0;
        const after  = balNum - feeNum;

        document.getElementById('modalCourseId').value         = courseId;
        document.getElementById('modalCourseName').textContent = courseName;
        document.getElementById('modalFee').textContent        = fmt(feeNum);
        document.getElementById('modalBalance').textContent    = fmt(balNum);

        const afterEl   = document.getElementById('modalAfter');
        const warnEl    = document.getElementById('modalWarning');
        const confirmEl = document.getElementById('btnConfirm');

        if (after < 0) {
            afterEl.textContent  = 'Không đủ số dư!';
            afterEl.className    = 'modal-info-value danger-val';
            warnEl.style.display = 'block';
            confirmEl.disabled   = true;
        } else {
            afterEl.textContent  = fmt(after);
            afterEl.className    = 'modal-info-value after-val';
            warnEl.style.display = 'none';
            confirmEl.disabled   = false;
        }
        document.getElementById('enrollModal').classList.add('show');
        document.body.style.overflow = 'hidden';
    }
    function closeModal() {
        document.getElementById('enrollModal').classList.remove('show');
        document.body.style.overflow = '';
    }
    function closeModalOutside(e) {
        if (e.target === document.getElementById('enrollModal')) closeModal();
    }
    document.addEventListener('keydown', e => { if (e.key === 'Escape') closeModal(); });

    /* ── TOAST ── */
    let toastTimer;
    function showToast(msg) {
        const toast = document.getElementById('toastNoti');
        document.getElementById('toastMsg').textContent = msg;
        toast.classList.add('show');
        clearTimeout(toastTimer);
        toastTimer = setTimeout(() => toast.classList.remove('show'), 2500);
    }

    /* ── REMOVE WISHLIST ── */
    function confirmRemove(btn) {
        const wishlistId = btn.dataset.wishid;
        const href       = btn.dataset.href;
        const card       = document.getElementById('card-' + wishlistId);
        if (!card) return;

        btn.disabled = true;
        card.style.transition = 'all 0.3s ease';
        card.style.opacity    = '0';
        card.style.transform  = 'translateX(40px)';

        showToast('Đã xóa khỏi danh sách yêu thích');

        setTimeout(() => {
            card.style.maxHeight = card.offsetHeight + 'px';
            card.style.overflow  = 'hidden';
            card.style.padding   = '0';
            card.style.margin    = '0';
            card.style.border    = 'none';
            requestAnimationFrame(() => {
                card.style.transition = 'all 0.3s ease';
                card.style.maxHeight  = '0';
            });
            setTimeout(() => {
                card.remove();
                const remaining = document.querySelectorAll('.wish-card').length;
                document.getElementById('statNum').textContent = remaining;
                window.location.href = href;
            }, 320);
        }, 300);
    }
</script>
</body>
</html>
