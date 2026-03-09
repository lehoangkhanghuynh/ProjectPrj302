<%-- 
    Document   : completeCourse
    Created on : Mar 9, 2026, 9:52:50 PM
    Author     : HOANG KHANG PC
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hoàn thành khóa học - DUK Academy</title>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&family=DM+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link rel="icon" type="favicon" href="img/page/favicon.jpg">
    <style>
        :root {
            --purple:      #7C4DFF;
            --purple-dark: #5E35B1;
            --purple-deep: #1A0A3A;
            --purple-light:#EDE7FF;
            --gold:        #FFB300;
            --text:        #1A1A2E;
            --muted:       #6B6B8A;
            --border:      #E2D9F3;
        }
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        body {
            font-family: 'DM Sans', sans-serif;
            background: linear-gradient(135deg, #1A0A3A 0%, #2D1B6B 50%, #1A0A3A 100%);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            position: relative;
            overflow: hidden;
        }

        /* CONFETTI */
        .confetti-wrap {
            position: fixed;
            inset: 0;
            pointer-events: none;
            z-index: 0;
        }
        .confetti-piece {
            position: absolute;
            width: 10px;
            height: 10px;
            top: -20px;
            opacity: 0;
            animation: confettiFall linear forwards;
        }
        @keyframes confettiFall {
            0%   { transform: translateY(0) rotate(0deg); opacity: 1; }
            100% { transform: translateY(110vh) rotate(720deg); opacity: 0; }
        }

        /* GLOW RINGS */
        .glow-ring {
            position: fixed;
            border-radius: 50%;
            pointer-events: none;
            z-index: 0;
        }
        .glow-ring-1 {
            width: 600px; height: 600px;
            background: radial-gradient(circle, rgba(124,77,255,0.15) 0%, transparent 70%);
            top: 50%; left: 50%;
            transform: translate(-50%, -50%);
            animation: pulse 3s ease-in-out infinite;
        }
        .glow-ring-2 {
            width: 900px; height: 900px;
            background: radial-gradient(circle, rgba(255,179,0,0.07) 0%, transparent 70%);
            top: 50%; left: 50%;
            transform: translate(-50%, -50%);
            animation: pulse 3s ease-in-out infinite 1.5s;
        }
        @keyframes pulse {
            0%, 100% { opacity: 0.6; transform: translate(-50%, -50%) scale(1); }
            50%       { opacity: 1;   transform: translate(-50%, -50%) scale(1.05); }
        }

        /* CARD */
        .complete-card {
            position: relative;
            z-index: 10;
            background: rgba(255,255,255,0.04);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255,255,255,0.1);
            border-radius: 28px;
            padding: 56px 52px 48px;
            width: 520px;
            max-width: 95vw;
            text-align: center;
            box-shadow: 0 32px 80px rgba(0,0,0,0.5), inset 0 1px 0 rgba(255,255,255,0.08);
            animation: cardIn 0.6s cubic-bezier(0.34,1.56,0.64,1) both;
        }
        @keyframes cardIn {
            from { opacity: 0; transform: scale(0.85) translateY(40px); }
            to   { opacity: 1; transform: scale(1) translateY(0); }
        }

        /* TROPHY */
        .trophy-wrap {
            position: relative;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 110px;
            height: 110px;
            margin: 0 auto 28px;
        }
        .trophy-bg {
            position: absolute;
            inset: 0;
            border-radius: 50%;
            background: linear-gradient(135deg, rgba(255,179,0,0.2), rgba(255,111,0,0.1));
            border: 2px solid rgba(255,179,0,0.3);
            animation: trophyPulse 2s ease-in-out infinite;
        }
        @keyframes trophyPulse {
            0%, 100% { box-shadow: 0 0 0 0 rgba(255,179,0,0.3); }
            50%       { box-shadow: 0 0 0 16px rgba(255,179,0,0); }
        }
        .trophy-icon {
            font-size: 3.2rem;
            animation: trophyBounce 0.8s cubic-bezier(0.34,1.56,0.64,1) 0.3s both;
            position: relative;
            z-index: 1;
        }
        @keyframes trophyBounce {
            from { transform: scale(0) rotate(-20deg); opacity: 0; }
            to   { transform: scale(1) rotate(0deg);   opacity: 1; }
        }

        /* STARS */
        .stars-row {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            margin-bottom: 18px;
        }
        .star {
            font-size: 1.4rem;
            color: var(--gold);
            animation: starPop 0.4s cubic-bezier(0.34,1.56,0.64,1) both;
        }
        .star:nth-child(1) { animation-delay: 0.5s; }
        .star:nth-child(2) { animation-delay: 0.65s; }
        .star:nth-child(3) { animation-delay: 0.8s; }
        .star:nth-child(4) { animation-delay: 0.65s; }
        .star:nth-child(5) { animation-delay: 0.5s; }
        @keyframes starPop {
            from { transform: scale(0); opacity: 0; }
            to   { transform: scale(1); opacity: 1; }
        }

        /* TEXT */
        .congrats-label {
            font-size: 0.72rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 3px;
            color: var(--gold);
            margin-bottom: 10px;
            animation: fadeUp 0.5s ease 0.2s both;
        }
        .complete-title {
            font-family: 'Playfair Display', serif;
            font-size: 2rem;
            font-weight: 700;
            color: #fff;
            margin-bottom: 10px;
            line-height: 1.25;
            animation: fadeUp 0.5s ease 0.3s both;
        }
        .course-name-badge {
            display: inline-block;
            background: rgba(124,77,255,0.2);
            border: 1px solid rgba(124,77,255,0.4);
            color: #C4B5FD;
            font-size: 0.88rem;
            font-weight: 600;
            padding: 7px 18px;
            border-radius: 20px;
            margin-bottom: 20px;
            animation: fadeUp 0.5s ease 0.4s both;
        }
        .complete-desc {
            font-size: 0.92rem;
            color: rgba(255,255,255,0.55);
            line-height: 1.7;
            margin-bottom: 36px;
            animation: fadeUp 0.5s ease 0.5s both;
        }
        @keyframes fadeUp {
            from { opacity: 0; transform: translateY(16px); }
            to   { opacity: 1; transform: translateY(0); }
        }

        /* DIVIDER */
        .divider {
            height: 1px;
            background: rgba(255,255,255,0.08);
            margin-bottom: 32px;
        }

        /* ACTION BUTTONS */
        .action-buttons {
            display: flex;
            flex-direction: column;
            gap: 12px;
            animation: fadeUp 0.5s ease 0.6s both;
        }
        .btn-cert {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            background: linear-gradient(135deg, #FFB300, #FF8F00);
            color: #1A0A00;
            font-family: 'DM Sans', sans-serif;
            font-size: 1rem;
            font-weight: 700;
            padding: 16px 28px;
            border-radius: 14px;
            text-decoration: none;
            border: none;
            cursor: pointer;
            transition: all 0.2s;
            box-shadow: 0 6px 24px rgba(255,143,0,0.4);
        }
        .btn-cert:hover {
            transform: translateY(-3px);
            box-shadow: 0 12px 32px rgba(255,143,0,0.55);
            color: #1A0A00;
        }
        .btn-cert i { font-size: 1.1rem; }

        .btn-row {
            display: flex;
            gap: 12px;
        }
        .btn-explore {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            background: rgba(124,77,255,0.15);
            border: 1.5px solid rgba(124,77,255,0.4);
            color: #C4B5FD;
            font-family: 'DM Sans', sans-serif;
            font-size: 0.88rem;
            font-weight: 700;
            padding: 13px 20px;
            border-radius: 12px;
            text-decoration: none;
            transition: all 0.2s;
        }
        .btn-explore:hover {
            background: rgba(124,77,255,0.28);
            border-color: rgba(124,77,255,0.7);
            color: #fff;
            transform: translateY(-2px);
        }
        .btn-mycourses {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            background: rgba(255,255,255,0.06);
            border: 1.5px solid rgba(255,255,255,0.12);
            color: rgba(255,255,255,0.7);
            font-family: 'DM Sans', sans-serif;
            font-size: 0.88rem;
            font-weight: 700;
            padding: 13px 20px;
            border-radius: 12px;
            text-decoration: none;
            transition: all 0.2s;
        }
        .btn-mycourses:hover {
            background: rgba(255,255,255,0.12);
            border-color: rgba(255,255,255,0.25);
            color: #fff;
            transform: translateY(-2px);
        }

        /* BRAND */
        .brand-top {
            position: fixed;
            top: 28px;
            left: 50%;
            transform: translateX(-50%);
            z-index: 20;
            font-family: 'Playfair Display', serif;
            font-size: 1.3rem;
            font-weight: 700;
            color: #fff;
            text-decoration: none;
            opacity: 0.85;
        }
        .brand-top span { color: var(--gold); }

        @media (max-width: 560px) {
            .complete-card { padding: 40px 24px 36px; }
            .complete-title { font-size: 1.6rem; }
            .btn-row { flex-direction: column; }
        }
    </style>
</head>
<body>

    <div class="glow-ring glow-ring-1"></div>
    <div class="glow-ring glow-ring-2"></div>
    <div class="confetti-wrap" id="confettiWrap"></div>

    <a href="courseController?action=ExploreCourse" class="brand-top">DUK<span>Academy</span></a>

    <div class="complete-card">

        <!-- Trophy -->
        <div class="trophy-wrap">
            <div class="trophy-bg"></div>
            <span class="trophy-icon">🏆</span>
        </div>

        <!-- Stars -->
        <div class="stars-row">
            <span class="star">★</span>
            <span class="star">★</span>
            <span class="star">★</span>
            <span class="star">★</span>
            <span class="star">★</span>
        </div>

        <div class="congrats-label">✦ Chúc mừng!</div>

        <div class="complete-title">
            Bạn đã hoàn thành<br>khóa học!
        </div>

        <div class="course-name-badge">
            <i class="bi bi-book-fill"></i>
            ${not empty course ? course.courseName : 'Khóa học'}
        </div>

        <div class="complete-desc">
            Xuất sắc! Bạn đã hoàn thành toàn bộ nội dung khóa học.<br>
            Hãy nhận chứng chỉ của bạn hoặc tiếp tục khám phá thêm kiến thức mới.
        </div>

        <div class="divider"></div>

        <div class="action-buttons">
            <!-- Nút chính: Nhận chứng chỉ -->
            <a href="certificate?courseId=${courseId}" class="btn-cert">
                <i class="bi bi-award-fill"></i>
                Nhận chứng chỉ hoàn thành
            </a>

            <!-- Nút phụ -->
            <div class="btn-row">
                <a href="courseController?action=ExploreCourse" class="btn-explore">
                    <i class="bi bi-compass-fill"></i>
                    Tìm khóa học mới
                </a>
                <a href="myCourses" class="btn-mycourses">
                    <i class="bi bi-collection-play-fill"></i>
                    Khóa học của tôi
                </a>
            </div>
        </div>

    </div>

    <script>
        // Confetti
        (function() {
            var wrap = document.getElementById('confettiWrap');
            var colors = ['#FFB300','#7C4DFF','#FF6F00','#B39DDB','#fff','#FFD54F','#E040FB'];
            var shapes = ['■','●','▲','◆'];
            for (var i = 0; i < 90; i++) {
                (function(i) {
                    var el = document.createElement('div');
                    el.className = 'confetti-piece';
                    el.textContent = shapes[Math.floor(Math.random() * shapes.length)];
                    el.style.left       = Math.random() * 100 + 'vw';
                    el.style.color      = colors[Math.floor(Math.random() * colors.length)];
                    el.style.fontSize   = (8 + Math.random() * 12) + 'px';
                    el.style.animationDuration  = (2.5 + Math.random() * 3) + 's';
                    el.style.animationDelay     = (Math.random() * 2) + 's';
                    wrap.appendChild(el);
                })(i);
            }
        })();
    </script>
</body>
</html>

