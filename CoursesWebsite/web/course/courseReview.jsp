<%@page import="java.util.List"%>
<%@page import="model.ReviewDTO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đánh giá khóa học - DUK Academy</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --purple: #6C3FC5; --purple-dark: #4E2C96; --purple-deep: #1E0A4A;
            --purple-light: #F3EEFF; --gold: #D4A843;
            --text: #1A1A2E; --muted: #6B6B8A; --border: #E2D9F3; --bg: #F4F0FC;
        }
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'DM Sans', sans-serif; background: var(--bg); color: var(--text); min-height: 100vh; }

        .topbar {
            background: var(--purple-deep);
            padding: 0 32px;
            height: 60px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            position: sticky;
            top: 0;
            z-index: 10;
            box-shadow: 0 2px 12px rgba(0,0,0,0.2);
        }
        .topbar-brand { font-size: 1.2rem; font-weight: 700; color: #fff; text-decoration: none; }
        .topbar-brand span { color: var(--gold); }
        .btn-back {
            display: inline-flex; align-items: center; gap: 6px;
            background: rgba(255,255,255,0.1); border: 1px solid rgba(255,255,255,0.2);
            color: #fff; text-decoration: none; font-size: 0.82rem; font-weight: 600;
            padding: 7px 16px; border-radius: 8px; transition: background 0.15s;
        }
        .btn-back:hover { background: rgba(255,255,255,0.2); color: #fff; }

        .page-wrap { max-width: 760px; margin: 36px auto; padding: 0 20px 60px; }

        .page-header {
            background: linear-gradient(135deg, var(--purple-deep), #3A1A7A);
            border-radius: 16px;
            padding: 24px 28px;
            margin-bottom: 24px;
            display: flex;
            align-items: center;
            gap: 16px;
        }
        .page-header-icon {
            width: 48px; height: 48px; border-radius: 12px;
            background: rgba(212,168,67,0.2);
            display: flex; align-items: center; justify-content: center;
            font-size: 1.4rem; flex-shrink: 0;
        }
        .page-header h1 { font-size: 1.15rem; font-weight: 700; color: #fff; margin-bottom: 4px; }
        .page-header p { font-size: 0.78rem; color: rgba(255,255,255,0.5); }

        /* STATS ROW */
        .stats-row {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 12px;
            margin-bottom: 24px;
        }
        .stat-card {
            background: #fff;
            border: 1px solid var(--border);
            border-radius: 12px;
            padding: 16px 18px;
            text-align: center;
        }
        .stat-val { font-size: 1.6rem; font-weight: 800; color: var(--gold); line-height: 1; margin-bottom: 4px; }
        .stat-lbl { font-size: 0.72rem; font-weight: 600; color: var(--muted); text-transform: uppercase; letter-spacing: 0.5px; }

        /* REVIEW LIST */
        .review-list { display: flex; flex-direction: column; gap: 12px; }

        .review-card {
            background: #fff;
            border: 1px solid var(--border);
            border-radius: 14px;
            padding: 18px 20px;
            transition: box-shadow 0.15s;
        }
        .review-card:hover { box-shadow: 0 4px 16px rgba(108,63,197,0.1); }

        .review-header { display: flex; align-items: center; gap: 12px; margin-bottom: 10px; }
        .review-avatar {
            width: 38px; height: 38px; border-radius: 50%;
            background: linear-gradient(135deg, #9B72E8, var(--gold));
            display: flex; align-items: center; justify-content: center;
            font-size: 0.9rem; font-weight: 700; color: #fff; flex-shrink: 0;
        }
        .review-name { font-size: 0.85rem; font-weight: 700; color: var(--text); }
        .review-date { font-size: 0.7rem; color: var(--muted); margin-top: 2px; }
        .review-stars { margin-left: auto; color: var(--gold); font-size: 0.95rem; letter-spacing: 1px; }
        .star-score { font-size: 0.72rem; color: var(--muted); margin-left: 4px; }

        .review-comment {
            font-size: 0.84rem;
            color: var(--text);
            line-height: 1.7;
            background: var(--bg);
            border-radius: 8px;
            padding: 10px 14px;
        }
        .review-comment.empty { color: var(--muted); font-style: italic; }

        /* EMPTY STATE */
        .empty-state {
            background: #fff;
            border: 1px solid var(--border);
            border-radius: 14px;
            padding: 60px 20px;
            text-align: center;
            color: var(--muted);
        }
        .empty-state i { font-size: 3rem; display: block; margin-bottom: 12px; opacity: 0.25; }
        .empty-state p { font-size: 0.88rem; }
    </style>
</head>
<body>

<!-- TOPBAR -->
<div class="topbar">
    <a href="${pageContext.request.contextPath}/homePage.jsp" class="topbar-brand">DUK<span>Academy</span></a>
    <a href="${pageContext.request.contextPath}/instructorController?action=viewMyCourses" class="btn-back">
        <i class="bi bi-arrow-left"></i> Quay lại
    </a>
</div>

<div class="page-wrap">

    <%
        List reviews = (List) request.getAttribute("REVIEWS");
        int total = (reviews != null) ? reviews.size() : 0;

        // Tính avg rating nếu REVIEWS là List<ReviewDTO>
        double avgRating = 0;
        int ratingCount = 0;
        if (reviews != null) {
            for (Object obj : reviews) {
                if (obj instanceof model.ReviewDTO) {
                    model.ReviewDTO rv = (model.ReviewDTO) obj;
                    avgRating += rv.getRating();
                    ratingCount++;
                }
            }
            if (ratingCount > 0) avgRating = avgRating / ratingCount;
        }
    %>

    <!-- HEADER -->
    <div class="page-header">
        <div class="page-header-icon">⭐</div>
        <div>
            <h1>Đánh giá từ học viên</h1>
            <p>Tổng hợp phản hồi về khóa học của bạn</p>
        </div>
    </div>

    <!-- STATS -->
    <div class="stats-row">
        <div class="stat-card">
            <div class="stat-val"><%= total %></div>
            <div class="stat-lbl">Tổng đánh giá</div>
        </div>
        <div class="stat-card">
            <div class="stat-val" style="color:var(--gold);">
                <%= ratingCount > 0 ? String.format("%.1f", avgRating) : "—" %>
            </div>
            <div class="stat-lbl">Điểm trung bình</div>
        </div>
        <div class="stat-card">
            <div class="stat-val" style="color:#16A34A;">
                <%
                    int fiveStar = 0;
                    if (reviews != null) {
                        for (Object obj : reviews) {
                            if (obj instanceof model.ReviewDTO && ((model.ReviewDTO)obj).getRating() == 5) fiveStar++;
                        }
                    }
                    out.print(fiveStar);
                %>
            </div>
            <div class="stat-lbl">5 sao</div>
        </div>
    </div>

    <!-- REVIEW LIST -->
    <div class="review-list">
        <%
            if (reviews != null && !reviews.isEmpty()) {
                for (Object obj : reviews) {
                    if (obj instanceof model.ReviewDTO) {
                        model.ReviewDTO rv = (model.ReviewDTO) obj;
                        String initial = (rv.getFullname() != null && rv.getFullname().length() > 0)
                                ? String.valueOf(rv.getFullname().charAt(0)) : "?";
        %>
        <div class="review-card">
            <div class="review-header">
                <div class="review-avatar"><%= initial %></div>
                <div>
                    <div class="review-name"><%= rv.getFullname() != null ? rv.getFullname() : rv.getUserId() %></div>
                    <div class="review-date">
                        <i class="bi bi-calendar3"></i>
                        <%= rv.getCreatedAt() != null ? rv.getCreatedAt().toString().substring(0, 10) : "" %>
                    </div>
                </div>
                <div class="review-stars">
                    <%
                        for (int s = 1; s <= 5; s++) {
                            if (s <= rv.getRating()) out.print("★");
                            else out.print("<span style='opacity:0.2'>★</span>");
                        }
                    %>
                    <span class="star-score"><%= rv.getRating() %>/5</span>
                </div>
            </div>
            <div class="review-comment <%= (rv.getComment() == null || rv.getComment().isEmpty()) ? "empty" : "" %>">
                <%= (rv.getComment() != null && !rv.getComment().isEmpty()) ? rv.getComment() : "Không có nhận xét." %>
            </div>
        </div>
        <%
                    } else {
        %>
        <div class="review-card">
            <div class="review-comment"><%= obj %></div>
        </div>
        <%
                    }
                }
            } else {
        %>
        <div class="empty-state">
            <i class="bi bi-chat-dots"></i>
            <p>Chưa có đánh giá nào cho khóa học này.</p>
        </div>
        <% } %>
    </div>
</div>

</body>
</html>
