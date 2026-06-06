<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <base href="${pageContext.request.contextPath}/">
        <meta charset="UTF-8">
        <title>Quản lý Khóa học - Admin</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/assets/css/admin/admincourses.css" rel="stylesheet" type="text/css"/>
        <style>
            /* ===== APPROVE BUTTON ===== */
            .btn-approve {
                background: #d1fae5;
                color: #059669;
                border: 1px solid #a7f3d0;
                border-radius: 6px;
                padding: 4px 10px;
                font-size: 0.76rem;
                font-weight: 600;
                cursor: pointer;
                transition: background 0.15s;
                margin-right: 4px;
                display: inline-flex;
                align-items: center;
                gap: 4px;
            }
            .btn-approve:hover { background: #a7f3d0; }

            /* ===== APPROVE MODAL BUTTON ===== */
            .btn-modal-approve {
                background: #059669;
                color: #fff !important;
                border: none;
                border-radius: 8px;
                padding: 8px 18px;
                font-size: 0.82rem;
                font-weight: 700;
                text-decoration: none;
                cursor: pointer;
                transition: background 0.15s;
                display: inline-flex;
                align-items: center;
                gap: 6px;
            }
            .btn-modal-approve:hover { background: #047857; color: #fff; }

            /* ===== APPROVE MODAL ICON ===== */
            .modal-icon-approve {
                width: 52px;
                height: 52px;
                border-radius: 50%;
                background: #d1fae5;
                color: #059669;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1.5rem;
                margin: 0 auto 12px;
            }
        </style>
    </head>
    <body>

        <aside class="sidebar">
            <a href="homePage.jsp" class="sidebar-logo">
                DUK<span>Academy</span>
                <small>⚙ Admin Portal</small>
            </a>
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
                <a href="mainController?action=manageCourses" class="s-link active"><i class="bi bi-collection-play-fill"></i> Quản lý Khóa học</a>
                <a href="mainController?action=viewTopups" class="s-link"><i class="bi bi-wallet2"></i> Duyệt nạp tiền</a>
                <a href="mainController?action=viewPayments" class="s-link"><i class="bi bi-receipt"></i> Lịch sử giao dịch</a>
            </nav>
            <div class="sidebar-footer">
                <a href="homePage.jsp" class="s-link"><i class="bi bi-house-fill"></i> Trang chủ</a>
                <a href="mainController?action=logout" class="s-link logout"><i class="bi bi-box-arrow-right"></i> Đăng xuất</a>
            </div>
        </aside>

        <div class="main">
            <div class="topbar">
                <div class="topbar-title">Quản lý Khóa học</div>
                <a href="adminController?action=dashboard"><i class="bi bi-arrow-left"></i> Dashboard</a>
            </div>

            <div class="page-content">
                <div class="breadcrumb-bar">
                    <a href="admin/administrator.jsp">Dashboard</a>
                    <i class="bi bi-chevron-right"></i>
                    <span>Quản lý Khóa học</span>
                </div>

                <div class="search-bar">
                    <div class="count-label">
                        Tổng: <strong id="countDisplay">${not empty COURSE_LIST ? COURSE_LIST.size() : 0}</strong> khóa học
                    </div>
                </div>

                <div class="table-wrap">
                    <c:choose>
                        <c:when test="${not empty COURSE_LIST}">
                            <table id="courseTable">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Khóa học</th>
                                        <th>Giảng viên(ID)</th>
                                        <th>Học phí</th>
                                        <th>Học viên</th>
                                        <th>Trạng thái</th>
                                        <th>Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="c" items="${COURSE_LIST}" varStatus="st">
                                        <tr data-name="${fn:toLowerCase(c.courseName)}"
                                            data-topic="${fn:toLowerCase(c.topic)}">
                                            <td style="color:var(--muted);font-size:0.75rem;">${st.index + 1}</td>
                                            <td>
                                                <div style="font-weight:600;font-size:0.85rem;">${c.courseName}</div>
                                                <span class="course-tag">${c.topic}</span>
                                            </td>
                                            <td style="font-size:0.85rem;font-weight:600;color:var(--purple);">
    ${not empty c.instructorId ? c.instructorId : '—'}
</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${c.fee == 0}">
                                                        <span class="fee-free"><i class="bi bi-gift-fill"></i> Miễn phí</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <fmt:formatNumber value="${c.fee}" type="number" maxFractionDigits="0"/> ₫
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td style="font-weight:700;">${not empty c.totalStudents ? c.totalStudents : 0}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${c.status == 'ACTIVE' || c.status == 'active' || c.status == '1'}">
                                                        <span class="badge-pill badge-active">Đang mở</span>
                                                    </c:when>
                                                    <c:when test="${c.status == 'PENDING' || c.status == 'pending'}">
                                                        <span class="badge-pill badge-pending">Chờ duyệt</span>
                                                    </c:when>
                                                    <c:when test="${c.status == 'deleted'}">
                                                        <span class="badge-pill badge-hidden">Đã ẩn</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge-pill badge-hidden">Ẩn</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <%-- Nút Duyệt: chỉ hiện khi status là PENDING --%>
                                                <c:if test="${c.status == 'PENDING' || c.status == 'pending'}">
                                                    <button class="btn-sm btn-approve"
                                                            onclick="openApproveModal(${c.courseId}, this.dataset.name)"
                                                            data-name="<c:out value='${c.courseName}'/>">
                                                        <i class="bi bi-check-circle"></i> Duyệt
                                                    </button>
                                                </c:if>

                                                <%-- Nút Xóa --%>
                                                <button class="btn-sm btn-del"
                                                        onclick="openModal(${c.courseId}, this.dataset.name)"
                                                        data-name="<c:out value='${c.courseName}'/>">
                                                    <i class="bi bi-trash"></i> Xóa
                                                </button>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-state">
                                <i class="bi bi-collection-play"></i>
                                <p style="font-size:0.85rem;">Chưa có khóa học nào trong hệ thống</p>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <!-- DELETE MODAL -->
        <div class="modal-overlay" id="delModal" onclick="if (event.target === this) closeModal()">
            <div class="modal-box">
                <div class="modal-icon"><i class="bi bi-trash3"></i></div>
                <div style="font-size:0.95rem;font-weight:700;margin-bottom:6px;">Xóa khóa học?</div>
                <div id="delName" style="font-size:0.82rem;color:var(--muted);margin-bottom:4px;"></div>
                <div style="font-size:0.75rem;color:#CC0000;margin-bottom:16px;">Hành động này không thể hoàn tác.</div>
                <div class="modal-actions">
                    <button class="btn-modal-cancel" onclick="closeModal()">Hủy</button>
                    <a id="delBtn" href="#" class="btn-modal-del">
                        <i class="bi bi-trash"></i> Xóa
                    </a>
                </div>
            </div>
        </div>

        <!-- APPROVE MODAL -->
        <div class="modal-overlay" id="approveModal" onclick="if (event.target === this) closeApproveModal()">
            <div class="modal-box">
                <div class="modal-icon-approve"><i class="bi bi-check-circle"></i></div>
                <div style="font-size:0.95rem;font-weight:700;margin-bottom:6px;">Duyệt khóa học?</div>
                <div id="approveName" style="font-size:0.82rem;color:var(--muted);margin-bottom:4px;"></div>
                <div style="font-size:0.75rem;color:#059669;margin-bottom:16px;">
                    Khóa học sẽ chuyển sang trạng thái <strong>Đang mở</strong>.
                </div>
                <div class="modal-actions">
                    <button class="btn-modal-cancel" onclick="closeApproveModal()">Hủy</button>
                    <a id="approveBtn" href="#" class="btn-modal-approve">
                        <i class="bi bi-check-circle"></i> Xác nhận duyệt
                    </a>
                </div>
            </div>
        </div>

        <script>

            // ===== DELETE MODAL =====
            function openModal(courseId, courseName) {
                document.getElementById('delName').textContent = courseName;
                document.getElementById('delBtn').href =
                    'adminController?action=deleteCourse&courseId=' + courseId;
                document.getElementById('delModal').classList.add('show');
            }
            function closeModal() {
                document.getElementById('delModal').classList.remove('show');
            }

            // ===== APPROVE MODAL =====
            function openApproveModal(courseId, courseName) {
                document.getElementById('approveName').textContent = courseName;
                document.getElementById('approveBtn').href =
                    'adminController?action=approveCourse&courseId=' + courseId;
                document.getElementById('approveModal').classList.add('show');
            }
            function closeApproveModal() {
                document.getElementById('approveModal').classList.remove('show');
            }
        </script>
    </body>
</html>
