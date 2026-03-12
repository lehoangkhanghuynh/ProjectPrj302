<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<fmt:setLocale value="vi_VN"/>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${COURSE.courseName} - DUK Academy</title>
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
        .nav-links a:hover { background: rgba(255,255,255,0.1); color: #fff; }
        .nav-right { display: flex; align-items: center; gap: 12px; }
        .user-menu { display: flex; align-items: center; gap: 10px; cursor: pointer; padding: 6px 12px; border-radius: 8px; border: 1px solid rgba(255,255,255,0.15); }
        .user-avatar { width: 34px; height: 34px; border-radius: 50%; background: linear-gradient(135deg, var(--purple-mid), var(--gold)); display: flex; align-items: center; justify-content: center; font-size: 0.9rem; font-weight: 700; color: #fff; }
        .user-name { font-size: 0.875rem; font-weight: 600; color: #fff; }

        /* HERO */
        .course-hero {
            background: linear-gradient(135deg, var(--purple-deep) 0%, #3A1A7A 60%, #5B2DC5 100%);
            padding: 48px 80px;
            position: relative;
            overflow: hidden;
        }
        .course-hero::before { content: ''; position: absolute; width: 400px; height: 400px; border-radius: 50%; background: rgba(212,168,67,0.06); top: -150px; right: -80px; }
        .hero-inner { position: relative; z-index: 1; display: flex; gap: 48px; align-items: flex-start; }
        .hero-thumb {
            width: 280px;
            height: 180px;
            border-radius: 16px;
            overflow: hidden;
            flex-shrink: 0;
            background: linear-gradient(135deg, var(--purple-dark), var(--purple-mid));
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 4rem;
            box-shadow: 0 12px 40px rgba(0,0,0,0.3);
        }
        .hero-thumb img { width: 100%; height: 100%; object-fit: cover; }
        .hero-info { flex: 1; }
        .hero-topic { display: inline-block; background: rgba(255,255,255,0.15); color: #fff; font-size: 0.72rem; font-weight: 700; text-transform: uppercase; letter-spacing: 1px; padding: 4px 12px; border-radius: 20px; margin-bottom: 12px; }
        .hero-title { font-family: 'Playfair Display', serif; font-size: 2rem; font-weight: 700; color: #fff; margin-bottom: 12px; line-height: 1.3; }
        .hero-meta { display: flex; align-items: center; gap: 16px; flex-wrap: wrap; margin-bottom: 20px; }
        .hero-meta-item { display: flex; align-items: center; gap: 6px; font-size: 0.85rem; color: rgba(255,255,255,0.75); }
        .hero-meta-item i { color: var(--gold); }
        .star-gold { color: var(--gold); }
        .hero-price { font-size: 1.8rem; font-weight: 800; color: var(--gold); margin-bottom: 16px; }
        .hero-price.free { color: #4CAF50; }
        .btn-enroll-hero { background: linear-gradient(135deg, var(--gold), #E6B830); color: var(--purple-deep); font-size: 0.95rem; font-weight: 700; padding: 12px 28px; border-radius: 10px; border: none; text-decoration: none; display: inline-flex; align-items: center; gap: 8px; transition: all 0.15s; cursor: pointer; font-family: 'DM Sans', sans-serif; }
        .btn-enroll-hero:hover { transform: translateY(-2px); box-shadow: 0 8px 24px rgba(212,168,67,0.4); color: var(--purple-deep); }
        .btn-study-hero { background: linear-gradient(135deg, #2E7D32, #388E3C); color: #fff; font-size: 0.95rem; font-weight: 700; padding: 12px 28px; border-radius: 10px; border: none; text-decoration: none; display: inline-flex; align-items: center; gap: 8px; transition: all 0.15s; }
        .btn-study-hero:hover { transform: translateY(-2px); color: #fff; }
        .btn-back { display: inline-flex; align-items: center; gap: 6px; color: rgba(255,255,255,0.65); font-size: 0.85rem; text-decoration: none; margin-bottom: 20px; transition: color 0.15s; }
        .btn-back:hover { color: #fff; }

        /* MAIN */
        .detail-main { max-width: 900px; margin: 40px auto; padding: 0 24px 60px; }

        /* RATING SUMMARY */
        .rating-summary-card {
            background: #fff;
            border: 1px solid var(--border);
            border-radius: 16px;
            padding: 24px;
            display: flex;
            align-items: center;
            gap: 32px;
            margin-bottom: 32px;
            box-shadow: 0 2px 12px rgba(108,63,197,0.06);
        }
        .rating-big-num { font-size: 4rem; font-weight: 800; color: var(--gold); line-height: 1; text-align: center; }
        .rating-big-stars { font-size: 1.4rem; color: var(--gold); text-align: center; letter-spacing: 2px; margin: 6px 0; }
        .rating-big-count { font-size: 0.78rem; color: var(--muted); text-align: center; }
        .rating-dist { flex: 1; }
        .dist-row { display: flex; align-items: center; gap: 10px; margin-bottom: 8px; }
        .dist-label { font-size: 0.75rem; color: var(--muted); width: 30px; text-align: right; flex-shrink: 0; display: flex; align-items: center; gap: 3px; }
        .dist-bar-wrap { flex: 1; height: 8px; background: var(--border); border-radius: 4px; overflow: hidden; }
        .dist-bar-fill { height: 100%; background: linear-gradient(90deg, var(--gold), #E6B830); border-radius: 4px; }
        .dist-count { font-size: 0.72rem; color: var(--muted); width: 24px; flex-shrink: 0; }

        /* SECTION TITLE */
        .section-title { font-family: 'Playfair Display', serif; font-size: 1.35rem; font-weight: 700; color: var(--text); margin-bottom: 20px; display: flex; align-items: center; gap: 10px; }
        .section-title i { color: var(--purple); }

        /* REVIEW ITEMS */
        .review-list { display: flex; flex-direction: column; gap: 14px; }
        .review-item { background: #fff; border: 1px solid var(--border); border-radius: 14px; padding: 18px 20px; transition: box-shadow 0.15s; }
        .review-item:hover { box-shadow: 0 4px 16px rgba(108,63,197,0.1); }
        .review-header { display: flex; align-items: center; gap: 12px; margin-bottom: 10px; }
        .review-avatar { width: 40px; height: 40px; border-radius: 50%; background: linear-gradient(135deg, var(--purple-mid), var(--gold)); display: flex; align-items: center; justify-content: center; font-size: 0.95rem; font-weight: 700; color: #fff; flex-shrink: 0; }
        .review-meta { flex: 1; }
        .review-name { font-size: 0.88rem; font-weight: 700; color: var(--text); }
        .review-date { font-size: 0.72rem; color: var(--muted); margin-top: 2px; }
        .review-stars { color: var(--gold); font-size: 0.95rem; letter-spacing: 1px; }
        .review-comment { font-size: 0.85rem; color: var(--text); line-height: 1.7; }
        .review-empty { text-align: center; padding: 60px 20px; color: var(--muted); background: #fff; border: 1px solid var(--border); border-radius: 14px; }
        .review-empty i { font-size: 3rem; display: block; margin-bottom: 12px; opacity: 0.3; }
        .review-empty p { font-size: 0.95rem; }

        /* ENROLLED BADGE */
        .badge-enrolled { display: inline-flex; align-items: center; gap: 6px; background: #E8F5E9; color: #2E7D32; font-size: 0.82rem; font-weight: 700; padding: 8px 16px; border-radius: 20px; border: 1px solid #C8E6C9; }
        .badge-completed { display: inline-flex; align-items: center; gap: 6px; background: #FFF9C4; color: #B8860B; font-size: 0.82rem; font-weight: 700; padding: 8px 16px; border-radius: 20px; border: 1px solid #FFD54F; }

        /* MODAL CONFIRM ENROLL */
        .modal-content { border-radius: 20px; border: none; box-shadow: 0 24px 64px rgba(108,63,197,0.2); }
        .modal-header { border-bottom: 1px solid var(--border); padding: 20px 24px; }
        .modal-body { padding: 24px; }
        .modal-footer { border-top: 1px solid var(--border); padding: 16px 24px; }
        .modal-info-row { display: flex; justify-content: space-between; align-items: center; background: var(--bg); border-radius: 10px; padding: 12px 16px; margin-bottom: 8px; }
        .modal-info-label { font-size: 0.82rem; color: var(--muted); font-weight: 500; display: flex; align-items: center; gap: 6px; }
        .modal-info-value { font-size: 0.9rem; font-weight: 700; }
        .fee-val     { color: var(--purple); font-size: 1rem !important; }
        .balance-val { color: #2E7D32; }
        .after-val   { color: var(--gold); }
        .danger-val  { color: #C62828; }
        .btn-purple { background: linear-gradient(135deg, var(--purple), var(--purple-dark)); color: #fff; border: none; font-weight: 700; font-family: 'DM Sans', sans-serif; }
        .btn-purple:hover { opacity: 0.9; color: #fff; }
        .insufficient-warn { display: none; background: #FFF3F3; border: 1px solid #FFCDD2; border-radius: 8px; padding: 10px 14px; margin-top: 10px; font-size: 0.82rem; color: #C62828; font-weight: 600; }

        @media (max-width: 900px) {
            .course-hero { padding: 32px 20px; }
            .hero-inner { flex-direction: column; }
            .hero-thumb { width: 100%; height: 200px; }
            .navbar-main { padding: 0 20px; }
            .detail-main { padding: 0 16px 40px; }
            .rating-summary-card { flex-direction: column; align-items: flex-start; gap: 16px; }
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
            <li><a href="dating.jsp">study and date</a></li>
            <c:if test="${sessionScope.user.role == 1}">
                <li><a href="administrator.jsp">Administrator Manager</a></li>
            </c:if>
            <c:if test="${sessionScope.user != null && sessionScope.user.role == 2}">
                <li><a href="instructorDashboard.jsp">Instructor Manager</a></li>
            </c:if>
            <li><a href="about.jsp">Thông tin Chung</a></li>
        </ul>
        <div class="nav-right">
            <c:if test="${not empty sessionScope.user}">
                <a href="paymentController" style="display:flex;align-items:center;gap:7px;background:rgba(212,168,67,0.12);border:1px solid rgba(212,168,67,0.35);border-radius:8px;padding:7px 14px;text-decoration:none;">
                    <i class="bi bi-wallet2" style="color:var(--gold);"></i>
                    <span style="font-size:0.75rem;color:rgba(255,255,255,0.6);">Số dư</span>
                    <span style="font-size:0.875rem;font-weight:700;color:var(--gold);"><fmt:formatNumber value="${sessionScope.user.balance}" type="number"/> ₫</span>
                </a>
                <div class="user-menu" data-bs-toggle="dropdown">
                    <div class="user-avatar">${fn:substring(sessionScope.user.fullname, 0, 1)}</div>
                    <span class="user-name">${sessionScope.user.fullname}</span>
                    <i class="bi bi-chevron-down" style="color:rgba(255,255,255,0.6);font-size:0.75rem;"></i>
                </div>
                <ul class="dropdown-menu dropdown-menu-end" style="border-radius:10px;border:1px solid var(--border);padding:8px;min-width:200px;">
                    <li><a class="dropdown-item" href="myprofile.jsp" style="border-radius:7px;"><i class="bi bi-person me-2"></i>Hồ sơ của tôi</a></li>
                    <li><a class="dropdown-item" href="myCourses" style="border-radius:7px;"><i class="bi bi-book me-2"></i>Khóa học của tôi</a></li>
                    <li><a class="dropdown-item" href="paymentController" style="border-radius:7px;"><i class="bi bi-wallet2 me-2"></i>Nạp tiền</a></li>
                    <li><a class="dropdown-item" href="Certificates.jsp" style="border-radius:7px;"><i class="bi bi-award me-2"></i>Chứng chỉ</a></li>
                    <li><hr class="dropdown-divider"></li>
                    <li><a class="dropdown-item text-danger" href="mainController?action=logout" style="border-radius:7px;"><i class="bi bi-box-arrow-right me-2"></i>Đăng xuất</a></li>
                </ul>
            </c:if>
            <c:if test="${empty sessionScope.user}">
                <a href="login.jsp" style="color:rgba(255,255,255,0.75);text-decoration:none;font-size:0.875rem;font-weight:500;">Đăng nhập</a>
            </c:if>
        </div>
    </nav>

    <!-- COURSE HERO -->
    <div class="course-hero">
        <div class="hero-inner">
            <div class="hero-thumb">
                <img src="${pageContext.request.contextPath}/img/courses/course${COURSE.courseId}.jpg"
                     alt="${COURSE.courseName}" onerror="this.style.display='none';">
            </div>
            <div class="hero-info">
                <a href="courseController?action=ExploreCourse" class="btn-back">
                    <i class="bi bi-arrow-left"></i> Quay lại danh sách
                </a>
                <span class="hero-topic">${COURSE.topic}</span>
                <h1 class="hero-title">${COURSE.courseName}</h1>
                <div class="hero-meta">
                    <c:choose>
                        <c:when test="${REVIEW_COUNT > 0}">
                            <span class="hero-meta-item">
                                <i class="bi bi-star-fill"></i>
                                <strong style="color:var(--gold);"><fmt:formatNumber value="${AVG_RATING}" minFractionDigits="1" maxFractionDigits="1"/></strong>
                                <span>(${REVIEW_COUNT} đánh giá)</span>
                            </span>
                        </c:when>
                        <c:otherwise>
                            <span class="hero-meta-item"><i class="bi bi-star"></i> Chưa có đánh giá</span>
                        </c:otherwise>
                    </c:choose>
                    <span class="hero-meta-item"><i class="bi bi-people-fill"></i> 1.2K học viên</span>
                    <span class="hero-meta-item"><i class="bi bi-building"></i> DUK Academy</span>
                </div>

                <div class="hero-price ${COURSE.fee == 0 ? 'free' : ''}">
                    <c:choose>
                        <c:when test="${COURSE.fee == 0}">Miễn phí</c:when>
                        <c:otherwise><fmt:formatNumber value="${COURSE.fee}" type="number"/> ₫</c:otherwise>
                    </c:choose>
                </div>

                <%-- NÚT HÀNH ĐỘNG --%>
                <c:choose>
                    <c:when test="${empty sessionScope.user}">
                        <a href="login.jsp" class="btn-enroll-hero">
                            <i class="bi bi-lock-fill"></i> Đăng nhập để đăng ký
                        </a>
                    </c:when>
                    <c:when test="${IS_COMPLETED}">
                        <span class="badge-completed me-2"><i class="bi bi-trophy-fill"></i> Đã hoàn thành</span>
                        <a href="lesson?courseId=${COURSE.courseId}" class="btn-enroll-hero">
                            <i class="bi bi-arrow-repeat"></i> Học lại
                        </a>
                    </c:when>
                    <c:when test="${IS_ENROLLED}">
                        <span class="badge-enrolled me-2"><i class="bi bi-check2-circle"></i> Đã đăng ký</span>
                        <a href="lesson?courseId=${COURSE.courseId}" class="btn-study-hero">
                            <i class="bi bi-play-circle-fill"></i> Vào học ngay
                        </a>
                    </c:when>
                    <c:otherwise>
                        <button class="btn-enroll-hero"
                                data-bs-toggle="modal" data-bs-target="#enrollModal">
                            <i class="bi bi-plus-circle-fill"></i> Đăng ký khóa học
                        </button>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <!-- MAIN CONTENT -->
    <div class="detail-main">

        <%-- THÔNG BÁO --%>
        <c:if test="${not empty sessionScope.reviewSuccess}">
            <div class="alert alert-success alert-dismissible fade show" role="alert" style="border-radius:12px;">
                <i class="bi bi-check-circle-fill me-2"></i>${sessionScope.reviewSuccess}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <c:remove var="reviewSuccess" scope="session"/>
        </c:if>
        <c:if test="${not empty sessionScope.reviewError}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert" style="border-radius:12px;">
                <i class="bi bi-exclamation-circle-fill me-2"></i>${sessionScope.reviewError}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
            <c:remove var="reviewError" scope="session"/>
        </c:if>

        <%-- RATING SUMMARY --%>
        <c:if test="${REVIEW_COUNT > 0}">
            <div class="rating-summary-card">
                <div>
                    <div class="rating-big-num"><fmt:formatNumber value="${AVG_RATING}" minFractionDigits="1" maxFractionDigits="1"/></div>
                    <div class="rating-big-stars">
                        <%-- Render sao tĩnh từ server --%>
                        <c:set var="avgFloor" value="${AVG_RATING}"/>
                        <c:forEach begin="1" end="5" var="s">
                            <c:choose>
                                <c:when test="${avgFloor >= s - 0.25}">★</c:when>
                                <c:when test="${avgFloor >= s - 0.75}">½</c:when>
                                <c:otherwise><span style="opacity:0.25">★</span></c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </div>
                    <div class="rating-big-count">${REVIEW_COUNT} đánh giá</div>
                </div>
                <div class="rating-dist">
                    <%
                        java.util.Map<Integer,Integer> distMap = (java.util.Map<Integer,Integer>) request.getAttribute("DIST");
                        int rc = distMap == null ? 0 : ((Number)request.getAttribute("REVIEW_COUNT")).intValue();
                        int[] starCounts = new int[6];
                        if (distMap != null) {
                            for (int i = 1; i <= 5; i++) {
                                Integer v = distMap.get(i);
                                starCounts[i] = (v == null) ? 0 : v;
                            }
                        }
                        request.setAttribute("SC5", starCounts[5]);
                        request.setAttribute("SC4", starCounts[4]);
                        request.setAttribute("SC3", starCounts[3]);
                        request.setAttribute("SC2", starCounts[2]);
                        request.setAttribute("SC1", starCounts[1]);
                    %>
                    <c:set var="pct5" value="${REVIEW_COUNT > 0 ? SC5 * 100 / REVIEW_COUNT : 0}"/>
                    <div class="dist-row">
                        <span class="dist-label">5 <i class="bi bi-star-fill" style="color:var(--gold);font-size:0.6rem;"></i></span>
                        <div class="dist-bar-wrap"><div class="dist-bar-fill" style="width:${pct5}%;"></div></div>
                        <span class="dist-count">${SC5}</span>
                    </div>
                    <c:set var="pct4" value="${REVIEW_COUNT > 0 ? SC4 * 100 / REVIEW_COUNT : 0}"/>
                    <div class="dist-row">
                        <span class="dist-label">4 <i class="bi bi-star-fill" style="color:var(--gold);font-size:0.6rem;"></i></span>
                        <div class="dist-bar-wrap"><div class="dist-bar-fill" style="width:${pct4}%;"></div></div>
                        <span class="dist-count">${SC4}</span>
                    </div>
                    <c:set var="pct3" value="${REVIEW_COUNT > 0 ? SC3 * 100 / REVIEW_COUNT : 0}"/>
                    <div class="dist-row">
                        <span class="dist-label">3 <i class="bi bi-star-fill" style="color:var(--gold);font-size:0.6rem;"></i></span>
                        <div class="dist-bar-wrap"><div class="dist-bar-fill" style="width:${pct3}%;"></div></div>
                        <span class="dist-count">${SC3}</span>
                    </div>
                    <c:set var="pct2" value="${REVIEW_COUNT > 0 ? SC2 * 100 / REVIEW_COUNT : 0}"/>
                    <div class="dist-row">
                        <span class="dist-label">2 <i class="bi bi-star-fill" style="color:var(--gold);font-size:0.6rem;"></i></span>
                        <div class="dist-bar-wrap"><div class="dist-bar-fill" style="width:${pct2}%;"></div></div>
                        <span class="dist-count">${SC2}</span>
                    </div>
                    <c:set var="pct1" value="${REVIEW_COUNT > 0 ? SC1 * 100 / REVIEW_COUNT : 0}"/>
                    <div class="dist-row">
                        <span class="dist-label">1 <i class="bi bi-star-fill" style="color:var(--gold);font-size:0.6rem;"></i></span>
                        <div class="dist-bar-wrap"><div class="dist-bar-fill" style="width:${pct1}%;"></div></div>
                        <span class="dist-count">${SC1}</span>
                    </div>
                </div>
            </div>
        </c:if>

        <%-- DANH SÁCH REVIEWS --%>
        <div class="section-title">
            <i class="bi bi-chat-quote-fill"></i>
            Đánh giá từ học viên
            <c:if test="${REVIEW_COUNT > 0}">
                <span style="font-size:0.82rem;font-weight:600;background:var(--purple-light);color:var(--purple);padding:3px 10px;border-radius:20px;">${REVIEW_COUNT} đánh giá</span>
            </c:if>
        </div>

        <div class="review-list">
            <c:choose>
                <c:when test="${not empty REVIEWS}">
                    <c:forEach var="rv" items="${REVIEWS}">
                        <div class="review-item">
                            <div class="review-header">
                                <div class="review-avatar">
                                    ${fn:substring(rv.fullname, 0, 1)}
                                </div>
                                <div class="review-meta">
                                    <div class="review-name">${rv.fullname}</div>
                                    <div class="review-date">
                                        <i class="bi bi-calendar3"></i>
                                        <c:if test="${rv.createdAt != null}">
                                            ${fn:substring(rv.createdAt.toString(), 0, 10)}
                                        </c:if>
                                    </div>
                                </div>
                                <div class="review-stars">
                                    <c:forEach begin="1" end="5" var="s">
                                        <c:choose>
                                            <c:when test="${s <= rv.rating}">★</c:when>
                                            <c:otherwise><span style="opacity:0.25;">★</span></c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                    <span style="font-size:0.78rem;color:var(--muted);margin-left:4px;">${rv.rating}/5</span>
                                </div>
                            </div>
                            <div class="review-comment">
                                <c:choose>
                                    <c:when test="${not empty rv.comment}">${rv.comment}</c:when>
                                    <c:otherwise><em style="color:var(--muted);">Không có nhận xét.</em></c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="review-empty">
                        <i class="bi bi-chat-dots"></i>
                        <p>Chưa có đánh giá nào cho khóa học này.</p>
                        <p style="font-size:0.82rem;margin-top:6px;">Hãy là người đầu tiên chia sẻ trải nghiệm!</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- FOOTER -->
    <footer style="background: var(--purple-deep); padding: 32px 80px; margin-top: 40px;">
        <div style="display:flex; justify-content:space-between; align-items:center; border-top:1px solid rgba(255,255,255,0.08); padding-top:20px;">
            <span style="font-family:'Playfair Display',serif; font-size:1.2rem; font-weight:700; color:#fff;">DUK<span style="color:var(--gold);">Academy</span></span>
            <span style="font-size:0.78rem; color:rgba(255,255,255,0.35);">© 2026 DUK Academy. All rights reserved.</span>
        </div>
    </footer>

    <!-- MODAL XÁC NHẬN ĐĂNG KÝ -->
    <div class="modal fade" id="enrollModal" tabindex="-1">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <div style="display:flex;align-items:center;gap:12px;">
                        <div style="width:44px;height:44px;border-radius:12px;background:var(--purple-light);display:flex;align-items:center;justify-content:center;font-size:1.4rem;">🎓</div>
                        <div>
                            <h5 class="modal-title" style="font-family:'Playfair Display',serif;font-size:1.15rem;font-weight:700;margin:0;">Xác nhận đăng ký</h5>
                            <div style="font-size:0.8rem;color:var(--purple);font-weight:600;">${COURSE.courseName}</div>
                        </div>
                    </div>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="modal-info-row">
                        <span class="modal-info-label"><i class="bi bi-tag-fill"></i> Học phí</span>
                        <span class="modal-info-value fee-val">
                            <c:choose>
                                <c:when test="${COURSE.fee == 0}">Miễn phí</c:when>
                                <c:otherwise><fmt:formatNumber value="${COURSE.fee}" type="number"/> ₫</c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                    <c:if test="${not empty sessionScope.user}">
                        <div class="modal-info-row">
                            <span class="modal-info-label"><i class="bi bi-wallet2"></i> Số dư hiện tại</span>
                            <span class="modal-info-value balance-val">
                                <fmt:formatNumber value="${sessionScope.user.balance}" type="number"/> ₫
                            </span>
                        </div>
                        <hr style="border-color:var(--border);margin:8px 0;">
                        <div class="modal-info-row">
                            <span class="modal-info-label"><i class="bi bi-arrow-right-circle-fill"></i> Số dư sau đăng ký</span>
                            <c:set var="afterBalance" value="${sessionScope.user.balance - COURSE.fee}"/>
                            <span class="modal-info-value ${afterBalance < 0 ? 'danger-val' : 'after-val'}">
                                <c:choose>
                                    <c:when test="${afterBalance < 0}">Không đủ số dư!</c:when>
                                    <c:otherwise><fmt:formatNumber value="${afterBalance}" type="number"/> ₫</c:otherwise>
                                </c:choose>
                            </span>
                        </div>
                        <c:if test="${afterBalance < 0}">
                            <div style="background:#FFF3F3;border:1px solid #FFCDD2;border-radius:8px;padding:10px 14px;margin-top:10px;font-size:0.82rem;color:#C62828;font-weight:600;">
                                <i class="bi bi-exclamation-triangle-fill"></i>
                                Số dư không đủ! <a href="paymentController" style="color:#C62828;font-weight:700;">Nạp tiền ngay →</a>
                            </div>
                        </c:if>
                    </c:if>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal" style="border-radius:8px;font-weight:600;">Hủy</button>
                    <c:choose>
                        <c:when test="${not empty sessionScope.user && sessionScope.user.balance >= COURSE.fee}">
                            <form action="enroll" method="post" style="margin:0;">
                                <input type="hidden" name="courseId" value="${COURSE.courseId}">
                                <input type="hidden" name="redirect" value="courseController?action=detail&courseId=${COURSE.courseId}">
                                <button type="submit" class="btn btn-purple" style="border-radius:8px;padding:8px 20px;">
                                    <i class="bi bi-check-circle-fill me-1"></i> Xác nhận đăng ký
                                </button>
                            </form>
                        </c:when>
                        <c:otherwise>
                            <button class="btn btn-purple" disabled style="border-radius:8px;padding:8px 20px;opacity:0.5;">
                                <i class="bi bi-check-circle-fill me-1"></i> Xác nhận đăng ký
                            </button>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
