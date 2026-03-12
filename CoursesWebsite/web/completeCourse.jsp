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
            overflow-x: hidden;
            padding: 80px 16px 40px;
        }

        /* CONFETTI */
        .confetti-wrap { position: fixed; inset: 0; pointer-events: none; z-index: 0; }
        .confetti-piece { position: absolute; top: -20px; opacity: 0; animation: confettiFall linear forwards; }
        @keyframes confettiFall {
            0%   { transform: translateY(0) rotate(0deg); opacity: 1; }
            100% { transform: translateY(110vh) rotate(720deg); opacity: 0; }
        }

        /* GLOW RINGS */
        .glow-ring { position: fixed; border-radius: 50%; pointer-events: none; z-index: 0; }
        .glow-ring-1 { width: 600px; height: 600px; background: radial-gradient(circle, rgba(124,77,255,0.15) 0%, transparent 70%); top: 50%; left: 50%; transform: translate(-50%,-50%); animation: pulse 3s ease-in-out infinite; }
        .glow-ring-2 { width: 900px; height: 900px; background: radial-gradient(circle, rgba(255,179,0,0.07) 0%, transparent 70%); top: 50%; left: 50%; transform: translate(-50%,-50%); animation: pulse 3s ease-in-out infinite 1.5s; }
        @keyframes pulse {
            0%,100% { opacity: 0.6; transform: translate(-50%,-50%) scale(1); }
            50%      { opacity: 1;   transform: translate(-50%,-50%) scale(1.05); }
        }

        /* BRAND */
        .brand-top { position: fixed; top: 28px; left: 50%; transform: translateX(-50%); z-index: 20; font-family: 'Playfair Display', serif; font-size: 1.3rem; font-weight: 700; color: #fff; text-decoration: none; opacity: 0.85; }
        .brand-top span { color: var(--gold); }

        /* CARD */
        .complete-card {
            position: relative; z-index: 10;
            background: rgba(255,255,255,0.04);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255,255,255,0.1);
            border-radius: 28px;
            padding: 56px 52px 48px;
            width: 560px; max-width: 100%;
            text-align: center;
            box-shadow: 0 32px 80px rgba(0,0,0,0.5), inset 0 1px 0 rgba(255,255,255,0.08);
            animation: cardIn 0.6s cubic-bezier(0.34,1.56,0.64,1) both;
        }
        @keyframes cardIn {
            from { opacity: 0; transform: scale(0.85) translateY(40px); }
            to   { opacity: 1; transform: scale(1) translateY(0); }
        }

        /* TROPHY */
        .trophy-wrap { position: relative; display: inline-flex; align-items: center; justify-content: center; width: 110px; height: 110px; margin: 0 auto 28px; }
        .trophy-bg { position: absolute; inset: 0; border-radius: 50%; background: linear-gradient(135deg, rgba(255,179,0,0.2), rgba(255,111,0,0.1)); border: 2px solid rgba(255,179,0,0.3); animation: trophyPulse 2s ease-in-out infinite; }
        @keyframes trophyPulse { 0%,100% { box-shadow: 0 0 0 0 rgba(255,179,0,0.3); } 50% { box-shadow: 0 0 0 16px rgba(255,179,0,0); } }
        .trophy-icon { font-size: 3.2rem; animation: trophyBounce 0.8s cubic-bezier(0.34,1.56,0.64,1) 0.3s both; position: relative; z-index: 1; }
        @keyframes trophyBounce { from { transform: scale(0) rotate(-20deg); opacity: 0; } to { transform: scale(1) rotate(0deg); opacity: 1; } }

        /* STARS DECO */
        .stars-row { display: flex; align-items: center; justify-content: center; gap: 8px; margin-bottom: 18px; }
        .star { font-size: 1.4rem; color: var(--gold); animation: starPop 0.4s cubic-bezier(0.34,1.56,0.64,1) both; }
        .star:nth-child(1) { animation-delay: 0.5s; }
        .star:nth-child(2) { animation-delay: 0.65s; }
        .star:nth-child(3) { animation-delay: 0.8s; }
        .star:nth-child(4) { animation-delay: 0.65s; }
        .star:nth-child(5) { animation-delay: 0.5s; }
        @keyframes starPop { from { transform: scale(0); opacity: 0; } to { transform: scale(1); opacity: 1; } }

        /* TEXT */
        .congrats-label { font-size: 0.72rem; font-weight: 700; text-transform: uppercase; letter-spacing: 3px; color: var(--gold); margin-bottom: 10px; animation: fadeUp 0.5s ease 0.2s both; }
        .complete-title { font-family: 'Playfair Display', serif; font-size: 2rem; font-weight: 700; color: #fff; margin-bottom: 10px; line-height: 1.25; animation: fadeUp 0.5s ease 0.3s both; }
        .course-name-badge { display: inline-block; background: rgba(124,77,255,0.2); border: 1px solid rgba(124,77,255,0.4); color: #C4B5FD; font-size: 0.88rem; font-weight: 600; padding: 7px 18px; border-radius: 20px; margin-bottom: 20px; animation: fadeUp 0.5s ease 0.4s both; }
        .complete-desc { font-size: 0.92rem; color: rgba(255,255,255,0.55); line-height: 1.7; margin-bottom: 36px; animation: fadeUp 0.5s ease 0.5s both; }
        @keyframes fadeUp { from { opacity: 0; transform: translateY(16px); } to { opacity: 1; transform: translateY(0); } }

        .divider { height: 1px; background: rgba(255,255,255,0.08); margin-bottom: 28px; }

        /* ===== REVIEW FORM ===== */
        .review-block {
            background: rgba(255,255,255,0.05);
            border: 1px solid rgba(255,255,255,0.1);
            border-radius: 16px;
            padding: 24px;
            margin-bottom: 24px;
            text-align: left;
            animation: fadeUp 0.5s ease 0.55s both;
        }
        .review-block-title {
            font-size: 0.72rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 2px;
            color: var(--gold);
            margin-bottom: 14px;
            display: flex;
            align-items: center;
            gap: 7px;
        }
        /* Star picker */
        .star-picker { display: flex; flex-direction: row-reverse; gap: 6px; margin-bottom: 14px; }
        .star-picker input[type="radio"] { display: none; }
        .star-picker label { font-size: 2rem; color: rgba(255,255,255,0.2); cursor: pointer; transition: color 0.12s; line-height: 1; }
        .star-picker input[type="radio"]:checked ~ label,
        .star-picker label:hover,
        .star-picker label:hover ~ label { color: var(--gold); }

        .review-textarea {
            width: 100%;
            background: rgba(255,255,255,0.06);
            border: 1.5px solid rgba(255,255,255,0.12);
            border-radius: 10px;
            padding: 11px 14px;
            font-size: 0.88rem;
            font-family: 'DM Sans', sans-serif;
            color: #fff;
            resize: vertical;
            min-height: 80px;
            outline: none;
            transition: border-color 0.15s;
        }
        .review-textarea::placeholder { color: rgba(255,255,255,0.25); }
        .review-textarea:focus { border-color: rgba(124,77,255,0.6); background: rgba(255,255,255,0.08); }

        .btn-review-submit {
            display: flex; align-items: center; justify-content: center; gap: 8px;
            width: 100%; margin-top: 12px;
            background: linear-gradient(135deg, var(--purple), var(--purple-dark));
            color: #fff; border: none; border-radius: 10px;
            padding: 12px 20px; font-size: 0.9rem; font-weight: 700;
            font-family: 'DM Sans', sans-serif; cursor: pointer;
            transition: all 0.18s;
            box-shadow: 0 4px 16px rgba(124,77,255,0.4);
        }
        .btn-review-submit:hover { transform: translateY(-2px); box-shadow: 0 8px 24px rgba(124,77,255,0.55); }

        /* Already reviewed */
        .already-reviewed {
            display: flex; align-items: center; gap: 10px;
            background: rgba(255,179,0,0.08);
            border: 1px solid rgba(255,179,0,0.2);
            border-radius: 10px; padding: 12px 16px;
            font-size: 0.85rem; color: rgba(255,255,255,0.7);
            margin-bottom: 24px;
            animation: fadeUp 0.5s ease 0.55s both;
        }
        .already-reviewed i { color: var(--gold); font-size: 1rem; }

        /* Flash */
        .rv-alert { padding: 10px 14px; border-radius: 9px; font-size: 0.82rem; font-weight: 600; margin-bottom: 16px; display: flex; align-items: center; gap: 8px; }
        .rv-alert-success { background: rgba(52,211,153,0.12); border: 1px solid rgba(52,211,153,0.3); color: #6EE7B7; }
        .rv-alert-error   { background: rgba(248,113,113,0.12); border: 1px solid rgba(248,113,113,0.3); color: #FCA5A5; }

        /* ACTION BUTTONS */
        .action-buttons { display: flex; flex-direction: column; gap: 12px; animation: fadeUp 0.5s ease 0.65s both; }
        .btn-cert { display: flex; align-items: center; justify-content: center; gap: 10px; background: linear-gradient(135deg, #FFB300, #FF8F00); color: #1A0A00; font-family: 'DM Sans', sans-serif; font-size: 1rem; font-weight: 700; padding: 16px 28px; border-radius: 14px; text-decoration: none; border: none; cursor: pointer; transition: all 0.2s; box-shadow: 0 6px 24px rgba(255,143,0,0.4); }
        .btn-cert:hover { transform: translateY(-3px); box-shadow: 0 12px 32px rgba(255,143,0,0.55); color: #1A0A00; }
        .btn-row { display: flex; gap: 12px; }
        .btn-explore { flex: 1; display: flex; align-items: center; justify-content: center; gap: 8px; background: rgba(124,77,255,0.15); border: 1.5px solid rgba(124,77,255,0.4); color: #C4B5FD; font-family: 'DM Sans', sans-serif; font-size: 0.88rem; font-weight: 700; padding: 13px 20px; border-radius: 12px; text-decoration: none; transition: all 0.2s; }
        .btn-explore:hover { background: rgba(124,77,255,0.28); border-color: rgba(124,77,255,0.7); color: #fff; transform: translateY(-2px); }
        .btn-mycourses { flex: 1; display: flex; align-items: center; justify-content: center; gap: 8px; background: rgba(255,255,255,0.06); border: 1.5px solid rgba(255,255,255,0.12); color: rgba(255,255,255,0.7); font-family: 'DM Sans', sans-serif; font-size: 0.88rem; font-weight: 700; padding: 13px 20px; border-radius: 12px; text-decoration: none; transition: all 0.2s; }
        .btn-mycourses:hover { background: rgba(255,255,255,0.12); border-color: rgba(255,255,255,0.25); color: #fff; transform: translateY(-2px); }

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

        <div class="trophy-wrap">
            <div class="trophy-bg"></div>
            <span class="trophy-icon">🏆</span>
        </div>

        <div class="stars-row">
            <span class="star">★</span><span class="star">★</span><span class="star">★</span>
            <span class="star">★</span><span class="star">★</span>
        </div>

        <div class="congrats-label">✦ Chúc mừng!</div>
        <div class="complete-title">Bạn đã hoàn thành<br>khóa học!</div>

        <div class="course-name-badge">
            <i class="bi bi-book-fill"></i>
            ${not empty course ? course.courseName : 'Khóa học'}
        </div>

        <div class="complete-desc">
            Xuất sắc! Bạn đã hoàn thành toàn bộ nội dung khóa học.<br>
            Hãy nhận chứng chỉ của bạn hoặc tiếp tục khám phá thêm kiến thức mới.
        </div>

        <div class="divider"></div>

        <%-- ===== REVIEW BLOCK ===== --%>
        <c:if test="${not empty sessionScope.reviewSuccess}">
            <div class="rv-alert rv-alert-success"><i class="bi bi-check-circle-fill"></i>${sessionScope.reviewSuccess}</div>
            <c:remove var="reviewSuccess" scope="session"/>
        </c:if>
        <c:if test="${not empty sessionScope.reviewError}">
            <div class="rv-alert rv-alert-error"><i class="bi bi-exclamation-circle-fill"></i>${sessionScope.reviewError}</div>
            <c:remove var="reviewError" scope="session"/>
        </c:if>

        <c:choose>
            <c:when test="${not empty MY_REVIEW}">
                <%-- Đã review rồi --%>
                <div class="already-reviewed">
                    <i class="bi bi-star-fill"></i>
                    Bạn đã đánh giá khóa học này — cảm ơn bạn!
                </div>
            </c:when>
            <c:otherwise>
                <%-- Chưa review → hiện form --%>
                <div class="review-block">
                    <div class="review-block-title">
                        <i class="bi bi-star-fill"></i> Bạn thấy khóa học thế nào?
                    </div>
                    <form method="POST" action="reviewController">
                        <input type="hidden" name="action"   value="add">
                        <input type="hidden" name="courseId" value="${courseId}">
                        <input type="hidden" name="redirect" value="courseComplete?courseId=${courseId}">
                        <div class="star-picker">
                            <input type="radio" name="rating" id="cs5" value="5" required/><label for="cs5">★</label>
                            <input type="radio" name="rating" id="cs4" value="4"/><label for="cs4">★</label>
                            <input type="radio" name="rating" id="cs3" value="3"/><label for="cs3">★</label>
                            <input type="radio" name="rating" id="cs2" value="2"/><label for="cs2">★</label>
                            <input type="radio" name="rating" id="cs1" value="1"/><label for="cs1">★</label>
                        </div>
                        <textarea name="comment" class="review-textarea"
                                  placeholder="Chia sẻ cảm nhận của bạn về khóa học này..." maxlength="1000"></textarea>
                        <button type="submit" class="btn-review-submit">
                            <i class="bi bi-send-fill"></i> Gửi đánh giá
                        </button>
                    </form>
                </div>
            </c:otherwise>
        </c:choose>
        <%-- ===== END REVIEW BLOCK ===== --%>

        <div class="action-buttons">
            <a href="certificate?courseId=${courseId}" class="btn-cert">
                <i class="bi bi-award-fill"></i> Nhận chứng chỉ hoàn thành
            </a>
            <div class="btn-row">
                <a href="courseController?action=ExploreCourse" class="btn-explore">
                    <i class="bi bi-compass-fill"></i> Tìm khóa học mới
                </a>
                <a href="myCourses" class="btn-mycourses">
                    <i class="bi bi-collection-play-fill"></i> Khóa học của tôi
                </a>
            </div>
        </div>

    </div>

    <script>
        (function() {
            var wrap = document.getElementById('confettiWrap');
            var colors = ['#FFB300','#7C4DFF','#FF6F00','#B39DDB','#fff','#FFD54F','#E040FB'];
            var shapes = ['■','●','▲','◆'];
            for (var i = 0; i < 90; i++) {
                (function(i) {
                    var el = document.createElement('div');
                    el.className = 'confetti-piece';
                    el.textContent = shapes[Math.floor(Math.random() * shapes.length)];
                    el.style.left              = Math.random() * 100 + 'vw';
                    el.style.color             = colors[Math.floor(Math.random() * colors.length)];
                    el.style.fontSize          = (8 + Math.random() * 12) + 'px';
                    el.style.animationDuration = (2.5 + Math.random() * 3) + 's';
                    el.style.animationDelay    = (Math.random() * 2) + 's';
                    wrap.appendChild(el);
                })(i);
            }
        })();
    </script>
</body>
</html>
