<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Duyệt nạp tiền - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <style>
        :root { --purple:#6C3FC5; --gold:#D4A843; --purple-deep:#1E0A4A; }
        body { background:#F4F0FC; font-family:'DM Sans',sans-serif; }
        .topbar { background:var(--purple-deep); padding:0 32px; height:60px; display:flex; align-items:center; justify-content:space-between; }
        .topbar-brand { color:#fff; font-weight:700; font-size:1.2rem; text-decoration:none; }
        .topbar-brand span { color:var(--gold); }
        .badge-pending { background:#FFF3CD; color:#856404; border:1px solid #FFE69C; padding:4px 12px; border-radius:20px; font-size:0.78rem; font-weight:700; }
        .card-payment { background:#fff; border-radius:14px; box-shadow:0 4px 20px rgba(108,63,197,0.08); overflow:hidden; }
        .amount-cell { font-weight:700; color:var(--purple); font-size:1rem; }
        .btn-approve { background:linear-gradient(135deg,#2E7D32,#388E3C); color:#fff; border:none; border-radius:8px; padding:7px 18px; font-weight:700; font-size:0.82rem; cursor:pointer; transition:all 0.15s; }
        .btn-approve:hover { transform:translateY(-1px); box-shadow:0 4px 12px rgba(46,125,50,0.4); }
        .btn-reject { background:#fff; color:#CC0000; border:1.5px solid #FCA5A5; border-radius:8px; padding:7px 18px; font-weight:700; font-size:0.82rem; cursor:pointer; transition:all 0.15s; }
        .btn-reject:hover { background:#FFF5F5; }
        .empty-state { text-align:center; padding:60px 20px; color:#9B72E8; }
        .empty-state i { font-size:3rem; display:block; margin-bottom:12px; opacity:0.4; }
        .status-badge { display:inline-flex; align-items:center; gap:6px; background:#FFF3CD; color:#856404; border:1px solid #FFE69C; border-radius:20px; padding:4px 12px; font-size:0.75rem; font-weight:700; }
    </style>
</head>
<body>

<div class="topbar">
    <a href="administrator.jsp" class="topbar-brand">DUK<span>Academy</span> — Admin</a>
    <a href="administrator.jsp" class="btn btn-sm" style="color:rgba(255,255,255,0.7);border:1px solid rgba(255,255,255,0.2);">
        <i class="bi bi-arrow-left"></i> Quay lại
    </a>
</div>

<div class="container py-4">
    <div class="d-flex align-items-center gap-3 mb-4">
        <h4 class="mb-0 fw-bold" style="color:var(--purple-deep);">
            <i class="bi bi-wallet2"></i> Duyệt nạp tiền
        </h4>
        <span class="badge-pending">
            ${pendingList.size()} yêu cầu chờ duyệt
        </span>
    </div>

    <div class="card-payment">
        <c:choose>
            <c:when test="${empty pendingList}">
                <div class="empty-state">
                    <i class="bi bi-check-circle"></i>
                    <p class="fw-600">Không có yêu cầu nào đang chờ duyệt</p>
                    <p style="font-size:0.85rem;color:#B0A0D0;">Tất cả giao dịch đã được xử lý!</p>
                </div>
            </c:when>
            <c:otherwise>
                <table class="table table-hover mb-0">
                    <thead style="background:#F3EEFF;">
                        <tr>
                            <th style="padding:16px 20px;color:#6B6B8A;font-size:0.75rem;text-transform:uppercase;letter-spacing:1px;">ID</th>
                            <th style="padding:16px 20px;color:#6B6B8A;font-size:0.75rem;text-transform:uppercase;letter-spacing:1px;">User ID</th>
                            <th style="padding:16px 20px;color:#6B6B8A;font-size:0.75rem;text-transform:uppercase;letter-spacing:1px;">Số tiền</th>
                            <th style="padding:16px 20px;color:#6B6B8A;font-size:0.75rem;text-transform:uppercase;letter-spacing:1px;">Phương thức</th>
                            <th style="padding:16px 20px;color:#6B6B8A;font-size:0.75rem;text-transform:uppercase;letter-spacing:1px;">Trạng thái</th>
                            <th style="padding:16px 20px;color:#6B6B8A;font-size:0.75rem;text-transform:uppercase;letter-spacing:1px;">Ngày tạo</th>
                            <th style="padding:16px 20px;color:#6B6B8A;font-size:0.75rem;text-transform:uppercase;letter-spacing:1px;">Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="p" items="${pendingList}">
                            <tr>
                                <td style="padding:16px 20px;font-weight:700;color:#9B72E8;">QR${p.paymentId}</td>
                                <td style="padding:16px 20px;">${p.userId}</td>
                                <td style="padding:16px 20px;" class="amount-cell">
                                    <fmt:formatNumber value="${p.amount}" type="number" groupingUsed="true"/> ₫
                                </td>
                                <td style="padding:16px 20px;">
                                    <span style="background:#EDE7FF;color:#6C3FC5;border-radius:6px;padding:3px 10px;font-size:0.78rem;font-weight:700;">
                                        ${p.paymentMethod}
                                    </span>
                                </td>
                                <td style="padding:16px 20px;">
                                    <span class="status-badge">
                                        <i class="bi bi-clock"></i> Chờ duyệt
                                    </span>
                                </td>
                                <td style="padding:16px 20px;color:#6B6B8A;font-size:0.85rem;">
                                    <fmt:formatDate value="${p.paymentDate}" pattern="HH:mm dd/MM/yyyy"/>
                                </td>
                                <td style="padding:16px 20px;">
                                    <div style="display:flex;gap:8px;">
                                        <%-- DUYỆT --%>
                                        <form method="POST" action="adminPaymentController" style="margin:0;">
                                            <input type="hidden" name="action" value="approve">
                                            <input type="hidden" name="paymentId" value="${p.paymentId}">
                                            <button type="submit" class="btn-approve"
                                                    onclick="return confirm('Duyệt và cộng ${p.amount}₫ cho user ${p.userId}?')">
                                                <i class="bi bi-check-lg"></i> Duyệt
                                            </button>
                                        </form>
                                        <%-- TỪ CHỐI --%>
                                        <form method="POST" action="adminPaymentController" style="margin:0;">
                                            <input type="hidden" name="action" value="reject">
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

</body>
</html>