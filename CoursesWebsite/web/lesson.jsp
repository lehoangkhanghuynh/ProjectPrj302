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
                --sidebar-w:   320px;
            }
            *, *::before, *::after {
                box-sizing: border-box;
                margin: 0;
                padding: 0;
            }
            body {
                font-family: 'DM Sans', sans-serif;
                color: var(--text);
                background: #0F0720;
                height: 100vh;
                display: flex;
                flex-direction: column;
                overflow: hidden;
            }

            /* ===== TOPBAR ===== */
            .topbar {
                background: var(--purple-deep);
                height: 58px;
                display: flex;
                align-items: center;
                padding: 0 24px;
                gap: 16px;
                border-bottom: 1px solid rgba(255,255,255,0.08);
                flex-shrink: 0;
                z-index: 50;
            }
            .topbar-brand {
                font-family: 'Playfair Display', serif;
                font-size: 1.2rem;
                font-weight: 700;
                color: #fff;
                text-decoration: none;
                white-space: nowrap;
            }
            .topbar-brand span {
                color: var(--gold);
            }
            .topbar-divider {
                width: 1px;
                height: 24px;
                background: rgba(255,255,255,0.15);
            }
            .topbar-course {
                font-size: 0.85rem;
                font-weight: 600;
                color: rgba(255,255,255,0.75);
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
                flex: 1;
            }
            .topbar-back {
                display: flex;
                align-items: center;
                gap: 6px;
                color: rgba(255,255,255,0.6);
                text-decoration: none;
                font-size: 0.82rem;
                font-weight: 500;
                padding: 6px 12px;
                border-radius: 7px;
                border: 1px solid rgba(255,255,255,0.12);
                transition: all 0.15s;
                white-space: nowrap;
            }
            .topbar-back:hover {
                background: rgba(255,255,255,0.08);
                color: #fff;
            }
            .topbar-progress {
                display: flex;
                align-items: center;
                gap: 10px;
            }
            .progress-text {
                font-size: 0.75rem;
                color: rgba(255,255,255,0.5);
                white-space: nowrap;
            }
            .progress-bar-wrap {
                width: 120px;
                height: 5px;
                background: rgba(255,255,255,0.1);
                border-radius: 3px;
                overflow: hidden;
            }
            .progress-bar-fill {
                height: 100%;
                background: linear-gradient(90deg, var(--purple-mid), var(--gold));
                border-radius: 3px;
                transition: width 0.4s ease;
            }

            /* ===== MAIN LAYOUT ===== */
            .main-layout {
                display: flex;
                flex: 1;
                overflow: hidden;
            }

            /* ===== VIDEO AREA ===== */
            .video-area {
                flex: 1;
                display: flex;
                flex-direction: column;
                overflow-y: auto;
                background: #0F0720;
            }
            .video-area::-webkit-scrollbar {
                width: 4px;
            }
            .video-area::-webkit-scrollbar-thumb {
                background: rgba(255,255,255,0.1);
                border-radius: 2px;
            }

            /* VIDEO PLAYER */
            .video-wrap {
                width: 100%;
                background: #000;
                position: relative;
            }
            .video-wrap iframe, .video-wrap video {
                width: 100%;
                aspect-ratio: 16/9;
                display: block;
                border: none;
            }
            .no-video {
                width: 100%;
                aspect-ratio: 16/9;
                background: linear-gradient(135deg, #1E0A4A, #3A1A7A);
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                gap: 12px;
            }
            .no-video i {
                font-size: 3rem;
                color: rgba(255,255,255,0.2);
            }
            .no-video span {
                font-size: 0.9rem;
                color: rgba(255,255,255,0.3);
            }

            /* LESSON INFO */
            .lesson-info {
                padding: 28px 36px;
                background: #160930;
                border-bottom: 1px solid rgba(255,255,255,0.06);
            }
            .lesson-number {
                font-size: 0.72rem;
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: 2px;
                color: var(--purple-mid);
                margin-bottom: 8px;
            }
            .lesson-title {
                font-family: 'Playfair Display', serif;
                font-size: 1.6rem;
                font-weight: 700;
                color: #fff;
                margin-bottom: 12px;
                line-height: 1.3;
            }
            .lesson-meta {
                display: flex;
                align-items: center;
                gap: 16px;
                flex-wrap: wrap;
            }
            .lesson-meta-item {
                display: flex;
                align-items: center;
                gap: 6px;
                font-size: 0.8rem;
                color: rgba(255,255,255,0.45);
            }
            .lesson-meta-item i {
                color: var(--purple-mid);
            }

            /* CONTENT AREA */
            .content-area {
                padding: 28px 36px 0;
                background: #0F0720;
            }
            .content-label {
                font-size: 0.72rem;
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: 2px;
                color: var(--gold);
                margin-bottom: 14px;
                display: flex;
                align-items: center;
                gap: 8px;
            }
            .content-box {
                background: rgba(255,255,255,0.04);
                border: 1px solid rgba(255,255,255,0.08);
                border-radius: 14px;
                padding: 24px;
                font-size: 0.9rem;
                line-height: 1.8;
                color: rgba(255,255,255,0.7);
            }
            .content-empty {
                color: rgba(255,255,255,0.25);
                font-style: italic;
                font-size: 0.875rem;
            }

            /* UPLOAD PANEL */
            .upload-panel {
                margin: 24px 36px 0;
                background: rgba(212,168,67,0.06);
                border: 1px dashed rgba(212,168,67,0.3);
                border-radius: 14px;
                padding: 20px 24px;
            }
            .upload-label {
                font-size: 0.72rem;
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: 2px;
                color: var(--gold);
                margin-bottom: 14px;
                display: flex;
                align-items: center;
                gap: 8px;
            }
            .upload-form {
                display: flex;
                align-items: center;
                gap: 12px;
                flex-wrap: wrap;
            }
            .upload-file-wrap {
                position: relative;
                flex: 1;
                min-width: 200px;
            }
            .upload-file-wrap input[type="file"] {
                position: absolute;
                inset: 0;
                opacity: 0;
                cursor: pointer;
                width: 100%;
            }
            .upload-file-btn {
                display: flex;
                align-items: center;
                gap: 8px;
                background: rgba(255,255,255,0.06);
                border: 1px solid rgba(255,255,255,0.12);
                border-radius: 8px;
                padding: 9px 16px;
                font-size: 0.82rem;
                color: rgba(255,255,255,0.55);
                cursor: pointer;
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
                width: 100%;
            }
            .upload-submit {
                display: flex;
                align-items: center;
                gap: 6px;
                background: linear-gradient(135deg, var(--gold), #B8892D);
                color: #1A1A2E;
                border: none;
                border-radius: 8px;
                padding: 9px 20px;
                font-size: 0.82rem;
                font-weight: 700;
                cursor: pointer;
                font-family: 'DM Sans', sans-serif;
                transition: all 0.15s;
                white-space: nowrap;
            }
            .upload-submit:hover {
                transform: translateY(-1px);
                box-shadow: 0 4px 14px rgba(212,168,67,0.35);
            }
            .upload-progress {
                display: none;
                margin-top: 10px;
            }
            .upload-bar {
                height: 4px;
                background: rgba(255,255,255,0.08);
                border-radius: 2px;
                overflow: hidden;
            }
            .upload-bar-fill {
                height: 100%;
                width: 0;
                background: linear-gradient(90deg, var(--purple-mid), var(--gold));
                border-radius: 2px;
                transition: width 0.2s;
            }
            .upload-status {
                font-size: 0.75rem;
                color: rgba(255,255,255,0.4);
                margin-top: 6px;
            }

            /* ALERT */
            .alert {
                margin: 16px 36px 0;
                padding: 12px 18px;
                border-radius: 10px;
                font-size: 0.83rem;
                font-weight: 500;
                display: flex;
                align-items: center;
                gap: 10px;
            }
            .alert-success {
                background: rgba(34,197,94,0.12);
                border: 1px solid rgba(34,197,94,0.25);
                color: #4ade80;
            }
            .alert-error   {
                background: rgba(239,68,68,0.12);
                border: 1px solid rgba(239,68,68,0.25);
                color: #f87171;
            }

            /* NAV BUTTONS */
            .lesson-nav {
                display: flex;
                gap: 12px;
                padding: 24px 36px 32px;
                background: #0F0720;
            }
            .btn-nav {
                display: flex;
                align-items: center;
                gap: 8px;
                padding: 11px 22px;
                border-radius: 10px;
                font-size: 0.85rem;
                font-weight: 700;
                text-decoration: none;
                transition: all 0.15s;
                font-family: 'DM Sans', sans-serif;
                border: none;
                cursor: pointer;
            }
            .btn-prev {
                background: rgba(255,255,255,0.06);
                color: rgba(255,255,255,0.6);
                border: 1px solid rgba(255,255,255,0.1);
            }
            .btn-prev:hover {
                background: rgba(255,255,255,0.1);
                color: #fff;
            }
            .btn-next {
                background: linear-gradient(135deg, var(--purple), var(--purple-dark));
                color: #fff;
                box-shadow: 0 4px 16px rgba(108,63,197,0.35);
            }
            .btn-next:hover {
                transform: translateY(-1px);
                box-shadow: 0 6px 20px rgba(108,63,197,0.5);
            }
            .btn-nav.disabled {
                opacity: 0.3;
                pointer-events: none;
            }

            /* ===== COMMENTS ===== */
            .comments-section {
                padding: 0 36px 48px;
                background: #0F0720;
            }
            .comments-section:target-within {
                scroll-margin-top: 20px;
            }

            .comments-header {
                display: flex;
                align-items: center;
                justify-content: space-between;
                margin-bottom: 20px;
                padding-top: 8px;
            }
            .comments-title {
                font-size: 0.72rem;
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: 2px;
                color: var(--gold);
                display: flex;
                align-items: center;
                gap: 8px;
            }
            .comments-count {
                font-size: 0.78rem;
                color: rgba(255,255,255,0.3);
                background: rgba(255,255,255,0.06);
                padding: 3px 10px;
                border-radius: 20px;
            }

            /* Comment Form */
            .comment-form-wrap {
                background: rgba(255,255,255,0.04);
                border: 1px solid rgba(255,255,255,0.08);
                border-radius: 14px;
                padding: 20px;
                margin-bottom: 20px;
            }
            .comment-form-row {
                display: flex;
                gap: 12px;
                align-items: flex-start;
            }
            .comment-avatar {
                width: 38px;
                height: 38px;
                border-radius: 50%;
                background: linear-gradient(135deg, var(--purple), var(--purple-mid));
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 0.85rem;
                font-weight: 700;
                color: #fff;
                flex-shrink: 0;
            }
            .comment-input-wrap {
                flex: 1;
            }
            .comment-textarea {
                width: 100%;
                background: rgba(255,255,255,0.05);
                border: 1px solid rgba(255,255,255,0.1);
                border-radius: 10px;
                padding: 12px 16px;
                font-size: 0.88rem;
                color: #fff;
                font-family: 'DM Sans', sans-serif;
                resize: vertical;
                min-height: 80px;
                outline: none;
                transition: border-color 0.15s;
            }
            .comment-textarea:focus {
                border-color: rgba(108,63,197,0.5);
            }
            .comment-textarea::placeholder {
                color: rgba(255,255,255,0.25);
            }
            .comment-form-actions {
                display: flex;
                justify-content: flex-end;
                margin-top: 10px;
            }
            .btn-comment-submit {
                display: flex;
                align-items: center;
                gap: 6px;
                background: linear-gradient(135deg, var(--purple), var(--purple-dark));
                color: #fff;
                border: none;
                border-radius: 8px;
                padding: 9px 20px;
                font-size: 0.82rem;
                font-weight: 700;
                cursor: pointer;
                font-family: 'DM Sans', sans-serif;
                transition: all 0.15s;
            }
            .btn-comment-submit:hover {
                transform: translateY(-1px);
                box-shadow: 0 4px 14px rgba(108,63,197,0.4);
            }

            /* Comment List */
            .comment-list {
                display: flex;
                flex-direction: column;
                gap: 14px;
            }
            .comment-card {
                display: flex;
                gap: 12px;
                background: rgba(255,255,255,0.03);
                border: 1px solid rgba(255,255,255,0.06);
                border-radius: 12px;
                padding: 16px;
                transition: border-color 0.15s;
            }
            .comment-card:hover {
                border-color: rgba(255,255,255,0.1);
            }
            .comment-body {
                flex: 1;
                min-width: 0;
            }
            .comment-meta {
                display: flex;
                align-items: center;
                gap: 10px;
                margin-bottom: 8px;
            }
            .comment-name {
                font-size: 0.82rem;
                font-weight: 700;
                color: rgba(255,255,255,0.85);
            }
            .comment-time {
                font-size: 0.72rem;
                color: rgba(255,255,255,0.25);
            }
            .comment-text {
                font-size: 0.875rem;
                line-height: 1.7;
                color: rgba(255,255,255,0.65);
                word-break: break-word;
            }
            .btn-delete-comment {
                background: none;
                border: none;
                cursor: pointer;
                color: rgba(255,255,255,0.2);
                font-size: 0.78rem;
                padding: 4px 8px;
                border-radius: 6px;
                transition: all 0.15s;
                display: flex;
                align-items: center;
                gap: 4px;
                white-space: nowrap;
                font-family: 'DM Sans', sans-serif;
            }
            .btn-delete-comment:hover {
                color: #f87171;
                background: rgba(239,68,68,0.1);
            }

            .no-comments {
                text-align: center;
                padding: 40px 20px;
            }
            .no-comments i {
                font-size: 2.2rem;
                color: rgba(255,255,255,0.08);
                display: block;
                margin-bottom: 10px;
            }
            .no-comments p {
                font-size: 0.83rem;
                color: rgba(255,255,255,0.2);
            }

            /* ===== SIDEBAR ===== */
            .sidebar {
                width: var(--sidebar-w);
                flex-shrink: 0;
                background: #160930;
                border-left: 1px solid rgba(255,255,255,0.07);
                display: flex;
                flex-direction: column;
                overflow: hidden;
            }
            .sidebar-header {
                padding: 18px 20px;
                border-bottom: 1px solid rgba(255,255,255,0.07);
                flex-shrink: 0;
            }
            .sidebar-title {
                font-size: 0.72rem;
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: 2px;
                color: rgba(255,255,255,0.4);
                margin-bottom: 6px;
            }
            .sidebar-count {
                font-size: 0.85rem;
                font-weight: 600;
                color: rgba(255,255,255,0.7);
            }
            .lesson-list {
                overflow-y: auto;
                flex: 1;
                padding: 10px;
            }
            .lesson-list::-webkit-scrollbar {
                width: 4px;
            }
            .lesson-list::-webkit-scrollbar-thumb {
                background: rgba(255,255,255,0.1);
                border-radius: 2px;
            }
            .lesson-item {
                display: flex;
                align-items: flex-start;
                gap: 12px;
                padding: 12px 14px;
                border-radius: 10px;
                text-decoration: none;
                color: rgba(255,255,255,0.55);
                transition: all 0.15s;
                margin-bottom: 4px;
                border: 1px solid transparent;
            }
            .lesson-item:hover {
                background: rgba(255,255,255,0.05);
                color: rgba(255,255,255,0.85);
            }
            .lesson-item.active {
                background: rgba(108,63,197,0.2);
                border-color: rgba(108,63,197,0.4);
                color: #fff;
            }
            .lesson-num {
                width: 28px;
                height: 28px;
                border-radius: 50%;
                background: rgba(255,255,255,0.07);
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 0.72rem;
                font-weight: 700;
                flex-shrink: 0;
                color: rgba(255,255,255,0.4);
            }
            .lesson-item.active .lesson-num {
                background: var(--purple);
                color: #fff;
            }
            .lesson-item-info {
                flex: 1;
                min-width: 0;
            }
            .lesson-item-title {
                font-size: 0.82rem;
                font-weight: 600;
                line-height: 1.4;
                margin-bottom: 4px;
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
            }
            .lesson-item-dur {
                font-size: 0.7rem;
                color: rgba(255,255,255,0.3);
                display: flex;
                align-items: center;
                gap: 4px;
            }
            .lesson-item.active .lesson-item-dur {
                color: rgba(255,255,255,0.5);
            }
            .lesson-play-icon {
                color: var(--purple-mid);
                font-size: 0.75rem;
                flex-shrink: 0;
                margin-top: 6px;
                opacity: 0;
                transition: opacity 0.15s;
            }
            .lesson-item:hover .lesson-play-icon, .lesson-item.active .lesson-play-icon {
                opacity: 1;
            }
            .no-lesson {
                text-align: center;
                padding: 48px 20px;
            }
            .no-lesson i {
                font-size: 2.5rem;
                color: rgba(255,255,255,0.1);
                margin-bottom: 12px;
                display: block;
            }
            .no-lesson p {
                font-size: 0.85rem;
                color: rgba(255,255,255,0.25);
            }

            @media (max-width: 768px) {
                .main-layout {
                    flex-direction: column;
                }
                .sidebar {
                    width: 100%;
                    height: 280px;
                    border-left: none;
                    border-top: 1px solid rgba(255,255,255,0.07);
                }
                .lesson-info, .content-area, .lesson-nav, .comments-section, .upload-panel, .alert {
                    padding-left: 20px;
                    padding-right: 20px;
                }
                .topbar-progress {
                    display: none;
                }
                .upload-form {
                    flex-direction: column;
                    align-items: stretch;
                }
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

                    <!-- UPLOAD VIDEO PANEL (có thể ẩn nếu chỉ admin/instructor xem) -->
                    <!-- Chỉ Admin (1) và Instructor (2) mới thấy upload panel -->
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

                    <!-- PREV / NEXT -->
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

                        <c:choose>
                            <c:when test="${not empty nextLesson}">
                                <a href="lesson?courseId=${courseId}&lessonId=${nextLesson.lessonId}" class="btn-nav btn-next">
                                    Bài tiếp <i class="bi bi-arrow-right"></i>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <span class="btn-nav btn-next" style="opacity:0.6; cursor:default;">
                                    <i class="bi bi-check-circle-fill"></i> Hoàn thành khóa học
                                </span>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <!-- ===== COMMENTS ===== -->
                    <div class="comments-section" id="comments">
                        <div class="comments-header">
                            <div class="comments-title">
                                <i class="bi bi-chat-dots-fill"></i> Bình luận
                            </div>
                            <span class="comments-count">
                                ${fn:length(comments)} bình luận
                            </span>
                        </div>

                        <!-- Form gửi comment -->
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

                        <!-- Danh sách comment -->
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
                                            <!-- Nút xóa: chỉ hiển thị nếu là chủ comment -->
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
                        <i class="bi bi-collection-play" style="font-size:3rem; color:rgba(255,255,255,0.1); display:block; margin-bottom:16px;"></i>
                        <p style="color:rgba(255,255,255,0.3);">Khóa học này chưa có bài học nào.</p>
                    </div>
                </c:if>
            </div>

            <!-- SIDEBAR - DANH SÁCH BÀI HỌC -->
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
            // ── Video Player ──────────────────────────────────────────────
            (function () {
                var container = document.getElementById('videoContainer');
                if (!container)
                    return;

                var videoUrl = container.getAttribute('data-video');
                var ctx = container.getAttribute('data-ctx');
                if (!videoUrl)
                    return;

                function getYouTubeId(url) {
                    var m = url.match(/[?&]v=([^&#]+)/);
                    if (m)
                        return m[1];
                    m = url.match(/youtu\.be\/([^?&#]+)/);
                    if (m)
                        return m[1];
                    m = url.match(/youtube\.com\/embed\/([^?&#]+)/);
                    if (m)
                        return m[1];
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
                            '<source src="' + src + '">' +
                            'Trình duyệt không hỗ trợ video.' +
                            '</video>';
                }
                container.innerHTML = html;
            })();

            // ── Progress Bar ──────────────────────────────────────────────
            (function () {
                var items = document.querySelectorAll('.lesson-item');
                var total = items.length;
                if (!total)
                    return;

                var currentIdx = 0;
                items.forEach(function (item, i) {
                    if (item.classList.contains('active'))
                        currentIdx = i;
                });

                var pct = Math.round(((currentIdx + 1) / total) * 100);
                var fill = document.getElementById('progressFill');
                var txt = document.getElementById('progressText');
                if (fill)
                    fill.style.width = pct + '%';
                if (txt)
                    txt.textContent = 'Bài ' + (currentIdx + 1) + ' / ' + total;

                var activeItem = document.querySelector('.lesson-item.active');
                if (activeItem)
                    activeItem.scrollIntoView({block: 'center', behavior: 'smooth'});
            })();

            // ── Upload UX ─────────────────────────────────────────────────
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
                if (!fileInput.files || fileInput.files.length === 0)
                    return;

                var progress = document.getElementById('uploadProgress');
                var barFill = document.getElementById('uploadBarFill');
                var status = document.getElementById('uploadStatus');

                progress.style.display = 'block';

                // Fake progress animation (real progress would need XHR)
                var pct = 0;
                var interval = setInterval(function () {
                    pct += Math.random() * 8;
                    if (pct > 90)
                        pct = 90;
                    barFill.style.width = pct + '%';
                    status.textContent = 'Đang upload... ' + Math.round(pct) + '%';
                }, 300);

                // Khi form submit xong (trang reload) interval sẽ bị clear tự động
                document.getElementById('uploadForm').addEventListener('submit', function () {
                    clearInterval(interval);
                    barFill.style.width = '100%';
                    status.textContent = 'Hoàn tất!';
                });
            }
        </script>
    </body>
</html>
