<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>${course.courseName} - KKKAcademy</title>
        <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&family=DM+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
        <style>
            :root {
                --purple:      #7C4DFF;
                --purple-dark: #5E35B1;
                --purple-deep: #1A0A3A;
                --purple-light:#EDE7FF;
                --purple-mid:  #B39DDB;
                --gold:        #FFB300;
                --gold-light:  #FFD54F;
                --text:        #1A1A2E;
                --muted:       #6B6B8A;
                --border:      #E2D9F3;
                --bg:          #F5F0FF;
                --sidebar-w:   340px;

                /* Bright theme surfaces */
                --surface-main:   #F7F4FF;
                --surface-card:   #FFFFFF;
                --surface-sidebar: #FDFBFF;
                --topbar-bg:      #2D1B6B;
                --lesson-info-bg: #FFFFFF;
                --video-bg:       #0F0720;
            }
            *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

            body {
                font-family: 'DM Sans', sans-serif;
                color: var(--text);
                background: var(--surface-main);
                height: 100vh;
                display: flex;
                flex-direction: column;
                overflow: hidden;
            }

            /* ===== TOPBAR ===== */
            .topbar {
                background: var(--topbar-bg);
                height: 58px;
                display: flex;
                align-items: center;
                padding: 0 24px;
                gap: 16px;
                border-bottom: 1px solid rgba(255,255,255,0.08);
                flex-shrink: 0;
                z-index: 50;
                box-shadow: 0 2px 16px rgba(45,27,107,0.35);
            }
            .topbar-brand {
                font-family: 'Playfair Display', serif;
                font-size: 1.2rem;
                font-weight: 700;
                color: #fff;
                text-decoration: none;
                white-space: nowrap;
            }
            .topbar-brand span { color: var(--gold); }
            .topbar-divider { width: 1px; height: 24px; background: rgba(255,255,255,0.18); }
            .topbar-course {
                font-size: 0.85rem;
                font-weight: 600;
                color: rgba(255,255,255,0.85);
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
                flex: 1;
            }
            .topbar-back {
                display: flex;
                align-items: center;
                gap: 6px;
                color: rgba(255,255,255,0.75);
                text-decoration: none;
                font-size: 0.82rem;
                font-weight: 600;
                padding: 6px 14px;
                border-radius: 8px;
                border: 1px solid rgba(255,255,255,0.2);
                transition: all 0.15s;
                white-space: nowrap;
                background: rgba(255,255,255,0.07);
            }
            .topbar-back:hover { background: rgba(255,255,255,0.15); color: #fff; }
            .topbar-progress { display: flex; align-items: center; gap: 10px; }
            .progress-text { font-size: 0.75rem; color: rgba(255,255,255,0.6); white-space: nowrap; font-weight: 600; }
            .progress-bar-wrap {
                width: 130px; height: 6px;
                background: rgba(255,255,255,0.12);
                border-radius: 3px; overflow: hidden;
            }
            .progress-bar-fill {
                height: 100%;
                background: linear-gradient(90deg, #B39DDB, var(--gold));
                border-radius: 3px;
                transition: width 0.4s ease;
            }

            /* ===== MAIN LAYOUT ===== */
            .main-layout { display: flex; flex: 1; overflow: hidden; }

            /* ===== VIDEO AREA ===== */
            .video-area {
                flex: 1;
                display: flex;
                flex-direction: column;
                overflow-y: auto;
                background: var(--surface-main);
            }
            .video-area::-webkit-scrollbar { width: 5px; }
            .video-area::-webkit-scrollbar-thumb { background: #D1C4E9; border-radius: 3px; }

            /* VIDEO PLAYER */
            .video-wrap { width: 100%; background: #000; position: relative; box-shadow: 0 4px 24px rgba(0,0,0,0.25); }
            .video-wrap iframe, .video-wrap video {
                width: 100%; aspect-ratio: 16/9;
                display: block; border: none;
            }
            .no-video {
                width: 100%; aspect-ratio: 16/9;
                background: linear-gradient(135deg, #1E0A4A, #3A1A7A);
                display: flex; flex-direction: column;
                align-items: center; justify-content: center; gap: 12px;
            }
            .no-video i { font-size: 3rem; color: rgba(255,255,255,0.2); }
            .no-video span { font-size: 0.9rem; color: rgba(255,255,255,0.3); }

            /* LESSON INFO */
            .lesson-info {
                padding: 28px 36px;
                background: var(--lesson-info-bg);
                border-bottom: 1px solid #EDE7FF;
                box-shadow: 0 2px 12px rgba(124,77,255,0.06);
            }
            .lesson-number {
                font-size: 0.7rem;
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: 2.5px;
                color: var(--purple);
                margin-bottom: 8px;
                display: flex; align-items: center; gap: 6px;
            }
            .lesson-number::before {
                content: '';
                display: inline-block;
                width: 18px; height: 2px;
                background: var(--purple);
                border-radius: 1px;
            }
            .lesson-title {
                font-family: 'Playfair Display', serif;
                font-size: 1.65rem;
                font-weight: 700;
                color: #1A0A3A;
                margin-bottom: 14px;
                line-height: 1.3;
            }
            .lesson-meta { display: flex; align-items: center; gap: 18px; flex-wrap: wrap; }
            .lesson-meta-item {
                display: flex; align-items: center; gap: 6px;
                font-size: 0.8rem;
                color: var(--muted);
                font-weight: 500;
            }
            .lesson-meta-item i { color: var(--purple); }

            /* CONTENT AREA */
            .content-area {
                padding: 28px 36px 0;
                background: var(--surface-main);
            }
            .content-label {
                font-size: 0.7rem;
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: 2.5px;
                color: var(--purple-dark);
                margin-bottom: 14px;
                display: flex; align-items: center; gap: 8px;
            }
            .content-box {
                background: #fff;
                border: 1px solid #EDE7FF;
                border-radius: 14px;
                padding: 24px;
                font-size: 0.9rem;
                line-height: 1.85;
                color: #3D2B6B;
                box-shadow: 0 2px 12px rgba(124,77,255,0.05);
            }
            .content-empty { color: #B0A0D0; font-style: italic; font-size: 0.875rem; }

            /* UPLOAD PANEL */
            .upload-panel {
                margin: 24px 36px 0;
                background: #FFFBEF;
                border: 1px dashed #FFB300;
                border-radius: 14px;
                padding: 20px 24px;
            }
            .upload-label {
                font-size: 0.7rem;
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: 2.5px;
                color: #B8860B;
                margin-bottom: 14px;
                display: flex; align-items: center; gap: 8px;
            }
            .upload-form { display: flex; align-items: center; gap: 12px; flex-wrap: wrap; }
            .upload-file-wrap { position: relative; flex: 1; min-width: 200px; }
            .upload-file-wrap input[type="file"] {
                position: absolute; inset: 0; opacity: 0;
                cursor: pointer; width: 100%;
            }
            .upload-file-btn {
                display: flex; align-items: center; gap: 8px;
                background: rgba(255,179,0,0.08);
                border: 1px solid rgba(255,179,0,0.3);
                border-radius: 8px; padding: 9px 16px;
                font-size: 0.82rem; color: #7A6000;
                cursor: pointer; white-space: nowrap;
                overflow: hidden; text-overflow: ellipsis; width: 100%;
            }
            .upload-submit {
                display: flex; align-items: center; gap: 6px;
                background: linear-gradient(135deg, var(--gold), #E6A200);
                color: #2D1B00;
                border: none; border-radius: 8px; padding: 9px 22px;
                font-size: 0.82rem; font-weight: 700;
                cursor: pointer; font-family: 'DM Sans', sans-serif;
                transition: all 0.15s; white-space: nowrap;
                box-shadow: 0 3px 10px rgba(255,179,0,0.3);
            }
            .upload-submit:hover { transform: translateY(-1px); box-shadow: 0 5px 16px rgba(255,179,0,0.45); }
            .upload-progress { display: none; margin-top: 10px; }
            .upload-bar { height: 4px; background: rgba(0,0,0,0.08); border-radius: 2px; overflow: hidden; }
            .upload-bar-fill { height: 100%; width: 0; background: linear-gradient(90deg, var(--purple-mid), var(--gold)); border-radius: 2px; transition: width 0.2s; }
            .upload-status { font-size: 0.75rem; color: #8B7000; margin-top: 6px; }

            /* ALERT */
            .alert {
                margin: 16px 36px 0;
                padding: 12px 18px;
                border-radius: 10px;
                font-size: 0.83rem;
                font-weight: 600;
                display: flex; align-items: center; gap: 10px;
            }
            .alert-success { background: #F0FFF4; border: 1px solid #6EE7B7; color: #065F46; }
            .alert-error   { background: #FFF5F5; border: 1px solid #FCA5A5; color: #991B1B; }

            /* ===== NAV BUTTONS ===== */
            .lesson-nav {
                display: flex;
                gap: 14px;
                padding: 24px 36px 32px;
                background: var(--surface-main);
                align-items: center;
            }

            /* Previous button */
            .btn-nav {
                display: flex; align-items: center; gap: 8px;
                padding: 12px 24px; border-radius: 12px;
                font-size: 0.88rem; font-weight: 700;
                text-decoration: none; transition: all 0.18s;
                font-family: 'DM Sans', sans-serif;
                border: none; cursor: pointer;
                position: relative; overflow: hidden;
            }
            .btn-prev {
                background: #fff;
                color: var(--purple-dark);
                border: 2px solid #D1C4E9;
                box-shadow: 0 2px 8px rgba(124,77,255,0.08);
            }
            .btn-prev:hover {
                background: #EDE7FF;
                border-color: var(--purple);
                color: var(--purple);
                box-shadow: 0 4px 16px rgba(124,77,255,0.15);
                transform: translateY(-1px);
            }

            /* Next lesson button */
            .btn-next {
                background: linear-gradient(135deg, var(--purple) 0%, var(--purple-dark) 100%);
                color: #fff;
                box-shadow: 0 4px 20px rgba(124,77,255,0.4);
                padding: 13px 28px;
                font-size: 0.92rem;
            }
            .btn-next::before {
                content: '';
                position: absolute;
                inset: 0;
                background: linear-gradient(135deg, rgba(255,255,255,0.15), transparent);
                opacity: 0;
                transition: opacity 0.18s;
            }
            .btn-next:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 28px rgba(124,77,255,0.55);
            }
            .btn-next:hover::before { opacity: 1; }

            /* ✅ COMPLETE button — the star of the show */
            .btn-complete {
                display: flex; align-items: center; gap: 10px;
                padding: 13px 28px; border-radius: 12px;
                font-size: 0.92rem; font-weight: 700;
                text-decoration: none; transition: all 0.2s;
                font-family: 'DM Sans', sans-serif;
                border: none; cursor: pointer;
                position: relative; overflow: hidden;

                background: linear-gradient(135deg, #FFB300 0%, #FF6F00 100%);
                color: #fff;
                box-shadow: 0 5px 22px rgba(255,111,0,0.45);
                animation: pulseGlow 2.4s ease-in-out infinite;
            }
            @keyframes pulseGlow {
                0%, 100% { box-shadow: 0 5px 22px rgba(255,111,0,0.45); }
                50%       { box-shadow: 0 8px 32px rgba(255,111,0,0.7), 0 0 0 4px rgba(255,179,0,0.18); }
            }
            .btn-complete::before {
                content: '';
                position: absolute;
                inset: 0;
                background: linear-gradient(135deg, rgba(255,255,255,0.25), transparent);
                opacity: 0;
                transition: opacity 0.2s;
            }
            .btn-complete:hover { transform: translateY(-3px); }
            .btn-complete:hover::before { opacity: 1; }
            .btn-complete .complete-star {
                font-size: 1.1rem;
                animation: spin 3s linear infinite;
            }
            @keyframes spin {
                0%   { transform: rotate(0deg) scale(1); }
                50%  { transform: rotate(180deg) scale(1.2); }
                100% { transform: rotate(360deg) scale(1); }
            }

            .btn-nav.disabled { opacity: 0.35; pointer-events: none; }

            /* Spacer */
            .nav-spacer { flex: 1; }

            /* ===== COMMENTS ===== */
            .comments-section { padding: 0 36px 48px; background: var(--surface-main); }
            .comments-header {
                display: flex; align-items: center;
                justify-content: space-between;
                margin-bottom: 20px; padding-top: 8px;
            }
            .comments-title {
                font-size: 0.7rem; font-weight: 700;
                text-transform: uppercase; letter-spacing: 2.5px;
                color: var(--purple-dark);
                display: flex; align-items: center; gap: 8px;
            }
            .comments-count {
                font-size: 0.78rem; color: var(--muted);
                background: #EDE7FF;
                padding: 3px 12px; border-radius: 20px;
                font-weight: 600;
            }
            .comment-form-wrap {
                background: #fff;
                border: 1px solid #EDE7FF;
                border-radius: 14px;
                padding: 20px; margin-bottom: 20px;
                box-shadow: 0 2px 10px rgba(124,77,255,0.05);
            }
            .comment-form-row { display: flex; gap: 12px; align-items: flex-start; }
            .comment-avatar {
                width: 38px; height: 38px; border-radius: 50%;
                background: linear-gradient(135deg, var(--purple), var(--purple-mid));
                display: flex; align-items: center; justify-content: center;
                font-size: 0.85rem; font-weight: 700; color: #fff; flex-shrink: 0;
                box-shadow: 0 2px 8px rgba(124,77,255,0.3);
            }
            .comment-input-wrap { flex: 1; }
            .comment-textarea {
                width: 100%;
                background: #F7F4FF;
                border: 1.5px solid #D1C4E9;
                border-radius: 10px; padding: 12px 16px;
                font-size: 0.88rem; color: #1A0A3A;
                font-family: 'DM Sans', sans-serif;
                resize: vertical; min-height: 80px;
                outline: none; transition: border-color 0.15s;
            }
            .comment-textarea:focus { border-color: var(--purple); background: #fff; }
            .comment-textarea::placeholder { color: #B0A0D0; }
            .comment-form-actions { display: flex; justify-content: flex-end; margin-top: 10px; }
            .btn-comment-submit {
                display: flex; align-items: center; gap: 6px;
                background: linear-gradient(135deg, var(--purple), var(--purple-dark));
                color: #fff; border: none; border-radius: 8px;
                padding: 9px 20px; font-size: 0.82rem; font-weight: 700;
                cursor: pointer; font-family: 'DM Sans', sans-serif;
                transition: all 0.15s;
                box-shadow: 0 3px 10px rgba(124,77,255,0.3);
            }
            .btn-comment-submit:hover { transform: translateY(-1px); box-shadow: 0 5px 16px rgba(124,77,255,0.45); }

            .comment-list { display: flex; flex-direction: column; gap: 10px; }
            .comment-card {
                display: flex; gap: 12px;
                background: #fff;
                border: 1px solid #EDE7FF;
                border-radius: 12px; padding: 16px;
                transition: all 0.15s;
                box-shadow: 0 1px 6px rgba(124,77,255,0.04);
            }
            .comment-card:hover { border-color: #C5B8F0; box-shadow: 0 3px 14px rgba(124,77,255,0.08); }
            .comment-body { flex: 1; min-width: 0; }
            .comment-meta { display: flex; align-items: center; gap: 10px; margin-bottom: 8px; }
            .comment-name { font-size: 0.82rem; font-weight: 700; color: #2D1B6B; }
            .comment-time { font-size: 0.72rem; color: #B0A0D0; }
            .comment-text { font-size: 0.875rem; line-height: 1.7; color: #3D2B6B; word-break: break-word; }
            .btn-delete-comment {
                background: none; border: none; cursor: pointer;
                color: #C5B8F0; font-size: 0.78rem;
                padding: 4px 8px; border-radius: 6px;
                transition: all 0.15s;
                display: flex; align-items: center; gap: 4px;
                white-space: nowrap; font-family: 'DM Sans', sans-serif;
            }
            .btn-delete-comment:hover { color: #E53935; background: #FFF5F5; }
            .no-comments { text-align: center; padding: 40px 20px; }
            .no-comments i { font-size: 2.2rem; color: #D1C4E9; display: block; margin-bottom: 10px; }
            .no-comments p { font-size: 0.83rem; color: #B0A0D0; }

            /* ===== SIDEBAR ===== */
            .sidebar {
                width: var(--sidebar-w); flex-shrink: 0;
                background: var(--surface-sidebar);
                border-left: 1px solid #EDE7FF;
                display: flex; flex-direction: column;
                overflow: hidden;
                box-shadow: -4px 0 20px rgba(124,77,255,0.06);
            }
            .sidebar-header {
                padding: 18px 20px;
                border-bottom: 1px solid #EDE7FF;
                flex-shrink: 0;
                background: #fff;
            }
            .sidebar-title {
                font-size: 0.7rem; font-weight: 700;
                text-transform: uppercase; letter-spacing: 2.5px;
                color: var(--purple); margin-bottom: 4px;
            }
            .sidebar-count { font-size: 0.88rem; font-weight: 600; color: #2D1B6B; }
            .lesson-list { overflow-y: auto; flex: 1; padding: 10px; }
            .lesson-list::-webkit-scrollbar { width: 4px; }
            .lesson-list::-webkit-scrollbar-thumb { background: #D1C4E9; border-radius: 2px; }
            .lesson-item {
                display: flex; align-items: flex-start; gap: 12px;
                padding: 12px 14px; border-radius: 10px;
                text-decoration: none; color: #5E4B8B;
                transition: all 0.15s; margin-bottom: 4px;
                border: 1px solid transparent;
            }
            .lesson-item:hover { background: #EDE7FF; color: #2D1B6B; }
            .lesson-item.active {
                background: linear-gradient(135deg, #EDE7FF, #E8E0FF);
                border-color: #B39DDB;
                color: #2D1B6B;
                box-shadow: 0 2px 10px rgba(124,77,255,0.1);
            }
            .lesson-num {
                width: 28px; height: 28px; border-radius: 50%;
                background: #EDE7FF;
                display: flex; align-items: center; justify-content: center;
                font-size: 0.72rem; font-weight: 700; flex-shrink: 0;
                color: var(--purple);
            }
            .lesson-item.active .lesson-num { background: var(--purple); color: #fff; }
            .lesson-item-info { flex: 1; min-width: 0; }
            .lesson-item-title {
                font-size: 0.82rem; font-weight: 600; line-height: 1.4;
                margin-bottom: 4px; white-space: nowrap;
                overflow: hidden; text-overflow: ellipsis;
            }
            .lesson-item-dur {
                font-size: 0.7rem; color: #B0A0D0;
                display: flex; align-items: center; gap: 4px;
            }
            .lesson-item.active .lesson-item-dur { color: #7C4DFF; }
            .lesson-play-icon {
                color: var(--purple); font-size: 0.8rem;
                flex-shrink: 0; margin-top: 6px;
                opacity: 0; transition: opacity 0.15s;
            }
            .lesson-item:hover .lesson-play-icon, .lesson-item.active .lesson-play-icon { opacity: 1; }
            .no-lesson { text-align: center; padding: 48px 20px; }
            .no-lesson i { font-size: 2.5rem; color: #D1C4E9; margin-bottom: 12px; display: block; }
            .no-lesson p { font-size: 0.85rem; color: #B0A0D0; }

            @media (max-width: 768px) {
                .main-layout { flex-direction: column; }
                .sidebar { width: 100%; height: 280px; border-left: none; border-top: 1px solid #EDE7FF; }
                .lesson-info, .content-area, .lesson-nav, .comments-section, .upload-panel, .alert {
                    padding-left: 20px; padding-right: 20px;
                }
                .topbar-progress { display: none; }
                .upload-form { flex-direction: column; align-items: stretch; }
            }
        </style>
    </head>
    <body>

        <!-- TOPBAR -->
        <div class="topbar">
            <a href="courseController?action=ExploreCourse" class="topbar-brand">KKK<span>Academy</span></a>
            <div class="topbar-divider"></div>
            <span class="topbar-course">${course.courseName}</span>

            <c:if test="${not empty lessons}">
                <div class="topbar-progress">
                    <span class="progress-text" id="progressText">Bài 1 / ${fn:length(lessons)}</span>
                    <div class="progress-bar-wrap">
                        <div class="progress-bar-fill" id="progressFill" style="width: 0%"></div>
                    </div>
                </div>
            </c:if>

            <a href="courseController?action=ExploreCourse" class="topbar-back">
                <i class="bi bi-arrow-left"></i> Thoát
            </a>
        </div>

        <!-- MAIN -->
        <div class="main-layout">

            <!-- VIDEO + CONTENT -->
            <div class="video-area">

                <!-- VIDEO PLAYER -->
                <div class="video-wrap">
                    <c:choose>
                        <c:when test="${not empty currentLesson and not empty currentLesson.video}">
                            <div id="videoContainer"
                                 data-video="${currentLesson.video}"
                                 data-ctx="${pageContext.request.contextPath}">
                                <div class="no-video" id="videoPlaceholder">
                                    <i class="bi bi-play-circle" style="font-size:3rem; color:rgba(255,255,255,0.3);"></i>
                                    <span>Đang tải video...</span>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="no-video">
                                <i class="bi bi-camera-video-off"></i>
                                <span>Bài học này chưa có video</span>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- LESSON INFO -->
                <c:if test="${not empty currentLesson}">
                    <div class="lesson-info">
                        <div class="lesson-number">
                            <c:forEach var="l" items="${lessons}" varStatus="st">
                                <c:if test="${l.lessonId == currentLesson.lessonId}">
                                    Bài ${st.index + 1} / ${fn:length(lessons)}
                                </c:if>
                            </c:forEach>
                        </div>
                        <div class="lesson-title">${currentLesson.title}</div>
                        <div class="lesson-meta">
                            <c:if test="${currentLesson.duration > 0}">
                                <span class="lesson-meta-item"><i class="bi bi-clock"></i>${currentLesson.duration} phút</span>
                            </c:if>
                            <span class="lesson-meta-item"><i class="bi bi-play-circle"></i>Video bài giảng</span>
                            <span class="lesson-meta-item"><i class="bi bi-book"></i>${course.topic}</span>
                        </div>
                    </div>

                    <!-- ALERTS -->
                    <c:if test="${not empty sessionScope.uploadSuccess}">
                        <div class="alert alert-success">
                            <i class="bi bi-check-circle-fill"></i>
                            ${sessionScope.uploadSuccess}
                        </div>
                        <c:remove var="uploadSuccess" scope="session"/>
                    </c:if>
                    <c:if test="${not empty sessionScope.uploadError}">
                        <div class="alert alert-error">
                            <i class="bi bi-exclamation-circle-fill"></i>
                            ${sessionScope.uploadError}
                        </div>
                        <c:remove var="uploadError" scope="session"/>
                    </c:if>

                    <!-- UPLOAD VIDEO PANEL -->
                    <c:if test="${sessionScope.user.role == 1 || sessionScope.user.role == 2}">
                        <div class="upload-panel">
                            <div class="upload-label"><i class="bi bi-cloud-upload-fill"></i> Upload Video cho bài này</div>
                            <form id="uploadForm" method="POST" action="uploadVideo" enctype="multipart/form-data">
                                <input type="hidden" name="courseId"  value="${courseId}">
                                <input type="hidden" name="lessonId"  value="${currentLesson.lessonId}">
                                <div class="upload-form">
                                    <div class="upload-file-wrap">
                                        <input type="file" name="videoFile" id="videoFile"
                                               accept="video/*,.mp4,.webm,.ogg,.mov,.mkv"
                                               onchange="onFileChange(this)">
                                        <div class="upload-file-btn" id="fileLabel">
                                            <i class="bi bi-file-earmark-play"></i>
                                            <span id="fileLabelText">Chọn file video (mp4, webm, mkv...)</span>
                                        </div>
                                    </div>
                                    <button type="submit" class="upload-submit" onclick="startUpload()">
                                        <i class="bi bi-upload"></i> Upload
                                    </button>
                                </div>
                                <div class="upload-progress" id="uploadProgress">
                                    <div class="upload-bar"><div class="upload-bar-fill" id="uploadBarFill"></div></div>
                                    <div class="upload-status" id="uploadStatus">Đang upload...</div>
                                </div>
                            </form>
                        </div>
                    </c:if>

                    <!-- NỘI DUNG BÀI HỌC -->
                    <div class="content-area">
                        <div class="content-label"><i class="bi bi-file-text-fill"></i> Nội dung bài học</div>
                        <div class="content-box">
                            <c:choose>
                                <c:when test="${not empty currentLesson.content}">${currentLesson.content}</c:when>
                                <c:otherwise><span class="content-empty">Bài học này chưa có nội dung mô tả.</span></c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <!-- ===== PREV / NEXT / COMPLETE ===== -->
                    <div class="lesson-nav">
                        <c:set var="prevLesson" value="${null}"/>
                        <c:set var="nextLesson" value="${null}"/>
                        <c:set var="found" value="false"/>
                        <c:forEach var="l" items="${lessons}">
                            <c:choose>
                                <c:when test="${found == 'true' and empty nextLesson}"><c:set var="nextLesson" value="${l}"/></c:when>
                                <c:when test="${l.lessonId == currentLesson.lessonId}"><c:set var="found" value="true"/></c:when>
                                <c:otherwise><c:if test="${found == 'false'}"><c:set var="prevLesson" value="${l}"/></c:if></c:otherwise>
                            </c:choose>
                        </c:forEach>

                        <!-- Nút Bài trước -->
                        <c:choose>
                            <c:when test="${not empty prevLesson}">
                                <a href="lesson?courseId=${courseId}&lessonId=${prevLesson.lessonId}" class="btn-nav btn-prev">
                                    <i class="bi bi-arrow-left"></i> Bài trước
                                </a>
                            </c:when>
                            <c:otherwise>
                                <span class="btn-nav btn-prev disabled"><i class="bi bi-arrow-left"></i> Bài trước</span>
                            </c:otherwise>
                        </c:choose>

                        <div class="nav-spacer"></div>

                        <!-- Nút Bài tiếp / Hoàn thành -->
                        <c:choose>
                            <c:when test="${not empty nextLesson}">
                                <!-- Còn bài tiếp theo -->
                                <a href="lesson?courseId=${courseId}&lessonId=${nextLesson.lessonId}" class="btn-nav btn-next">
                                    Bài tiếp theo <i class="bi bi-arrow-right"></i>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <!-- Đây là bài cuối → Hoàn thành khóa học → về listCourse -->
                                <a href="courseController?action=ExploreCourse" class="btn-complete">
                                    <span class="complete-star"><i class="bi bi-star-fill"></i></span>
                                    Hoàn thành khóa học!
                                    <i class="bi bi-trophy-fill"></i>
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <!-- ===== COMMENTS ===== -->
                    <div class="comments-section" id="comments">
                        <div class="comments-header">
                            <div class="comments-title">
                                <i class="bi bi-chat-dots-fill"></i> Bình luận
                            </div>
                            <span class="comments-count">${fn:length(comments)} bình luận</span>
                        </div>

                        <div class="comment-form-wrap">
                            <div class="comment-form-row">
                                <div class="comment-avatar">
                                    ${fn:substring(sessionScope.user.fullname, 0, 1)}
                                </div>
                                <div class="comment-input-wrap">
                                    <form method="POST" action="lesson">
                                        <input type="hidden" name="action"   value="addComment">
                                        <input type="hidden" name="courseId" value="${courseId}">
                                        <input type="hidden" name="lessonId" value="${currentLesson.lessonId}">
                                        <textarea name="commentContent" class="comment-textarea"
                                                  placeholder="Chia sẻ câu hỏi hoặc nhận xét của bạn về bài học này..."
                                                  maxlength="1000" rows="3"></textarea>
                                        <div class="comment-form-actions">
                                            <button type="submit" class="btn-comment-submit">
                                                <i class="bi bi-send-fill"></i> Gửi bình luận
                                            </button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>

                        <div class="comment-list">
                            <c:choose>
                                <c:when test="${not empty comments}">
                                    <c:forEach var="cm" items="${comments}">
                                        <div class="comment-card">
                                            <div class="comment-avatar">
                                                ${fn:substring(cm.username, 0, 1)}
                                            </div>
                                            <div class="comment-body">
                                                <div class="comment-meta">
                                                    <span class="comment-name">${cm.username}</span>
                                                    <span class="comment-time">
                                                        <fmt:formatDate value="${cm.createdAt}" pattern="HH:mm dd/MM/yyyy"/>
                                                    </span>
                                                </div>
                                                <div class="comment-text">${cm.content}</div>
                                            </div>
                                            <c:if test="${cm.userId == sessionScope.user.userId}">
                                                <form method="POST" action="lesson" style="align-self:flex-start;">
                                                    <input type="hidden" name="action"    value="deleteComment">
                                                    <input type="hidden" name="commentId" value="${cm.commentId}">
                                                    <input type="hidden" name="lessonId"  value="${currentLesson.lessonId}">
                                                    <input type="hidden" name="courseId"  value="${courseId}">
                                                    <button type="submit" class="btn-delete-comment"
                                                            onclick="return confirm('Xóa bình luận này?')">
                                                        <i class="bi bi-trash3"></i>
                                                    </button>
                                                </form>
                                            </c:if>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <div class="no-comments">
                                        <i class="bi bi-chat-square-dots"></i>
                                        <p>Chưa có bình luận nào. Hãy là người đầu tiên!</p>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </c:if>

                <c:if test="${empty currentLesson}">
                    <div class="no-lesson" style="padding:60px 36px;">
                        <i class="bi bi-collection-play" style="font-size:3rem; color:#D1C4E9; display:block; margin-bottom:16px;"></i>
                        <p style="color:#B0A0D0;">Khóa học này chưa có bài học nào.</p>
                    </div>
                </c:if>
            </div>

            <!-- SIDEBAR -->
            <div class="sidebar">
                <div class="sidebar-header">
                    <div class="sidebar-title">Nội dung khóa học</div>
                    <div class="sidebar-count">${fn:length(lessons)} bài học</div>
                </div>
                <div class="lesson-list">
                    <c:choose>
                        <c:when test="${not empty lessons}">
                            <c:forEach var="l" items="${lessons}" varStatus="st">
                                <a href="lesson?courseId=${courseId}&lessonId=${l.lessonId}"
                                   class="lesson-item ${currentLesson.lessonId == l.lessonId ? 'active' : ''}">
                                    <div class="lesson-num">${st.index + 1}</div>
                                    <div class="lesson-item-info">
                                        <div class="lesson-item-title">${l.title}</div>
                                        <div class="lesson-item-dur">
                                            <i class="bi bi-clock"></i>
                                            <c:choose>
                                                <c:when test="${l.duration > 0}">${l.duration} phút</c:when>
                                                <c:otherwise>—</c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                    <i class="bi bi-play-circle-fill lesson-play-icon"></i>
                                </a>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="no-lesson">
                                <i class="bi bi-collection-play"></i>
                                <p>Chưa có bài học nào</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <script>
            // ── Video Player ─────────────────────────────────────────────
            (function () {
                var container = document.getElementById('videoContainer');
                if (!container) return;
                var videoUrl = container.getAttribute('data-video');
                var ctx = container.getAttribute('data-ctx');
                if (!videoUrl) return;

                function getYouTubeId(url) {
                    var m = url.match(/[?&]v=([^&#]+)/);
                    if (m) return m[1];
                    m = url.match(/youtu\.be\/([^?&#]+)/);
                    if (m) return m[1];
                    m = url.match(/youtube\.com\/embed\/([^?&#]+)/);
                    if (m) return m[1];
                    return null;
                }

                var html = '';
                var ytId = getYouTubeId(videoUrl);
                if (ytId) {
                    html = '<iframe src="https://www.youtube.com/embed/' + ytId +
                           '?rel=0&modestbranding=1" style="width:100%;aspect-ratio:16/9;border:none;display:block;" ' +
                           'allowfullscreen allow="autoplay; encrypted-media"></iframe>';
                } else {
                    var src = videoUrl.startsWith('http') ? videoUrl : ctx + '/' + videoUrl;
                    html = '<video controls style="width:100%;aspect-ratio:16/9;background:#000;display:block;">' +
                           '<source src="' + src + '">Trình duyệt không hỗ trợ video.</video>';
                }
                container.innerHTML = html;
            })();

            // ── Progress Bar ─────────────────────────────────────────────
            (function () {
                var items = document.querySelectorAll('.lesson-item');
                var total = items.length;
                if (!total) return;

                var currentIdx = 0;
                items.forEach(function (item, i) {
                    if (item.classList.contains('active')) currentIdx = i;
                });

                var pct = Math.round(((currentIdx + 1) / total) * 100);
                var fill = document.getElementById('progressFill');
                var txt = document.getElementById('progressText');
                if (fill) fill.style.width = pct + '%';
                if (txt) txt.textContent = 'Bài ' + (currentIdx + 1) + ' / ' + total;

                var activeItem = document.querySelector('.lesson-item.active');
                if (activeItem) activeItem.scrollIntoView({ block: 'center', behavior: 'smooth' });
            })();

            // ── Upload UX ────────────────────────────────────────────────
            function onFileChange(input) {
                var label = document.getElementById('fileLabelText');
                if (input.files && input.files[0]) {
                    var name = input.files[0].name;
                    var size = (input.files[0].size / 1024 / 1024).toFixed(1);
                    label.textContent = name + ' (' + size + ' MB)';
                }
            }

            function startUpload() {
                var fileInput = document.getElementById('videoFile');
                if (!fileInput.files || fileInput.files.length === 0) return;

                var progress = document.getElementById('uploadProgress');
                var barFill = document.getElementById('uploadBarFill');
                var status = document.getElementById('uploadStatus');
                progress.style.display = 'block';

                var pct = 0;
                var interval = setInterval(function () {
                    pct += Math.random() * 8;
                    if (pct > 90) pct = 90;
                    barFill.style.width = pct + '%';
                    status.textContent = 'Đang upload... ' + Math.round(pct) + '%';
                }, 300);

                document.getElementById('uploadForm').addEventListener('submit', function () {
                    clearInterval(interval);
                    barFill.style.width = '100%';
                    status.textContent = 'Hoàn tất!';
                });
            }
        </script>
    </body>
</html>
