<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.CourseDTO"%>
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
        <title>Khóa học của tôi - DUK Academy</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
        <link rel="icon" type="image/jpeg" href="img/page/favicon.jpg">
        <style>
            :root {
                --purple:       #6C3FC5;
                --purple-dark:  #4E2C96;
                --purple-deep:  #1E0A4A;
                --purple-light: #F3EEFF;
                --gold:         #D4A843;
                --text:         #1A1A2E;
                --muted:        #6B6B8A;
                --border:       #E2D9F3;
                --bg:           #F4F0FC;
                --sidebar-w:    240px;
            }
            * { box-sizing: border-box; margin: 0; padding: 0; }
            body {
                font-family: 'DM Sans', sans-serif;
                background: var(--bg);
                color: var(--text);
                display: flex;
                min-height: 100vh;
            }
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
                color: var(--gold); text-transform: uppercase;
                letter-spacing: 1.5px; margin-top: 4px;
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
                letter-spacing: 2px; color: rgba(255,255,255,0.3); padding: 10px 10px 5px;
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
            .main { margin-left: var(--sidebar-w); flex: 1; display: flex; flex-direction: column; }
            .topbar {
                background: #fff; border-bottom: 1px solid var(--border);
                padding: 0 28px; height: 58px;
                display: flex; align-items: center; justify-content: space-between;
                position: sticky; top: 0; z-index: 90;
            }
            .topbar-title { font-size: 1rem; font-weight: 700; }
            .topbar-right { display: flex; gap: 10px; align-items: center; }
            .btn-primary {
                display: inline-flex; align-items: center; gap: 6px;
                background: var(--purple); color: #fff; text-decoration: none;
                font-size: 0.8rem; font-weight: 700; padding: 7px 16px;
                border-radius: 8px; transition: background 0.15s;
            }
            .btn-primary:hover { background: var(--purple-dark); color: #fff; }
            .btn-outline {
                display: inline-flex; align-items: center; gap: 6px;
                color: var(--muted); text-decoration: none;
                font-size: 0.8rem; font-weight: 500; padding: 7px 14px;
                border-radius: 8px; border: 1px solid var(--border);
                transition: all 0.15s; background: #fff;
            }
            .btn-outline:hover { background: var(--purple-light); color: var(--purple); border-color: var(--purple); }
            .page-content { padding: 28px; }
            .breadcrumb-bar {
                display: flex; align-items: center; gap: 8px;
                font-size: 0.78rem; color: var(--muted); margin-bottom: 22px;
            }
            .breadcrumb-bar a { color: var(--purple); text-decoration: none; font-weight: 600; }
            .breadcrumb-bar a:hover { text-decoration: underline; }
            .breadcrumb-bar i { font-size: 0.65rem; }
            .search-bar { display: flex; align-items: center; gap: 10px; margin-bottom: 20px; }
            .search-wrap { position: relative; flex: 1; max-width: 320px; }
            .search-wrap i {
                position: absolute; left: 12px; top: 50%; transform: translateY(-50%);
                color: var(--muted); font-size: 0.9rem; pointer-events: none;
            }
            .search-input {
                width: 100%; padding: 8px 14px 8px 36px;
                border: 1.5px solid var(--border); border-radius: 9px;
                font-size: 0.83rem; font-family: 'DM Sans', sans-serif;
                outline: none; transition: border-color 0.15s; background: #fff;
            }
            .search-input:focus { border-color: var(--purple); }
            .count-label { font-size: 0.8rem; color: var(--muted); margin-left: auto; }
            .count-label strong { color: var(--text); }
            .table-wrap {
                background: #fff; border: 1px solid var(--border);
                border-radius: 14px; overflow: hidden;
            }
            table { width: 100%; border-collapse: collapse; }
            thead th {
                background: var(--bg); padding: 10px 16px;
                font-size: 0.7rem; font-weight: 700; color: var(--muted);
                text-transform: uppercase; letter-spacing: 0.5px;
                border-bottom: 1px solid var(--border); text-align: left; white-space: nowrap;
            }
            tbody td {
                padding: 13px 16px; font-size: 0.83rem;
                border-bottom: 1px solid var(--border); vertical-align: middle;
            }
            tbody tr:last-child td { border-bottom: none; }
            tbody tr:hover { background: var(--bg); }
            .course-name { font-weight: 600; font-size: 0.85rem; }
            .course-topic {
                display: inline-block; margin-top: 3px;
                font-size: 0.68rem; font-weight: 700;
                background: var(--purple-light); color: var(--purple);
                padding: 2px 8px; border-radius: 4px;
            }
            .fee-free { color: #16A34A; font-weight: 700; font-size: 0.82rem; }
            .fee-paid { font-size: 0.82rem; font-weight: 600; }
            .badge-pill {
                display: inline-flex; align-items: center; gap: 4px;
                font-size: 0.68rem; font-weight: 700; padding: 3px 9px; border-radius: 20px;
            }
            .badge-pill::before { content: ''; width: 5px; height: 5px; border-radius: 50%; background: currentColor; }
            .badge-active   { background: #DCFCE7; color: #16A34A; }
            .badge-pending  { background: #FEF3C7; color: #D97706; }
            .badge-inactive { background: #FEE2E2; color: #DC2626; }
            .btn-sm {
                display: inline-flex; align-items: center; gap: 4px;
                font-size: 0.73rem; font-weight: 600; padding: 5px 10px;
                border-radius: 7px; text-decoration: none; border: none;
                cursor: pointer; transition: all 0.15s; font-family: 'DM Sans', sans-serif;
            }
            .btn-review { background: var(--purple-light); color: var(--purple); }
            .btn-review:hover { background: var(--purple); color: #fff; }
            .btn-edit   { background: #EFF6FF; color: #2563EB; }
            .btn-edit:hover   { background: #2563EB; color: #fff; }
            .btn-del    { background: #FEE2E2; color: #DC2626; }
            .btn-del:hover    { background: #DC2626; color: #fff; }
            .btn-add-lesson { background: #DCFCE7; color: #16A34A; }
            .btn-add-lesson:hover { background: #16A34A; color: #fff; }
            /* ── NÚT ẨN / MỞ ── */
            .btn-toggle-on  { background: #FEF3C7; color: #D97706; }
            .btn-toggle-on:hover  { background: #D97706; color: #fff; }
            .btn-toggle-off { background: #DCFCE7; color: #16A34A; }
            .btn-toggle-off:hover { background: #16A34A; color: #fff; }
            .empty-state { padding: 56px; text-align: center; color: var(--muted); }
            .empty-state i { font-size: 2.8rem; opacity: 0.2; display: block; margin-bottom: 14px; }
            .empty-state p { font-size: 0.85rem; line-height: 1.8; }
            .modal-overlay {
                display: none; position: fixed; inset: 0;
                background: rgba(10,5,30,0.55); z-index: 500;
                align-items: center; justify-content: center;
            }
            .modal-overlay.show { display: flex; }
            .modal-box {
                background: #fff; border-radius: 16px; padding: 30px 28px;
                width: 360px; max-width: 95vw; text-align: center;
                box-shadow: 0 16px 50px rgba(0,0,0,0.18); animation: popIn 0.2s ease;
            }
            @keyframes popIn { from { transform: scale(0.9); opacity: 0; } to { transform: scale(1); opacity: 1; } }
            .modal-icon {
                width: 52px; height: 52px; background: #FEE2E2; border-radius: 50%;
                display: flex; align-items: center; justify-content: center;
                margin: 0 auto 14px; font-size: 1.4rem; color: #DC2626;
            }
            .modal-title { font-size: 0.95rem; font-weight: 700; margin-bottom: 6px; }
            .modal-sub { font-size: 0.82rem; color: var(--muted); margin-bottom: 22px; }
            .modal-actions { display: flex; gap: 10px; justify-content: center; }
            .btn-modal-cancel {
                padding: 8px 20px; border-radius: 8px;
                border: 1px solid var(--border); background: #fff;
                font-size: 0.82rem; font-weight: 600; cursor: pointer;
                font-family: 'DM Sans', sans-serif;
            }
            .btn-modal-cancel:hover { background: var(--bg); }
            .btn-modal-del {
                padding: 8px 20px; border-radius: 8px;
                background: #DC2626; color: #fff; text-decoration: none;
                font-size: 0.82rem; font-weight: 700; border: none;
                cursor: pointer; font-family: 'DM Sans', sans-serif;
            }
            .btn-modal-del:hover { background: #B91C1C; color: #fff; }
            .lesson-modal-overlay {
                display: none; position: fixed; inset: 0;
                background: rgba(10,5,30,0.55); z-index: 600;
                align-items: center; justify-content: center;
            }
            .lesson-modal-overlay.show { display: flex; }
            .lesson-modal-box {
                background: #fff; border-radius: 16px; padding: 28px 28px 24px;
                width: 560px; max-width: 96vw; max-height: 90vh; overflow-y: auto;
                box-shadow: 0 16px 50px rgba(0,0,0,0.2); animation: popIn 0.2s ease;
            }
            .lesson-modal-header { display: flex; align-items: center; justify-content: space-between; margin-bottom: 4px; }
            .lesson-modal-title { font-size: 1rem; font-weight: 700; color: var(--text); display: flex; align-items: center; gap: 8px; }
            .lesson-modal-title i { color: var(--purple); }
            .lesson-modal-close {
                background: none; border: none; font-size: 1.2rem; color: var(--muted);
                cursor: pointer; padding: 2px 6px; border-radius: 6px; transition: background 0.15s;
            }
            .lesson-modal-close:hover { background: var(--bg); color: var(--text); }
            .lesson-modal-sub { font-size: 0.78rem; color: var(--muted); margin-bottom: 20px; }
            .lesson-divider { border: none; border-top: 1px solid var(--border); margin: 18px 0; }
            .lesson-list { display: flex; flex-direction: column; gap: 12px; }
            .lesson-item {
                background: var(--bg); border: 1.5px solid var(--border);
                border-radius: 10px; padding: 14px 16px; position: relative;
            }
            .lesson-item-header { display: flex; align-items: center; justify-content: space-between; margin-bottom: 10px; }
            .lesson-item-num {
                font-size: 0.7rem; font-weight: 700; color: var(--purple);
                background: var(--purple-light); padding: 2px 8px; border-radius: 4px;
            }
            .btn-remove-lesson {
                background: #FEE2E2; color: #DC2626; border: none;
                font-size: 0.72rem; font-weight: 600; padding: 3px 9px;
                border-radius: 6px; cursor: pointer; font-family: 'DM Sans', sans-serif; transition: background 0.15s;
            }
            .btn-remove-lesson:hover { background: #DC2626; color: #fff; }
            .l-form-group { margin-bottom: 10px; }
            .l-form-label { font-size: 0.75rem; font-weight: 600; color: var(--text); display: block; margin-bottom: 5px; }
            .l-form-label span { color: var(--muted); font-weight: 400; }
            .l-form-input {
                width: 100%; padding: 8px 12px; border: 1.5px solid var(--border);
                border-radius: 8px; font-size: 0.83rem; font-family: 'DM Sans', sans-serif;
                outline: none; background: #fff; transition: border 0.15s;
            }
            .l-form-input:focus { border-color: var(--purple); }
            .video-upload-wrap { margin-top: 6px; }
            .video-tabs {
                display: flex; gap: 0; margin-bottom: 10px;
                border: 1.5px solid var(--border); border-radius: 8px; overflow: hidden;
            }
            .video-tab {
                flex: 1; padding: 7px 0; text-align: center;
                font-size: 0.75rem; font-weight: 600; cursor: pointer;
                background: #fff; color: var(--muted); transition: all 0.15s;
                border: none; font-family: 'DM Sans', sans-serif;
            }
            .video-tab.active { background: var(--purple); color: #fff; }
            .video-panel { display: none; }
            .video-panel.active { display: block; }
            .upload-zone-sm {
                border: 2px dashed var(--border); border-radius: 8px; padding: 16px;
                text-align: center; cursor: pointer; transition: border-color 0.15s; background: #fff;
            }
            .upload-zone-sm:hover { border-color: var(--purple); background: var(--purple-light); }
            .upload-zone-sm i { font-size: 1.4rem; color: var(--muted); display: block; margin-bottom: 6px; }
            .upload-zone-sm span { font-size: 0.75rem; color: var(--muted); }
            .upload-zone-sm .browse { color: var(--purple); font-weight: 700; text-decoration: underline; cursor: pointer; }
            .upload-file-name { font-size: 0.75rem; color: #16A34A; font-weight: 600; margin-top: 6px; display: none; }
            .btn-add-more {
                display: flex; align-items: center; justify-content: center; gap: 6px;
                width: 100%; padding: 10px; border: 2px dashed var(--border);
                border-radius: 10px; background: none; color: var(--purple);
                font-size: 0.82rem; font-weight: 700; cursor: pointer;
                font-family: 'DM Sans', sans-serif; transition: all 0.15s; margin-top: 4px;
            }
            .btn-add-more:hover { border-color: var(--purple); background: var(--purple-light); }
            .lesson-modal-footer { display: flex; gap: 10px; justify-content: flex-end; margin-top: 20px; }
            .btn-lm-cancel {
                padding: 9px 22px; border-radius: 8px; border: 1.5px solid var(--border);
                background: #fff; color: var(--muted); font-size: 0.83rem; font-weight: 600;
                cursor: pointer; font-family: 'DM Sans', sans-serif;
            }
            .btn-lm-submit {
                padding: 9px 24px; border-radius: 8px; border: none;
                background: var(--purple); color: #fff; font-size: 0.83rem; font-weight: 700;
                cursor: pointer; font-family: 'DM Sans', sans-serif; transition: background 0.15s;
                display: flex; align-items: center; gap: 6px;
            }
            .btn-lm-submit:hover { background: var(--purple-dark); }
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
                <a href="instructorController?action=dashboard" class="s-link">
                    <i class="bi bi-grid-1x2-fill"></i> Dashboard
                </a>
                <div class="nav-section-label">Quản lý</div>
                <a href="instructorController?action=viewMyCourses" class="s-link active">
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
                <a href="homePage.jsp" class="s-link">
                    <i class="bi bi-house-fill"></i> Trang chủ
                </a>
                <a href="mainController?action=logout" class="s-link logout">
                    <i class="bi bi-box-arrow-right"></i> Đăng xuất
                </a>
            </div>
        </aside>

        <!-- MAIN -->
        <div class="main">

            <!-- TOPBAR -->
            <div class="topbar">
                <div class="topbar-title">Khóa học của tôi</div>
                <div class="topbar-right">
                    <a href="instructor/instructorCreateCourse.jsp" class="btn-primary">
                        <i class="bi bi-plus-lg"></i> Tạo khóa học mới
                    </a>
                    <a href="instructorController?action=dashboard" class="btn-outline">
                        <i class="bi bi-arrow-left"></i> Dashboard
                    </a>
                </div>
            </div>

            <div class="page-content">

                <!-- BREADCRUMB -->
                <div class="breadcrumb-bar">
                    <a href="instructorController?action=dashboard">Dashboard</a>
                    <i class="bi bi-chevron-right"></i>
                    <span>Khóa học của tôi</span>
                </div>

                <!-- SEARCH + COUNT -->
                <div class="search-bar">
                    <div class="search-wrap">
                        <i class="bi bi-search"></i>
                        <input type="text" class="search-input" id="searchInput"
                               placeholder="Tìm tên hoặc chủ đề..." oninput="filterTable()">
                    </div>
                    <div class="count-label">
                        Tổng: <strong id="countDisplay">${fn:length(COURSE_LIST)}</strong> khóa học
                    </div>
                </div>

                <!-- TABLE -->
                <div class="table-wrap">
                    <c:choose>
                        <c:when test="${not empty COURSE_LIST}">
                            <table id="courseTable">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Khóa học</th>
                                        <th>Học phí</th>
                                        <th>Trạng thái</th>
                                        <th>Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="c" items="${COURSE_LIST}" varStatus="st">
                                        <tr data-name="${fn:toLowerCase(c.courseName)}"
                                            data-topic="${fn:toLowerCase(c.topic)}">
                                            <td style="color:var(--muted);font-size:0.75rem;width:40px;">${st.index + 1}</td>
                                            <td>
                                                <div class="course-name">${c.courseName}</div>
                                                <span class="course-topic">${c.topic}</span>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${c.fee == 0}">
                                                        <span class="fee-free"><i class="bi bi-gift-fill"></i> Miễn phí</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="fee-paid">
                                                            <fmt:formatNumber value="${c.fee}" type="number" maxFractionDigits="0"/> ₫
                                                        </span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${c.status == 'active'}">
                                                        <span class="badge-pill badge-active">Đang mở</span>
                                                    </c:when>
                                                    <c:when test="${c.status == 'pending'}">
                                                        <span class="badge-pill badge-pending">Chờ duyệt</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge-pill badge-inactive">Ẩn</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <div style="display:flex;gap:6px;flex-wrap:wrap;">

                                                    <a href="${pageContext.request.contextPath}/instructorController?action=viewReviews&courseId=${c.courseId}"
                                                       class="btn-sm btn-review">
                                                        <i class="bi bi-star"></i> Reviews
                                                    </a>

                                                    <a href="${pageContext.request.contextPath}/instructorController?action=editCourse&courseId=${c.courseId}"
                                                       class="btn-sm btn-edit">
                                                        <i class="bi bi-pencil"></i> Sửa
                                                    </a>

                                                    <button class="btn-sm btn-add-lesson"
                                                            onclick="openAddLesson(${c.courseId}, '${fn:replace(c.courseName, "'", "\\'")}')">
                                                        <i class="bi bi-plus-circle"></i> Thêm bài
                                                    </button>

                                                    <%-- NÚT ẨN / MỞ --%>
                                                    <c:choose>
                                                        <c:when test="${c.status == 'active'}">
                                                            <a href="${pageContext.request.contextPath}/instructorController?action=toggleCourse&courseId=${c.courseId}&currentStatus=active&from=courses"
                                                               class="btn-sm btn-toggle-on"
                                                               onclick="return confirm('Ẩn khóa học này?')">
                                                                <i class="bi bi-eye-slash"></i> Ẩn
                                                            </a>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <a href="${pageContext.request.contextPath}/instructorController?action=toggleCourse&courseId=${c.courseId}&currentStatus=deleted&from=courses"
                                                               class="btn-sm btn-toggle-off"
                                                               onclick="return confirm('Mở lại khóa học này?')">
                                                                <i class="bi bi-eye"></i> Mở lại
                                                            </a>
                                                        </c:otherwise>
                                                    </c:choose>

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

        <!-- DELETE MODAL -->
        <div class="modal-overlay" id="delModal" onclick="if(event.target===this) closeModal()">
            <div class="modal-box">
                <div class="modal-icon"><i class="bi bi-trash3"></i></div>
                <div class="modal-title">Xóa khóa học?</div>
                <div class="modal-sub" id="delName"></div>
                <div class="modal-actions">
                    <button class="btn-modal-cancel" onclick="closeModal()">Hủy</button>
                    <a id="delBtn" href="#" class="btn-modal-del">Xóa</a>
                </div>
            </div>
        </div>

        <!-- MODAL THÊM BÀI HỌC -->
        <div class="lesson-modal-overlay" id="addLessonModal"
             onclick="if(event.target===this) closeAddLesson()">
            <div class="lesson-modal-box">
                <div class="lesson-modal-header">
                    <div class="lesson-modal-title">
                        <i class="bi bi-plus-circle-fill"></i> Thêm bài học
                    </div>
                    <button class="lesson-modal-close" onclick="closeAddLesson()">
                        <i class="bi bi-x-lg"></i>
                    </button>
                </div>
                <div class="lesson-modal-sub" id="addLessonCourseName">Khóa học: ...</div>
                <hr class="lesson-divider">
                <div class="lesson-list" id="lessonList"></div>
                <button class="btn-add-more" onclick="addLessonRow()">
                    <i class="bi bi-plus-lg"></i> Thêm bài học nữa
                </button>
                <hr class="lesson-divider">
                <div class="lesson-modal-footer">
                    <button class="btn-lm-cancel" onclick="closeAddLesson()">Hủy</button>
                    <button class="btn-lm-submit" onclick="submitAllLessons()">
                        <i class="bi bi-check-lg"></i> Lưu tất cả bài học
                    </button>
                </div>
            </div>
        </div>

        <form id="hiddenLessonForm"
              action="${pageContext.request.contextPath}/instructorController"
              method="post" enctype="multipart/form-data" style="display:none;">
            <input type="hidden" name="action"      value="addLesson">
            <input type="hidden" name="courseId"    id="hCourseId"    value="">
            <input type="hidden" name="lessonTitle" id="hLessonTitle" value="">
            <input type="hidden" name="videoUrl"    id="hVideoUrl"    value="">
            <input type="file"   name="videoFile"   id="hVideoFile"   accept="video/*">
        </form>

        <input type="hidden" id="contextPath" value="${pageContext.request.contextPath}">
        <script src="${pageContext.request.contextPath}/assets/js/instructorcourse.js"></script>
    </body>
</html>
