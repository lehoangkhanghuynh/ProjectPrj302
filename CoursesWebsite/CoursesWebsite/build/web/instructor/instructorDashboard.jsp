<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<fmt:setLocale value="vi_VN" scope="session"/>
<!DOCTYPE html>
<html lang="vi">
<head>
    <base href="${pageContext.request.contextPath}/">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Instructor Dashboard - DUK Academy</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="icon" type="image/jpeg" href="img/page/favicon.jpg">
    <style>
        :root {
            --purple:      #6C3FC5;
            --purple-dark: #4E2C96;
            --purple-deep: #1E0A4A;
            --purple-light:#F3EEFF;
            --gold:        #D4A843;
            --text:        #1A1A2E;
            --muted:       #6B6B8A;
            --border:      #E2D9F3;
            --bg:          #F4F0FC;
            --sidebar-w:   240px;
        }
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'DM Sans', sans-serif; background: var(--bg); color: var(--text); display: flex; min-height: 100vh; }

        /* ── SIDEBAR ── */
        .sidebar {
            width: var(--sidebar-w);
            background: var(--purple-deep);
            min-height: 100vh;
            position: fixed; left: 0; top: 0;
            display: flex; flex-direction: column;
            z-index: 100;
        }
        .sidebar-logo {
            padding: 22px 20px 18px;
            border-bottom: 1px solid rgba(255,255,255,0.08);
            font-size: 1.3rem; font-weight: 700; color: #fff;
            text-decoration: none; display: block;
        }
        .sidebar-logo span { color: var(--gold); }
        .sidebar-logo small {
            display: block; font-size: 0.65rem; font-weight: 600;
            color: var(--gold); text-transform: uppercase; letter-spacing: 1.5px; margin-top: 4px;
        }
        .sidebar-user {
            padding: 16px 20px;
            border-bottom: 1px solid rgba(255,255,255,0.08);
            display: flex; align-items: center; gap: 10px;
        }
        .s-avatar {
            width: 40px; height: 40px; border-radius: 50%;
            background: linear-gradient(135deg, #9B72E8, var(--gold));
            display: flex; align-items: center; justify-content: center;
            font-weight: 700; color: #fff; font-size: 1rem; flex-shrink: 0;
        }
        .s-name { font-size: 0.82rem; font-weight: 700; color: #fff; }
        .s-role { font-size: 0.68rem; color: rgba(255,255,255,0.45); }
        .sidebar-nav { flex: 1; padding: 12px; }
        .nav-section-label {
            font-size: 0.58rem; font-weight: 700; text-transform: uppercase;
            letter-spacing: 2px; color: rgba(255,255,255,0.3);
            padding: 10px 10px 5px;
        }
        .s-link {
            display: flex; align-items: center; gap: 10px;
            padding: 9px 12px; border-radius: 8px;
            color: rgba(255,255,255,0.6); text-decoration: none;
            font-size: 0.83rem; font-weight: 500;
            transition: all 0.15s; margin-bottom: 2px;
        }
        .s-link i { width: 18px; text-align: center; font-size: 0.95rem; flex-shrink: 0; }
        .s-link:hover { background: rgba(255,255,255,0.08); color: #fff; }
        .s-link.active { background: var(--purple); color: #fff; }
        .sidebar-footer { padding: 12px; border-top: 1px solid rgba(255,255,255,0.08); }
        .s-link.logout { color: rgba(255,120,120,0.7); }
        .s-link.logout:hover { background: rgba(220,38,38,0.12); color: #ff8080; }

        /* ── MAIN ── */
        .main { margin-left: var(--sidebar-w); flex: 1; display: flex; flex-direction: column; }

        /* ── TOPBAR ── */
        .topbar {
            background: #fff; border-bottom: 1px solid var(--border);
            padding: 0 28px; height: 58px;
            display: flex; align-items: center; justify-content: space-between;
            position: sticky; top: 0; z-index: 90;
        }
        .topbar-title { font-size: 1rem; font-weight: 700; color: var(--text); }
        .topbar-right { display: flex; align-items: center; gap: 10px; }
        .btn-primary {
            display: inline-flex; align-items: center; gap: 6px;
            background: var(--purple); color: #fff; text-decoration: none;
            font-size: 0.8rem; font-weight: 700; padding: 7px 16px;
            border-radius: 8px; transition: background 0.15s; border: none; cursor: pointer;
            font-family: 'DM Sans', sans-serif;
        }
        .btn-primary:hover { background: var(--purple-dark); color: #fff; }
        .btn-outline {
            display: inline-flex; align-items: center; gap: 6px;
            color: var(--muted); text-decoration: none;
            font-size: 0.8rem; font-weight: 500; padding: 7px 12px;
            border-radius: 8px; border: 1px solid var(--border);
            transition: all 0.15s; background: #fff;
        }
        .btn-outline:hover { background: var(--purple-light); color: var(--purple); border-color: var(--purple); }

        /* ── CONTENT ── */
        .page-content { padding: 28px; }

        /* STAT CARDS */
        .stats-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 16px; margin-bottom: 28px; }
        .stat-card {
            background: #fff; border: 1px solid var(--border);
            border-radius: 14px; padding: 20px;
            display: flex; align-items: center; gap: 14px;
        }
        .stat-icon {
            width: 46px; height: 46px; border-radius: 12px;
            display: flex; align-items: center; justify-content: center;
            font-size: 1.3rem; flex-shrink: 0;
        }
        .icon-purple { background: var(--purple-light); color: var(--purple); }
        .icon-gold   { background: #FEF9EC; color: var(--gold); }
        .icon-green  { background: #DCFCE7; color: #16A34A; }
        .icon-blue   { background: #EFF6FF; color: #2563EB; }
        .stat-num { font-size: 1.35rem; font-weight: 700; color: var(--text); line-height: 1; }
        .stat-lbl { font-size: 0.72rem; color: var(--muted); margin-top: 3px; }

        /* SECTION TITLE */
        .section-title {
            font-size: 0.95rem; font-weight: 700; color: var(--text);
            margin-bottom: 14px; display: flex; align-items: center; gap: 8px;
        }
        .section-title::before {
            content: ''; width: 4px; height: 16px;
            background: var(--purple); border-radius: 2px;
        }

        /* QUICK ACTIONS */
        .quick-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 14px; margin-bottom: 28px; }
        .quick-card {
            background: #fff; border: 1px solid var(--border);
            border-radius: 12px; padding: 18px;
            text-decoration: none; color: var(--text);
            display: flex; align-items: center; gap: 14px;
            transition: all 0.18s;
        }
        .quick-card:hover {
            border-color: var(--purple);
            box-shadow: 0 4px 16px rgba(108,63,197,0.1);
            color: var(--text); transform: translateY(-2px);
        }
        .quick-icon {
            width: 42px; height: 42px; border-radius: 10px;
            background: var(--purple-light); color: var(--purple);
            display: flex; align-items: center; justify-content: center;
            font-size: 1.1rem; flex-shrink: 0;
        }
        .quick-label { font-size: 0.85rem; font-weight: 700; }
        .quick-desc  { font-size: 0.7rem; color: var(--muted); margin-top: 2px; }

        /* TABLE */
        .table-wrap {
            background: #fff; border: 1px solid var(--border);
            border-radius: 14px; overflow: hidden;
        }
        .table-head {
            padding: 14px 20px;
            border-bottom: 1px solid var(--border);
            display: flex; align-items: center; justify-content: space-between;
        }
        .table-head-title { font-size: 0.9rem; font-weight: 700; }
        table { width: 100%; border-collapse: collapse; }
        thead th {
            background: var(--bg); padding: 10px 16px;
            font-size: 0.7rem; font-weight: 700; color: var(--muted);
            text-transform: uppercase; letter-spacing: 0.5px;
            border-bottom: 1px solid var(--border); text-align: left;
        }
        tbody td {
            padding: 12px 16px; font-size: 0.83rem;
            border-bottom: 1px solid var(--border);
        }
        tbody tr:last-child td { border-bottom: none; }
        tbody tr:hover { background: var(--bg); }

        /* BADGES */
        .badge-pill {
            display: inline-flex; align-items: center; gap: 4px;
            font-size: 0.68rem; font-weight: 700; padding: 3px 9px; border-radius: 20px;
        }
        .badge-pill::before { content: ''; width: 5px; height: 5px; border-radius: 50%; background: currentColor; }
        .badge-active   { background: #DCFCE7; color: #16A34A; }
        .badge-pending  { background: #FEF3C7; color: #D97706; }
        .badge-inactive { background: #FEE2E2; color: #DC2626; }

        /* ACTION BTNs */
        .btn-sm {
            display: inline-flex; align-items: center; gap: 4px;
            font-size: 0.73rem; font-weight: 600; padding: 5px 10px;
            border-radius: 7px; text-decoration: none; border: none;
            cursor: pointer; transition: all 0.15s;
            font-family: 'DM Sans', sans-serif;
        }
        .btn-edit { background: var(--purple-light); color: var(--purple); }
        .btn-edit:hover { background: var(--purple); color: #fff; }
        .btn-view { background: #EFF6FF; color: #2563EB; }
        .btn-view:hover { background: #2563EB; color: #fff; }
        .btn-del  { background: #FEE2E2; color: #DC2626; }
        .btn-del:hover  { background: #DC2626; color: #fff; }

        /* EMPTY */
        .empty-state { padding: 48px; text-align: center; color: var(--muted); }
        .empty-state i { font-size: 2.5rem; opacity: 0.25; display: block; margin-bottom: 12px; }
        .empty-state p { font-size: 0.85rem; line-height: 1.7; }

        /* DELETE MODAL */
        .modal-overlay {
            display: none;
            position: fixed; inset: 0;
            background: rgba(10,5,30,0.55);
            z-index: 500;
            align-items: center;
            justify-content: center;
        }
        .modal-overlay.show { display: flex; }
        .modal-box {
            background: #fff; border-radius: 16px;
            padding: 30px 28px; width: 360px; max-width: 95vw;
            text-align: center;
            box-shadow: 0 16px 50px rgba(0,0,0,0.18);
        }
        .modal-icon-del {
            width: 52px; height: 52px; background: #FEE2E2;
            border-radius: 50%; display: flex; align-items: center;
            justify-content: center; margin: 0 auto 14px;
            font-size: 1.4rem; color: #DC2626;
        }
        .modal-actions { display: flex; gap: 10px; justify-content: center; margin-top: 22px; }
        .btn-modal-cancel {
            padding: 8px 20px; border-radius: 8px;
            border: 1px solid var(--border); background: #fff;
            font-size: 0.82rem; font-weight: 600; cursor: pointer;
            font-family: 'DM Sans', sans-serif;
        }
        .btn-modal-del {
            padding: 8px 20px; border-radius: 8px;
            background: #DC2626; color: #fff; border: none;
            font-size: 0.82rem; font-weight: 700; cursor: pointer;
            font-family: 'DM Sans', sans-serif;
        }
        .btn-modal-del:hover { background: #B91C1C; }

        @media (max-width: 1024px) {
            .stats-grid { grid-template-columns: repeat(2, 1fr); }
            .quick-grid { grid-template-columns: repeat(2, 1fr); }
        }
    </style>
</head>
<body>

<!-- SIDEBAR -->
<aside class="sidebar">
    <a href="homePage.jsp" class="sidebar-logo">
        DUK<span>Academy</span>
        <small>✦ Instructor Portal</small>
    </a>
    <div class="sidebar-user">
        <div class="s-avatar">${fn:substring(sessionScope.user.fullname, 0, 1)}</div>
        <div>
            <div class="s-name">${sessionScope.user.fullname}</div>
            <div class="s-role">Giảng viên</div>
        </div>
    </div>
    <nav class="sidebar-nav">
        <div class="nav-section-label">Tổng quan</div>
        <a href="instructorController?action=dashboard" class="s-link active">
            <i class="bi bi-grid-1x2-fill"></i> Dashboard
        </a>
        <div class="nav-section-label">Quản lý</div>
        <a href="mainController?action=viewMyCourses" class="s-link">
            <i class="bi bi-collection-play-fill"></i> Khóa học của tôi
        </a>
        <a href="instructorController?action=showCreateForm" class="s-link">
            <i class="bi bi-plus-circle-fill"></i> Tạo khóa học mới
        </a>
        <div class="nav-section-label">Tài khoản</div>
        <a href="user/myprofile.jsp" class="s-link">
            <i class="bi bi-person-fill"></i> Hồ sơ cá nhân
        </a>
    </nav>
    <div class="sidebar-footer">
        <a href="homePage.jsp" class="s-link"><i class="bi bi-house-fill"></i> Trang chủ</a>
        <a href="mainController?action=logout" class="s-link logout">
            <i class="bi bi-box-arrow-right"></i> Đăng xuất
        </a>
    </div>
</aside>

<!-- MAIN -->
<div class="main">

    <!-- TOPBAR -->
    <div class="topbar">
        <div class="topbar-title">Instructor Dashboard</div>
        <div class="topbar-right">
            <a href="instructorController?action=showCreateForm" class="btn-primary">
                <i class="bi bi-plus-lg"></i> Tạo khóa học mới
            </a>
            <a href="homePage.jsp" class="btn-outline">
                <i class="bi bi-arrow-left"></i> Trang chủ
            </a>
        </div>
    </div>

    <div class="page-content">

        <!-- STAT CARDS -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon icon-purple"><i class="bi bi-collection-play-fill"></i></div>
                <div>
                    <div class="stat-num">${TOTAL_COURSES}</div>
                    <div class="stat-lbl">Khóa học</div>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon icon-gold"><i class="bi bi-people-fill"></i></div>
                <div>
                    <div class="stat-num">${TOTAL_STUDENTS}</div>
                    <div class="stat-lbl">Học viên</div>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon icon-green"><i class="bi bi-cash-stack"></i></div>
                <div>
                    <div class="stat-num">
                        <fmt:formatNumber value="${TOTAL_REVENUE}" type="number" maxFractionDigits="0"/> ₫
                    </div>
                    <div class="stat-lbl">Doanh thu</div>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon icon-blue"><i class="bi bi-star-fill"></i></div>
                <div>
                    <div class="stat-num">
                        <c:choose>
                            <c:when test="${AVG_RATING > 0}">
                                <fmt:formatNumber value="${AVG_RATING}" maxFractionDigits="1"/> ★
                            </c:when>
                            <c:otherwise>—</c:otherwise>
                        </c:choose>
                    </div>
                    <div class="stat-lbl">Đánh giá TB</div>
                </div>
            </div>
        </div>

        <!-- QUICK ACTIONS -->
        <div class="section-title">Thao tác nhanh</div>
        <div class="quick-grid">
            <a href="instructorController?action=showCreateForm" class="quick-card">
                <div class="quick-icon"><i class="bi bi-plus-circle-fill"></i></div>
                <div>
                    <div class="quick-label">Tạo khóa học mới</div>
                    <div class="quick-desc">Thêm nội dung, bài giảng</div>
                </div>
            </a>
            <a href="mainController?action=viewMyCourses" class="quick-card">
                <div class="quick-icon"><i class="bi bi-pencil-square"></i></div>
                <div>
                    <div class="quick-label">Quản lý khóa học</div>
                    <div class="quick-desc">Chỉnh sửa, cập nhật nội dung</div>
                </div>
            </a>
            <a href="user/myprofile.jsp" class="quick-card">
                <div class="quick-icon"><i class="bi bi-person-badge-fill"></i></div>
                <div>
                    <div class="quick-label">Hồ sơ giảng viên</div>
                    <div class="quick-desc">Cập nhật thông tin cá nhân</div>
                </div>
            </a>
        </div>

        <!-- COURSES TABLE -->
        <div class="section-title">Khóa học của tôi</div>
        <div class="table-wrap">
            <div class="table-head">
                <div class="table-head-title">Danh sách khóa học</div>
                <a href="instructor/instructorCreateCourse.jsp" class="btn-sm btn-edit">
                    <i class="bi bi-plus-lg"></i> Thêm mới
                </a>
            </div>
            <c:choose>
                <c:when test="${not empty COURSE_LIST}">
                    <table>
                        <thead>
                            <tr>
                                <th>#</th>
                                <th>Tên khóa học</th>
                                <th>Học phí</th>
                                <th>Trạng thái</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="course" items="${COURSE_LIST}" varStatus="st">
                                <tr>
                                    <td style="color:var(--muted);font-size:0.75rem;">${st.index + 1}</td>
                                    <td>
                                        <div style="font-weight:600;font-size:0.85rem;">${course.courseName}</div>
                                        <div style="font-size:0.7rem;color:var(--muted);">${course.topic}</div>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${course.fee == 0}">
                                                <span style="color:#16A34A;font-weight:600;font-size:0.8rem;">Miễn phí</span>
                                            </c:when>
                                            <c:otherwise>
                                                <fmt:formatNumber value="${course.fee}" type="number" maxFractionDigits="0"/> ₫
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${course.status == 'active'}">
                                                <span class="badge-pill badge-active">Đang mở</span>
                                            </c:when>
                                            <c:when test="${course.status == 'deleted'}">
                                                <span class="badge-pill badge-inactive">Ẩn</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge-pill badge-pending">Chờ duyệt</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <div style="display:flex;gap:6px;flex-wrap:wrap;">
                                            <a href="courseController?action=detail&courseId=${course.courseId}"
                                               class="btn-sm btn-view">
                                                <i class="bi bi-eye"></i> Xem
                                            </a>

                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <div class="empty-state">
                        <i class="bi bi-collection-play"></i>
                        <p>Bạn chưa có khóa học nào.<br>
                            <a href="instructorController?action=showCreateForm"
                               style="color:var(--purple);font-weight:700;">Tạo khóa học đầu tiên →</a>
                        </p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

    </div>
</div>

<div class="modal-overlay" id="delModal"
     onclick="if(event.target===this) this.classList.remove('show')">
    <div class="modal-box">
        <div class="modal-icon-del"><i class="bi bi-trash3"></i></div>
        <div style="font-size:0.95rem;font-weight:700;margin-bottom:6px;">Xóa khóa học?</div>
        <div id="delCourseName" style="font-size:0.82rem;color:var(--muted);margin-bottom:4px;"></div>
        <div style="font-size:0.75rem;color:#DC2626;margin-bottom:4px;">Hành động này không thể hoàn tác.</div>
        <div class="modal-actions">
            <%-- Nút Hủy: bỏ class show để đóng modal --%>
            <button type="button" class="btn-modal-cancel"
                    onclick="document.getElementById('delModal').classList.remove('show')">
                Hủy
            </button>

            <form method="post" action="instructorController" style="margin:0;">
                <input type="hidden" name="action"   value="deleteCourse">
                <input type="hidden" name="courseId" id="delCourseId" value="">
                <button type="submit" class="btn-modal-del">
                    <i class="bi bi-trash3"></i> Xóa
                </button>
            </form>
        </div>
    </div>
</div>

</body>
</html>
