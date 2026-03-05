<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Khóa học - DUK Academy</title>
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
            --bg:          #F4F0FC;
        }
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'DM Sans', sans-serif; color: var(--text); background: var(--bg); }

        /* NAVBAR */
        .navbar-main { background: var(--purple-deep); padding: 0 48px; height: 68px; display: flex; align-items: center; justify-content: space-between; position: sticky; top: 0; z-index: 100; box-shadow: 0 2px 20px rgba(0,0,0,0.25); }
        .brand { font-family: 'Playfair Display', serif; font-size: 1.55rem; font-weight: 700; color: #fff; text-decoration: none; }
        .brand span { color: var(--gold); }
        .nav-links { display: flex; align-items: center; gap: 4px; list-style: none; }
        .nav-links a { font-size: 0.9rem; font-weight: 500; color: rgba(255,255,255,0.75); text-decoration: none; padding: 7px 14px; border-radius: 6px; transition: background 0.15s, color 0.15s; }
        .nav-links a:hover, .nav-links a.active { background: rgba(255,255,255,0.1); color: #fff; }
        .nav-right { display: flex; align-items: center; gap: 12px; }
        .search-bar { display: flex; align-items: center; background: rgba(255,255,255,0.1); border: 1px solid rgba(255,255,255,0.15); border-radius: 8px; padding: 7px 14px; gap: 8px; }
        .search-bar input { background: none; border: none; outline: none; color: #fff; font-size: 0.875rem; font-family: 'DM Sans', sans-serif; width: 180px; }
        .search-bar input::placeholder { color: rgba(255,255,255,0.5); }
        .search-bar i { color: rgba(255,255,255,0.6); }
        .balance-pill { display: flex; align-items: center; gap: 7px; background: rgba(212,168,67,0.12); border: 1px solid rgba(212,168,67,0.35); border-radius: 8px; padding: 7px 14px; text-decoration: none; }
        .balance-pill i { color: var(--gold); }
        .balance-label { font-size: 0.75rem; font-weight: 500; color: rgba(255,255,255,0.6); }
        .balance-amount { font-size: 0.875rem; font-weight: 700; color: var(--gold); }
        .user-menu { display: flex; align-items: center; gap: 10px; cursor: pointer; padding: 6px 12px; border-radius: 8px; border: 1px solid rgba(255,255,255,0.15); transition: background 0.15s; }
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

        /* PAGE HEADER */
        .page-header { background: linear-gradient(135deg, var(--purple-deep) 0%, #3A1A7A 60%, #5B2DC5 100%); padding: 48px 80px 52px; position: relative; overflow: hidden; }
        .page-header::before { content: ''; position: absolute; width: 400px; height: 400px; border-radius: 50%; background: rgba(212,168,67,0.06); top: -150px; right: -80px; }
        .page-header::after { content: ''; position: absolute; width: 200px; height: 200px; border-radius: 50%; background: rgba(155,114,232,0.1); bottom: -60px; left: 200px; }
        .page-header-inner { position: relative; z-index: 1; }
        .page-eyebrow { font-size: 0.72rem; font-weight: 700; text-transform: uppercase; letter-spacing: 2px; color: var(--gold); margin-bottom: 10px; }
        .page-title { font-family: 'Playfair Display', serif; font-size: 2.4rem; font-weight: 700; color: #fff; margin-bottom: 10px; }
        .page-subtitle { font-size: 1rem; color: rgba(255,255,255,0.65); max-width: 480px; }
        .stats-row { display: flex; gap: 32px; margin-top: 28px; }
        .stat-num { font-size: 1.5rem; font-weight: 700; color: var(--gold); }
        .stat-lbl { font-size: 0.78rem; color: rgba(255,255,255,0.55); margin-top: 2px; }

        /* FILTER BAR */
        .filter-bar { background: #fff; border-bottom: 1px solid var(--border); padding: 14px 80px; display: flex; align-items: center; gap: 10px; flex-wrap: wrap; }
        .filter-chip { display: inline-flex; align-items: center; gap: 6px; padding: 6px 16px; border-radius: 20px; font-size: 0.82rem; font-weight: 600; border: 1.5px solid var(--border); background: #fff; color: var(--muted); cursor: pointer; transition: all 0.15s; }
        .filter-chip:hover { border-color: var(--purple); color: var(--purple); }
        .filter-chip.active { background: var(--purple); border-color: var(--purple); color: #fff; }
        .filter-label { font-size: 0.82rem; font-weight: 600; color: var(--muted); margin-right: 4px; }

        /* MAIN */
        .main-content { padding: 40px 80px 60px; }
        .alert-custom { display: flex; align-items: center; gap: 10px; padding: 12px 18px; border-radius: 10px; font-size: 0.875rem; font-weight: 500; margin-bottom: 24px; }
        .alert-error { background: #FFF3F3; border: 1px solid #FFCDD2; color: #C62828; }
        .alert-warn  { background: #FFF8E1; border: 1px solid #FFE082; color: #E65100; }

        /* TRENDING */
        .trending-section { margin-bottom: 48px; }
        .trending-title { font-family: 'Playfair Display', serif; font-size: 1.5rem; font-weight: 700; color: var(--text); margin-bottom: 20px; display: flex; align-items: center; gap: 10px; }
        .trending-title i { color: var(--purple); font-size: 1.3rem; }
        .trending-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 20px; }
        .trending-col { background: #EEE8FA; border-radius: 14px; padding: 20px; border: 1px solid rgba(108,63,197,0.1); }
        .trending-col-header { display: flex; align-items: center; justify-content: space-between; margin-bottom: 16px; }
        .trending-col-title { font-size: 0.92rem; font-weight: 700; color: var(--purple-dark); }
        .trending-col-link { font-size: 0.78rem; font-weight: 600; color: var(--purple); text-decoration: none; display: flex; align-items: center; gap: 3px; }
        .trending-col-link:hover { color: var(--purple-dark); }
        .mini-course-card { background: #fff; border-radius: 10px; padding: 12px; display: flex; gap: 12px; align-items: center; margin-bottom: 10px; text-decoration: none; color: var(--text); border: 1px solid transparent; transition: border-color 0.15s, box-shadow 0.15s; cursor: pointer; }
        .mini-course-card:last-child { margin-bottom: 0; }
        .mini-course-card:hover { border-color: var(--purple-mid); box-shadow: 0 4px 16px rgba(108,63,197,0.1); color: var(--text); }
        .mini-thumb { width: 60px; height: 60px; border-radius: 8px; overflow: hidden; flex-shrink: 0; background: linear-gradient(135deg, var(--purple-deep), var(--purple)); display: flex; align-items: center; justify-content: center; font-size: 1.4rem; }
        .mini-thumb img { width: 100%; height: 100%; object-fit: cover; }
        .mini-info { flex: 1; min-width: 0; }
        .mini-org { font-size: 0.65rem; font-weight: 700; color: var(--muted); text-transform: uppercase; letter-spacing: 0.5px; margin-bottom: 3px; display: flex; align-items: center; gap: 4px; }
        .mini-name { font-size: 0.82rem; font-weight: 700; color: var(--text); line-height: 1.35; margin-bottom: 5px; }
        .mini-meta { font-size: 0.68rem; color: var(--muted); display: flex; align-items: center; gap: 6px; }
        .mini-star { color: var(--gold); }
        .mini-price { font-size: 0.75rem; font-weight: 700; color: var(--purple); white-space: nowrap; flex-shrink: 0; }

        /* ALL COURSES */
        .all-courses-header { display: flex; align-items: center; justify-content: space-between; margin-bottom: 20px; }
        .all-courses-title { font-family: 'Playfair Display', serif; font-size: 1.5rem; font-weight: 700; color: var(--text); }
        .course-count-badge { background: var(--purple-light); color: var(--purple); font-size: 0.78rem; font-weight: 700; padding: 4px 12px; border-radius: 20px; }
        .course-grid-full { display: grid; grid-template-columns: repeat(4, 1fr); gap: 20px; }
        .course-card-full { background: #fff; border: 1px solid var(--border); border-radius: 14px; overflow: hidden; color: var(--text); transition: box-shadow 0.2s, transform 0.2s; display: flex; flex-direction: column; }
        .course-card-full:hover { box-shadow: 0 12px 36px rgba(108,63,197,0.15); transform: translateY(-4px); }
        .card-thumb { height: 150px; overflow: hidden; position: relative; background: linear-gradient(135deg, var(--purple-deep), var(--purple)); display: flex; align-items: center; justify-content: center; font-size: 3rem; }
        .card-thumb img { width: 100%; height: 100%; object-fit: cover; object-position: center; position: absolute; top: 0; left: 0; }
        .card-thumb-overlay { position: absolute; inset: 0; background: linear-gradient(to top, rgba(30,10,74,0.5) 0%, transparent 60%); }
        .card-topic-badge { position: absolute; top: 10px; left: 10px; background: rgba(255,255,255,0.92); color: var(--purple); font-size: 0.62rem; font-weight: 700; padding: 3px 9px; border-radius: 4px; text-transform: uppercase; letter-spacing: 0.5px; }
        .card-body { padding: 16px; flex: 1; display: flex; flex-direction: column; }
        .card-org { font-size: 0.68rem; font-weight: 700; color: var(--muted); text-transform: uppercase; letter-spacing: 0.5px; margin-bottom: 6px; }
        .card-name { font-size: 0.88rem; font-weight: 700; line-height: 1.4; color: var(--text); margin-bottom: 10px; flex: 1; }
        .card-meta { display: flex; align-items: center; gap: 6px; font-size: 0.72rem; color: var(--muted); margin-bottom: 12px; }
        .card-stars { color: var(--gold); font-size: 0.7rem; }
        .card-footer-row { display: flex; align-items: center; justify-content: space-between; padding-top: 12px; border-top: 1px solid var(--border); }
        .card-price { font-size: 1rem; font-weight: 700; color: var(--purple); }
        .card-price.free { color: #2E7D32; }
        .card-enroll-btn { background: var(--purple); color: #fff; border: none; padding: 7px 16px; border-radius: 7px; font-size: 0.78rem; font-weight: 700; cursor: pointer; transition: background 0.15s, transform 0.1s; font-family: 'DM Sans', sans-serif; }
        .card-enroll-btn:hover { background: var(--purple-dark); transform: translateY(-1px); }
        .card-enrolled-badge { display: inline-flex; align-items: center; gap: 5px; background: #E8F5E9; color: #2E7D32; font-size: 0.75rem; font-weight: 700; padding: 7px 12px; border-radius: 7px; border: 1px solid #C8E6C9; }
        .card-study-btn { display: inline-flex; align-items: center; gap: 6px; background: linear-gradient(135deg, #2E7D32, #388E3C); color: #fff; font-size: 0.78rem; font-weight: 700; padding: 7px 16px; border-radius: 7px; text-decoration: none; transition: all 0.15s; }
        .card-study-btn:hover { background: linear-gradient(135deg, #1B5E20, #2E7D32); transform: translateY(-1px); box-shadow: 0 4px 14px rgba(46,125,50,0.35); color: #fff; }
        .card-price.enrolled-label { font-size: 0.72rem; font-weight: 700; color: #2E7D32; background: #E8F5E9; padding: 4px 10px; border-radius: 20px; border: 1px solid #C8E6C9; }
        .card-login-link { font-size: 0.78rem; font-weight: 600; color: var(--purple); text-decoration: none; }
        .card-login-link:hover { text-decoration: underline; }
        .empty-state { text-align: center; padding: 80px 20px; grid-column: 1 / -1; }
        .empty-icon { font-size: 4rem; margin-bottom: 16px; opacity: 0.4; }
        .empty-title { font-size: 1.2rem; font-weight: 700; color: var(--muted); margin-bottom: 8px; }
        .empty-sub { font-size: 0.9rem; color: var(--muted); }
        .bg1 { background: linear-gradient(135deg, #1E0A4A, #6C3FC5); }
        .bg2 { background: linear-gradient(135deg, #3A1A7A, #9B72E8); }
        .bg3 { background: linear-gradient(135deg, #4E2C96, #D4A843); }
        .bg4 { background: linear-gradient(135deg, #1A0D35, #5B2DC5); }
        .bg5 { background: linear-gradient(135deg, #0D47A1, #1565C0); }
        .bg6 { background: linear-gradient(135deg, #1B5E20, #388E3C); }

        /* ===== MODAL XÁC NHẬN ===== */
        .modal-overlay { display: none; position: fixed; inset: 0; background: rgba(10,5,30,0.65); backdrop-filter: blur(5px); z-index: 1000; align-items: center; justify-content: center; }
        .modal-overlay.show { display: flex; }
        .modal-box { background: #fff; border-radius: 20px; padding: 36px; width: 440px; max-width: 95vw; box-shadow: 0 24px 64px rgba(108,63,197,0.3); animation: modalIn 0.25s cubic-bezier(0.34,1.56,0.64,1); }
        @keyframes modalIn { from { transform: scale(0.88) translateY(24px); opacity: 0; } to { transform: scale(1) translateY(0); opacity: 1; } }
        .modal-icon { width: 58px; height: 58px; border-radius: 16px; background: var(--purple-light); display: flex; align-items: center; justify-content: center; font-size: 1.7rem; margin-bottom: 18px; }
        .modal-title { font-family: 'Playfair Display', serif; font-size: 1.35rem; font-weight: 700; color: var(--text); margin-bottom: 6px; }
        .modal-course-name { font-size: 0.88rem; font-weight: 600; color: var(--purple); margin-bottom: 22px; line-height: 1.4; }
        .modal-info-row { display: flex; justify-content: space-between; align-items: center; background: var(--bg); border-radius: 10px; padding: 13px 16px; margin-bottom: 8px; }
        .modal-info-label { font-size: 0.82rem; color: var(--muted); font-weight: 500; display: flex; align-items: center; gap: 6px; }
        .modal-info-value { font-size: 0.9rem; font-weight: 700; }
        .modal-info-value.fee-val     { color: var(--purple); font-size: 1rem; }
        .modal-info-value.balance-val { color: #2E7D32; }
        .modal-info-value.after-val   { color: var(--gold); }
        .modal-info-value.danger-val  { color: #C62828; }
        .modal-divider { height: 1px; background: var(--border); margin: 14px 0; }
        .modal-actions { display: flex; gap: 10px; margin-top: 22px; }
        .btn-cancel { flex: 1; padding: 12px; border-radius: 10px; border: 1.5px solid var(--border); background: #fff; color: var(--muted); font-size: 0.88rem; font-weight: 700; cursor: pointer; font-family: 'DM Sans', sans-serif; transition: all 0.15s; }
        .btn-cancel:hover { border-color: var(--purple); color: var(--purple); }
        .btn-confirm { flex: 2; padding: 12px; border-radius: 10px; border: none; background: linear-gradient(135deg, var(--purple), var(--purple-dark)); color: #fff; font-size: 0.88rem; font-weight: 700; cursor: pointer; font-family: 'DM Sans', sans-serif; transition: all 0.15s; display: flex; align-items: center; justify-content: center; gap: 8px; }
        .btn-confirm:hover:not(:disabled) { transform: translateY(-1px); box-shadow: 0 6px 20px rgba(108,63,197,0.4); }
        .btn-confirm:disabled { opacity: 0.5; cursor: not-allowed; }
        .modal-warning { display: none; background: #FFF3F3; border: 1px solid #FFCDD2; border-radius: 8px; padding: 10px 14px; margin-top: 12px; font-size: 0.82rem; color: #C62828; font-weight: 600; }

        @media (max-width: 1200px) { .course-grid-full { grid-template-columns: repeat(3, 1fr); } .trending-grid { grid-template-columns: repeat(2, 1fr); } }
        @media (max-width: 900px) { .course-grid-full { grid-template-columns: repeat(2, 1fr); } .trending-grid { grid-template-columns: 1fr; } .main-content, .page-header, .filter-bar { padding-left: 20px; padding-right: 20px; } .navbar-main { padding: 0 20px; } .search-bar { display: none; } }
        @media (max-width: 600px) { .course-grid-full { grid-template-columns: 1fr; } }
    </style>
</head>
<body>

    <!-- NAVBAR -->
    <nav class="navbar-main" style="position:relative;">
        <a href="homePage.jsp" class="brand">DUK<span>Academy</span></a>
        <ul class="nav-links">
            <li><a href="homePage.jsp">Trang chủ</a></li>
            <li><a href="courseController?action=ExploreCourse" class="active">Khóa học</a></li>
            <li><a href="instructors.jsp">Giảng viên</a></li>
            <li><a href="#">Về chúng tôi</a></li>
            <li><a href="dating.jsp">study and date</a></li>
        </ul>
        <div class="nav-right">
            <div class="search-bar">
                <i class="bi bi-search"></i>
                <input type="text" placeholder="Tìm khóa học..." id="searchInput" oninput="filterCourses()">
            </div>
            <c:if test="${not empty sessionScope.user}">
                <%-- Bấm vào số dư → đến trang nạp tiền --%>
                <a href="payment.jsp" class="balance-pill">
                    <i class="bi bi-wallet2"></i>
                    <span class="balance-label">Số dư</span>
                    <span class="balance-amount">
                        <fmt:formatNumber value="${sessionScope.user.balance}" type="number"/> ₫
                    </span>
                </a>
            </c:if>
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <div class="user-menu" onclick="toggleDropdown()">
                        <div class="user-avatar">${fn:substring(sessionScope.user.fullname, 0, 1)}</div>
                        <span class="user-name">${sessionScope.user.fullname}</span>
                        <i class="bi bi-chevron-down" style="color:rgba(255,255,255,0.6); font-size:0.75rem;"></i>
                    </div>
                    <div class="dropdown-menu-custom" id="userDropdown">
                        <a href="myprofile.jsp"><i class="bi bi-person"></i> Hồ sơ của tôi</a>
                        <a href="myCourses"><i class="bi bi-book"></i> Khóa học của tôi</a>
                        <a href="payment.jsp"><i class="bi bi-wallet2"></i> Nạp tiền</a>
                        <a href="Certificates.jsp"><i class="bi bi-award"></i> Chứng chỉ</a>
                        <a href="#"><i class="bi bi-gear"></i> Cài đặt</a>
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

    <!-- PAGE HEADER -->
    <div class="page-header">
        <div class="page-header-inner">
            <div class="page-eyebrow">✦ Thư viện khóa học</div>
            <h1 class="page-title">Khám phá & Học tập</h1>
            <p class="page-subtitle">Hàng trăm khóa học chất lượng cao từ các chuyên gia hàng đầu, học theo tốc độ của bạn.</p>
            <div class="stats-row">
                <div class="stat-item">
                    <div class="stat-num">${not empty COURSE_LIST ? COURSE_LIST.size() : 0}+</div>
                    <div class="stat-lbl">Khóa học</div>
                </div>
                <div class="stat-item"><div class="stat-num">50K+</div><div class="stat-lbl">Học viên</div></div>
                <div class="stat-item"><div class="stat-num">4.8 ★</div><div class="stat-lbl">Đánh giá TB</div></div>
            </div>
        </div>
    </div>

    <!-- FILTER BAR -->
    <div class="filter-bar">
        <span class="filter-label"><i class="bi bi-funnel"></i> Lọc:</span>
        <span class="filter-chip active" onclick="filterByTopic(this, '')">Tất cả</span>
        <span class="filter-chip" onclick="filterByTopic(this, 'ai')">🤖 AI & ML</span>
        <span class="filter-chip" onclick="filterByTopic(this, 'data')">📊 Data Science</span>
        <span class="filter-chip" onclick="filterByTopic(this, 'web')">💻 Web Dev</span>
        <span class="filter-chip" onclick="filterByTopic(this, 'design')">🎨 Design</span>
        <span class="filter-chip" onclick="filterByTopic(this, 'business')">💼 Business</span>
        <span class="filter-chip" onclick="filterByTopic(this, 'mobile')">📱 Mobile</span>
        <span class="filter-chip" onclick="filterByTopic(this, 'cloud')">☁️ Cloud</span>
        <span class="filter-chip" onclick="filterByTopic(this, 'security')">🔐 Security</span>
        <span class="filter-chip" onclick="filterByTopic(this, 'language')">🌐 Ngôn ngữ</span>
        <span class="filter-chip" onclick="filterByTopic(this, 'programming')">⌨️ Lập trình</span>
    </div>

    <!-- MAIN CONTENT -->
    <div class="main-content">
        <c:if test="${not empty enrollmessage}">
            <div class="alert-custom alert-error"><i class="bi bi-exclamation-circle-fill"></i> ${enrollmessage}</div>
        </c:if>
        <c:if test="${not empty msg}">
            <div class="alert-custom alert-warn"><i class="bi bi-info-circle-fill"></i> ${msg}</div>
        </c:if>

        <!-- TRENDING -->
        <div class="trending-section">
            <div class="trending-title"><i class="bi bi-fire"></i> Khóa học nổi bật</div>
            <div class="trending-grid">
                <div class="trending-col">
                    <div class="trending-col-header">
                        <span class="trending-col-title">🏆 Phổ biến nhất</span>
                        <a href="#all-courses" class="trending-col-link">Xem tất cả <i class="bi bi-arrow-right"></i></a>
                    </div>
                    <c:forEach var="course" items="${COURSE_LIST}" begin="0" end="2">
                        <div class="mini-course-card">
                            <div class="mini-thumb bg1"><img src="${pageContext.request.contextPath}/img/courses/course${course.courseId}.jpg" alt="${course.courseName}" onerror="this.style.display='none';"></div>
                            <div class="mini-info">
                                <div class="mini-org"><i class="bi bi-building"></i> DUK Academy</div>
                                <div class="mini-name">${course.courseName}</div>
                                <div class="mini-meta"><span class="mini-star">★★★★★</span><span>${course.topic}</span></div>
                            </div>
                            <div class="mini-price"><c:choose><c:when test="${course.fee == 0}">Miễn phí</c:when><c:otherwise><fmt:formatNumber value="${course.fee}" type="number"/> ₫</c:otherwise></c:choose></div>
                        </div>
                    </c:forEach>
                    <c:if test="${empty COURSE_LIST}">
                        <div class="mini-course-card"><div class="mini-thumb bg1">🤖</div><div class="mini-info"><div class="mini-org">DeepLearning.AI</div><div class="mini-name">Machine Learning Specialization</div><div class="mini-meta"><span class="mini-star">★★★★★</span><span>AI · ML</span></div></div><div class="mini-price">1.200.000 ₫</div></div>
                        <div class="mini-course-card"><div class="mini-thumb bg2">🐍</div><div class="mini-info"><div class="mini-org">ĐH Bách Khoa</div><div class="mini-name">Python cho Khoa học Dữ liệu</div><div class="mini-meta"><span class="mini-star">★★★★★</span><span>Data Science</span></div></div><div class="mini-price">980.000 ₫</div></div>
                        <div class="mini-course-card"><div class="mini-thumb bg3">🎨</div><div class="mini-info"><div class="mini-org">Google</div><div class="mini-name">Google UX Design</div><div class="mini-meta"><span class="mini-star">★★★★½</span><span>Design</span></div></div><div class="mini-price">850.000 ₫</div></div>
                    </c:if>
                </div>
                <div class="trending-col">
                    <div class="trending-col-header">
                        <span class="trending-col-title">✨ Mới nhất</span>
                        <a href="#all-courses" class="trending-col-link">Xem tất cả <i class="bi bi-arrow-right"></i></a>
                    </div>
                    <c:forEach var="course" items="${COURSE_LIST}" begin="3" end="5">
                        <div class="mini-course-card">
                            <div class="mini-thumb bg2"><img src="${pageContext.request.contextPath}/img/courses/course${course.courseId}.jpg" alt="${course.courseName}" onerror="this.style.display='none';"></div>
                            <div class="mini-info">
                                <div class="mini-org"><i class="bi bi-building"></i> DUK Academy</div>
                                <div class="mini-name">${course.courseName}</div>
                                <div class="mini-meta"><span class="mini-star">★★★★★</span><span>${course.topic}</span></div>
                            </div>
                            <div class="mini-price"><c:choose><c:when test="${course.fee == 0}">Miễn phí</c:when><c:otherwise><fmt:formatNumber value="${course.fee}" type="number"/> ₫</c:otherwise></c:choose></div>
                        </div>
                    </c:forEach>
                    <c:if test="${empty COURSE_LIST}">
                        <div class="mini-course-card"><div class="mini-thumb bg4">📈</div><div class="mini-info"><div class="mini-org">IBM</div><div class="mini-name">IBM Data Science Professional</div><div class="mini-meta"><span class="mini-star">★★★★★</span><span>Data Science</span></div></div><div class="mini-price">1.500.000 ₫</div></div>
                        <div class="mini-course-card"><div class="mini-thumb bg5">💻</div><div class="mini-info"><div class="mini-org">Meta</div><div class="mini-name">React Native Development</div><div class="mini-meta"><span class="mini-star">★★★★½</span><span>Web Dev</span></div></div><div class="mini-price">1.100.000 ₫</div></div>
                        <div class="mini-course-card"><div class="mini-thumb bg6">🌿</div><div class="mini-info"><div class="mini-org">Google</div><div class="mini-name">Google Cloud Fundamentals</div><div class="mini-meta"><span class="mini-star">★★★★★</span><span>Cloud</span></div></div><div class="mini-price">Miễn phí</div></div>
                    </c:if>
                </div>
                <div class="trending-col">
                    <div class="trending-col-header">
                        <span class="trending-col-title">🤖 Kỹ năng AI hot</span>
                        <a href="#all-courses" class="trending-col-link">Xem tất cả <i class="bi bi-arrow-right"></i></a>
                    </div>
                    <c:forEach var="course" items="${COURSE_LIST}" begin="6" end="8">
                        <div class="mini-course-card">
                            <div class="mini-thumb bg3"><img src="${pageContext.request.contextPath}/img/courses/course${course.courseId}.jpg" alt="${course.courseName}" onerror="this.style.display='none';"></div>
                            <div class="mini-info">
                                <div class="mini-org"><i class="bi bi-building"></i> DUK Academy</div>
                                <div class="mini-name">${course.courseName}</div>
                                <div class="mini-meta"><span class="mini-star">★★★★★</span><span>${course.topic}</span></div>
                            </div>
                            <div class="mini-price"><c:choose><c:when test="${course.fee == 0}">Miễn phí</c:when><c:otherwise><fmt:formatNumber value="${course.fee}" type="number"/> ₫</c:otherwise></c:choose></div>
                        </div>
                    </c:forEach>
                    <c:if test="${empty COURSE_LIST}">
                        <div class="mini-course-card"><div class="mini-thumb bg1">🧠</div><div class="mini-info"><div class="mini-org">OpenAI</div><div class="mini-name">ChatGPT & Prompt Engineering</div><div class="mini-meta"><span class="mini-star">★★★★★</span><span>AI</span></div></div><div class="mini-price">750.000 ₫</div></div>
                        <div class="mini-course-card"><div class="mini-thumb bg2">🔬</div><div class="mini-info"><div class="mini-org">DeepMind</div><div class="mini-name">Deep Learning với TensorFlow</div><div class="mini-meta"><span class="mini-star">★★★★½</span><span>AI · ML</span></div></div><div class="mini-price">1.300.000 ₫</div></div>
                        <div class="mini-course-card"><div class="mini-thumb bg6">📷</div><div class="mini-info"><div class="mini-org">Stanford</div><div class="mini-name">Computer Vision Fundamentals</div><div class="mini-meta"><span class="mini-star">★★★★★</span><span>AI</span></div></div><div class="mini-price">Miễn phí</div></div>
                    </c:if>
                </div>
            </div>
        </div>

        <!-- ALL COURSES -->
        <div id="all-courses">
            <div class="all-courses-header">
                <div class="all-courses-title">Tất cả khóa học</div>
                <span class="course-count-badge" id="courseCount">${not empty COURSE_LIST ? COURSE_LIST.size() : 0} khóa học</span>
            </div>
            <div class="course-grid-full" id="courseGrid">
                <c:choose>
                    <c:when test="${not empty COURSE_LIST}">
                        <c:forEach var="course" items="${COURSE_LIST}" varStatus="st">
                            <div class="course-card-full" data-topic="${course.topic}" data-name="${course.courseName}">
                                <div class="card-thumb bg${(st.index % 6) + 1}">
                                    <img src="${pageContext.request.contextPath}/img/courses/course${course.courseId}.jpg" alt="${course.courseName}" onerror="this.style.display='none';">
                                    <div class="card-thumb-overlay"></div>
                                    <span class="card-topic-badge">${course.topic}</span>
                                </div>
                                <div class="card-body">
                                    <div class="card-org">DUK Academy</div>
                                    <div class="card-name">${course.courseName}</div>
                                    <div class="card-meta">
                                        <span class="card-stars">★★★★★</span>
                                        <span>4.8</span>
                                        <span>·</span>
                                        <span><i class="bi bi-people"></i> 1.2K học viên</span>
                                    </div>
                                    <div class="card-footer-row">
                                        <%-- Tính isEnrolled trước để dùng cho cả giá lẫn nút --%>
                                        <c:set var="isEnrolled" value="false"/>
                                        <c:if test="${not empty sessionScope.user}">
                                            <c:forEach var="eid" items="${ENROLLED_IDS}">
                                                <c:if test="${eid == course.courseId}">
                                                    <c:set var="isEnrolled" value="true"/>
                                                </c:if>
                                            </c:forEach>
                                        </c:if>

                                        <%-- Hiển thị giá hoặc "Đã thanh toán" --%>
                                        <c:choose>
                                            <c:when test="${isEnrolled}">
                                                <span class="card-price enrolled-label">
                                                    <i class="bi bi-check2-circle"></i> Đã thanh toán
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="card-price ${course.fee == 0 ? 'free' : ''}">
                                                    <c:choose>
                                                        <c:when test="${course.fee == 0}">Miễn phí</c:when>
                                                        <c:otherwise><fmt:formatNumber value="${course.fee}" type="number"/> VND</c:otherwise>
                                                    </c:choose>
                                                </span>
                                            </c:otherwise>
                                        </c:choose>

                                        <%-- Nút hành động --%>
                                        <c:choose>
                                            <c:when test="${empty sessionScope.user}">
                                                <a href="login.jsp" class="card-login-link">
                                                    <i class="bi bi-lock"></i> Đăng nhập
                                                </a>
                                            </c:when>
                                            <c:otherwise>
                                                <c:choose>
                                                    <c:when test="${isEnrolled}">
                                                        <a href="lesson?courseId=${course.courseId}" class="card-study-btn">
                                                            <i class="bi bi-play-circle-fill"></i> Vào học
                                                        </a>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <button type="button" class="card-enroll-btn"
                                                            onclick="openModal('${course.courseId}','${fn:escapeXml(course.courseName)}','${course.fee}','${sessionScope.user.balance}')">
                                                            <i class="bi bi-plus-circle"></i> Đăng ký
                                                        </button>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state">
                            <div class="empty-icon">📚</div>
                            <div class="empty-title">Chưa có khóa học nào</div>
                            <div class="empty-sub">Vui lòng quay lại sau hoặc liên hệ quản trị viên.</div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <!-- FOOTER -->
    <footer style="background: var(--purple-deep); padding: 32px 80px; margin-top: 40px;">
        <div style="display:flex; justify-content:space-between; align-items:center; border-top:1px solid rgba(255,255,255,0.08); padding-top:20px;">
            <span style="font-family:'Playfair Display',serif; font-size:1.2rem; font-weight:700; color:#fff;">DUK<span style="color:var(--gold);">Academy</span></span>
            <span style="font-size:0.78rem; color:rgba(255,255,255,0.35);">© 2026 DUK Academy. All rights reserved.</span>
        </div>
    </footer>

    <!-- ===== MODAL XÁC NHẬN ĐĂNG KÝ ===== -->
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
                <span class="modal-info-label"><i class="bi bi-arrow-right-circle-fill"></i> Số dư sau đăng ký</span>
                <span class="modal-info-value after-val" id="modalAfter">—</span>
            </div>

            <div class="modal-warning" id="modalWarning">
                <i class="bi bi-exclamation-triangle-fill"></i>
                Số dư không đủ! <a href="payment.jsp" style="color:#C62828; font-weight:700;">Nạp tiền ngay →</a>
            </div>

            <form id="enrollForm" action="enroll" method="post">
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
        /* DROPDOWN */
        function toggleDropdown() { document.getElementById('userDropdown').classList.toggle('show'); }
        document.addEventListener('click', function(e) {
            const menu = document.querySelector('.user-menu');
            const dd   = document.getElementById('userDropdown');
            if (dd && menu && !menu.contains(e.target) && !dd.contains(e.target)) dd.classList.remove('show');
        });

        /* MODAL */
        function fmt(val) { return Number(val).toLocaleString('vi-VN') + ' ₫'; }

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
                afterEl.textContent = 'Không đủ số dư!';
                afterEl.className   = 'modal-info-value danger-val';
                warnEl.style.display    = 'block';
                confirmEl.disabled      = true;
            } else {
                afterEl.textContent = fmt(after);
                afterEl.className   = 'modal-info-value after-val';
                warnEl.style.display    = 'none';
                confirmEl.disabled      = false;
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

        /* FILTER */
        const TOPIC_MAP = {
            ai:          ['ai', 'machine learning', 'ml', 'deep learning', 'neural', 'nlp', 'computer vision', 'tensorflow', 'pytorch', 'chatgpt', 'llm', 'generative', 'prompt'],
            data:        ['data', 'python', 'pandas', 'sql', 'analytics', 'statistics', 'tableau', 'power bi', 'excel', 'bi', 'hadoop', 'spark', 'etl'],
            web:         ['web', 'html', 'css', 'javascript', 'js', 'react', 'vue', 'angular', 'nodejs', 'php', 'laravel', 'django', 'flask', 'frontend', 'backend', 'fullstack', 'typescript', 'next.js', 'api', 'rest', 'java'],
            design:      ['design', 'ui', 'ux', 'figma', 'photoshop', 'illustrator', 'graphic', 'adobe', 'canva', 'sketch', 'prototype', 'wireframe'],
            mobile:      ['mobile', 'android', 'ios', 'flutter', 'react native', 'swift', 'kotlin', 'app'],
            cloud:       ['cloud', 'aws', 'azure', 'gcp', 'google cloud', 'devops', 'docker', 'kubernetes', 'ci/cd', 'linux', 'server', 'network'],
            security:    ['security', 'cybersecurity', 'hacking', 'ethical', 'pentest', 'firewall', 'encryption', 'blockchain', 'crypto'],
            language:    ['english', 'tiếng anh', 'giao tiếp', 'ielts', 'toeic', 'toefl', 'japanese', 'tiếng nhật', 'korean', 'tiếng hàn', 'chinese', 'tiếng trung', 'french', 'tiếng pháp', 'german', 'language', 'ngôn ngữ', 'communication', 'speaking', 'writing', 'grammar'],
            programming: ['java', 'c++', 'c#', 'golang', 'go lang', 'rust', 'ruby', 'scala', 'kotlin', 'swift', 'algorithm', 'data structure', 'cấu trúc dữ liệu', 'lập trình', 'programming', 'oop', 'design pattern', 'clean code'],
            business:    ['business', 'marketing', 'management', 'finance', 'accounting', 'hr', 'leadership', 'project management', 'scrum', 'agile', 'pmp', 'mba'],
        };

        function getTopicGroup(t) {
            t = (t || '').toLowerCase();
            for (const [g, kws] of Object.entries(TOPIC_MAP)) {
                if (kws.some(kw => t.includes(kw))) return g;
            }
            return t;
        }

        document.querySelectorAll('.course-card-full').forEach(c => {
            c.dataset.group = getTopicGroup(c.dataset.topic || '');
        });

        let currentGroup = '';

        function filterByTopic(el, group) {
            document.querySelectorAll('.filter-chip').forEach(c => c.classList.remove('active'));
            el.classList.add('active');
            currentGroup = group;
            applyFilters();
        }

        function filterCourses() { applyFilters(); }

        function applyFilters() {
            const search = (document.getElementById('searchInput')?.value || '').toLowerCase();
            let visible = 0;
            document.querySelectorAll('.course-card-full').forEach(card => {
                const ok = (!search || (card.dataset.name||'').toLowerCase().includes(search) || (card.dataset.topic||'').toLowerCase().includes(search))
                        && (!currentGroup || card.dataset.group === currentGroup);
                card.style.display = ok ? '' : 'none';
                if (ok) visible++;
            });
            const b = document.getElementById('courseCount');
            if (b) b.textContent = visible + ' khóa học';
        }
    </script>
</body>
</html>
