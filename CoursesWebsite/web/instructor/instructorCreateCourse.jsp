<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<fmt:setLocale value="vi_VN" scope="session"/>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <base href="${pageContext.request.contextPath}/">
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Tạo khóa học - DUK Academy</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
        <link rel="icon" type="image/jpeg" href="img/page/favicon.jpg">
        <style>
            :root {
                --purple:       #6C3FC5;
                --purple-dark:  #4E2C96;
                --purple-deep:  #1E0A4A;
                --purple-light: #F3EEFF;
                --gold:         #D4A843;
                --text:         #1A1A2E;
                --muted:        #6B6B8A;
                --border:       #E2D9F3;
                --bg:           #F4F0FC;
                --sidebar-w:    240px;
            }
            * {
                box-sizing: border-box;
                margin: 0;
                padding: 0;
            }
            body {
                font-family: 'DM Sans', sans-serif;
                background: var(--bg);
                color: var(--text);
                display: flex;
                min-height: 100vh;
            }

            /* ── SIDEBAR (giống Dashboard) ── */
            .sidebar {
                width: var(--sidebar-w);
                background: var(--purple-deep);
                min-height: 100vh;
                position: fixed;
                left: 0;
                top: 0;
                display: flex;
                flex-direction: column;
                z-index: 100;
            }
            .sidebar-logo {
                padding: 22px 20px 18px;
                border-bottom: 1px solid rgba(255,255,255,0.08);
                font-size: 1.3rem;
                font-weight: 700;
                color: #fff;
                text-decoration: none;
                display: block;
            }
            .sidebar-logo span {
                color: var(--gold);
            }
            .sidebar-logo small {
                display: block;
                font-size: 0.65rem;
                font-weight: 600;
                color: var(--gold);
                text-transform: uppercase;
                letter-spacing: 1.5px;
                margin-top: 4px;
            }
            .sidebar-user {
                padding: 16px 20px;
                border-bottom: 1px solid rgba(255,255,255,0.08);
                display: flex;
                align-items: center;
                gap: 10px;
            }
            .s-avatar {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                background: linear-gradient(135deg, #9B72E8, var(--gold));
                display: flex;
                align-items: center;
                justify-content: center;
                font-weight: 700;
                color: #fff;
                font-size: 1rem;
                flex-shrink: 0;
            }
            .s-name {
                font-size: 0.82rem;
                font-weight: 700;
                color: #fff;
            }
            .s-role {
                font-size: 0.68rem;
                color: rgba(255,255,255,0.45);
            }
            .sidebar-nav {
                flex: 1;
                padding: 12px;
            }
            .nav-section-label {
                font-size: 0.58rem;
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: 2px;
                color: rgba(255,255,255,0.3);
                padding: 10px 10px 5px;
            }
            .s-link {
                display: flex;
                align-items: center;
                gap: 10px;
                padding: 9px 12px;
                border-radius: 8px;
                color: rgba(255,255,255,0.6);
                text-decoration: none;
                font-size: 0.83rem;
                font-weight: 500;
                transition: all 0.15s;
                margin-bottom: 2px;
            }
            .s-link i {
                width: 18px;
                text-align: center;
                font-size: 0.95rem;
                flex-shrink: 0;
            }
            .s-link:hover {
                background: rgba(255,255,255,0.08);
                color: #fff;
            }
            .s-link.active {
                background: var(--purple);
                color: #fff;
            }
            .sidebar-footer {
                padding: 12px;
                border-top: 1px solid rgba(255,255,255,0.08);
            }
            .s-link.logout {
                color: rgba(255,120,120,0.7);
            }
            .s-link.logout:hover {
                background: rgba(220,38,38,0.12);
                color: #ff8080;
            }

            /* ── MAIN ── */
            .main {
                margin-left: var(--sidebar-w);
                flex: 1;
                display: flex;
                flex-direction: column;
            }

            /* ── TOPBAR ── */
            .topbar {
                background: #fff;
                border-bottom: 1px solid var(--border);
                padding: 0 28px;
                height: 58px;
                display: flex;
                align-items: center;
                justify-content: space-between;
                position: sticky;
                top: 0;
                z-index: 90;
            }
            .topbar-title {
                font-size: 1rem;
                font-weight: 700;
                color: var(--text);
            }
            .topbar-right {
                display: flex;
                align-items: center;
                gap: 10px;
            }
            .btn-outline {
                display: inline-flex;
                align-items: center;
                gap: 6px;
                color: var(--muted);
                text-decoration: none;
                font-size: 0.8rem;
                font-weight: 500;
                padding: 7px 14px;
                border-radius: 8px;
                border: 1px solid var(--border);
                transition: all 0.15s;
                background: #fff;
            }
            .btn-outline:hover {
                background: var(--purple-light);
                color: var(--purple);
                border-color: var(--purple);
            }

            /* ── PAGE ── */
            .page-content {
                padding: 28px;
                max-width: 760px;
            }

            /* BREADCRUMB */
            .breadcrumb-bar {
                display: flex;
                align-items: center;
                gap: 8px;
                font-size: 0.78rem;
                color: var(--muted);
                margin-bottom: 22px;
            }
            .breadcrumb-bar a {
                color: var(--purple);
                text-decoration: none;
                font-weight: 600;
            }
            .breadcrumb-bar a:hover {
                text-decoration: underline;
            }
            .breadcrumb-bar i {
                font-size: 0.65rem;
            }

            /* FORM CARD */
            .form-card {
                background: #fff;
                border: 1px solid var(--border);
                border-radius: 16px;
                overflow: hidden;
            }
            .form-card-header {
                padding: 20px 24px;
                border-bottom: 1px solid var(--border);
                display: flex;
                align-items: center;
                gap: 12px;
            }
            .form-card-icon {
                width: 40px;
                height: 40px;
                border-radius: 10px;
                background: var(--purple-light);
                color: var(--purple);
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1.1rem;
                flex-shrink: 0;
            }
            .form-card-title {
                font-size: 0.95rem;
                font-weight: 700;
            }
            .form-card-sub   {
                font-size: 0.72rem;
                color: var(--muted);
                margin-top: 2px;
            }
            .form-body {
                padding: 24px;
            }

            /* FORM ELEMENTS */
            .form-row {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 18px;
            }
            .form-group {
                margin-bottom: 20px;
            }
            .form-group:last-child {
                margin-bottom: 0;
            }
            .form-label {
                display: block;
                font-size: 0.8rem;
                font-weight: 700;
                color: var(--text);
                margin-bottom: 7px;
            }
            .form-label .required {
                color: #DC2626;
                margin-left: 3px;
            }
            .form-label .hint {
                font-size: 0.7rem;
                color: var(--muted);
                font-weight: 400;
                margin-left: 6px;
            }
            .form-control {
                width: 100%;
                padding: 10px 14px;
                border: 1.5px solid var(--border);
                border-radius: 9px;
                font-size: 0.85rem;
                font-family: 'DM Sans', sans-serif;
                color: var(--text);
                background: #fff;
                transition: border-color 0.15s, box-shadow 0.15s;
                outline: none;
            }
            .form-control:focus {
                border-color: var(--purple);
                box-shadow: 0 0 0 3px rgba(108,63,197,0.1);
            }
            .form-control::placeholder {
                color: #BCBCCC;
            }
            select.form-control {
                cursor: pointer;
            }
            textarea.form-control {
                resize: vertical;
                min-height: 100px;
            }

            /* FEE TOGGLE */
            .fee-toggle {
                display: flex;
                gap: 10px;
                margin-bottom: 12px;
            }
            .fee-opt {
                flex: 1;
                padding: 10px;
                border-radius: 9px;
                border: 1.5px solid var(--border);
                font-size: 0.82rem;
                font-weight: 600;
                text-align: center;
                cursor: pointer;
                transition: all 0.15s;
                background: #fff;
                color: var(--muted);
            }
            .fee-opt.selected {
                border-color: var(--purple);
                background: var(--purple-light);
                color: var(--purple);
            }
            #feeInputWrap {
                display: none;
            }
            #feeInputWrap.show {
                display: block;
            }

            /* UPLOAD ZONE */
            .upload-zone {
                border: 2px dashed var(--border);
                border-radius: 12px;
                padding: 28px;
                text-align: center;
                cursor: pointer;
                transition: all 0.2s;
                background: #FAFAFE;
                position: relative;
                overflow: hidden;
            }
            .upload-zone:hover, .upload-zone.drag-over {
                border-color: var(--purple);
                background: var(--purple-light);
            }
            .upload-icon {
                font-size: 2rem;
                color: var(--purple);
                opacity: 0.5;
                display: block;
                margin-bottom: 10px;
            }
            .upload-text {
                font-size: 0.85rem;
                font-weight: 600;
                color: var(--text);
                margin-bottom: 4px;
            }
            .upload-browse {
                color: var(--purple);
                text-decoration: underline;
                cursor: pointer;
            }
            .upload-hint {
                font-size: 0.7rem;
                color: var(--muted);
            }
            .upload-preview {
                width: 100%;
                max-height: 200px;
                object-fit: cover;
                border-radius: 8px;
                display: block;
            }

            /* DIVIDER */
            .form-divider {
                height: 1px;
                background: var(--border);
                margin: 4px 0 20px;
            }
            .section-label {
                font-size: 0.7rem;
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: 1.5px;
                color: var(--muted);
                margin-bottom: 16px;
            }

            /* SUBMIT */
            .form-actions {
                display: flex;
                gap: 10px;
                justify-content: flex-end;
                padding: 18px 24px;
                border-top: 1px solid var(--border);
                background: var(--bg);
            }
            .btn-submit {
                display: inline-flex;
                align-items: center;
                gap: 7px;
                background: var(--purple);
                color: #fff;
                border: none;
                font-size: 0.85rem;
                font-weight: 700;
                padding: 10px 24px;
                border-radius: 9px;
                cursor: pointer;
                transition: all 0.15s;
                font-family: 'DM Sans', sans-serif;
            }
            .btn-submit:hover {
                background: var(--purple-dark);
                transform: translateY(-1px);
            }
            .btn-cancel {
                display: inline-flex;
                align-items: center;
                gap: 7px;
                background: #fff;
                color: var(--muted);
                border: 1.5px solid var(--border);
                font-size: 0.85rem;
                font-weight: 600;
                padding: 10px 20px;
                border-radius: 9px;
                cursor: pointer;
                transition: all 0.15s;
                font-family: 'DM Sans', sans-serif;
                text-decoration: none;
            }
            .btn-cancel:hover {
                background: var(--purple-light);
                color: var(--purple);
                border-color: var(--purple);
            }

            /* SUCCESS / ERROR MSG */
            .alert-msg {
                display: flex;
                align-items: center;
                gap: 10px;
                padding: 12px 16px;
                border-radius: 10px;
                font-size: 0.83rem;
                font-weight: 600;
                margin-bottom: 20px;
            }
            .alert-success {
                background: #DCFCE7;
                color: #16A34A;
                border: 1px solid #BBF7D0;
            }
            .alert-error   {
                background: #FEE2E2;
                color: #DC2626;
                border: 1px solid #FECACA;
            }

            @media (max-width: 768px) {
                .form-row {
                    grid-template-columns: 1fr;
                }
                .page-content {
                    padding: 20px 16px;
                }
            }
        </style>
    </head>
    <body>

        <!-- SIDEBAR -->
        <aside class="sidebar">
            <a href="homePage.jsp" class="sidebar-logo">
                DUK<span>Academy</span>
                <small>✦ Instructor Portal</small>
            </a>
            <div class="sidebar-user">
                <div class="s-avatar">${fn:substring(sessionScope.user.fullname, 0, 1)}</div>
                <div>
                    <div class="s-name">${sessionScope.user.fullname}</div>
                    <div class="s-role">Giảng viên</div>
                </div>
            </div>
            <nav class="sidebar-nav">
                <div class="nav-section-label">Tổng quan</div>
                <a href="instructorController?action=dashboard" class="s-link">
                    <i class="bi bi-grid-1x2-fill"></i> Dashboard
                </a>
                <div class="nav-section-label">Quản lý</div>
                <a href="mainController?action=viewMyCourses" class="s-link">
                    <i class="bi bi-collection-play-fill"></i> Khóa học của tôi
                </a>
<a href="instructorController?action=showCreateForm" class="s-link active">
                    <i class="bi bi-plus-circle-fill"></i> Tạo khóa học mới
                </a>
                <div class="nav-section-label">Tài khoản</div>
                <a href="user/myprofile.jsp" class="s-link">
                    <i class="bi bi-person-fill"></i> Hồ sơ cá nhân
                </a>
            </nav>
            <div class="sidebar-footer">
                <a href="homePage.jsp" class="s-link">
                    <i class="bi bi-house-fill"></i> Trang chủ
                </a>
                <a href="mainController?action=logout" class="s-link logout">
                    <i class="bi bi-box-arrow-right"></i> Đăng xuất
                </a>
            </div>
        </aside>

        <!-- MAIN -->
        <div class="main">

            <!-- TOPBAR -->
            <div class="topbar">
                <div class="topbar-title">Tạo khóa học mới</div>
                <div class="topbar-right">
                    <a href="instructorController?action=dashboard" class="btn-outline">
                        <i class="bi bi-arrow-left"></i> Quay lại Dashboard
                    </a>
                </div>
            </div>

            <div class="page-content">

                <!-- BREADCRUMB -->
                <div class="breadcrumb-bar">
                    <a href="instructorController?action=dashboard">Dashboard</a>
                    <i class="bi bi-chevron-right"></i>
                    <span>Tạo khóa học mới</span>
                </div>

                <!-- ALERTS -->
                <c:if test="${not empty successMessage}">
                    <div class="alert-msg alert-success">
                        <i class="bi bi-check-circle-fill"></i> ${successMessage}
                    </div>
                </c:if>
                <c:if test="${not empty errorMessage}">
                    <div class="alert-msg alert-error">
                        <i class="bi bi-exclamation-circle-fill"></i> ${errorMessage}
                    </div>
                </c:if>

                <!-- FORM CARD -->
                <div class="form-card">
                    <div class="form-card-header">
                        <div class="form-card-icon"><i class="bi bi-plus-circle-fill"></i></div>
                        <div>
                            <div class="form-card-title">Thông tin khóa học</div>
                            <div class="form-card-sub">Điền đầy đủ thông tin để tạo khóa học mới</div>
                        </div>
                    </div>

                    <form action="${pageContext.request.contextPath}/instructorController" method="post" id="createForm" enctype="multipart/form-data">
                        <input type="hidden" name="action" value="createCourse">

                        <div class="form-body">

                            <!-- Thông tin cơ bản -->
                            <div class="section-label">Thông tin cơ bản</div>

                            <div class="form-row">
                                <div class="form-group">
                                    <label class="form-label">
                                        Chủ đề (Topic) <span class="required">*</span>
                                    </label>
                                    <input type="text" name="topic" class="form-control"
                                           placeholder="VD: Lập trình Web, AI, Design..."
                                           value="${param.topic}" required>
                                </div>
                                <div class="form-group">
                                    <label class="form-label">
                                        Tên khóa học <span class="required">*</span>
                                    </label>
                                    <input type="text" name="courseName" class="form-control"
                                           placeholder="VD: React JS từ cơ bản đến nâng cao"
                                           value="${param.courseName}" required>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="form-label">
                                    Mô tả khóa học
                                    <span class="hint">(không bắt buộc)</span>
                                </label>
                                <textarea name="description" class="form-control"
                                          placeholder="Mô tả ngắn gọn về nội dung và đối tượng học viên...">${param.description}</textarea>
                            </div>

                            <div class="form-divider"></div>

                            <!-- Học phí -->
                            <div class="section-label">Học phí</div>

                            <div class="form-group">
                                <div class="fee-toggle">
                                    <div class="fee-opt" id="optFree" onclick="setFree()">
                                        <i class="bi bi-gift-fill"></i> Miễn phí
                                    </div>
                                    <div class="fee-opt selected" id="optPaid" onclick="setPaid()">
                                        <i class="bi bi-cash"></i> Có phí
                                    </div>
                                </div>
                                <div id="feeInputWrap" class="show">
                                    <input type="number" name="fee" id="feeInput" class="form-control"
                                           placeholder="Nhập học phí (VD: 299000)"
                                           min="0" value="${not empty param.fee ? param.fee : ''}">
                                    <div style="font-size:0.7rem;color:var(--muted);margin-top:5px;">
                                        <i class="bi bi-info-circle"></i> Đơn vị: VNĐ
                                    </div>
                                </div>
                                <input type="hidden" name="feeHidden" id="feeHidden" value="0">
                            </div>

                            <div class="form-divider"></div>

                            <!-- Ảnh khóa học -->
                            <div class="section-label">Ảnh khóa học</div>

                            <div class="form-group">
                                <label class="form-label">
                                    Tải lên ảnh thumbnail
                                    <span class="hint">(không bắt buộc, JPG/PNG, tối đa 2MB)</span>
                                </label>

                                <!-- Drop zone -->
                                <div class="upload-zone" id="uploadZone" onclick="document.getElementById('thumbnailFile').click()">
                                    <div class="upload-zone-inner" id="uploadPlaceholder">
                                        <i class="bi bi-image-fill upload-icon"></i>
                                        <div class="upload-text">Kéo thả ảnh vào đây hoặc <span class="upload-browse">chọn file</span></div>
                                        <div class="upload-hint">PNG, JPG tối đa 2MB — tỉ lệ 16:9 tốt nhất</div>
                                    </div>
                                    <img id="previewImg" src="" alt="Preview" class="upload-preview" style="display:none;">
                                </div>
                                <input type="file" name="thumbnailFile" id="thumbnailFile"
                                       accept="image/png,image/jpeg,image/webp"
                                       style="display:none;" onchange="previewImage(this)">

                                <!-- Hoặc nhập URL -->
                                <div style="display:flex;align-items:center;gap:10px;margin:12px 0;">
                                    <div style="flex:1;height:1px;background:var(--border);"></div>
                                    <span style="font-size:0.72rem;color:var(--muted);font-weight:600;">HOẶC NHẬP URL</span>
                                    <div style="flex:1;height:1px;background:var(--border);"></div>
                                </div>
                                <input type="text" name="thumbnail" id="thumbnailUrl" class="form-control"
                                       placeholder="https://example.com/image.jpg"
                                       value="${param.thumbnail}"
                                       oninput="previewFromUrl(this.value)">
                            </div>

                            <div class="form-divider"></div>

                            <!-- Cài đặt thêm -->
                            <div class="section-label">Cài đặt thêm</div>

                            <div class="form-row">
                                <div class="form-group">
                                    <label class="form-label">
                                        Danh mục <span class="required">*</span>
                                    </label>
                                    <select name="categoryId" class="form-control" required>
                                        <option value="">-- Chọn danh mục --</option>
                                        <c:forEach var="cat" items="${CATEGORY_LIST}">
                                            <option value="${cat.categoryId}">${cat.categoryName}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label class="form-label">Trạng thái</label>
                                    <select name="status" class="form-control">
                                        <option value="0">⏳ Chờ duyệt</option>
                                    </select>
                                </div>
                            </div>

                        </div><!-- end form-body -->

                        <div class="form-actions">
                            <a href="instructorController?action=dashboard" class="btn-cancel">
                                <i class="bi bi-x-lg"></i> Hủy
                            </a>
                            <button type="submit" class="btn-submit">
                                <i class="bi bi-check-lg"></i> Tạo khóa học
                            </button>
                        </div>
                    </form>
                </div>

            </div>
        </div>
        <script src="${pageContext.request.contextPath}/assets/js/instructorcreate.js" type="text/javascript"></script>

    </body>
</html>

