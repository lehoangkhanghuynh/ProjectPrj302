<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<fmt:setLocale value="vi_VN"/>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Yêu thích - DUK Academy</title>
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
            --red:         #E53935;
            --red-light:   #FFF3F3;
        }

        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'DM Sans', sans-serif; color: var(--text); background: var(--bg); min-height: 100vh; }

        /* NAVBAR */
        .navbar-main { background: var(--purple-deep); padding: 0 48px; height: 68px; display: flex; align-items: center; justify-content: space-between; position: sticky; top: 0; z-index: 100; box-shadow: 0 2px 20px rgba(0,0,0,0.25); }
        .brand { font-family: 'Playfair Display', serif; font-size: 1.55rem; font-weight: 700; color: #fff; text-decoration: none; }
        .brand span { color: var(--gold); }
        .nav-links { display: flex; align-items: center; gap: 4px; list-style: none; }
        .nav-links a { font-size: 0.9rem; font-weight: 500; color: rgba(255,255,255,0.75); text-decoration: none; padding: 7px 14px; border-radius: 6px; transition: background 0.15s, color 0.15s; }
        .nav-links a:hover, .nav-links a.active { background: rgba(255,255,255,0.1); color: #fff; }
        .nav-right { display: flex; align-items: center; gap: 12px; }
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
        .page-header {
            background: linear-gradient(135deg, var(--purple-deep) 0%, #3A1A7A 60%, #5B2DC5 100%);
            padding: 52px 80px 56px;
            position: relative;
            overflow: hidden;
        }
        .page-header::before {
            content: '';
            position: absolute;
            width: 500px; height: 500px;
            border-radius: 50%;
            background: rgba(212,168,67,0.05);
            top: -200px; right: -100px;
        }
        .page-header::after {
            content: '';
            position: absolute;
            width: 250px; height: 250px;
            border-radius: 50%;
            background: rgba(229,57,53,0.08);
            bottom: -80px; left: 150px;
        }
        /* Floating hearts decoration */
        .header-hearts {
            position: absolute;
            inset: 0;
            pointer-events: none;
            overflow: hidden;
        }
        .header-hearts span {
            position: absolute;
            color: rgba(255,107,107,0.15);
            font-size: 2rem;
            animation: floatHeart 6s ease-in-out infinite;
        }
        .header-hearts span:nth-child(1) { left: 5%;  top: 20%; animation-delay: 0s;   font-size: 1.5rem; }
        .header-hearts span:nth-child(2) { left: 15%; top: 60%; animation-delay: 1s;   font-size: 2.5rem; }
        .header-hearts span:nth-child(3) { left: 80%; top: 15%; animation-delay: 0.5s; font-size: 1.8rem; }
        .header-hearts span:nth-child(4) { left: 70%; top: 65%; animation-delay: 2s;   font-size: 1.2rem; }
        .header-hearts span:nth-child(5) { left: 90%; top: 40%; animation-delay: 1.5s; font-size: 2rem;   }
        @keyframes floatHeart {
            0%, 100% { transform: translateY(0) rotate(-10deg); opacity: 0.15; }
            50%       { transform: translateY(-18px) rotate(10deg); opacity: 0.3; }
        }
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

        /* SORT/FILTER BAR */
        .list-topbar {
            display: flex; align-items: center; justify-content: space-between;
            margin-bottom: 28px;
        }
        .list-title { font-family: 'Playfair Display', serif; font-size: 1.4rem; font-weight: 700; color: var(--text); display: flex; align-items: center; gap: 8px; }
        .list-title i { color: var(--red); }
        .btn-back {
            display: inline-flex; align-items: center; gap: 8px;
            background: #fff; border: 1.5px solid var(--border);
            color: var(--muted); font-size: 0.82rem; font-weight: 600;
            padding: 8px 18px; border-radius: 8px; text-decoration: none;
            transition: all 0.15s;
        }
        .btn-back:hover { border-color: var(--purple); color: var(--purple); background: var(--purple-light); }

        /* WISHLIST CARDS */
        .wishlist-list { display: flex; flex-direction: column; gap: 16px; }

        .wish-card {
            background: #fff;
            border: 1px solid var(--border);
            border-radius: 16px;
            padding: 20px 24px;
            display: flex;
            align-items: center;
            gap: 20px;
            transition: box-shadow 0.2s, transform 0.2s, border-color 0.2s;
            animation: slideIn 0.3s ease both;
        }
        .wish-card:hover { box-shadow: 0 8px 32px rgba(108,63,197,0.12); transform: translateY(-2px); border-color: var(--purple-mid); }
        @keyframes slideIn { from { opacity: 0; transform: translateY(16px); } to { opacity: 1; transform: translateY(0); } }

        .wish-card-thumb {
            width: 80px; height: 80px; border-radius: 12px; flex-shrink: 0;
            background: linear-gradient(135deg, var(--purple-deep), var(--purple));
            display: flex; align-items: center; justify-content: center;
            font-size: 2rem; overflow: hidden; position: relative;
        }
        .wish-card-thumb img { width: 100%; height: 100%; object-fit: cover; }
        .wish-card-thumb .thumb-overlay {
            position: absolute; inset: 0;
            background: linear-gradient(to top, rgba(30,10,74,0.4), transparent);
        }

        .wish-card-info { flex: 1; min-width: 0; }
        .wish-card-meta { font-size: 0.68rem; font-weight: 700; color: var(--muted); text-transform: uppercase; letter-spacing: 0.5px; margin-bottom: 5px; display: flex; align-items: center; gap: 6px; }
        .wish-card-name { font-size: 1rem; font-weight: 700; color: var(--text); margin-bottom: 8px; line-height: 1.4; }
        .wish-card-details { display: flex; align-items: center; gap: 14px; flex-wrap: wrap; }
        .wish-card-badge {
            display: inline-flex; align-items: center; gap: 5px;
            font-size: 0.72rem; font-weight: 600;
            padding: 3px 10px; border-radius: 20px;
        }
        .badge-id { background: var(--purple-light); color: var(--purple); }
        .badge-date { background: #F0FFF4; color: #2E7D32; }
        .badge-price { background: #FFF8E1; color: #B8860B; font-size: 0.78rem; padding: 4px 12px; }
        .badge-free { background: #E8F5E9; color: #2E7D32; }

        .wish-card-actions { display: flex; align-items: center; gap: 10px; flex-shrink: 0; }

        .btn-study {
            display: inline-flex; align-items: center; gap: 6px;
            background: linear-gradient(135deg, var(--purple), var(--purple-dark));
            color: #fff; font-size: 0.78rem; font-weight: 700;
            padding: 8px 18px; border-radius: 8px; text-decoration: none;
            border: none; cursor: pointer; font-family: 'DM Sans', sans-serif;
            transition: all 0.15s;
        }
        .btn-study:hover { transform: translateY(-1px); box-shadow: 0 4px 16px rgba(108,63,197,0.35); color: #fff; }

        .btn-remove {
            display: inline-flex; align-items: center; gap: 6px;
            background: var(--red-light); color: var(--red);
            border: 1.5px solid rgba(229,57,53,0.2);
            font-size: 0.78rem; font-weight: 700;
            padding: 8px 16px; border-radius: 8px;
            text-decoration: none; cursor: pointer;
            font-family: 'DM Sans', sans-serif;
            transition: all 0.15s;
        }
        .btn-remove:hover { background: var(--red); color: #fff; border-color: var(--red); transform: translateY(-1px); }

        /* EMPTY STATE */
        .empty-wrap {
            text-align: center;
            padding: 80px 20px;
            background: #fff;
            border-radius: 20px;
            border: 1px solid var(--border);
        }
        .empty-heart { font-size: 5rem; margin-bottom: 20px; animation: heartbeat 2s ease-in-out infinite; display: block; }
        .empty-title { font-family: 'Playfair Display', serif; font-size: 1.5rem; font-weight: 700; color: var(--text); margin-bottom: 10px; }
        .empty-sub { font-size: 0.9rem; color: var(--muted); margin-bottom: 28px; }
        .btn-explore {
            display: inline-flex; align-items: center; gap: 8px;
            background: linear-gradient(135deg, var(--purple), var(--purple-dark));
            color: #fff; font-size: 0.9rem; font-weight: 700;
            padding: 12px 28px; border-radius: 10px; text-decoration: none;
            transition: all 0.15s;
        }
        .btn-explore:hover { transform: translateY(-2px); box-shadow: 0 6px 24px rgba(108,63,197,0.4); color: #fff; }

        /* TOAST */
        .toast-noti { position: fixed; bottom: 32px; left: 50%; transform: translateX(-50%) translateY(20px); background: #1E0A4A; color: #fff; padding: 13px 24px; border-radius: 50px; font-size: 0.875rem; font-weight: 600; display: flex; align-items: center; gap: 10px; box-shadow: 0 8px 32px rgba(0,0,0,0.25); z-index: 9999; opacity: 0; transition: opacity 0.3s, transform 0.3s; pointer-events: none; }
        .toast-noti.show { opacity: 1; transform: translateX(-50%) translateY(0); }

        /* FOOTER */
        footer { background: var(--purple-deep); padding: 32px 80px; margin-top: 0; }
        footer .inner { display: flex; justify-content: space-between; align-items: center; border-top: 1px solid rgba(255,255,255,0.08); padding-top: 20px; }

        @media (max-width: 768px) {
            .navbar-main { padding: 0 20px; }
            .page-header { padding: 40px 20px 44px; }
            .page-title { font-size: 2rem; }
            .main-wrap { padding: 32px 16px 60px; }
            .wish-card { flex-wrap: wrap; }
            .wish-card-actions { width: 100%; justify-content: flex-end; }
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
        <li><a href="courseController?action=ExploreCourse">Khóa học</a></li>
        <li><a href="instructors.jsp">Giảng viên</a></li>
        <li><a href="#">Về chúng tôi</a></li>
    </ul>
    <div class="nav-right">
        <c:if test="${not empty sessionScope.user}">
            <div class="user-menu" onclick="toggleDropdown()">
                <div class="user-avatar">${fn:substring(sessionScope.user.fullname, 0, 1)}</div>
                <span class="user-name">${sessionScope.user.fullname}</span>
                <i class="bi bi-chevron-down" style="color:rgba(255,255,255,0.6);font-size:0.75rem;"></i>
            </div>
            <div class="dropdown-menu-custom" id="userDropdown">
                <a href="myprofile.jsp"><i class="bi bi-person"></i> Hồ sơ của tôi</a>
                <a href="myCourses"><i class="bi bi-book"></i> Khóa học của tôi</a>
                <a href="paymentController"><i class="bi bi-wallet2"></i> Nạp tiền</a>
                <a href="Certificates.jsp"><i class="bi bi-award"></i> Chứng chỉ</a>
                <div class="divider-drop"></div>
                <a href="mainController?action=logout" class="logout-link"><i class="bi bi-box-arrow-right"></i> Đăng xuất</a>
            </div>
        </c:if>
        <c:if test="${empty sessionScope.user}">
            <a href="login.jsp" style="color:rgba(255,255,255,0.75);text-decoration:none;font-size:0.875rem;font-weight:500;">Đăng nhập</a>
        </c:if>
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
            <span class="header-stat-num">${not empty wishlist ? fn:length(wishlist) : 0}</span>
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
                    <div class="wish-card" id="card-${w.wishlistId}" style="animation-delay: ${st.index * 0.06}s">
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
                            <div class="wish-card-name">Khóa học #${w.courseId}</div>
                            <div class="wish-card-details">
                                <span class="wish-card-badge badge-id">
                                    <i class="bi bi-hash"></i> ID: ${w.wishlistId}
                                </span>
                                <span class="wish-card-badge badge-date">
                                    <i class="bi bi-calendar3"></i>
                                    <fmt:formatDate value="${w.createdAt}" pattern="dd/MM/yyyy"/>
                                </span>
                                <span class="wish-card-badge badge-date" style="background:#EFF6FF;color:#1D4ED8;">
                                    <i class="bi bi-clock"></i>
                                    <fmt:formatDate value="${w.createdAt}" pattern="HH:mm"/>
                                </span>
                            </div>
                        </div>

                        <!-- ACTIONS -->
                        <div class="wish-card-actions">
                            <a href="lesson?courseId=${w.courseId}" class="btn-study">
                                <i class="bi bi-play-circle-fill"></i> Học ngay
                            </a>
                            <a href="wishlistController?action=remove&wishlistId=${w.wishlistId}&userId=${sessionScope.user.userId}&from=wishlist"
                               class="btn-remove"
                               onclick="return confirmRemove(event, '${w.wishlistId}')">
                                <i class="bi bi-trash3"></i> Xóa
                            </a>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <!-- BOTTOM CTA -->
            <div style="text-align:center; margin-top:40px; padding-top:32px; border-top:1px solid var(--border);">
                <p style="font-size:0.875rem; color:var(--muted); margin-bottom:16px;">Khám phá thêm khóa học mới?</p>
                <a href="courseController?action=ExploreCourse" class="btn-explore">
                    <i class="bi bi-compass"></i> Khám phá khóa học
                </a>
            </div>
        </c:when>

        <c:otherwise>
            <div class="empty-wrap">
                <span class="empty-heart">🤍</span>
                <div class="empty-title">Chưa có khóa học yêu thích</div>
                <p class="empty-sub">Hãy thêm những khóa học bạn quan tâm để dễ dàng tìm lại sau này.</p>
                <a href="courseController?action=ExploreCourse" class="btn-explore">
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
        <span style="font-size:0.78rem;color:rgba(255,255,255,0.35);">© 2026 DUK Academy. All rights reserved.</span>
    </div>
</footer>

<script>
    function toggleDropdown() {
        document.getElementById('userDropdown').classList.toggle('show');
    }
    document.addEventListener('click', function(e) {
        const ud = document.getElementById('userDropdown');
        const um = document.querySelector('.user-menu');
        if (ud && um && !um.contains(e.target) && !ud.contains(e.target)) ud.classList.remove('show');
    });

    function confirmRemove(e, wishlistId) {
        e.preventDefault();
        const card = document.getElementById('card-' + wishlistId);
        const href = e.currentTarget.href;

        // Animate out
        card.style.transition = 'all 0.3s ease';
        card.style.opacity = '0';
        card.style.transform = 'translateX(40px)';

        // Show toast
        const toast = document.getElementById('toastNoti');
        toast.classList.add('show');
        setTimeout(() => toast.classList.remove('show'), 2500);

        setTimeout(() => {
            card.style.maxHeight = card.offsetHeight + 'px';
            card.style.overflow = 'hidden';
            card.style.padding = '0';
            card.style.marginBottom = '0';
            requestAnimationFrame(() => {
                card.style.maxHeight = '0';
                card.style.marginBottom = '-16px';
            });
            setTimeout(() => {
                card.remove();
                // Cập nhật count
                const remaining = document.querySelectorAll('.wish-card').length;
                const statEl = document.querySelector('.header-stat-num');
                if (statEl) statEl.textContent = remaining;
                // Nếu hết thì redirect
                if (remaining === 0) setTimeout(() => window.location.href = href, 400);
                else window.location.href = href;
            }, 350);
        }, 300);

        return false;
    }
</script>
</body>
</html>
