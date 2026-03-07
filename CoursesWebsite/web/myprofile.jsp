<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hồ sơ của tôi - KKKAcademy</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Sora:wght@300;400;500;600;700&family=Fraunces:ital,opsz,wght@0,9..144,400;0,9..144,600;0,9..144,700;1,9..144,400&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">

    <style>
        :root {
            --ink:          #0D0B1A;
            --ink-soft:     #3D3959;
            --ink-muted:    #7E7A9A;
            --surface:      #F7F5FF;
            --surface-card: #FFFFFF;
            --accent:       #5B3FE0;
            --accent-glow:  #7B5FF0;
            --accent-soft:  #EEE9FF;
            --gold:         #C9922A;
            --gold-light:   #F5E0B0;
            --success:      #1A7A4A;
            --success-bg:   #EDFAF4;
            --success-border:#A3E6C4;
            --error:        #B91C1C;
            --error-bg:     #FFF2F2;
            --error-border: #FCA5A5;
            --border:       #E4DFFA;
            --border-focus: #8B6FEF;
            --radius-sm:    8px;
            --radius-md:    12px;
            --radius-lg:    18px;
            --radius-xl:    24px;
            --shadow-sm:    0 1px 4px rgba(91,63,224,0.06);
            --shadow-md:    0 4px 20px rgba(91,63,224,0.10);
            --shadow-lg:    0 8px 40px rgba(91,63,224,0.14);
        }

        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        body {
            font-family: 'Sora', sans-serif;
            color: var(--ink);
            background: var(--surface);
            min-height: 100vh;
        }

        /* ─── NAVBAR ──────────────────────────────────────── */
        .navbar-main {
            background: var(--ink);
            padding: 0 52px;
            height: 66px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            position: sticky;
            top: 0;
            z-index: 200;
            border-bottom: 1px solid rgba(255,255,255,0.06);
        }

        .brand {
            font-family: 'Fraunces', serif;
            font-size: 1.45rem;
            font-weight: 700;
            color: #fff;
            text-decoration: none;
            letter-spacing: -0.3px;
        }
        .brand span { color: var(--gold); }

        .nav-links {
            display: flex;
            align-items: center;
            gap: 2px;
            list-style: none;
        }
        .nav-links a {
            font-size: 0.84rem;
            font-weight: 500;
            color: rgba(255,255,255,0.6);
            text-decoration: none;
            padding: 6px 14px;
            border-radius: var(--radius-sm);
            transition: background 0.15s, color 0.15s;
        }
        .nav-links a:hover {
            background: rgba(255,255,255,0.07);
            color: #fff;
        }

        .user-chip {
            display: flex;
            align-items: center;
            gap: 9px;
            text-decoration: none;
            padding: 5px 14px 5px 6px;
            border-radius: 40px;
            border: 1px solid rgba(255,255,255,0.12);
            transition: background 0.15s;
        }
        .user-chip:hover { background: rgba(255,255,255,0.07); }

        .avatar-ring {
            width: 32px; height: 32px;
            border-radius: 50%;
            background: linear-gradient(135deg, #8B6FEF 0%, var(--gold) 100%);
            display: flex; align-items: center; justify-content: center;
            font-size: 0.8rem; font-weight: 700; color: #fff;
            flex-shrink: 0; overflow: hidden;
        }
        .user-chip-name {
            font-size: 0.82rem;
            font-weight: 600;
            color: #fff;
        }

        /* ─── PAGE ────────────────────────────────────────── */
        .page-wrap {
            max-width: 820px;
            margin: 44px auto 60px;
            padding: 0 20px;
        }

        /* ─── HERO BANNER ─────────────────────────────────── */
        .profile-banner {
            background: var(--ink);
            border-radius: var(--radius-xl);
            padding: 36px 40px;
            display: flex;
            align-items: center;
            gap: 22px;
            margin-bottom: 22px;
            position: relative;
            overflow: hidden;
            animation: riseUp 0.5s cubic-bezier(.16,1,.3,1) both;
        }

        /* decorative blobs */
        .profile-banner::before,
        .profile-banner::after {
            content: '';
            position: absolute;
            border-radius: 50%;
            pointer-events: none;
        }
        .profile-banner::before {
            width: 260px; height: 260px;
            background: radial-gradient(circle, rgba(139,111,239,0.18) 0%, transparent 70%);
            top: -100px; right: -60px;
        }
        .profile-banner::after {
            width: 160px; height: 160px;
            background: radial-gradient(circle, rgba(201,146,42,0.12) 0%, transparent 70%);
            bottom: -80px; left: 30px;
        }

        .banner-avatar {
            width: 70px; height: 70px;
            border-radius: 50%;
            background: linear-gradient(135deg, #8B6FEF 0%, var(--gold) 100%);
            display: flex; align-items: center; justify-content: center;
            font-family: 'Fraunces', serif;
            font-size: 1.7rem; font-weight: 700; color: #fff;
            flex-shrink: 0;
            border: 2.5px solid rgba(255,255,255,0.18);
            position: relative; z-index: 1;
            overflow: hidden;
        }

        .banner-info { position: relative; z-index: 1; }
        .banner-info h1 {
            font-family: 'Fraunces', serif;
            font-size: 1.35rem;
            font-weight: 600;
            color: #fff;
            letter-spacing: -0.3px;
            margin-bottom: 3px;
        }
        .banner-info p {
            font-size: 0.82rem;
            color: rgba(255,255,255,0.45);
        }

        .banner-id {
            margin-left: auto;
            position: relative; z-index: 1;
            background: rgba(255,255,255,0.05);
            border: 1px solid rgba(255,255,255,0.1);
            border-radius: var(--radius-md);
            padding: 10px 20px;
            text-align: center;
            backdrop-filter: blur(8px);
        }
        .banner-id .lbl {
            font-size: 0.65rem;
            color: rgba(255,255,255,0.35);
            text-transform: uppercase;
            letter-spacing: 1.2px;
            display: block;
            margin-bottom: 3px;
        }
        .banner-id .val {
            font-size: 1rem;
            font-weight: 700;
            color: var(--gold);
            letter-spacing: 0.5px;
        }

        /* ─── CARDS ───────────────────────────────────────── */
        .card-block {
            background: var(--surface-card);
            border: 1px solid var(--border);
            border-radius: var(--radius-lg);
            padding: 30px 34px;
            margin-bottom: 18px;
            box-shadow: var(--shadow-sm);
            animation: riseUp 0.5s cubic-bezier(.16,1,.3,1) both;
        }
        .card-block:nth-child(2) { animation-delay: 0.06s; }
        .card-block:nth-child(3) { animation-delay: 0.12s; }

        @keyframes riseUp {
            from { opacity: 0; transform: translateY(18px); }
            to   { opacity: 1; transform: translateY(0); }
        }

        .card-heading {
            display: flex;
            align-items: center;
            gap: 11px;
            font-size: 0.92rem;
            font-weight: 700;
            color: var(--ink);
            margin-bottom: 22px;
            padding-bottom: 16px;
            border-bottom: 1px solid var(--border);
        }
        .card-heading-icon {
            width: 34px; height: 34px;
            background: var(--accent-soft);
            border: 1px solid var(--border);
            border-radius: var(--radius-sm);
            display: flex; align-items: center; justify-content: center;
            color: var(--accent);
            font-size: 0.9rem;
        }

        /* ─── FORM ────────────────────────────────────────── */
        .field-label {
            display: block;
            font-size: 0.76rem;
            font-weight: 600;
            color: var(--ink-muted);
            text-transform: uppercase;
            letter-spacing: 0.6px;
            margin-bottom: 6px;
        }

        .field-input,
        select.field-input {
            font-family: 'Sora', sans-serif;
            font-size: 0.875rem;
            width: 100%;
            border: 1.5px solid var(--border);
            border-radius: var(--radius-sm);
            padding: 10px 13px;
            color: var(--ink);
            background: #FAFAFA;
            transition: border-color 0.15s, box-shadow 0.15s, background 0.15s;
            appearance: none;
            -webkit-appearance: none;
        }
        .field-input:focus,
        select.field-input:focus {
            border-color: var(--border-focus);
            box-shadow: 0 0 0 3px rgba(139,111,239,0.12);
            background: #fff;
            outline: none;
        }
        .field-input::placeholder { color: #C0BAD9; }

        .select-wrap {
            position: relative;
        }
        .select-wrap::after {
            content: '\F282';
            font-family: 'bootstrap-icons';
            position: absolute;
            right: 12px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--ink-muted);
            font-size: 0.78rem;
            pointer-events: none;
        }

        .pw-wrap { position: relative; }
        .pw-toggle {
            position: absolute;
            right: 11px; top: 50%;
            transform: translateY(-50%);
            background: none; border: none;
            color: var(--ink-muted);
            cursor: pointer;
            font-size: 0.95rem;
            padding: 0; line-height: 1;
            transition: color 0.12s;
        }
        .pw-toggle:hover { color: var(--accent); }
        .pw-wrap .field-input { padding-right: 36px; }

        /* field group spacing */
        .field-row { display: grid; gap: 16px; }
        .field-row.cols-2 { grid-template-columns: 1fr 1fr; }
        .field-row.cols-3 { grid-template-columns: 1fr 1fr 1fr; }

        @media (max-width: 640px) {
            .field-row.cols-2,
            .field-row.cols-3 { grid-template-columns: 1fr; }
        }

        .field-group { display: flex; flex-direction: column; }

        /* ─── INFO GRID ───────────────────────────────────── */
        .info-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 12px;
        }
        .info-item {
            display: flex;
            align-items: flex-start;
            gap: 12px;
            background: var(--surface);
            border: 1px solid var(--border);
            border-radius: var(--radius-md);
            padding: 14px 16px;
        }
        .info-icon {
            width: 36px; height: 36px;
            background: var(--accent-soft);
            border-radius: var(--radius-sm);
            display: flex; align-items: center; justify-content: center;
            color: var(--accent);
            font-size: 1rem;
            flex-shrink: 0;
        }
        .info-label {
            display: block;
            font-size: 0.7rem;
            font-weight: 600;
            color: var(--ink-muted);
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 3px;
        }
        .info-value {
            display: block;
            font-size: 0.88rem;
            font-weight: 600;
            color: var(--ink);
        }
        .info-empty {
            font-style: normal;
            font-weight: 400;
            color: var(--ink-muted);
            font-size: 0.82rem;
        }
        @media (max-width: 640px) {
            .info-grid { grid-template-columns: 1fr; }
        }

        /* ─── BUTTONS ─────────────────────────────────────── */
        .btn-primary {
            font-family: 'Sora', sans-serif;
            font-size: 0.84rem;
            font-weight: 700;
            background: var(--accent);
            color: #fff;
            border: none;
            padding: 10px 26px;
            border-radius: var(--radius-sm);
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 7px;
            transition: background 0.15s, transform 0.1s, box-shadow 0.15s;
            box-shadow: 0 4px 16px rgba(91,63,224,0.28);
            letter-spacing: 0.1px;
        }
        .btn-primary:hover {
            background: var(--accent-glow);
            transform: translateY(-1px);
            box-shadow: 0 6px 22px rgba(91,63,224,0.36);
        }
        .btn-primary:active { transform: translateY(0); }

        .btn-ghost {
            font-family: 'Sora', sans-serif;
            font-size: 0.84rem;
            font-weight: 600;
            background: transparent;
            color: var(--ink-soft);
            border: 1.5px solid var(--border);
            padding: 10px 22px;
            border-radius: var(--radius-sm);
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 7px;
            text-decoration: none;
            transition: border-color 0.15s, background 0.15s, color 0.15s;
        }
        .btn-ghost:hover {
            border-color: var(--accent);
            background: var(--accent-soft);
            color: var(--accent);
        }

        .actions-row {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-top: 24px;
            flex-wrap: wrap;
        }

        /* ─── ALERTS ──────────────────────────────────────── */
        .alert-ok, .alert-err {
            display: flex;
            align-items: center;
            gap: 9px;
            border-radius: var(--radius-sm);
            padding: 11px 14px;
            font-size: 0.84rem;
            font-weight: 500;
            margin-top: 18px;
        }
        .alert-ok {
            background: var(--success-bg);
            border: 1px solid var(--success-border);
            color: var(--success);
        }
        .alert-err {
            background: var(--error-bg);
            border: 1px solid var(--error-border);
            color: var(--error);
        }

        /* ─── DIVIDER ─────────────────────────────────────── */
        .field-divider {
            height: 1px;
            background: var(--border);
            margin: 4px 0 8px;
        }

        /* ─── RESPONSIVE ──────────────────────────────────── */
        @media (max-width: 768px) {
            .navbar-main { padding: 0 18px; }
            .page-wrap { margin: 22px auto 40px; }
            .profile-banner {
                flex-direction: column;
                text-align: center;
                padding: 28px 24px;
                gap: 16px;
            }
            .banner-id { margin-left: 0; }
            .card-block { padding: 22px 18px; }
            .nav-links { display: none; }
        }
    </style>
</head>
<body>

<c:if test="${empty sessionScope.user}">
    <c:redirect url="login.jsp" />
</c:if>

<!-- NAVBAR -->
<nav class="navbar-main">
    <a href="homePage.jsp" class="brand">KKK<span>Academy</span></a>
    <ul class="nav-links">
        <li><a href="search.jsp"><i class="bi bi-compass me-1"></i>Khám phá</a></li>
        <li><a href="mainController?action=ExploreCourse">Khóa học</a></li>
        <li><a href="#">Giảng viên</a></li>
        <li><a href="#">Về chúng tôi</a></li>
    </ul>
    <a href="homePage.jsp" class="user-chip">
        <div class="avatar-ring">${sessionScope.user.fullname}</div>
        <span class="user-chip-name">${sessionScope.user.fullname}</span>
    </a>
</nav>

<!-- PAGE -->
<div class="page-wrap">

    <!-- BANNER -->
    <div class="profile-banner">
        <div class="banner-avatar">${sessionScope.user.fullname}</div>
        <div class="banner-info">
            <h1>${sessionScope.user.fullname}</h1>
            <p>${sessionScope.user.email}</p>
        </div>
        <div class="banner-id">
            <span class="lbl">ID tài khoản</span>
            <span class="val">#${sessionScope.user.userId}</span>
        </div>
    </div>

    <!-- THÔNG TIN TỔNG QUAN -->
    <div class="card-block">
        <div class="card-heading">
            <div class="card-heading-icon"><i class="bi bi-grid-fill"></i></div>
            Thông tin tổng quan
        </div>
        <div class="info-grid">
            <div class="info-item">
                <span class="info-icon"><i class="bi bi-person-badge"></i></span>
                <div>
                    <span class="info-label">Họ và tên</span>
                    <span class="info-value">${sessionScope.user.fullname}</span>
                </div>
            </div>
            <div class="info-item">
                <span class="info-icon"><i class="bi bi-envelope"></i></span>
                <div>
                    <span class="info-label">Email</span>
                    <span class="info-value">${sessionScope.user.email}</span>
                </div>
            </div>
            <div class="info-item">
                <span class="info-icon"><i class="bi bi-calendar3"></i></span>
                <div>
                    <span class="info-label">Tuổi</span>
                    <span class="info-value">
                        <c:choose>
                            <c:when test="${not empty sessionScope.user.age and sessionScope.user.age != 0}">
                                ${sessionScope.user.age} tuổi
                            </c:when>
                            <c:otherwise><em class="info-empty">Chưa cập nhật</em></c:otherwise>
                        </c:choose>
                    </span>
                </div>
            </div>
            <div class="info-item">
                <span class="info-icon"><i class="bi bi-geo-alt"></i></span>
                <div>
                    <span class="info-label">Quê quán</span>
                    <span class="info-value">
                        <c:choose>
                            <c:when test="${not empty sessionScope.user.location}">${sessionScope.user.location}</c:when>
                            <c:otherwise><em class="info-empty">Chưa cập nhật</em></c:otherwise>
                        </c:choose>
                    </span>
                </div>
            </div>
            <div class="info-item">
                <span class="info-icon"><i class="bi bi-gender-ambiguous"></i></span>
                <div>
                    <span class="info-label">Giới tính</span>
                    <span class="info-value">
                        <c:choose>
                            <c:when test="${sessionScope.user.sex == 'male'}">Nam</c:when>
                            <c:when test="${sessionScope.user.sex == 'female'}">Nữ</c:when>
                            <c:when test="${sessionScope.user.sex == 'other'}">Khác</c:when>
                            <c:otherwise><em class="info-empty">Chưa cập nhật</em></c:otherwise>
                        </c:choose>
                    </span>
                </div>
            </div>
            <div class="info-item">
                <span class="info-icon"><i class="bi bi-heart"></i></span>
                <div>
                    <span class="info-label">Hôn nhân</span>
                    <span class="info-value">
                        <c:choose>
                            <c:when test="${sessionScope.user.marital_status == 'single'}">Độc thân</c:when>
                            <c:when test="${sessionScope.user.marital_status == 'married'}">Đã kết hôn</c:when>
                            <c:when test="${sessionScope.user.marital_status == 'divorced'}">Ly hôn</c:when>
                            <c:when test="${sessionScope.user.marital_status == 'widowed'}">Góa phụ</c:when>
                            <c:when test="${sessionScope.user.marital_status == 'separated'}">Ly thân</c:when>
                            <c:when test="${sessionScope.user.marital_status == 'singleDad'}">Bố đơn thân</c:when>
                            <c:when test="${sessionScope.user.marital_status == 'singleMom'}">Mẹ đơn thân</c:when>
                            <c:otherwise><em class="info-empty">Chưa cập nhật</em></c:otherwise>
                        </c:choose>
                    </span>
                </div>
            </div>
        </div>
    </div>

    <!-- CẬP NHẬT THÔNG TIN -->
    <div class="card-block">
        <div class="card-heading">
            <div class="card-heading-icon"><i class="bi bi-person-fill"></i></div>
            Cập nhật thông tin cá nhân
        </div>

        <form action="mainController" method="POST">
            <input type="hidden" name="action" value="updateUser" />
            <input type="hidden" name="userId" value="${sessionScope.user.userId}" />

            <!-- Row 1: name + email -->
            <div class="field-row cols-2" style="margin-bottom:16px;">
                <div class="field-group">
                    <label class="field-label">Họ và tên</label>
                    <input type="text" class="field-input" name="fullname"
                           value="${sessionScope.user.fullname}" />
                </div>
                <div class="field-group">
                    <label class="field-label">Email</label>
                    <input type="text" class="field-input" name="email"
                           value="${sessionScope.user.email}" />
                </div>
            </div>

            <!-- Row 2: age + location + sex -->
            <div class="field-row cols-3" style="margin-bottom:16px;">
                <div class="field-group">
                    <label class="field-label">Tuổi</label>
                    <div class="select-wrap">
                        <select name="age" class="field-input">
                            <option value="">-- Chọn --</option>
                            <c:forEach begin="16" end="80" var="i">
                                <option value="${i}"
                                    <c:if test="${sessionScope.user.age == i}">selected</c:if>>${i}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <div class="field-group">
                    <label class="field-label">Quê quán</label>
                    <input type="text" class="field-input" name="location"
                           value="${sessionScope.user.location}" placeholder="Thành phố, tỉnh…" />
                </div>
                <div class="field-group">
                    <label class="field-label">Giới tính</label>
                    <div class="select-wrap">
                        <select name="sex" class="field-input">
                            <option value="">-- Chọn --</option>
                            <option value="male">Nam</option>
                            <option value="female">Nữ</option>
                            <option value="other">Khác</option>
                        </select>
                    </div>
                </div>
            </div>

            <!-- Row 3: marital status -->
            <div class="field-row" style="margin-bottom:4px; max-width:280px;">
                <div class="field-group">
                    <label class="field-label">Tình trạng hôn nhân</label>
                    <div class="select-wrap">
                        <select name="maritalStatus" class="field-input">
                            <option value="">-- Chọn --</option>
                            <option value="single">Độc thân</option>
                            <option value="married">Đã kết hôn</option>
                            <option value="divorced">Ly hôn</option>
                            <option value="widowed">Góa phụ</option>
                            <option value="separated">Ly thân</option>
                            <option value="singleDad">Bố đơn thân</option>
                            <option value="singleMom">Mẹ đơn thân</option>
                        </select>
                    </div>
                </div>
            </div>

            <div class="actions-row">
                <button type="submit" class="btn-primary"
                        onclick="return confirm('Bạn có chắc muốn cập nhật thông tin không?')">
                    <i class="bi bi-check-lg"></i> Lưu thay đổi
                </button>
                <a href="homePage.jsp" class="btn-ghost">
                    <i class="bi bi-arrow-left"></i> Quay lại
                </a>
            </div>
        </form>

        <c:if test="${not empty MSG}">
            <div class="alert-ok"><i class="bi bi-check-circle-fill"></i> ${MSG}</div>
        </c:if>
        <c:if test="${not empty ERROR}">
            <div class="alert-err"><i class="bi bi-exclamation-circle-fill"></i> ${ERROR}</div>
        </c:if>
    </div>

    <!-- ĐỔI MẬT KHẨU -->
    <div class="card-block">
        <div class="card-heading">
            <div class="card-heading-icon"><i class="bi bi-shield-lock-fill"></i></div>
            Đổi mật khẩu
        </div>

        <form action="mainController" method="POST">
            <input type="hidden" name="action" value="updatePassword" />
            <input type="hidden" name="userId" value="${sessionScope.user.userId}" />

            <div class="field-row" style="margin-bottom:16px; max-width:420px;">
                <div class="field-group">
                    <label class="field-label">Mật khẩu hiện tại</label>
                    <div class="pw-wrap">
                        <input type="password" class="field-input" name="oldPassword"
                               id="oldPassword" required placeholder="••••••••" />
                        <button type="button" class="pw-toggle"
                                onclick="togglePw('oldPassword',this)">
                            <i class="bi bi-eye"></i>
                        </button>
                    </div>
                </div>
            </div>

            <div class="field-row cols-2">
                <div class="field-group">
                    <label class="field-label">Mật khẩu mới</label>
                    <div class="pw-wrap">
                        <input type="password" class="field-input" name="password"
                               id="newPassword" required placeholder="Tối thiểu 6 ký tự" />
                        <button type="button" class="pw-toggle"
                                onclick="togglePw('newPassword',this)">
                            <i class="bi bi-eye"></i>
                        </button>
                    </div>
                </div>
                <div class="field-group">
                    <label class="field-label">Xác nhận mật khẩu mới</label>
                    <div class="pw-wrap">
                        <input type="password" class="field-input" name="confirmPassword"
                               id="confirmPassword" required placeholder="Nhập lại mật khẩu" />
                        <button type="button" class="pw-toggle"
                                onclick="togglePw('confirmPassword',this)">
                            <i class="bi bi-eye"></i>
                        </button>
                    </div>
                </div>
            </div>

            <div class="actions-row">
                <button type="submit" class="btn-primary"
                        onclick="return confirmPassword()">
                    <i class="bi bi-shield-check"></i> Đổi mật khẩu
                </button>
            </div>
        </form>

        <c:if test="${not empty MSGpass}">
            <div class="alert-ok"><i class="bi bi-check-circle-fill"></i> ${MSGpass}</div>
        </c:if>
        <c:if test="${not empty ERRORpass}">
            <div class="alert-err"><i class="bi bi-exclamation-circle-fill"></i> ${ERRORpass}</div>
        </c:if>
    </div>

</div><!-- /page-wrap -->

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    function togglePw(id, btn) {
        const inp = document.getElementById(id);
        const ico = btn.querySelector('i');
        if (inp.type === 'password') {
            inp.type = 'text';
            ico.className = 'bi bi-eye-slash';
        } else {
            inp.type = 'password';
            ico.className = 'bi bi-eye';
        }
    }

    function confirmPassword() {
        const old  = document.getElementById('oldPassword').value.trim();
        const pw   = document.getElementById('newPassword').value;
        const conf = document.getElementById('confirmPassword').value;
        if (!old)            { alert('Vui lòng nhập mật khẩu cũ!'); return false; }
        if (pw.length < 6)   { alert('Mật khẩu mới phải có ít nhất 6 ký tự!'); return false; }
        if (pw !== conf)     { alert('Mật khẩu xác nhận không khớp!'); return false; }
        return confirm('Bạn có chắc muốn đổi mật khẩu không?');
    }
</script>
</body>
</html>
