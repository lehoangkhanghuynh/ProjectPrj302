<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'DM Sans', sans-serif; color: var(--text); background: #0F0720; height: 100vh; display: flex; flex-direction: column; overflow: hidden; }

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
        .topbar-brand { font-family: 'Playfair Display', serif; font-size: 1.2rem; font-weight: 700; color: #fff; text-decoration: none; white-space: nowrap; }
        .topbar-brand span { color: var(--gold); }
        .topbar-divider { width: 1px; height: 24px; background: rgba(255,255,255,0.15); }
        .topbar-course { font-size: 0.85rem; font-weight: 600; color: rgba(255,255,255,0.75); white-space: nowrap; overflow: hidden; text-overflow: ellipsis; flex: 1; }
        .topbar-back { display: flex; align-items: center; gap: 6px; color: rgba(255,255,255,0.6); text-decoration: none; font-size: 0.82rem; font-weight: 500; padding: 6px 12px; border-radius: 7px; border: 1px solid rgba(255,255,255,0.12); transition: all 0.15s; white-space: nowrap; }
        .topbar-back:hover { background: rgba(255,255,255,0.08); color: #fff; }
        .topbar-progress { display: flex; align-items: center; gap: 10px; }
        .progress-text { font-size: 0.75rem; color: rgba(255,255,255,0.5); white-space: nowrap; }
        .progress-bar-wrap { width: 120px; height: 5px; background: rgba(255,255,255,0.1); border-radius: 3px; overflow: hidden; }
        .progress-bar-fill { height: 100%; background: linear-gradient(90deg, var(--purple-mid), var(--gold)); border-radius: 3px; transition: width 0.4s ease; }

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

        /* VIDEO PLAYER */
        .video-wrap {
            width: 100%;
            background: #000;
            position: relative;
        }
        .video-wrap iframe {
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
        .no-video i { font-size: 3rem; color: rgba(255,255,255,0.2); }
        .no-video span { font-size: 0.9rem; color: rgba(255,255,255,0.3); }

        /* LESSON INFO */
        .lesson-info {
            padding: 28px 36px;
            background: #160930;
            border-bottom: 1px solid rgba(255,255,255,0.06);
        }
        .lesson-number { font-size: 0.72rem; font-weight: 700; text-transform: uppercase; letter-spacing: 2px; color: var(--purple-mid); margin-bottom: 8px; }
        .lesson-title { font-family: 'Playfair Display', serif; font-size: 1.6rem; font-weight: 700; color: #fff; margin-bottom: 12px; line-height: 1.3; }
        .lesson-meta { display: flex; align-items: center; gap: 16px; }
        .lesson-meta-item { display: flex; align-items: center; gap: 6px; font-size: 0.8rem; color: rgba(255,255,255,0.45); }
        .lesson-meta-item i { color: var(--purple-mid); }

        /* CONTENT AREA */
        .content-area {
            padding: 28px 36px 48px;
            background: #0F0720;
        }
        .content-label { font-size: 0.72rem; font-weight: 700; text-transform: uppercase; letter-spacing: 2px; color: var(--gold); margin-bottom: 14px; display: flex; align-items: center; gap: 8px; }
        .content-box {
            background: rgba(255,255,255,0.04);
            border: 1px solid rgba(255,255,255,0.08);
            border-radius: 14px;
            padding: 24px;
            font-size: 0.9rem;
            line-height: 1.8;
            color: rgba(255,255,255,0.7);
        }
        .content-empty { color: rgba(255,255,255,0.25); font-style: italic; font-size: 0.875rem; }

        /* NAV BUTTONS */
        .lesson-nav {
            display: flex;
            gap: 12px;
            padding: 0 36px 32px;
            background: #0F0720;
        }
        .btn-nav {
            display: flex; align-items: center; gap: 8px;
            padding: 11px 22px;
            border-radius: 10px;
            font-size: 0.85rem; font-weight: 700;
            text-decoration: none;
            transition: all 0.15s;
            font-family: 'DM Sans', sans-serif;
            border: none; cursor: pointer;
        }
        .btn-prev { background: rgba(255,255,255,0.06); color: rgba(255,255,255,0.6); border: 1px solid rgba(255,255,255,0.1); }
        .btn-prev:hover { background: rgba(255,255,255,0.1); color: #fff; }
        .btn-next { background: linear-gradient(135deg, var(--purple), var(--purple-dark)); color: #fff; box-shadow: 0 4px 16px rgba(108,63,197,0.35); }
        .btn-next:hover { transform: translateY(-1px); box-shadow: 0 6px 20px rgba(108,63,197,0.5); }
        .btn-nav.disabled { opacity: 0.3; pointer-events: none; }

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
        .sidebar-title { font-size: 0.72rem; font-weight: 700; text-transform: uppercase; letter-spacing: 2px; color: rgba(255,255,255,0.4); margin-bottom: 6px; }
        .sidebar-count { font-size: 0.85rem; font-weight: 600; color: rgba(255,255,255,0.7); }

        .lesson-list { overflow-y: auto; flex: 1; padding: 10px; }
        .lesson-list::-webkit-scrollbar { width: 4px; }
        .lesson-list::-webkit-scrollbar-track { background: transparent; }
        .lesson-list::-webkit-scrollbar-thumb { background: rgba(255,255,255,0.1); border-radius: 2px; }

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
        .lesson-item:hover { background: rgba(255,255,255,0.05); color: rgba(255,255,255,0.85); }
        .lesson-item.active { background: rgba(108,63,197,0.2); border-color: rgba(108,63,197,0.4); color: #fff; }

        .lesson-num {
            width: 28px; height: 28px;
            border-radius: 50%;
            background: rgba(255,255,255,0.07);
            display: flex; align-items: center; justify-content: center;
            font-size: 0.72rem; font-weight: 700;
            flex-shrink: 0;
            color: rgba(255,255,255,0.4);
        }
        .lesson-item.active .lesson-num { background: var(--purple); color: #fff; }

        .lesson-item-info { flex: 1; min-width: 0; }
        .lesson-item-title { font-size: 0.82rem; font-weight: 600; line-height: 1.4; margin-bottom: 4px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
        .lesson-item-dur { font-size: 0.7rem; color: rgba(255,255,255,0.3); display: flex; align-items: center; gap: 4px; }
        .lesson-item.active .lesson-item-dur { color: rgba(255,255,255,0.5); }

        .lesson-play-icon { color: var(--purple-mid); font-size: 0.75rem; flex-shrink: 0; margin-top: 6px; opacity: 0; transition: opacity 0.15s; }
        .lesson-item:hover .lesson-play-icon,
        .lesson-item.active .lesson-play-icon { opacity: 1; }

        /* Empty state */
        .no-lesson { text-align: center; padding: 48px 20px; }
        .no-lesson i { font-size: 2.5rem; color: rgba(255,255,255,0.1); margin-bottom: 12px; display: block; }
        .no-lesson p { font-size: 0.85rem; color: rgba(255,255,255,0.25); }

        @media (max-width: 768px) {
            .main-layout { flex-direction: column; }
            .sidebar { width: 100%; height: 280px; border-left: none; border-top: 1px solid rgba(255,255,255,0.07); }
            .lesson-info, .content-area, .lesson-nav { padding-left: 20px; padding-right: 20px; }
            .topbar-progress { display: none; }
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
                        <%-- Nếu là YouTube link → embed, nếu không thì dùng video tag --%>
                        <c:choose>
                            <c:when test="${fn:contains(currentLesson.video, 'youtube') or fn:contains(currentLesson.video, 'youtu.be')}">
                                <c:set var="ytId" value="${fn:substringAfter(currentLesson.video, 'v=')}"/>
                                <c:if test="${fn:contains(currentLesson.video, 'youtu.be')}">
                                    <c:set var="ytId" value="${fn:substringAfterLast(currentLesson.video, '/')}"/>
                                </c:if>
                                <iframe src="https://www.youtube.com/embed/${ytId}?rel=0&modestbranding=1"
                                        allowfullscreen allow="autoplay; encrypted-media"></iframe>
                            </c:when>
                            <c:otherwise>
                                <video controls style="width:100%; aspect-ratio:16/9; background:#000;">
                                    <source src="${currentLesson.video}">
                                    Trình duyệt không hỗ trợ video.
                                </video>
                            </c:otherwise>
                        </c:choose>
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
                            <span class="lesson-meta-item">
                                <i class="bi bi-clock"></i>
                                ${currentLesson.duration} phút
                            </span>
                        </c:if>
                        <span class="lesson-meta-item">
                            <i class="bi bi-play-circle"></i>
                            Video bài giảng
                        </span>
                        <span class="lesson-meta-item">
                            <i class="bi bi-book"></i>
                            ${course.topic}
                        </span>
                    </div>
                </div>

                <!-- NỘI DUNG BÀI HỌC -->
                <div class="content-area">
                    <div class="content-label">
                        <i class="bi bi-file-text-fill"></i> Nội dung bài học
                    </div>
                    <div class="content-box">
                        <c:choose>
                            <c:when test="${not empty currentLesson.content}">
                                ${currentLesson.content}
                            </c:when>
                            <c:otherwise>
                                <span class="content-empty">Bài học này chưa có nội dung mô tả.</span>
                            </c:otherwise>
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
                            <c:when test="${found == 'true' and empty nextLesson}">
                                <c:set var="nextLesson" value="${l}"/>
                            </c:when>
                            <c:when test="${l.lessonId == currentLesson.lessonId}">
                                <c:set var="found" value="true"/>
                            </c:when>
                            <c:otherwise>
                                <c:if test="${found == 'false'}">
                                    <c:set var="prevLesson" value="${l}"/>
                                </c:if>
                            </c:otherwise>
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
        // Tính progress bar
        (function() {
            const items   = document.querySelectorAll('.lesson-item');
            const total   = items.length;
            if (!total) return;

            let currentIdx = 0;
            items.forEach((item, i) => { if (item.classList.contains('active')) currentIdx = i; });

            const pct  = Math.round(((currentIdx + 1) / total) * 100);
            const fill = document.getElementById('progressFill');
            const txt  = document.getElementById('progressText');
            if (fill) fill.style.width = pct + '%';
            if (txt)  txt.textContent  = 'Bài ' + (currentIdx + 1) + ' / ' + total;

            // Scroll sidebar đến item đang active
            const activeItem = document.querySelector('.lesson-item.active');
            if (activeItem) activeItem.scrollIntoView({ block: 'center', behavior: 'smooth' });
        })();
    </script>
</body>
</html>
