<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <base href="${pageContext.request.contextPath}/">
        <meta charset="UTF-8">
        <title>Duyệt nạp tiền - Admin</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
        <style>
            :root {
                --purple:#6C3FC5;
                --purple-dark:#4E2C96;
                --purple-deep:#1E0A4A;
                --purple-light:#F3EEFF;
                --gold:#D4A843;
                --text:#1A1A2E;
                --muted:#6B6B8A;
                --border:#E2D9F3;
                --bg:#F4F0FC;
                --sidebar-w:240px;
            }
            * {
                box-sizing:border-box;
                margin:0;
                padding:0;
            }
            body {
                font-family:'DM Sans',sans-serif;
                background:var(--bg);
                color:var(--text);
                display:flex;
                min-height:100vh;
            }

            /* SIDEBAR */
            .sidebar {
                width:var(--sidebar-w);
                background:var(--purple-deep);
                min-height:100vh;
                position:fixed;
                left:0;
                top:0;
                display:flex;
                flex-direction:column;
                z-index:100;
            }
            .sidebar-logo {
                padding:22px 20px 18px;
                border-bottom:1px solid rgba(255,255,255,0.08);
                font-size:1.3rem;
                font-weight:700;
                color:#fff;
                text-decoration:none;
                display:block;
            }
            .sidebar-logo span {
                color:var(--gold);
            }
            .sidebar-logo small {
                display:block;
                font-size:0.65rem;
                font-weight:600;
                color:#ff8080;
                text-transform:uppercase;
                letter-spacing:1.5px;
                margin-top:4px;
            }
            .sidebar-user {
                padding:16px 20px;
                border-bottom:1px solid rgba(255,255,255,0.08);
                display:flex;
                align-items:center;
                gap:10px;
            }
            .s-avatar {
                width:40px;
                height:40px;
                border-radius:50%;
                background:linear-gradient(135deg,#ff6b6b,var(--gold));
                display:flex;
                align-items:center;
                justify-content:center;
                font-weight:700;
                color:#fff;
                font-size:1rem;
                flex-shrink:0;
            }
            .s-name {
                font-size:0.82rem;
                font-weight:700;
                color:#fff;
            }
            .s-role {
                font-size:0.68rem;
                color:rgba(255,255,255,0.45);
            }
            .sidebar-nav {
                flex:1;
                padding:12px;
            }
            .nav-section-label {
                font-size:0.58rem;
                font-weight:700;
                text-transform:uppercase;
                letter-spacing:2px;
                color:rgba(255,255,255,0.3);
                padding:10px 10px 5px;
            }
            .s-link {
                display:flex;
                align-items:center;
                gap:10px;
                padding:9px 12px;
                border-radius:8px;
                color:rgba(255,255,255,0.6);
                text-decoration:none;
                font-size:0.83rem;
                font-weight:500;
                transition:all 0.15s;
                margin-bottom:2px;
            }
            .s-link i {
                width:18px;
                text-align:center;
                font-size:0.95rem;
                flex-shrink:0;
            }
            .s-link:hover {
                background:rgba(255,255,255,0.08);
                color:#fff;
            }
            .s-link.active {
                background:var(--purple);
                color:#fff;
            }
            .sidebar-footer {
                padding:12px;
                border-top:1px solid rgba(255,255,255,0.08);
            }
            .s-link.logout {
                color:rgba(255,120,120,0.7);
            }
            .s-link.logout:hover {
                background:rgba(220,38,38,0.12);
                color:#ff8080;
            }

            /* MAIN */
            .main {
                margin-left:var(--sidebar-w);
                flex:1;
                display:flex;
                flex-direction:column;
            }
            .topbar {
                background:#fff;
                border-bottom:1px solid var(--border);
                padding:0 28px;
                height:58px;
                display:flex;
                align-items:center;
                justify-content:space-between;
                position:sticky;
                top:0;
                z-index:90;
            }
            .topbar-title {
                font-size:1rem;
                font-weight:700;
            }
            .topbar-right {
                display:flex;
                align-items:center;
                gap:10px;
            }
            .btn-outline {
                display:inline-flex;
                align-items:center;
                gap:6px;
                color:var(--muted);
                text-decoration:none;
                font-size:0.8rem;
                font-weight:500;
                padding:7px 14px;
                border-radius:8px;
                border:1px solid var(--border);
                transition:all 0.15s;
                background:#fff;
            }
            .btn-outline:hover {
                background:var(--purple-light);
                color:var(--purple);
                border-color:var(--purple);
            }
            .page-content {
                padding:28px;
            }
            .breadcrumb-bar {
                display:flex;
                align-items:center;
                gap:8px;
                font-size:0.78rem;
                color:var(--muted);
                margin-bottom:22px;
            }
            .breadcrumb-bar a {
                color:var(--purple);
                text-decoration:none;
                font-weight:600;
            }
            .breadcrumb-bar i {
                font-size:0.65rem;
            }

            /* PENDING BADGE */
            .pending-count {
                display:inline-flex;
                align-items:center;
                gap:6px;
                background:#FEF3C7;
                color:#D97706;
                border:1px solid #FDE68A;
                border-radius:20px;
                padding:4px 14px;
                font-size:0.78rem;
                font-weight:700;
            }

            /* TABLE */
            .table-wrap {
                background:#fff;
                border:1px solid var(--border);
                border-radius:14px;
                overflow:hidden;
            }
            table {
                width:100%;
                border-collapse:collapse;
            }
            thead th {
                background:var(--bg);
                padding:10px 16px;
                font-size:0.7rem;
                font-weight:700;
                color:var(--muted);
                text-transform:uppercase;
                letter-spacing:0.5px;
                border-bottom:1px solid var(--border);
                text-align:left;
                white-space:nowrap;
            }
            tbody td {
                padding:13px 16px;
                font-size:0.83rem;
                border-bottom:1px solid var(--border);
                vertical-align:middle;
            }
            tbody tr:last-child td {
                border-bottom:none;
            }
            tbody tr:hover {
                background:var(--bg);
            }

            .amount-cell {
                font-weight:700;
                color:var(--purple);
                font-size:0.9rem;
            }
            .method-tag {
                background:var(--purple-light);
                color:var(--purple);
                font-size:0.7rem;
                font-weight:700;
                padding:2px 8px;
                border-radius:5px;
            }
            .status-badge {
                display:inline-flex;
                align-items:center;
                gap:5px;
                background:#FEF3C7;
                color:#D97706;
                border:1px solid #FDE68A;
                border-radius:20px;
                padding:3px 10px;
                font-size:0.72rem;
                font-weight:700;
            }

            /* ACTION BTNS */
            .btn-approve {
                display:inline-flex;
                align-items:center;
                gap:5px;
                background:linear-gradient(135deg,#2E7D32,#388E3C);
                color:#fff;
                border:none;
                border-radius:8px;
                padding:7px 16px;
                font-weight:700;
                font-size:0.78rem;
                cursor:pointer;
                transition:all 0.15s;
                font-family:'DM Sans',sans-serif;
            }
            .btn-approve:hover {
                transform:translateY(-1px);
                box-shadow:0 4px 12px rgba(46,125,50,0.4);
            }
            .btn-reject  {
                display:inline-flex;
                align-items:center;
                gap:5px;
                background:#fff;
                color:#CC0000;
                border:1.5px solid #FCA5A5;
                border-radius:8px;
                padding:7px 16px;
                font-weight:700;
                font-size:0.78rem;
                cursor:pointer;
                transition:all 0.15s;
                font-family:'DM Sans',sans-serif;
            }
            .btn-reject:hover {
                background:#FFF5F5;
            }

            /* EMPTY */
            .empty-state {
                padding:60px;
                text-align:center;
                color:var(--muted);
            }
            .empty-state i {
                font-size:3rem;
                opacity:0.2;
                display:block;
                margin-bottom:14px;
            }
            .empty-state p {
                font-size:0.85rem;
            }
        </style>
    </head>
    <body>

        <!-- SIDEBAR -->
        <aside class="sidebar">
            <a href="homePage.jsp" class="sidebar-logo">DUK<span>Academy</span><small>⚙ Admin Portal</small></a>
            <div class="sidebar-user">
                <div class="s-avatar">${fn:substring(sessionScope.user.fullname, 0, 1)}</div>
                <div><div class="s-name">${sessionScope.user.fullname}</div><div class="s-role">Administrator</div></div>
            </div>
            <nav class="sidebar-nav">
                <div class="nav-section-label">Tổng quan</div>
                <a href="adminController?action=dashboard" class="s-link"><i class="bi bi-grid-1x2-fill"></i> Dashboard</a>
                <div class="nav-section-label">Quản lý</div>
                <a href="mainController?action=manageUsers" class="s-link"><i class="bi bi-people-fill"></i> Quản lý Users</a>
                <a href="mainController?action=manageCourses" class="s-link"><i class="bi bi-collection-play-fill"></i> Quản lý Khóa học</a>
                <a href="mainController?action=viewTopups" class="s-link active"><i class="bi bi-wallet2"></i> Duyệt nạp tiền</a>
                <a href="mainController?action=viewPayments" class="s-link"><i class="bi bi-receipt"></i> Lịch sử giao dịch</a>
            </nav>
            <div class="sidebar-footer">
                <a href="homePage.jsp" class="s-link"><i class="bi bi-house-fill"></i> Trang chủ</a>
                <a href="mainController?action=logout" class="s-link logout"><i class="bi bi-box-arrow-right"></i> Đăng xuất</a>
            </div>
        </aside>

        <!-- MAIN -->
        <div class="main">
            <div class="topbar">
                <div class="topbar-title">Duyệt nạp tiền</div>
                <a href="adminController?action=dashboard" class="btn-outline"><i class="bi bi-arrow-left"></i> Dashboard</a>
            </div>
            <div class="page-content">
                <div class="breadcrumb-bar">
                    <a href="admin/administrator.jsp">Dashboard</a>
                    <i class="bi bi-chevron-right"></i><span>Duyệt nạp tiền</span>
                </div>

                <div style="display:flex;align-items:center;gap:12px;margin-bottom:20px;">
                    <span class="pending-count">
                        <i class="bi bi-clock"></i> ${pendingList.size()} yêu cầu chờ duyệt
                    </span>
                </div>

                <div class="table-wrap">
                    <c:choose>
                        <c:when test="${empty pendingList}">
                            <div class="empty-state">
                                <i class="bi bi-check-circle"></i>
                                <p style="font-weight:700;margin-bottom:4px;">Không có yêu cầu nào đang chờ</p>
                                <p>Tất cả giao dịch đã được xử lý!</p>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <table>
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>User ID</th>
                                        <th>Số tiền</th>
                                        <th>Phương thức</th>
                                        <th>Ngày tạo</th>
                                        <th>Trạng thái</th>
                                        <th>Hành động</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="p" items="${pendingList}">
                                        <tr>
                                            <td style="font-weight:700;color:#9B72E8;">QR${p.paymentId}</td>
                                            <td style="font-weight:600;">${p.userId}</td>
                                            <td class="amount-cell">
                                                <fmt:formatNumber value="${p.amount}" type="number" groupingUsed="true"/> ₫
                                            </td>
                                            <td><span class="method-tag">${p.paymentMethod}</span></td>
                                            <td style="font-size:0.78rem;color:var(--muted);">
                                                <fmt:formatDate value="${p.paymentDate}" pattern="HH:mm dd/MM/yyyy"/>
                                            </td>
                                            <td>
                                                <span class="status-badge"><i class="bi bi-clock"></i> Chờ duyệt</span>
                                            </td>
                                            <td>
                                                <div style="display:flex;gap:8px;">
                                                    <form method="POST" action="adminController" style="margin:0;">
                                                        <input type="hidden" name="action" value="confirmPayment">
                                                        <input type="hidden" name="paymentId" value="${p.paymentId}">
                                                        <button type="submit" class="btn-approve"
                                                                onclick="return confirm('Duyệt và cộng ${p.amount}₫ cho user ${p.userId}?')">
                                                            <i class="bi bi-check-lg"></i> Duyệt
                                                        </button>
                                                    </form>
                                                    <form method="POST" action="mainController" style="margin:0;">
                                                        <input type="hidden" name="action" value="cancelPayment">
                                                        <input type="hidden" name="paymentId" value="${p.paymentId}">
                                                        <button type="submit" class="btn-reject"
                                                                onclick="return confirm('Từ chối giao dịch QR${p.paymentId}?')">
                                                            <i class="bi bi-x-lg"></i> Từ chối
                                                        </button>
                                                    </form>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

    </body>
</html>
