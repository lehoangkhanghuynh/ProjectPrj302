<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Khóa học của tôi - DUK Academy</title>
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
            body { font-family: 'DM Sans', sans-serif; color: var(--text); background: var(--bg); min-height: 100vh; }

            /* NAVBAR */
            .navbar-main { background: var(--purple-deep); padding: 0 48px; height: 68px; display: flex; align-items: center; justify-content: space-between; position: sticky; top: 0; z-index: 100; box-shadow: 0 2px 20px rgba(0,0,0,0.25); }
            .brand { font-family: 'Playfair Display', serif; font-size: 1.55rem; font-weight: 700; color: #fff; text-decoration: none; }
            .brand span { color: var(--gold); }
            .nav-links { display: flex; align-items: center; gap: 4px; list-style: none; }
            .nav-links a { font-size: 0.9rem; font-weight: 500; color: rgba(255,255,255,0.75); text-decoration: none; padding: 7px 14px; border-radius: 6px; transition: all 0.15s; }
            .nav-links a:hover, .nav-links a.active { background: rgba(255,255,255,0.1); color: #fff; }
            .nav-right { display: flex; align-items: center; gap: 12px; }
            .user-menu { display: flex; align-items: center; gap: 10px; cursor: pointer; padding: 6px 12px; border-radius: 8px; border: 1px solid rgba(255,255,255,0.15); transition: background 0.15s; text-decoration: none; }
            .user-menu:hover { background: rgba(255,255,255,0.08); }
            .user-avatar { width: 34px; height: 34px; border-radius: 50%; background: linear-gradient(135deg, var(--purple-mid), var(--gold)); display: flex; align-items: center; justify-content: center; font-size: 0.9rem; font-weight: 700; color: #fff; flex-shrink: 0; }
            .user-name { font-size: 0.875rem; font-weight: 600; color: #fff; max-width: 120px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }

            /* PAGE HEADER */
            .page-header { background: linear-gradient(135deg, var(--purple-deep) 0%, #3A1A7A 60%, #5B2DC5 100%); padding: 52px 80px 56px; position: relative; overflow: hidden; }
            .page-header::before { content: ''; position: absolute; width: 380px; height: 380px; border-radius: 50%; background: rgba(212,168,67,0.07); top: -140px; right: -60px; }
            .page-header::after  { content: ''; position: absolute; width: 180px; height: 180px; border-radius: 50%; background: rgba(155,114,232,0.1); bottom: -50px; left: 220px; }
            .page-header-inner { position: relative; z-index: 1; }
            .page-eyebrow { font-size: 0.72rem; font-weight: 700; text-transform: uppercase; letter-spacing: 2px; color: var(--gold); margin-bottom: 10px; }
            .page-title { font-family: 'Playfair Display', serif; font-size: 2.4rem; font-weight: 700; color: #fff; margin-bottom: 10px; }
            .page-subtitle { font-size: 1rem; color: rgba(255,255,255,0.6); }
            .header-stats { display: flex; gap: 32px; margin-top: 28px; }
            .stat-num { font-size: 1.5rem; font-weight: 700; color: var(--gold); }
            .stat-lbl { font-size: 0.78rem; color: rgba(255,255,255,0.5); margin-top: 2px; }

            /* MAIN */
            .main-content { padding: 48px 80px 80px; }

            /* TABS */
            .tab-bar { display: flex; gap: 8px; margin-bottom: 28px; }
            .tab-btn { display: flex; align-items: center; gap: 7px; padding: 9px 20px; border-radius: 10px; font-size: 0.85rem; font-weight: 700; border: 1.5px solid var(--border); background: #fff; color: var(--muted); cursor: pointer; transition: all 0.15s; font-family: 'DM Sans', sans-serif; }
            .tab-btn:hover { border-color: var(--purple); color: var(--purple); }
            .tab-btn.active { background: var(--purple); border-color: var(--purple); color: #fff; }
            .tab-count { background: rgba(255,255,255,0.25); padding: 2px 8px; border-radius: 20px; font-size: 0.72rem; }
            .tab-btn:not(.active) .tab-count { background: var(--purple-light); color: var(--purple); }

            /* SECTION HEADER */
            .section-header { display: flex; align-items: center; justify-content: space-between; margin-bottom: 28px; }
            .section-title { font-family: 'Playfair Display', serif; font-size: 1.5rem; font-weight: 700; color: var(--text); display: flex; align-items: center; gap: 10px; }
            .section-title i { color: var(--purple); }
            .course-badge { background: var(--purple-light); color: var(--purple); font-size: 0.78rem; font-weight: 700; padding: 4px 14px; border-radius: 20px; }

            /* COURSE GRID */
            .course-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 24px; }

            /* COURSE CARD */
            .course-card { background: #fff; border: 1px solid var(--border); border-radius: 18px; overflow: hidden; display: flex; flex-direction: column; transition: transform 0.2s, box-shadow 0.2s; animation: fadeUp 0.4s ease both; }
            .course-card:hover { transform: translateY(-5px); box-shadow: 0 16px 40px rgba(108,63,197,0.14); }
            @keyframes fadeUp { from { opacity: 0; transform: translateY(20px); } to { opacity: 1; transform: translateY(0); } }
            .course-card:nth-child(1) { animation-delay: 0.05s; }
            .course-card:nth-child(2) { animation-delay: 0.1s; }
            .course-card:nth-child(3) { animation-delay: 0.15s; }
            .course-card:nth-child(4) { animation-delay: 0.2s; }
            .course-card:nth-child(5) { animation-delay: 0.25s; }
            .course-card:nth-child(6) { animation-delay: 0.3s; }

            /* Completed card glow */
            .course-card.completed { border-color: #FFD54F; box-shadow: 0 4px 20px rgba(255,179,0,0.12); }
            .course-card.completed:hover { box-shadow: 0 16px 40px rgba(255,179,0,0.22); }

            /* Thumbnail */
            .card-thumb { height: 158px; position: relative; background: linear-gradient(135deg, var(--purple-deep), var(--purple)); display: flex; align-items: center; justify-content: center; font-size: 3.5rem; overflow: hidden; }
            .card-thumb img { width: 100%; height: 100%; object-fit: cover; position: absolute; top: 0; left: 0; }
            .card-thumb-overlay { position: absolute; inset: 0; background: linear-gradient(to top, rgba(30,10,74,0.55) 0%, transparent 60%); }
            .card-topic-badge { position: absolute; top: 12px; left: 12px; background: rgba(255,255,255,0.93); color: var(--purple); font-size: 0.62rem; font-weight: 700; padding: 3px 10px; border-radius: 5px; text-transform: uppercase; letter-spacing: 0.5px; }

            /* Completed overlay badge */
            .card-completed-badge { position: absolute; top: 12px; right: 12px; background: linear-gradient(135deg, #FFB300, #FF8F00); color: #fff; font-size: 0.68rem; font-weight: 700; padding: 4px 10px; border-radius: 20px; display: flex; align-items: center; gap: 4px; box-shadow: 0 2px 8px rgba(255,143,0,0.45); }

            /* Progress bar on thumb */
            .card-progress-wrap { position: absolute; bottom: 0; left: 0; right: 0; height: 4px; background: rgba(255,255,255,0.15); }
            .card-progress-fill { height: 100%; background: linear-gradient(90deg, var(--purple-mid), var(--gold)); border-radius: 0 2px 2px 0; }
            .card-progress-fill.full { background: linear-gradient(90deg, #66BB6A, #43A047); width: 100% !important; }

            /* Card body */
            .card-body { padding: 18px 18px 14px; flex: 1; display: flex; flex-direction: column; gap: 6px; }
            .card-org { font-size: 0.68rem; font-weight: 700; color: var(--muted); text-transform: uppercase; letter-spacing: 0.5px; display: flex; align-items: center; gap: 4px; }
            .card-name { font-size: 0.95rem; font-weight: 700; line-height: 1.4; color: var(--text); flex: 1; }
            .card-meta { display: flex; align-items: center; gap: 10px; font-size: 0.72rem; color: var(--muted); margin-top: 4px; }
            .card-meta i { color: var(--purple-mid); }

            /* Card footer */
            .card-footer { padding: 14px 18px 18px; border-top: 1px solid var(--border); display: flex; align-items: center; justify-content: space-between; gap: 8px; }
            .card-fee { font-size: 0.8rem; font-weight: 700; background: #E8F5E9; color: #2E7D32; padding: 4px 12px; border-radius: 20px; border: 1px solid #C8E6C9; display: flex; align-items: center; gap: 5px; white-space: nowrap; }
            .card-fee.free { background: var(--purple-light); color: var(--purple); border-color: var(--border); }
            .card-fee.done { background: #FFF9C4; color: #B8860B; border-color: #FFD54F; }

            /* Action buttons */
            .btn-study { display: inline-flex; align-items: center; gap: 8px; background: linear-gradient(135deg, var(--purple), var(--purple-dark)); color: #fff; text-decoration: none; font-size: 0.82rem; font-weight: 700; padding: 9px 20px; border-radius: 10px; border: none; cursor: pointer; font-family: 'DM Sans', sans-serif; transition: all 0.18s; box-shadow: 0 4px 14px rgba(108,63,197,0.28); white-space: nowrap; }
            .btn-study:hover { transform: translateY(-2px); box-shadow: 0 7px 22px rgba(108,63,197,0.42); color: #fff; }
            .btn-cert { display: inline-flex; align-items: center; gap: 8px; background: linear-gradient(135deg, #F59E0B, #D97706); color: #fff; text-decoration: none; font-size: 0.82rem; font-weight: 700; padding: 9px 20px; border-radius: 10px; border: none; cursor: pointer; font-family: 'DM Sans', sans-serif; transition: all 0.18s; box-shadow: 0 4px 14px rgba(245,158,11,0.35); white-space: nowrap; }
            .btn-cert:hover { transform: translateY(-2px); box-shadow: 0 7px 22px rgba(245,158,11,0.5); color: #fff; }
            .btn-review { display: inline-flex; align-items: center; gap: 6px; background: #fff; color: var(--purple); text-decoration: none; font-size: 0.78rem; font-weight: 700; padding: 8px 14px; border-radius: 10px; border: 1.5px solid #D1C4E9; cursor: pointer; font-family: 'DM Sans', sans-serif; transition: all 0.18s; white-space: nowrap; }
            .btn-review:hover { background: var(--purple-light); border-color: var(--purple); color: var(--purple); }

            /* EMPTY STATE */
            .empty-state { text-align: center; padding: 100px 20px; display: flex; flex-direction: column; align-items: center; gap: 16px; }
            .empty-icon-wrap { width: 90px; height: 90px; border-radius: 24px; background: var(--purple-light); display: flex; align-items: center; justify-content: center; font-size: 2.8rem; }
            .empty-title { font-family: 'Playfair Display', serif; font-size: 1.4rem; font-weight: 700; color: var(--text); }
            .empty-sub { font-size: 0.9rem; color: var(--muted); max-width: 360px; line-height: 1.6; }
            .btn-explore { display: inline-flex; align-items: center; gap: 8px; background: linear-gradient(135deg, var(--purple), var(--purple-dark)); color: #fff; text-decoration: none; font-size: 0.88rem; font-weight: 700; padding: 12px 28px; border-radius: 12px; transition: all 0.18s; box-shadow: 0 4px 16px rgba(108,63,197,0.3); margin-top: 8px; }
            .btn-explore:hover { transform: translateY(-2px); box-shadow: 0 8px 24px rgba(108,63,197,0.45); color: #fff; }

            /* HIDDEN for tab filter */
            .course-card.hidden { display: none; }

            /* BG VARIANTS */
            .bg1 { background: linear-gradient(135deg, #1E0A4A, #6C3FC5); }
            .bg2 { background: linear-gradient(135deg, #3A1A7A, #9B72E8); }
            .bg3 { background: linear-gradient(135deg, #4E2C96, #D4A843); }
            .bg4 { background: linear-gradient(135deg, #1A0D35, #5B2DC5); }
            .bg5 { background: linear-gradient(135deg, #0D47A1, #1565C0); }
            .bg6 { background: linear-gradient(135deg, #1B5E20, #388E3C); }

            /* FOOTER */
            footer { background: var(--purple-deep); padding: 32px 80px; margin-top: 40px; }
            .footer-inner { display: flex; justify-content: space-between; align-items: center; border-top: 1px solid rgba(255,255,255,0.08); padding-top: 20px; }

            @media (max-width: 1100px) { .course-grid { grid-template-columns: repeat(2, 1fr); } }
            @media (max-width: 700px) {
                .course-grid { grid-template-columns: 1fr; }
                .main-content, .page-header { padding-left: 20px; padding-right: 20px; }
                .navbar-main { padding: 0 20px; }
                .nav-links { display: none; }
            }
        </style>
    </head>
    <body>

        <c:if test="${empty sessionScope.user}">
            <c:redirect url="login.jsp"/>
        </c:if>

        <%-- Đếm số khóa đã hoàn thành --%>
        <c:set var="completedCount" value="0"/>
        <c:set var="inProgressCount" value="0"/>
        <c:if test="${not empty MY_COURSES}">
            <c:forEach var="course" items="${MY_COURSES}">
                <c:choose>
                    <c:when test="${course.status eq '2'}">
                        <c:set var="completedCount" value="${completedCount + 1}"/>
                    </c:when>
                    <c:otherwise>
                        <c:set var="inProgressCount" value="${inProgressCount + 1}"/>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </c:if>

        <!-- NAVBAR -->
        <nav class="navbar-main">
            <a href="homePage.jsp" class="brand">DUK<span>Academy</span></a>
            <ul class="nav-links">
                <li><a href="homePage.jsp">Trang chủ</a></li>
                <li><a href="courseController?action=ExploreCourse">Khóa học</a></li>
                <li><a href="myCourses" class="active">Khóa học của tôi</a></li>
                <li><a href="dating.jsp">study and date</a></li>
            </ul>
            <div class="nav-right">
                <c:if test="${not empty sessionScope.user}">
                    <a href="payment.jsp" style="display:flex;align-items:center;gap:7px;background:rgba(212,168,67,0.12);border:1px solid rgba(212,168,67,0.35);border-radius:8px;padding:7px 14px;text-decoration:none;">
                        <i class="bi bi-wallet2" style="color:var(--gold);"></i>
                        <span style="font-size:0.75rem;font-weight:500;color:rgba(255,255,255,0.6);">Số dư</span>
                        <span style="font-size:0.875rem;font-weight:700;color:var(--gold);">
                            <fmt:formatNumber value="${sessionScope.user.balance}" type="number"/> ₫
                        </span>
                    </a>
                    <a href="#" class="user-menu">
                        <div class="user-avatar">${fn:substring(sessionScope.user.fullname, 0, 1)}</div>
                        <span class="user-name">${sessionScope.user.fullname}</span>
                    </a>
                </c:if>
            </div>
        </nav>

        <!-- PAGE HEADER -->
        <div class="page-header">
            <div class="page-header-inner">
                <div class="page-eyebrow">✦ Học tập của bạn</div>
                <h1 class="page-title">Khóa học của tôi</h1>
                <p class="page-subtitle">Tiếp tục hành trình học tập — kiến thức đang chờ bạn khám phá.</p>
                <div class="header-stats">
                    <div>
                        <div class="stat-num">${not empty MY_COURSES ? fn:length(MY_COURSES) : 0}</div>
                        <div class="stat-lbl">Khóa đã đăng ký</div>
                    </div>
                    <div>
                        <div class="stat-num">${inProgressCount}</div>
                        <div class="stat-lbl">Đang học</div>
                    </div>
                    <div>
                        <div class="stat-num">${completedCount}</div>
                        <div class="stat-lbl">Đã hoàn thành</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- MAIN -->
        <div class="main-content">
            <c:choose>
                <c:when test="${not empty MY_COURSES}">

                    <%-- TAB BAR --%>
                    <div class="tab-bar">
                        <button class="tab-btn active" onclick="filterTab(this, 'all')">
                            <i class="bi bi-collection-play-fill"></i> Tất cả
                            <span class="tab-count">${fn:length(MY_COURSES)}</span>
                        </button>
                        <button class="tab-btn" onclick="filterTab(this, 'progress')">
                            <i class="bi bi-play-circle-fill"></i> Đang học
                            <span class="tab-count">${inProgressCount}</span>
                        </button>
                        <button class="tab-btn" onclick="filterTab(this, 'done')">
                            <i class="bi bi-trophy-fill"></i> Đã hoàn thành
                            <span class="tab-count">${completedCount}</span>
                        </button>
                    </div>

                    <div class="course-grid" id="courseGrid">
                        <c:forEach var="course" items="${MY_COURSES}" varStatus="st">
                            <c:set var="isDone" value="${course.status eq '2'}"/>
                            <div class="course-card ${isDone ? 'completed' : ''}" data-status="${isDone ? 'done' : 'progress'}">
                                <!-- Thumbnail -->
                                <div class="card-thumb bg${(st.index % 6) + 1}">
                                    <img src="${pageContext.request.contextPath}/img/courses/course${course.courseId}.jpg"
                                         alt="${course.courseName}" onerror="this.style.display='none';">
                                    <div class="card-thumb-overlay"></div>
                                    <span class="card-topic-badge">${course.topic}</span>
                                    <c:if test="${isDone}">
                                        <span class="card-completed-badge">
                                            <i class="bi bi-trophy-fill"></i> Hoàn thành
                                        </span>
                                    </c:if>
                                    <div class="card-progress-wrap">
                                        <div class="card-progress-fill ${isDone ? 'full' : ''}"
                                             style="${isDone ? '' : 'width:40%;'}"></div>
                                    </div>
                                </div>

                                <!-- Body -->
                                <div class="card-body">
                                    <div class="card-org"><i class="bi bi-building"></i> DUK Academy</div>
                                    <div class="card-name">${course.courseName}</div>
                                    <div class="card-meta">
                                        <span><i class="bi bi-play-circle"></i> Video bài giảng</span>
                                        <span><i class="bi bi-people"></i> 1.2K học viên</span>
                                    </div>
                                </div>

                                <!-- Footer -->
                                <div class="card-footer">
                                    <c:choose>
                                        <c:when test="${isDone}">
                                            <span class="card-fee done">
                                                <i class="bi bi-trophy-fill"></i> Hoàn thành
                                            </span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="card-fee ${course.fee == 0 ? 'free' : ''}">
                                                <i class="bi bi-check-circle-fill"></i>
                                                <c:choose>
                                                    <c:when test="${course.fee == 0}">Miễn phí</c:when>
                                                    <c:otherwise><fmt:formatNumber value="${course.fee}" type="number"/> ₫</c:otherwise>
                                                </c:choose>
                                            </span>
                                        </c:otherwise>
                                    </c:choose>

                                    <div style="display:flex;gap:8px;align-items:center;">
                                        <%-- Nút "Vào học" luôn có, dù đã hoàn thành vẫn học lại được --%>
                                        <a href="lesson?courseId=${course.courseId}" class="${isDone ? 'btn-review' : 'btn-study'}">
                                            <i class="bi bi-${isDone ? 'arrow-repeat' : 'play-circle-fill'}"></i>
                                            ${isDone ? 'Học lại' : 'Vào học'}
                                        </a>
                                        <%-- Nút "Nhận chứng chỉ" chỉ hiện khi đã hoàn thành --%>
                                        <c:if test="${isDone}">
                                            <a href="certificate?courseId=${course.courseId}" class="btn-cert">
                                                <i class="bi bi-award-fill"></i> Chứng chỉ
                                            </a>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                </c:when>

                <c:otherwise>
                    <div class="empty-state">
                        <div class="empty-icon-wrap">📚</div>
                        <div class="empty-title">Chưa có khóa học nào</div>
                        <p class="empty-sub">Bạn chưa đăng ký khóa học nào. Hãy khám phá thư viện khóa học và bắt đầu hành trình học tập!</p>
                        <a href="courseController?action=ExploreCourse" class="btn-explore">
                            <i class="bi bi-compass-fill"></i> Khám phá khóa học
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- FOOTER -->
        <footer>
            <div class="footer-inner">
                <span style="font-family:'Playfair Display',serif;font-size:1.2rem;font-weight:700;color:#fff;">
                    DUK<span style="color:var(--gold);">Academy</span>
                </span>
                <span style="font-size:0.78rem;color:rgba(255,255,255,0.35);">© 2026 DUK Academy. All rights reserved.</span>
            </div>
        </footer>

        <script>
            function filterTab(el, type) {
                // Update tab active state
                document.querySelectorAll('.tab-btn').forEach(function(b) { b.classList.remove('active'); });
                el.classList.add('active');

                // Show/hide cards
                document.querySelectorAll('.course-card').forEach(function(card) {
                    if (type === 'all') {
                        card.classList.remove('hidden');
                    } else if (type === 'done') {
                        card.dataset.status === 'done' ? card.classList.remove('hidden') : card.classList.add('hidden');
                    } else {
                        card.dataset.status === 'progress' ? card.classList.remove('hidden') : card.classList.add('hidden');
                    }
                });
            }
        </script>

    </body>
</html>
