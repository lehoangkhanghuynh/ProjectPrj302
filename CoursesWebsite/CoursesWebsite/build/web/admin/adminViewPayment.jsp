<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <base href="${pageContext.request.contextPath}/">
    <meta charset="UTF-8">
    <title>Lịch sử giao dịch - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --purple:#6C3FC5; --purple-dark:#4E2C96; --purple-deep:#1E0A4A;
            --purple-light:#F3EEFF; --gold:#D4A843; --text:#1A1A2E;
            --muted:#6B6B8A; --border:#E2D9F3; --bg:#F4F0FC; --sidebar-w:240px;
        }
        * { box-sizing:border-box; margin:0; padding:0; }
        body { font-family:'DM Sans',sans-serif; background:var(--bg); color:var(--text); display:flex; min-height:100vh; }

        /* SIDEBAR */
        .sidebar { width:var(--sidebar-w); background:var(--purple-deep); min-height:100vh; position:fixed; left:0; top:0; display:flex; flex-direction:column; z-index:100; }
        .sidebar-logo { padding:22px 20px 18px; border-bottom:1px solid rgba(255,255,255,0.08); font-size:1.3rem; font-weight:700; color:#fff; text-decoration:none; display:block; }
        .sidebar-logo span { color:var(--gold); }
        .sidebar-logo small { display:block; font-size:0.65rem; font-weight:600; color:#ff8080; text-transform:uppercase; letter-spacing:1.5px; margin-top:4px; }
        .sidebar-user { padding:16px 20px; border-bottom:1px solid rgba(255,255,255,0.08); display:flex; align-items:center; gap:10px; }
        .s-avatar { width:40px; height:40px; border-radius:50%; background:linear-gradient(135deg,#ff6b6b,var(--gold)); display:flex; align-items:center; justify-content:center; font-weight:700; color:#fff; font-size:1rem; flex-shrink:0; }
        .s-name { font-size:0.82rem; font-weight:700; color:#fff; }
        .s-role { font-size:0.68rem; color:rgba(255,255,255,0.45); }
        .sidebar-nav { flex:1; padding:12px; }
        .nav-section-label { font-size:0.58rem; font-weight:700; text-transform:uppercase; letter-spacing:2px; color:rgba(255,255,255,0.3); padding:10px 10px 5px; }
        .s-link { display:flex; align-items:center; gap:10px; padding:9px 12px; border-radius:8px; color:rgba(255,255,255,0.6); text-decoration:none; font-size:0.83rem; font-weight:500; transition:all 0.15s; margin-bottom:2px; }
        .s-link i { width:18px; text-align:center; font-size:0.95rem; flex-shrink:0; }
        .s-link:hover { background:rgba(255,255,255,0.08); color:#fff; }
        .s-link.active { background:var(--purple); color:#fff; }
        .sidebar-footer { padding:12px; border-top:1px solid rgba(255,255,255,0.08); }
        .s-link.logout { color:rgba(255,120,120,0.7); }
        .s-link.logout:hover { background:rgba(220,38,38,0.12); color:#ff8080; }

        /* MAIN */
        .main { margin-left:var(--sidebar-w); flex:1; display:flex; flex-direction:column; }
        .topbar { background:#fff; border-bottom:1px solid var(--border); padding:0 28px; height:58px; display:flex; align-items:center; justify-content:space-between; position:sticky; top:0; z-index:90; }
        .topbar-title { font-size:1rem; font-weight:700; }
        .btn-outline { display:inline-flex; align-items:center; gap:6px; color:var(--muted); text-decoration:none; font-size:0.8rem; font-weight:500; padding:7px 14px; border-radius:8px; border:1px solid var(--border); transition:all 0.15s; background:#fff; }
        .btn-outline:hover { background:var(--purple-light); color:var(--purple); border-color:var(--purple); }
        .page-content { padding:28px; }
        .breadcrumb-bar { display:flex; align-items:center; gap:8px; font-size:0.78rem; color:var(--muted); margin-bottom:22px; }
        .breadcrumb-bar a { color:var(--purple); text-decoration:none; font-weight:600; }
        .breadcrumb-bar i { font-size:0.65rem; }

        /* SEARCH */
        .search-bar { display:flex; align-items:center; gap:10px; margin-bottom:20px; }
        .search-wrap { position:relative; flex:1; max-width:320px; }
        .search-wrap i { position:absolute; left:12px; top:50%; transform:translateY(-50%); color:var(--muted); font-size:0.9rem; pointer-events:none; }
        .search-input { width:100%; padding:8px 14px 8px 36px; border:1.5px solid var(--border); border-radius:9px; font-size:0.83rem; font-family:'DM Sans',sans-serif; outline:none; transition:border-color 0.15s; background:#fff; }
        .search-input:focus { border-color:var(--purple); }
        .count-label { font-size:0.8rem; color:var(--muted); margin-left:auto; }
        .count-label strong { color:var(--text); }

        /* TABLE */
        .table-wrap { background:#fff; border:1px solid var(--border); border-radius:14px; overflow:hidden; }
        table { width:100%; border-collapse:collapse; }
        thead th { background:var(--bg); padding:10px 16px; font-size:0.7rem; font-weight:700; color:var(--muted); text-transform:uppercase; letter-spacing:0.5px; border-bottom:1px solid var(--border); text-align:left; white-space:nowrap; }
        tbody td { padding:12px 16px; font-size:0.83rem; border-bottom:1px solid var(--border); vertical-align:middle; }
        tbody tr:last-child td { border-bottom:none; }
        tbody tr:hover { background:var(--bg); }

        /* PAYMENT ID */
        .payment-id { font-size:0.75rem; color:#9B72E8; font-weight:700; }

        /* METHOD BADGES */
        .badge-method { border-radius:6px; padding:3px 10px; font-size:0.7rem; font-weight:700; }
        .method-vnpay    { background:#E3F2FD; color:#1565C0; }
        .method-momo     { background:#FCE4EC; color:#AD1457; }
        .method-bank     { background:#E8F5E9; color:#2E7D32; }
        .method-wallet   { background:var(--purple-light); color:var(--purple); }
        .method-default  { background:#F5F5F5; color:#616161; }

        /* STATUS BADGES */
        .badge-success  { background:#E8F5E9; color:#2E7D32; border:1px solid #C8E6C9; padding:3px 10px; border-radius:20px; font-size:0.72rem; font-weight:700; }
        .badge-pending  { background:#FFF8E1; color:#F57F17; border:1px solid #FFE082; padding:3px 10px; border-radius:20px; font-size:0.72rem; font-weight:700; }
        .badge-failed   { background:#FFF5F5; color:#CC0000; border:1px solid #FCA5A5; padding:3px 10px; border-radius:20px; font-size:0.72rem; font-weight:700; }
    </style>
</head>
<body>

<!-- SIDEBAR -->
<aside class="sidebar">
    <a href="homePage.jsp" class="sidebar-logo">DUK<span>Academy</span><small>⚙ Admin Portal</small></a>
    <div class="sidebar-user">
        <div class="s-avatar">${fn:substring(sessionScope.user.fullname, 0, 1)}</div>
        <div>
            <div class="s-name">${sessionScope.user.fullname}</div>
            <div class="s-role">Administrator</div>
        </div>
    </div>
    <nav class="sidebar-nav">
        <div class="nav-section-label">Tổng quan</div>
        <a href="adminController?action=dashboard" class="s-link"><i class="bi bi-grid-1x2-fill"></i> Dashboard</a>
        <div class="nav-section-label">Quản lý</div>
        <a href="mainController?action=manageUsers" class="s-link"><i class="bi bi-people-fill"></i> Quản lý Users</a>
        <a href="mainController?action=manageCourses" class="s-link"><i class="bi bi-collection-play-fill"></i> Quản lý Khóa học</a>
        <a href="mainController?action=viewTopups" class="s-link"><i class="bi bi-wallet2"></i> Duyệt nạp tiền</a>
        <a href="mainController?action=viewPayments" class="s-link active"><i class="bi bi-receipt"></i> Lịch sử giao dịch</a>
    </nav>
    <div class="sidebar-footer">
        <a href="homePage.jsp" class="s-link"><i class="bi bi-house-fill"></i> Trang chủ</a>
        <a href="mainController?action=logout" class="s-link logout"><i class="bi bi-box-arrow-right"></i> Đăng xuất</a>
    </div>
</aside>

<!-- MAIN -->
<div class="main">
    <div class="topbar">
        <div class="topbar-title">Lịch sử giao dịch</div>
        <a href="adminController?action=dashboard" class="btn-outline"><i class="bi bi-arrow-left"></i> Dashboard</a>
    </div>
    <div class="page-content">
        <div class="breadcrumb-bar">
            <a href="adminController?action=dashboard">Dashboard</a>
            <i class="bi bi-chevron-right"></i>
            <span>Lịch sử giao dịch</span>
        </div>

        <div class="search-bar">
            <div class="count-label">
                Tổng: <strong id="countDisplay">${not empty PAYMENT_LIST ? PAYMENT_LIST.size() : 0}</strong> giao dịch
            </div>
        </div>

        <div class="table-wrap">
            <table id="paymentTable">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>User</th>
                        <th>Số tiền</th>
                        <th>Phương thức</th>
                        <th>Ngày</th>
                        <th>Trạng thái</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="p" items="${PAYMENT_LIST}">
                        <tr>
                            <td><span class="payment-id">#${p.paymentId}</span></td>
                            <td style="font-weight:600;">${p.userId}</td>
                            <td style="font-weight:700; color:var(--purple);">
                                <fmt:formatNumber value="${p.amount}" type="number" groupingUsed="true"/> ₫
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${fn:toLowerCase(p.paymentMethod) == 'vnpay'}">
                                        <span class="badge-method method-vnpay"><i class="bi bi-credit-card"></i> VNPay</span>
                                    </c:when>
                                    <c:when test="${fn:toLowerCase(p.paymentMethod) == 'momo'}">
                                        <span class="badge-method method-momo"><i class="bi bi-phone"></i> MoMo</span>
                                    </c:when>
                                    <c:when test="${fn:toLowerCase(p.paymentMethod) == 'bank'}">
                                        <span class="badge-method method-bank"><i class="bi bi-bank"></i> Bank</span>
                                    </c:when>
                                    <c:when test="${fn:toLowerCase(p.paymentMethod) == 'wallet'}">
                                        <span class="badge-method method-wallet"><i class="bi bi-wallet2"></i> Wallet</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge-method method-default"><i class="bi bi-cash"></i> ${p.paymentMethod}</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td style="color:var(--muted); font-size:0.8rem;">${p.paymentDate}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${fn:toLowerCase(p.paymentStatus) == 'success' || fn:toLowerCase(p.paymentStatus) == 'completed'}">
                                        <span class="badge-success"><i class="bi bi-check-circle-fill"></i> Success</span>
                                    </c:when>
                                    <c:when test="${fn:toLowerCase(p.paymentStatus) == 'pending'}">
                                        <span class="badge-pending"><i class="bi bi-clock-fill"></i> Pending</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge-failed"><i class="bi bi-x-circle-fill"></i> Failed</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>
