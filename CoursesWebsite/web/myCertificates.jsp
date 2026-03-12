<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%!
    public String fmtBal(Object bal) {
        if (bal == null) {
            return "0";
        }
        try {
            double d = Double.parseDouble(bal.toString().trim());
            long v = (long) d;
            return String.format("%,d", v).replace(',', '.');
        } catch (Exception e) {
            return "0";
        }
    }
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Hồ sơ của tôi - DUK Academy</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&family=DM+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
        <link rel="icon" type="image/jpeg" href="img/page/favicon.jpg">
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
                --bg:           #F8F5FF;
                --white:        #FFFFFF;
                --success:      #1A7A4A;
                --success-bg:   #EDFAF4;
                --success-border:#A3E6C4;
                --error:        #B91C1C;
                --error-bg:     #FFF2F2;
                --error-border: #FCA5A5;
            }

            *, *::before, *::after {
                box-sizing: border-box;
                margin: 0;
                padding: 0;
            }
            body {
                font-family: 'DM Sans', sans-serif;
                color: var(--text);
                background: var(--bg);
                min-height: 100vh;
            }

            /* ─── NAVBAR ─── */
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
                transition: all 0.15s;
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
            }
            .balance-pill:hover {
                background: rgba(212,168,67,0.22);
            }
            .balance-pill i {
                color: var(--gold);
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
            }

            /* WISHLIST PILL */
            .wishlist-pill-wrap {
                position: relative;
            }
            .wishlist-pill {
                display: flex;
                align-items: center;
                gap: 7px;
                background: rgba(229,57,53,0.12);
                border: 1px solid rgba(229,57,53,0.35);
                border-radius: 8px;
                padding: 7px 14px;
                cursor: pointer;
                transition: background 0.15s;
                user-select: none;
            }
            .wishlist-pill:hover {
                background: rgba(229,57,53,0.2);
            }
            .wishlist-pill i {
                color: #FF6B6B;
                font-size: 1rem;
            }
            .wishlist-pill-label {
                font-size: 0.75rem;
                font-weight: 500;
                color: rgba(255,255,255,0.6);
            }
            .wishlist-pill-count {
                font-size: 0.875rem;
                font-weight: 700;
                color: #FF6B6B;
            }
            .wishlist-dropdown {
                position: absolute;
                top: calc(100% + 10px);
                right: 0;
                background: #fff;
                border: 1px solid var(--border);
                border-radius: 14px;
                min-width: 320px;
                max-width: 360px;
                box-shadow: 0 12px 40px rgba(0,0,0,0.18);
                display: none;
                z-index: 300;
                overflow: hidden;
            }
            .wishlist-dropdown.show {
                display: block;
                animation: ddIn 0.18s ease;
            }
            @keyframes ddIn {
                from {
                    opacity:0;
                    transform:translateY(-8px);
                }
                to {
                    opacity:1;
                    transform:translateY(0);
                }
            }
            .wishlist-dd-header {
                padding: 14px 18px 10px;
                border-bottom: 1px solid var(--border);
                display: flex;
                align-items: center;
                justify-content: space-between;
            }
            .wishlist-dd-title {
                font-size: 0.9rem;
                font-weight: 700;
                color: var(--text);
                display: flex;
                align-items: center;
                gap: 7px;
            }
            .wishlist-dd-title i {
                color: #E53935;
            }
            .wishlist-dd-link {
                font-size: 0.75rem;
                font-weight: 600;
                color: var(--purple);
                text-decoration: none;
            }
            .wishlist-dd-link:hover {
                text-decoration: underline;
            }
            .wishlist-dd-list {
                max-height: 320px;
                overflow-y: auto;
                padding: 8px;
            }
            .wishlist-dd-item {
                display: flex;
                align-items: center;
                gap: 10px;
                padding: 10px;
                border-radius: 10px;
                transition: background 0.12s;
            }
            .wishlist-dd-item:hover {
                background: var(--purple-light);
            }
            .wishlist-dd-thumb {
                width: 44px;
                height: 44px;
                border-radius: 8px;
                background: linear-gradient(135deg, var(--purple-deep), var(--purple));
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1.2rem;
                flex-shrink: 0;
                overflow: hidden;
            }
            .wishlist-dd-thumb img {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }
            .wishlist-dd-info {
                flex: 1;
                min-width: 0;
            }
            .wishlist-dd-name {
                font-size: 0.8rem;
                font-weight: 700;
                color: var(--text);
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
            }
            .wishlist-dd-price {
                font-size: 0.72rem;
                color: var(--purple);
                font-weight: 600;
                margin-top: 2px;
            }
            .wishlist-dd-remove {
                background: none;
                border: none;
                color: #ccc;
                cursor: pointer;
                font-size: 1rem;
                padding: 4px 6px;
                border-radius: 50%;
                transition: color 0.15s, background 0.15s;
                flex-shrink: 0;
            }
            .wishlist-dd-remove:hover {
                color: #E53935;
                background: #FFF3F3;
            }
            .wishlist-dd-empty {
                padding: 32px 16px;
                text-align: center;
                color: var(--muted);
                font-size: 0.85rem;
            }
            .wishlist-dd-empty i {
                font-size: 2rem;
                display: block;
                margin-bottom: 8px;
                opacity: 0.4;
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

            /* ─── PAGE ─── */
            .page-wrap {
                max-width: 820px;
                margin: 44px auto 60px;
                padding: 0 20px;
            }

            /* ─── BANNER ─── */
            .profile-banner {
                background: linear-gradient(145deg, var(--purple-deep) 0%, #3A1A7A 50%, #5B2DC5 100%);
                border-radius: 18px;
                padding: 36px 40px;
                display: flex;
                align-items: center;
                gap: 22px;
                margin-bottom: 22px;
                position: relative;
                overflow: hidden;
                animation: riseUp 0.5s cubic-bezier(.16,1,.3,1) both;
                box-shadow: 0 8px 32px rgba(108,63,197,0.25);
            }
            .profile-banner::before {
                content: '';
                position: absolute;
                width: 300px;
                height: 300px;
                border-radius: 50%;
                background: rgba(212,168,67,0.06);
                top: -120px;
                right: -60px;
            }
            .banner-avatar {
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
                color: #fff;
                flex-shrink: 0;
                border: 2.5px solid rgba(255,255,255,0.2);
                position: relative;
                z-index: 1;
            }
            .banner-info {
                position: relative;
                z-index: 1;
            }
            .banner-info h1 {
                font-family: 'Playfair Display', serif;
                font-size: 1.4rem;
                font-weight: 700;
                color: #fff;
                margin-bottom: 4px;
            }
            .banner-info p {
                font-size: 0.84rem;
                color: rgba(255,255,255,0.5);
            }
            .banner-id {
                margin-left: auto;
                position: relative;
                z-index: 1;
                background: rgba(255,255,255,0.07);
                border: 1px solid rgba(255,255,255,0.12);
                border-radius: 12px;
                padding: 10px 20px;
                text-align: center;
            }
            .banner-id .lbl {
                font-size: 0.65rem;
                color: rgba(255,255,255,0.4);
                text-transform: uppercase;
                letter-spacing: 1.2px;
                display: block;
                margin-bottom: 3px;
            }
            .banner-id .val {
                font-size: 1rem;
                font-weight: 700;
                color: var(--gold);
            }

            /* ─── CARDS ─── */
            .card-block {
                background: var(--white);
                border: 1px solid var(--border);
                border-radius: 16px;
                padding: 30px 34px;
                margin-bottom: 18px;
                box-shadow: 0 2px 12px rgba(108,63,197,0.06);
                animation: riseUp 0.5s cubic-bezier(.16,1,.3,1) both;
            }
            .card-block:nth-child(2) {
                animation-delay: 0.06s;
            }
            .card-block:nth-child(3) {
                animation-delay: 0.12s;
            }

            @keyframes riseUp {
                from {
                    opacity: 0;
                    transform: translateY(18px);
                }
                to   {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            .card-heading {
                display: flex;
                align-items: center;
                gap: 11px;
                font-size: 0.92rem;
                font-weight: 700;
                color: var(--text);
                margin-bottom: 22px;
                padding-bottom: 16px;
                border-bottom: 1px solid var(--border);
            }
            .card-heading-icon {
                width: 34px;
                height: 34px;
                background: var(--purple-light);
                border: 1px solid var(--border);
                border-radius: 8px;
                display: flex;
                align-items: center;
                justify-content: center;
                color: var(--purple);
                font-size: 0.9rem;
            }

            /* ─── INFO GRID ─── */
            .info-grid {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 12px;
            }
            .info-item {
                display: flex;
                align-items: flex-start;
                gap: 12px;
                background: var(--bg);
                border: 1px solid var(--border);
                border-radius: 12px;
                padding: 14px 16px;
            }
            .info-icon {
                width: 36px;
                height: 36px;
                background: var(--purple-light);
                border-radius: 8px;
                display: flex;
                align-items: center;
                justify-content: center;
                color: var(--purple);
                font-size: 1rem;
                flex-shrink: 0;
            }
            .info-label {
                display: block;
                font-size: 0.7rem;
                font-weight: 600;
                color: var(--muted);
                text-transform: uppercase;
                letter-spacing: 0.5px;
                margin-bottom: 3px;
            }
            .info-value {
                display: block;
                font-size: 0.88rem;
                font-weight: 600;
                color: var(--text);
            }
            .info-empty {
                font-style: normal;
                font-weight: 400;
                color: var(--muted);
                font-size: 0.82rem;
            }

            /* ─── FORM ─── */
            .field-label {
                display: block;
                font-size: 0.76rem;
                font-weight: 600;
                color: var(--muted);
                text-transform: uppercase;
                letter-spacing: 0.6px;
                margin-bottom: 6px;
            }
            .field-input, select.field-input {
                font-family: 'DM Sans', sans-serif;
                font-size: 0.875rem;
                width: 100%;
                border: 1.5px solid var(--border);
                border-radius: 8px;
                padding: 10px 13px;
                color: var(--text);
                background: var(--bg);
                transition: border-color 0.15s, box-shadow 0.15s, background 0.15s;
                appearance: none;
                -webkit-appearance: none;
            }
            .field-input:focus, select.field-input:focus {
                border-color: var(--purple);
                box-shadow: 0 0 0 3px rgba(108,63,197,0.12);
                background: #fff;
                outline: none;
            }
            .field-input::placeholder {
                color: #C0BAD9;
            }
            .select-wrap {
                position: relative;
            }
            .select-wrap::after {
                content: '\F282';
                font-family: 'bootstrap-icons';
                position: absolute;
                right: 12px;
                top: 50%;
                transform: translateY(-50%);
                color: var(--muted);
                font-size: 0.78rem;
                pointer-events: none;
            }
            .pw-wrap {
                position: relative;
            }
            .pw-toggle {
                position: absolute;
                right: 11px;
                top: 50%;
                transform: translateY(-50%);
                background: none;
                border: none;
                color: var(--muted);
                cursor: pointer;
                font-size: 0.95rem;
                padding: 0;
                line-height: 1;
                transition: color 0.12s;
            }
            .pw-toggle:hover {
                color: var(--purple);
            }
            .pw-wrap .field-input {
                padding-right: 36px;
            }

            .field-row {
                display: grid;
                gap: 16px;
            }
            .field-row.cols-2 {
                grid-template-columns: 1fr 1fr;
            }
            .field-row.cols-3 {
                grid-template-columns: 1fr 1fr 1fr;
            }
            .field-group {
                display: flex;
                flex-direction: column;
            }

            /* ─── BUTTONS ─── */
            .btn-primary {
                font-family: 'DM Sans', sans-serif;
                font-size: 0.875rem;
                font-weight: 700;
                background: var(--purple);
                color: #fff;
                border: none;
                padding: 11px 28px;
                border-radius: 8px;
                cursor: pointer;
                display: inline-flex;
                align-items: center;
                gap: 7px;
                transition: all 0.15s;
                box-shadow: 0 4px 16px rgba(108,63,197,0.3);
            }
            .btn-primary:hover {
                background: var(--purple-dark);
                transform: translateY(-1px);
                box-shadow: 0 6px 20px rgba(108,63,197,0.4);
            }
            .btn-ghost {
                font-family: 'DM Sans', sans-serif;
                font-size: 0.875rem;
                font-weight: 600;
                background: transparent;
                color: var(--muted);
                border: 1.5px solid var(--border);
                padding: 11px 22px;
                border-radius: 8px;
                cursor: pointer;
                display: inline-flex;
                align-items: center;
                gap: 7px;
                text-decoration: none;
                transition: all 0.15s;
            }
            .btn-ghost:hover {
                border-color: var(--purple);
                background: var(--purple-light);
                color: var(--purple);
            }
            .actions-row {
                display: flex;
                align-items: center;
                gap: 10px;
                margin-top: 24px;
                flex-wrap: wrap;
            }

            /* ─── ALERTS ─── */
            .alert-ok, .alert-err {
                display: flex;
                align-items: center;
                gap: 9px;
                border-radius: 8px;
                padding: 11px 14px;
                font-size: 0.84rem;
                font-weight: 500;
                margin-top: 18px;
            }
            .alert-ok {
                background: var(--success-bg);
                border: 1px solid var(--success-border);
                color: var(--success);
            }
            .alert-err {
                background: var(--error-bg);
                border: 1px solid var(--error-border);
                color: var(--error);
            }

            @media (max-width: 768px) {
                .navbar-main {
                    padding: 0 20px;
                }
                .page-wrap {
                    margin: 22px auto 40px;
                }
                .profile-banner {
                    flex-direction: column;
                    text-align: center;
                    padding: 28px 24px;
                    gap: 16px;
                }
                .banner-id {
                    margin-left: 0;
                }
                .card-block {
                    padding: 22px 18px;
                }
                .nav-links {
                    display: none;
                }
                .field-row.cols-2, .field-row.cols-3 {
                    grid-template-columns: 1fr;
                }
                .info-grid {
                    grid-template-columns: 1fr;
                }
                .dropdown-menu-custom {
                    right: 16px;
                }
            }

            /* PAGE */
            .page-wrap{
                max-width:1100px;
                margin:auto;
                padding:30px 20px;
            }

            /* TITLE */
            .page-title{
                font-size:28px;
                font-weight:700;
                margin-bottom:30px;
                display:flex;
                align-items:center;
                gap:10px;
            }

            .page-title i{
                color:#6c63ff;
            }

            /* GRID */
            .cert-grid{
                display:grid;
                grid-template-columns:repeat(auto-fill,minmax(250px,1fr));
                gap:24px;
            }

            /* CARD */
            .cert-card{
                background:#fff;
                border-radius:14px;
                padding:28px 20px;
                text-align:center;
                border:1px solid #eee;
                transition:all .25s ease;
                box-shadow:0 4px 15px rgba(0,0,0,0.05);
            }

            .cert-card:hover{
                transform:translateY(-6px);
                box-shadow:0 10px 25px rgba(0,0,0,0.1);
            }

            /* ICON */
            .cert-icon{
                font-size:42px;
                color:#6c63ff;
                margin-bottom:14px;
            }

            /* NAME */
            .cert-name{
                font-weight:600;
                font-size:16px;
                margin-bottom:6px;
            }

            /* DATE */
            .cert-date{
                font-size:14px;
                color:#777;
                margin-bottom:18px;
            }

            /* BUTTON */
            .btn-view{
                display:inline-block;
                padding:8px 18px;
                border-radius:8px;
                background:#6c63ff;
                color:#fff;
                text-decoration:none;
                font-size:14px;
                font-weight:500;
                transition:.2s;
            }

            .btn-view:hover{
                background:#574ee3;
            }

            /* EMPTY */
            .empty{
                text-align:center;
                padding:60px 20px;
                color:#777;
            }

            .empty i{
                color:#bbb;
                margin-bottom:10px;
            }
        </style>
    </head>
    <body>

        <c:if test="${empty sessionScope.user}">
            <c:redirect url="login.jsp"/>
        </c:if>

        <!-- NAVBAR -->
        <nav class="navbar-main" style="position:relative;">
            <a href="homePage.jsp" class="brand">DUK<span>Academy</span></a>
            <ul class="nav-links">
                <li><a href="homePage.jsp">Trang Chủ</a></li>
                <li><a href="mainController?action=ExploreCourse">Khóa học</a></li>
                <li><a href="instructors.jsp">Giảng viên</a></li>
                    <c:if test="${sessionScope.user.role == 1}">
                    <li><a href="administrator.jsp">Administrator Manager</a></li>
                    </c:if>
                    <c:if test="${sessionScope.user != null && sessionScope.user.role == 2}">
                    <li>
                        <a href="instructorDashboard.jsp">
                            Instructor Manager
                        </a>
                    </li>
                </c:if>
                <li><a href="about.jsp">Thông tin Chung</a></li>

            </ul>
            <div class="nav-right">
                <%-- BALANCE PILL --%>
                <a href="paymentController" class="balance-pill">
                    <i class="bi bi-wallet2"></i>
                    <span class="balance-label">Số dư</span>
                    <span class="balance-amount">
                        <%= fmtBal(session.getAttribute("user") != null ? ((model.UserDTO) session.getAttribute("user")).getBalance() : null)%> ₫
                    </span>
                </a>

                <%-- WISHLIST PILL --%>
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
                                                <img src="${pageContext.request.contextPath}/img/courses/course${wc.courseId}.jpg"
                                                     alt="${wc.courseName}" onerror="this.style.display='none';">
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
                    <a href="wishlistController?action=view&userId=${sessionScope.user.userId}"><i class="bi bi-heart"></i> Yêu thích</a>
                    <div class="divider-drop"></div>
                    <a href="mainController?action=logout" class="logout-link"><i class="bi bi-box-arrow-right"></i> Đăng xuất</a>
                </div>
            </div>
        </nav>

        <!-- PAGE -->

        <div class="page-wrap">

            <div class="page-title">
                <i class="bi bi-award"></i>
                Chứng chỉ của tôi
            </div>

            <c:choose>

                <c:when test="${not empty certList}">

                    <div class="cert-grid">

                        <c:forEach var="c" items="${certList}">

                            <div class="cert-card">

                                <div class="cert-icon">
                                    <i class="bi bi-patch-check-fill"></i>
                                </div>

                                <div class="cert-name">
                                    Course ID: ${c.courseId}
                                </div>

                                <div class="cert-date">
                                    Issued: ${c.issueDate}
                                </div>

                                <a class="btn-view"
                                   href="certificate?courseId=${c.courseId}">
                                    Xem chứng chỉ
                                </a>

                            </div>

                        </c:forEach>

                    </div>

                </c:when>


                <c:otherwise>

                    <div class="empty">

                        <i class="bi bi-award" style="font-size:70px"></i>

                        <p>Bạn chưa có chứng chỉ nào</p>

                    </div>

                </c:otherwise>

            </c:choose>


        </div>

        <script>
            /* USER DROPDOWN */
            function toggleDD() {
                const dd = document.getElementById("userDD");
                dd.classList.toggle("show");
            }

            /* WISHLIST DROPDOWN */
            function toggleWishlistDD(e) {
                e.stopPropagation();
                const wd = document.getElementById("wishlistDD");
                wd.classList.toggle("show");
            }

            /* CLICK OUTSIDE TO CLOSE */
            document.addEventListener("click", function (e) {

                const userMenu = document.querySelector(".user-menu");
                const userDD = document.getElementById("userDD");

                const wishWrap = document.getElementById("wishlistWrap");
                const wishDD = document.getElementById("wishlistDD");

                if (userDD && userMenu && !userMenu.contains(e.target) && !userDD.contains(e.target)) {
                    userDD.classList.remove("show");
                }

                if (wishDD && wishWrap && !wishWrap.contains(e.target)) {
                    wishDD.classList.remove("show");
                }

            });
        </script>

    </body>

</html>