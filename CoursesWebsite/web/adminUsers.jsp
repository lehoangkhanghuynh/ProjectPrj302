<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Quản lý Users - Admin</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
        <style>
            :root {
                --purple:#6C3FC5;
                --gold:#D4A843;
                --purple-deep:#1E0A4A;
            }
            body {
                background:#F4F0FC;
                font-family:'DM Sans',sans-serif;
            }
            .topbar {
                background:var(--purple-deep);
                padding:0 32px;
                height:60px;
                display:flex;
                align-items:center;
                justify-content:space-between;
            }
            .brand {
                color:#fff;
                font-weight:700;
                font-size:1.2rem;
                text-decoration:none;
            }
            .brand span {
                color:var(--gold);
            }
            .card-table {
                background:#fff;
                border-radius:16px;
                box-shadow:0 4px 24px rgba(108,63,197,0.08);
                overflow:hidden;
            }
            .avatar {
                width:36px;
                height:36px;
                border-radius:50%;
                background:linear-gradient(135deg,#6C3FC5,#9B72E8);
                display:flex;
                align-items:center;
                justify-content:center;
                font-size:0.85rem;
                font-weight:700;
                color:#fff;
                flex-shrink:0;
            }
            .badge-active {
                background:#E8F5E9;
                color:#2E7D32;
                border:1px solid #C8E6C9;
                padding:4px 12px;
                border-radius:20px;
                font-size:0.75rem;
                font-weight:700;
            }
            .badge-blocked {
                background:#FFF5F5;
                color:#CC0000;
                border:1px solid #FCA5A5;
                padding:4px 12px;
                border-radius:20px;
                font-size:0.75rem;
                font-weight:700;
            }
            .badge-role {
                background:#EDE7FF;
                color:#6C3FC5;
                border-radius:6px;
                padding:3px 10px;
                font-size:0.72rem;
                font-weight:700;
            }
            .btn-block {
                background:#fff;
                color:#CC0000;
                border:1.5px solid #FCA5A5;
                border-radius:8px;
                padding:6px 16px;
                font-weight:700;
                font-size:0.78rem;
                cursor:pointer;
                transition:all 0.15s;
                text-decoration:none;
            }
            .btn-block:hover {
                background:#FFF5F5;
                color:#CC0000;
            }
            .btn-unblock {
                background:linear-gradient(135deg,#2E7D32,#388E3C);
                color:#fff;
                border:none;
                border-radius:8px;
                padding:6px 16px;
                font-weight:700;
                font-size:0.78rem;
                cursor:pointer;
                transition:all 0.15s;
                text-decoration:none;
            }
            .btn-unblock:hover {
                transform:translateY(-1px);
                box-shadow:0 4px 12px rgba(46,125,50,0.35);
                color:#fff;
            }
            .search-wrap {
                position:relative;
            }
            .search-wrap input {
                padding-left:36px;
                border-radius:10px;
                border:1.5px solid #E2D9F3;
                font-size:0.88rem;
            }
            .search-wrap input:focus {
                border-color:var(--purple);
                box-shadow:0 0 0 3px rgba(108,63,197,0.1);
                outline:none;
            }
            .search-wrap i {
                position:absolute;
                left:12px;
                top:50%;
                transform:translateY(-50%);
                color:#9B72E8;
            }
        </style>
    </head>
    <body>

        <div class="topbar">
            <a href="administrator.jsp" class="brand">DUK<span>Academy</span> — Admin</a>
            <a href="administrator.jsp" style="color:rgba(255,255,255,0.7);font-size:0.85rem;text-decoration:none;">
                <i class="bi bi-arrow-left"></i> Quay lại
            </a>
        </div>

        <div class="container py-4">
            <div class="d-flex align-items-center justify-content-between mb-4 flex-wrap gap-3">
                <h4 class="fw-bold mb-0" style="color:#1E0A4A;">
                    <i class="bi bi-people-fill" style="color:var(--purple);"></i> Quản lý Users
                    <span style="background:#EDE7FF;color:#6C3FC5;border-radius:20px;padding:3px 14px;font-size:0.78rem;margin-left:8px;">
                        ${USER_LIST.size()} users
                    </span>
                </h4>
                <div class="search-wrap">
                    <i class="bi bi-search"></i>
                    <input type="text" id="searchInput" placeholder="Tìm theo tên, email, ID..."
                           style="width:280px;padding:9px 12px 9px 36px;" oninput="filterTable()">
                </div>
            </div>

            <div class="card-table">
                <table class="table table-hover mb-0" id="userTable">
                    <thead style="background:#F3EEFF;">
                        <tr>
                            <th style="padding:16px 20px;color:#6B6B8A;font-size:0.72rem;text-transform:uppercase;letter-spacing:1px;">User</th>
                            <th style="padding:16px 20px;color:#6B6B8A;font-size:0.72rem;text-transform:uppercase;letter-spacing:1px;">Email</th>
                            <th style="padding:16px 20px;color:#6B6B8A;font-size:0.72rem;text-transform:uppercase;letter-spacing:1px;">Role</th>
                            <th style="padding:16px 20px;color:#6B6B8A;font-size:0.72rem;text-transform:uppercase;letter-spacing:1px;">Số dư</th>
                            <th style="padding:16px 20px;color:#6B6B8A;font-size:0.72rem;text-transform:uppercase;letter-spacing:1px;">Trạng thái</th>
                            <th style="padding:16px 20px;color:#6B6B8A;font-size:0.72rem;text-transform:uppercase;letter-spacing:1px;">Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="u" items="${USER_LIST}">
                            <tr>
                                <td style="padding:14px 20px;">
                                    <div style="display:flex;align-items:center;gap:10px;">
                                        <div class="avatar">${fn:substring(u.fullname,0,1)}</div>
                                        <div>
                                            <div style="font-weight:700;font-size:0.88rem;color:#1E0A4A;">${u.fullname}</div>
                                            <div style="font-size:0.72rem;color:#9B72E8;font-weight:600;">${u.userId}</div>
                                        </div>
                                    </div>
                                </td>
                                <td style="padding:14px 20px;font-size:0.85rem;color:#6B6B8A;">${u.email}</td>
                                <td style="padding:14px 20px;">
                                    <c:choose>
                                        <c:when test="${u.role == 1}">
                                            <span class="badge-role" style="background:#FFF3CD;color:#856404;">Admin</span>
                                        </c:when>
                                        <c:when test="${u.role == 2}">
                                            <span class="badge-role" style="background:#E3F2FD;color:#1565C0;">Instructor</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge-role">Student</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td style="padding:14px 20px;font-weight:700;color:#6C3FC5;">
                        <fmt:formatNumber value="${u.balance}" type="number" groupingUsed="true"/> ₫
                        </td>
                        <td style="padding:14px 20px;">
                            <c:choose>
                                <c:when test="${u.status}">
                                    <span class="badge-active"><i class="bi bi-check-circle-fill"></i> Active</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge-blocked"><i class="bi bi-x-circle-fill"></i> Blocked</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td style="padding:14px 20px;">
                            <c:choose>
                                <c:when test="${u.status}">
                                    <a href="adminController?action=blockUser&userId=${u.userId}"
                                       class="btn-block"
                                       onclick="return confirm('Block user ${u.fullname}?')">
                                        <i class="bi bi-slash-circle"></i> Block
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <a href="adminController?action=unblockUser&userId=${u.userId}"
                                       class="btn-unblock"
                                       onclick="return confirm('Unblock user ${u.fullname}?')">
                                        <i class="bi bi-check-circle"></i> Unblock
                                    </a>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>

        <script>
            function filterTable() {
                const q = document.getElementById('searchInput').value.toLowerCase();
                document.querySelectorAll('#userTable tbody tr').forEach(row => {
                    row.style.display = row.textContent.toLowerCase().includes(q) ? '' : 'none';
                });
            }
        </script>
    </body>
</html>