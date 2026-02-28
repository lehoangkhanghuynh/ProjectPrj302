<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.CourseDTO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Khóa học - KKKAcademy</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&family=DM+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
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

        /* ===== PAGE HEADER ===== */
        .page-header {
            background: linear-gradient(135deg, var(--purple-deep) 0%, #3A1A7A 60%, #5B2DC5 100%);
            padding: 48px 80px 52px;
            position: relative;
            overflow: hidden;
        }
        .page-header::before {
            content: '';
            position: absolute;
            width: 400px; height: 400px;
            border-radius: 50%;
            background: rgba(212,168,67,0.06);
            top: -150px; right: -80px;
        }
        .page-header::after {
            content: '';
            position: absolute;
            width: 200px; height: 200px;
            border-radius: 50%;
            background: rgba(155,114,232,0.1);
            bottom: -60px; left: 200px;
        }
        .page-header-inner { position: relative; z-index: 1; }
        .page-eyebrow { font-size: 0.72rem; font-weight: 700; text-transform: uppercase; letter-spacing: 2px; color: var(--gold); margin-bottom: 10px; }
        .page-title { font-family: 'Playfair Display', serif; font-size: 2.4rem; font-weight: 700; color: #fff; margin-bottom: 10px; }
        .page-subtitle { font-size: 1rem; color: rgba(255,255,255,0.65); max-width: 480px; }

        /* Stats row */
        .stats-row { display: flex; gap: 32px; margin-top: 28px; }
        .stat-item { }
        .stat-num { font-size: 1.5rem; font-weight: 700; color: var(--gold); }
        .stat-lbl { font-size: 0.78rem; color: rgba(255,255,255,0.55); margin-top: 2px; }

        /* Filter bar */
        .filter-bar {
            background: #fff;
            border-bottom: 1px solid var(--border);
            padding: 14px 80px;
            display: flex;
            align-items: center;
            gap: 10px;
            flex-wrap: wrap;
        }
        .filter-chip {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 6px 16px;
            border-radius: 20px;
            font-size: 0.82rem;
            font-weight: 600;
            border: 1.5px solid var(--border);
            background: #fff;
            color: var(--muted);
            cursor: pointer;
            transition: all 0.15s;
        }
        .filter-chip:hover { border-color: var(--purple); color: var(--purple); }
        .filter-chip.active { background: var(--purple); border-color: var(--purple); color: #fff; }
        .filter-label { font-size: 0.82rem; font-weight: 600; color: var(--muted); margin-right: 4px; }

        /* ===== MAIN CONTENT ===== */
        .main-content { padding: 40px 80px 60px; }

        /* Alert messages */
        .alert-custom {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 12px 18px;
            border-radius: 10px;
            font-size: 0.875rem;
            font-weight: 500;
            margin-bottom: 24px;
        }
        .alert-error { background: #FFF3F3; border: 1px solid #FFCDD2; color: #C62828; }
        .alert-warn  { background: #FFF8E1; border: 1px solid #FFE082; color: #E65100; }

        /* ===== TRENDING SECTION (3 columns like Coursera) ===== */
        .trending-section { margin-bottom: 48px; }
        .trending-title {
            font-family: 'Playfair Display', serif;
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--text);
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .trending-title i { color: var(--purple); font-size: 1.3rem; }

        .trending-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
        }

        .trending-col {
            background: #EEE8FA;
            border-radius: 14px;
            padding: 20px;
            border: 1px solid rgba(108,63,197,0.1);
        }

        .trending-col-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 16px;
        }
        .trending-col-title {
            font-size: 0.92rem;
            font-weight: 700;
            color: var(--purple-dark);
        }
        .trending-col-link {
            font-size: 0.78rem;
            font-weight: 600;
            color: var(--purple);
            text-decoration: none;
            display: flex;
            align-items: center;
            gap: 3px;
        }
        .trending-col-link:hover { color: var(--purple-dark); }

        /* Mini course card inside trending col */
        .mini-course-card {
            background: #fff;
            border-radius: 10px;
            padding: 12px;
            display: flex;
            gap: 12px;
            align-items: center;
            margin-bottom: 10px;
            text-decoration: none;
            color: var(--text);
            border: 1px solid transparent;
            transition: border-color 0.15s, box-shadow 0.15s;
            cursor: pointer;
        }
        .mini-course-card:last-child { margin-bottom: 0; }
        .mini-course-card:hover { border-color: var(--purple-mid); box-shadow: 0 4px 16px rgba(108,63,197,0.1); color: var(--text); }

        .mini-thumb {
            width: 60px;
            height: 60px;
            border-radius: 8px;
            overflow: hidden;
            flex-shrink: 0;
            background: linear-gradient(135deg, var(--purple-deep), var(--purple));
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.4rem;
        }
        .mini-thumb img { width: 100%; height: 100%; object-fit: cover; }

        .mini-info { flex: 1; min-width: 0; }
        .mini-org { font-size: 0.65rem; font-weight: 700; color: var(--muted); text-transform: uppercase; letter-spacing: 0.5px; margin-bottom: 3px; display: flex; align-items: center; gap: 4px; }
        .mini-name { font-size: 0.82rem; font-weight: 700; color: var(--text); line-height: 1.35; margin-bottom: 5px; }
        .mini-meta { font-size: 0.68rem; color: var(--muted); display: flex; align-items: center; gap: 6px; }
        .mini-star { color: var(--gold); }
        .mini-price {
            font-size: 0.75rem;
            font-weight: 700;
            color: var(--purple);
            white-space: nowrap;
            flex-shrink: 0;
        }

        /* ===== ALL COURSES GRID ===== */
        .all-courses-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 20px;
        }
        .all-courses-title {
            font-family: 'Playfair Display', serif;
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--text);
        }
        .course-count-badge {
            background: var(--purple-light);
            color: var(--purple);
            font-size: 0.78rem;
            font-weight: 700;
            padding: 4px 12px;
            border-radius: 20px;
        }

        .course-grid-full {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
        }

        .course-card-full {
            background: #fff;
            border: 1px solid var(--border);
            border-radius: 14px;
            overflow: hidden;
            text-decoration: none;
            color: var(--text);
            transition: box-shadow 0.2s, transform 0.2s;
            display: flex;
            flex-direction: column;
        }
        .course-card-full:hover {
            box-shadow: 0 12px 36px rgba(108,63,197,0.15);
            transform: translateY(-4px);
            color: var(--text);
        }

        .card-thumb {
            height: 150px;
            overflow: hidden;
            position: relative;
            background: linear-gradient(135deg, var(--purple-deep), var(--purple));
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 3rem;
        }
        .card-thumb img {
            width: 100%; height: 100%;
            object-fit: cover;
            object-position: center;
            position: absolute; top: 0; left: 0;
        }
        .card-thumb-overlay {
            position: absolute; inset: 0;
            background: linear-gradient(to top, rgba(30,10,74,0.5) 0%, transparent 60%);
        }
        .card-topic-badge {
            position: absolute;
            top: 10px; left: 10px;
            background: rgba(255,255,255,0.92);
            color: var(--purple);
            font-size: 0.62rem;
            font-weight: 700;
            padding: 3px 9px;
            border-radius: 4px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .card-body { padding: 16px; flex: 1; display: flex; flex-direction: column; }
        .card-org { font-size: 0.68rem; font-weight: 700; color: var(--muted); text-transform: uppercase; letter-spacing: 0.5px; margin-bottom: 6px; }
        .card-name { font-size: 0.88rem; font-weight: 700; line-height: 1.4; color: var(--text); margin-bottom: 10px; flex: 1; }
        .card-meta { display: flex; align-items: center; gap: 6px; font-size: 0.72rem; color: var(--muted); margin-bottom: 12px; }
        .card-stars { color: var(--gold); font-size: 0.7rem; }

        .card-footer-row {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding-top: 12px;
            border-top: 1px solid var(--border);
        }
        .card-price {
            font-size: 1rem;
            font-weight: 700;
            color: var(--purple);
        }
        .card-price.free { color: #2E7D32; }
        .card-enroll-btn {
            background: var(--purple);
            color: #fff;
            border: none;
            padding: 7px 16px;
            border-radius: 7px;
            font-size: 0.78rem;
            font-weight: 700;
            cursor: pointer;
            transition: background 0.15s, transform 0.1s;
            font-family: 'DM Sans', sans-serif;
        }
        .card-enroll-btn:hover { background: var(--purple-dark); transform: translateY(-1px); }
        .card-login-link {
            font-size: 0.78rem;
            font-weight: 600;
            color: var(--purple);
            text-decoration: none;
        }
        .card-login-link:hover { text-decoration: underline; }

        /* Empty state */
        .empty-state {
            text-align: center;
            padding: 80px 20px;
            grid-column: 1 / -1;
        }
        .empty-icon { font-size: 4rem; margin-bottom: 16px; opacity: 0.4; }
        .empty-title { font-size: 1.2rem; font-weight: 700; color: var(--muted); margin-bottom: 8px; }
        .empty-sub { font-size: 0.9rem; color: var(--muted); }

        /* Emoji colors for thumbs */
        .bg1 { background: linear-gradient(135deg, #1E0A4A, #6C3FC5); }
        .bg2 { background: linear-gradient(135deg, #3A1A7A, #9B72E8); }
        .bg3 { background: linear-gradient(135deg, #4E2C96, #D4A843); }
        .bg4 { background: linear-gradient(135deg, #1A0D35, #5B2DC5); }
        .bg5 { background: linear-gradient(135deg, #0D47A1, #1565C0); }
        .bg6 { background: linear-gradient(135deg, #1B5E20, #388E3C); }

        @media (max-width: 1200px) { .course-grid-full { grid-template-columns: repeat(3, 1fr); } .trending-grid { grid-template-columns: repeat(2, 1fr); } }
        @media (max-width: 900px) { .course-grid-full { grid-template-columns: repeat(2, 1fr); } .trending-grid { grid-template-columns: 1fr; } .main-content, .page-header, .filter-bar { padding-left: 20px; padding-right: 20px; } .navbar-main { padding: 0 20px; } .search-bar { display: none; } }
        @media (max-width: 600px) { .course-grid-full { grid-template-columns: 1fr; } }
    </style>
</head>
<body>

    <!-- NAVBAR -->
    <nav class="navbar-main" style="position:relative;">
        <a href="homePage.jsp" class="brand">KKK<span>Academy</span></a>
        <ul class="nav-links">
            <li><a href="homePage.jsp">Trang chủ</a></li>
            <li><a href="mainController?action=ExploreCourse" class="active">Khóa học</a></li>
            <li><a href="#">Giảng viên</a></li>
            <li><a href="#">Về chúng tôi</a></li>
        </ul>
        <div class="nav-right">
            <div class="search-bar">
                <i class="bi bi-search"></i>
                <input type="text" placeholder="Tìm khóa học..." id="searchInput" oninput="filterCourses()">
            </div>
            <c:if test="${not empty sessionScope.user}">
                <a href="#" class="balance-pill">
                    <i class="bi bi-wallet2"></i>
                    <span class="balance-label">Số dư</span>
                    <span class="balance-amount">${sessionScope.user.balance != null ? sessionScope.user.balance : '0'} ₫</span>
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
                        <a href="#"><i class="bi bi-person"></i> Hồ sơ của tôi</a>
                        <a href="mainController?action=MyCourse"><i class="bi bi-book"></i> Khóa học của tôi</a>
                        <a href="#"><i class="bi bi-award"></i> Chứng chỉ</a>
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
                <div class="stat-item">
                    <div class="stat-num">50K+</div>
                    <div class="stat-lbl">Học viên</div>
                </div>
                <div class="stat-item">
                    <div class="stat-num">4.8 ★</div>
                    <div class="stat-lbl">Đánh giá TB</div>
                </div>
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

        <!-- Alerts -->
        <c:if test="${not empty enrollmessage}">
            <div class="alert-custom alert-error"><i class="bi bi-exclamation-circle-fill"></i> ${enrollmessage}</div>
        </c:if>
        <c:if test="${not empty msg}">
            <div class="alert-custom alert-warn"><i class="bi bi-info-circle-fill"></i> ${msg}</div>
        </c:if>

        <!-- TRENDING SECTION -->
        <div class="trending-section">
            <div class="trending-title"><i class="bi bi-fire"></i> Khóa học nổi bật</div>
            <div class="trending-grid">
                <!-- Col 1: Phổ biến nhất -->
                <div class="trending-col">
                    <div class="trending-col-header">
                        <span class="trending-col-title">🏆 Phổ biến nhất</span>
                        <a href="#all-courses" class="trending-col-link">Xem tất cả <i class="bi bi-arrow-right"></i></a>
                    </div>
                    <c:forEach var="course" items="${COURSE_LIST}" begin="0" end="2">
                        <div class="mini-course-card">
                            <div class="mini-thumb bg1">
                                <img src="${pageContext.request.contextPath}/img/courses/course${course.courseId}.jpg"
                                     alt="${course.courseName}"
                                     onerror="this.style.display='none';">
                            </div>
                            <div class="mini-info">
                                <div class="mini-org"><i class="bi bi-building"></i> KKKAcademy</div>
                                <div class="mini-name">${course.courseName}</div>
                                <div class="mini-meta">
                                    <span class="mini-star">★★★★★</span>
                                    <span>${course.topic}</span>
                                </div>
                            </div>
                            <div class="mini-price">
                                <c:choose>
                                    <c:when test="${course.fee == 0}">Miễn phí</c:when>
                                    <c:otherwise><fmt:formatNumber value="${course.fee}" type="number"/> ₫</c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </c:forEach>
                    <c:if test="${empty COURSE_LIST}">
                        <div class="mini-course-card"><div class="mini-thumb bg1">🤖</div><div class="mini-info"><div class="mini-org">DeepLearning.AI</div><div class="mini-name">Machine Learning Specialization</div><div class="mini-meta"><span class="mini-star">★★★★★</span><span>AI · ML</span></div></div><div class="mini-price">1.200.000 ₫</div></div>
                        <div class="mini-course-card"><div class="mini-thumb bg2">🐍</div><div class="mini-info"><div class="mini-org">ĐH Bách Khoa</div><div class="mini-name">Python cho Khoa học Dữ liệu</div><div class="mini-meta"><span class="mini-star">★★★★★</span><span>Data Science</span></div></div><div class="mini-price">980.000 ₫</div></div>
                        <div class="mini-course-card"><div class="mini-thumb bg3">🎨</div><div class="mini-info"><div class="mini-org">Google</div><div class="mini-name">Google UX Design</div><div class="mini-meta"><span class="mini-star">★★★★½</span><span>Design</span></div></div><div class="mini-price">850.000 ₫</div></div>
                    </c:if>
                </div>

                <!-- Col 2: Mới nhất -->
                <div class="trending-col">
                    <div class="trending-col-header">
                        <span class="trending-col-title">✨ Mới nhất</span>
                        <a href="#all-courses" class="trending-col-link">Xem tất cả <i class="bi bi-arrow-right"></i></a>
                    </div>
                    <c:forEach var="course" items="${COURSE_LIST}" begin="3" end="5">
                        <div class="mini-course-card">
                            <div class="mini-thumb bg2">
                                <img src="${pageContext.request.contextPath}/img/courses/course${course.courseId}.jpg"
                                     alt="${course.courseName}"
                                     onerror="this.style.display='none';">
                            </div>
                            <div class="mini-info">
                                <div class="mini-org"><i class="bi bi-building"></i> KKKAcademy</div>
                                <div class="mini-name">${course.courseName}</div>
                                <div class="mini-meta"><span class="mini-star">★★★★★</span><span>${course.topic}</span></div>
                            </div>
                            <div class="mini-price">
                                <c:choose>
                                    <c:when test="${course.fee == 0}">Miễn phí</c:when>
                                    <c:otherwise><fmt:formatNumber value="${course.fee}" type="number"/> ₫</c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </c:forEach>
                    <c:if test="${empty COURSE_LIST}">
                        <div class="mini-course-card"><div class="mini-thumb bg4">📈</div><div class="mini-info"><div class="mini-org">IBM</div><div class="mini-name">IBM Data Science Professional</div><div class="mini-meta"><span class="mini-star">★★★★★</span><span>Data Science</span></div></div><div class="mini-price">1.500.000 ₫</div></div>
                        <div class="mini-course-card"><div class="mini-thumb bg5">💻</div><div class="mini-info"><div class="mini-org">Meta</div><div class="mini-name">React Native Development</div><div class="mini-meta"><span class="mini-star">★★★★½</span><span>Web Dev</span></div></div><div class="mini-price">1.100.000 ₫</div></div>
                        <div class="mini-course-card"><div class="mini-thumb bg6">🌿</div><div class="mini-info"><div class="mini-org">Google</div><div class="mini-name">Google Cloud Fundamentals</div><div class="mini-meta"><span class="mini-star">★★★★★</span><span>Cloud</span></div></div><div class="mini-price">Miễn phí</div></div>
                    </c:if>
                </div>

                <!-- Col 3: Kỹ năng AI -->
                <div class="trending-col">
                    <div class="trending-col-header">
                        <span class="trending-col-title">🤖 Kỹ năng AI hot</span>
                        <a href="#all-courses" class="trending-col-link">Xem tất cả <i class="bi bi-arrow-right"></i></a>
                    </div>
                    <c:forEach var="course" items="${COURSE_LIST}" begin="6" end="8">
                        <div class="mini-course-card">
                            <div class="mini-thumb bg3">
                                <img src="${pageContext.request.contextPath}/img/courses/course${course.courseId}.jpg"
                                     alt="${course.courseName}"
                                     onerror="this.style.display='none';">
                            </div>
                            <div class="mini-info">
                                <div class="mini-org"><i class="bi bi-building"></i> KKKAcademy</div>
                                <div class="mini-name">${course.courseName}</div>
                                <div class="mini-meta"><span class="mini-star">★★★★★</span><span>${course.topic}</span></div>
                            </div>
                            <div class="mini-price">
                                <c:choose>
                                    <c:when test="${course.fee == 0}">Miễn phí</c:when>
                                    <c:otherwise><fmt:formatNumber value="${course.fee}" type="number"/> ₫</c:otherwise>
                                </c:choose>
                            </div>
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
                <span class="course-count-badge" id="courseCount">
                    ${not empty COURSE_LIST ? COURSE_LIST.size() : 0} khóa học
                </span>
            </div>

            <div class="course-grid-full" id="courseGrid">
                <c:choose>
                    <c:when test="${not empty COURSE_LIST}">
                        <c:forEach var="course" items="${COURSE_LIST}" varStatus="st">
                            <div class="course-card-full" data-topic="${course.topic}" data-name="${course.courseName}">
                                <div class="card-thumb bg${(st.index % 6) + 1}">
                                    <img src="${pageContext.request.contextPath}/img/courses/course${course.courseId}.jpg"
                                         alt="${course.courseName}"
                                         onerror="this.style.display='none';">
                                    <div class="card-thumb-overlay"></div>
                                    <span class="card-topic-badge">${course.topic}</span>
                                </div>
                                <div class="card-body">
                                    <div class="card-org">KKKAcademy</div>
                                    <div class="card-name">${course.courseName}</div>
                                    <div class="card-meta">
                                        <span class="card-stars">★★★★★</span>
                                        <span>4.8</span>
                                        <span>·</span>
                                        <span><i class="bi bi-people"></i> 1.2K học viên</span>
                                    </div>
                                    <div class="card-footer-row">
                                        <span class="card-price ${course.fee == 0 ? 'free' : ''}">
                                            <c:choose>
                                                <c:when test="${course.fee == 0}">Miễn phí</c:when>
                                                <c:otherwise><fmt:formatNumber value="${course.fee}" type="number"/> ₫</c:otherwise>
                                            </c:choose>
                                        </span>
                                        <c:choose>
                                            <c:when test="${not empty sessionScope.user}">
                                                <form action="enroll" method="post" style="margin:0;">
                                                    <input type="hidden" name="courseId" value="${course.courseId}">
                                                    <button type="submit" class="card-enroll-btn">
                                                        <i class="bi bi-plus-circle"></i> Đăng ký
                                                    </button>
                                                </form>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="login.jsp" class="card-login-link">
                                                    <i class="bi bi-lock"></i> Đăng nhập
                                                </a>
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
            <span style="font-family:'Playfair Display',serif; font-size:1.2rem; font-weight:700; color:#fff;">KKK<span style="color:var(--gold);">Academy</span></span>
            <span style="font-size:0.78rem; color:rgba(255,255,255,0.35);">© 2026 KKKAcademy. All rights reserved.</span>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function toggleDropdown() {
            document.getElementById('userDropdown').classList.toggle('show');
        }
        document.addEventListener('click', function(e) {
            const menu = document.querySelector('.user-menu');
            const dd = document.getElementById('userDropdown');
            if (dd && menu && !menu.contains(e.target) && !dd.contains(e.target)) {
                dd.classList.remove('show');
            }
        });

        // Smart topic mapping: từ khóa → nhóm filter
        const TOPIC_MAP = {
            ai:       ['ai', 'machine learning', 'ml', 'deep learning', 'neural', 'nlp', 'computer vision',
                       'tensorflow', 'pytorch', 'chatgpt', 'llm', 'generative', 'prompt'],
            data:     ['data', 'python', 'pandas', 'sql', 'analytics', 'statistics', 'tableau',
                       'power bi', 'excel', 'bi', 'hadoop', 'spark', 'etl'],
            web:      ['web', 'html', 'css', 'javascript', 'js', 'react', 'vue', 'angular',
                       'nodejs', 'php', 'laravel', 'django', 'flask', 'frontend', 'backend',
                       'fullstack', 'typescript', 'next.js', 'api', 'rest', 'java'],
            design:   ['design', 'ui', 'ux', 'figma', 'photoshop', 'illustrator', 'graphic',
                       'adobe', 'canva', 'sketch', 'prototype', 'wireframe'],
            mobile:   ['mobile', 'android', 'ios', 'flutter', 'react native', 'swift', 'kotlin', 'app'],
            cloud:    ['cloud', 'aws', 'azure', 'gcp', 'google cloud', 'devops', 'docker',
                       'kubernetes', 'ci/cd', 'linux', 'server', 'network'],
            security: ['security', 'cybersecurity', 'hacking', 'ethical', 'pentest', 'firewall',
                       'encryption', 'blockchain', 'crypto'],
            language: ['english', 'tiếng anh', 'giao tiếp', 'ielts', 'toeic', 'toefl',
                       'japanese', 'tiếng nhật', 'korean', 'tiếng hàn', 'chinese', 'tiếng trung',
                       'french', 'tiếng pháp', 'german', 'tiếng đức', 'spanish', 'tiếng tây ban nha',
                       'language', 'ngôn ngữ', 'communication', 'speaking', 'writing', 'grammar'],
            programming: ['java', 'c++', 'c#', 'golang', 'go lang', 'rust', 'ruby', 'scala',
                          'kotlin', 'swift', 'algorithm', 'data structure', 'cấu trúc dữ liệu',
                          'lập trình', 'programming', 'oop', 'design pattern', 'clean code'],
            business: ['business', 'marketing', 'management', 'finance', 'accounting', 'hr',
                       'leadership', 'project management', 'scrum', 'agile', 'pmp', 'mba'],
        };

        function getTopicGroup(rawTopic) {
            const t = (rawTopic || '').toLowerCase();
            for (const [group, keywords] of Object.entries(TOPIC_MAP)) {
                if (keywords.some(kw => t.includes(kw))) return group;
            }
            return t; // fallback: chính tên topic
        }

        // Gán data-group cho mỗi card sau khi load
        document.querySelectorAll('.course-card-full').forEach(card => {
            const raw = card.dataset.topic || '';
            card.dataset.group = getTopicGroup(raw);
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
            const cards = document.querySelectorAll('.course-card-full');
            let visible = 0;
            cards.forEach(card => {
                const name  = (card.dataset.name  || '').toLowerCase();
                const topic = (card.dataset.topic || '').toLowerCase();
                const group = (card.dataset.group || '').toLowerCase();

                const matchSearch = !search || name.includes(search) || topic.includes(search);
                const matchGroup  = !currentGroup || group === currentGroup;

                if (matchSearch && matchGroup) {
                    card.style.display = '';
                    visible++;
                } else {
                    card.style.display = 'none';
                }
            });
            const badge = document.getElementById('courseCount');
            if (badge) badge.textContent = visible + ' khóa học';
        }
    </script>
</body>
</html>
