<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Admin Panel - DUK Academy</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <style>
        :root { --purple:#6C3FC5; --gold:#D4A843; --purple-deep:#1E0A4A; }
        body { background:#F4F0FC; font-family:'DM Sans',sans-serif; min-height:100vh; }
        .topbar { background:var(--purple-deep); padding:0 32px; height:60px; display:flex; align-items:center; justify-content:space-between; }
        .brand { color:#fff; font-weight:700; font-size:1.3rem; text-decoration:none; }
        .brand span { color:var(--gold); }
        .menu-card { background:#fff; border-radius:16px; box-shadow:0 4px 24px rgba(108,63,197,0.10); padding:32px; display:flex; flex-direction:column; align-items:center; gap:12px; text-decoration:none; transition:all 0.18s; border:2px solid transparent; }
        .menu-card:hover { border-color:var(--purple); transform:translateY(-3px); box-shadow:0 8px 32px rgba(108,63,197,0.18); }
        .menu-card i { font-size:2.2rem; color:var(--purple); }
        .menu-card span { font-size:0.95rem; font-weight:700; color:#1E0A4A; }
        .menu-card small { font-size:0.78rem; color:#6B6B8A; text-align:center; }
    </style>
</head>
<body>

<div class="topbar">
    <a href="homePage.jsp" class="brand">DUK<span>Academy</span> — Admin</a>
    <a href="homePage.jsp" style="color:rgba(255,255,255,0.7);font-size:0.85rem;text-decoration:none;">
        <i class="bi bi-house"></i> Trang chủ
    </a>
</div>

<div class="container py-5">
    <h4 class="fw-bold mb-4" style="color:#1E0A4A;">
        <i class="bi bi-shield-check" style="color:var(--purple);"></i> Administrator Panel
    </h4>

    <div class="row g-4">
        <div class="col-md-3">
            <a href="mainController?action=manageUsers" class="menu-card">
                <i class="bi bi-people-fill"></i>
                <span>Quản lý Users</span>
                <small>Xem và chỉnh sửa tài khoản</small>
            </a>
        </div>
        <div class="col-md-3">
            <a href="mainController?action=manageCourses" class="menu-card">
                <i class="bi bi-book-fill"></i>
                <span>Quản lý Khóa học</span>
                <small>Thêm, sửa, xóa khóa học</small>
            </a>
        </div>
        <div class="col-md-3">
            <a href="adminPaymentController" class="menu-card">
                <i class="bi bi-wallet2" style="color:#2E7D32;"></i>
                <span>Duyệt nạp tiền</span>
                <small>Xét duyệt yêu cầu nạp tiền</small>
            </a>
        </div>
        <div class="col-md-3">
            <a href="mainController?action=viewPayments" class="menu-card">
                <i class="bi bi-receipt" style="color:#B8860B;"></i>
                <span>Lịch sử giao dịch</span>
                <small>Xem toàn bộ thanh toán</small>
            </a>
        </div>
    </div>
</div>

</body>
</html>