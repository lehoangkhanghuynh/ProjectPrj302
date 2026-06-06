<%-- 
    Document   : forgotPassword
    Created on : Mar 10, 2026, 7:32:40 PM
    Author     : HOANG KHANG PC
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Quên mật khẩu – DUKAcademy</title>    
    <link rel="icon" type="image/jpeg" href="img/page/favicon.jpg">

    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600&family=DM+Sans:wght@300;400;500;600&display=swap" rel="stylesheet">
    <style>
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

        :root {
            --bg: #F8F5FF;
            --card: #ffffff;
            --border: #E2D9F3;
            --accent: #6B48FF;
            --accent-light: rgba(107,72,255,0.08);
            --accent-mid: rgba(107,72,255,0.18);
            --text: #1a1a2e;
            --muted: #7c7c9a;
            --input-bg: #fafafa;
            --error: #e05252;
            --error-bg: rgba(224,82,82,0.08);
            --success: #2e9e6b;
            --success-bg: rgba(46,158,107,0.08);
        }

        body {
            font-family: 'DM Sans', sans-serif;
            background: var(--bg);
            color: var(--text);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 24px;
        }

        body::before {
            content: '';
            position: fixed;
            top: -120px; left: -120px;
            width: 500px; height: 500px;
            border-radius: 50%;
            background: radial-gradient(circle, rgba(107,72,255,0.10) 0%, transparent 65%);
            pointer-events: none;
        }

        body::after {
            content: '';
            position: fixed;
            bottom: -120px; right: -80px;
            width: 450px; height: 450px;
            border-radius: 50%;
            background: radial-gradient(circle, rgba(107,72,255,0.07) 0%, transparent 65%);
            pointer-events: none;
        }

        .container {
            position: relative;
            z-index: 1;
            width: 100%;
            max-width: 430px;
            animation: fadeUp 0.55s cubic-bezier(0.16,1,0.3,1) both;
        }

        @keyframes fadeUp {
            from { opacity: 0; transform: translateY(24px); }
            to   { opacity: 1; transform: translateY(0); }
        }

        .brand {
            text-align: center;
            margin-bottom: 28px;
            font-family: 'Playfair Display', serif;
            font-size: 1.5rem;
            color: var(--text);
        }
        .brand span { color: var(--accent); }

        .card {
            background: var(--card);
            border: 1px solid var(--border);
            border-radius: 24px;
            padding: 40px 36px;
            box-shadow: 0 8px 40px rgba(107,72,255,0.10);
        }

        .icon-wrap {
            width: 56px; height: 56px;
            border-radius: 16px;
            background: var(--accent-light);
            border: 1px solid var(--accent-mid);
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 24px;
        }

        .icon-wrap svg {
            width: 26px; height: 26px;
            stroke: var(--accent);
            fill: none;
            stroke-width: 2;
            stroke-linecap: round;
            stroke-linejoin: round;
        }

        h2 {
            font-family: 'Playfair Display', serif;
            font-size: 1.75rem;
            font-weight: 600;
            color: var(--text);
            margin-bottom: 8px;
        }

        .subtitle {
            font-size: 0.875rem;
            color: var(--muted);
            line-height: 1.65;
            margin-bottom: 28px;
        }

        .divider {
            border: none;
            border-top: 1px solid var(--border);
            margin: 0 0 24px;
        }

        .field { margin-bottom: 20px; }

        label {
            display: block;
            font-size: 0.78rem;
            font-weight: 600;
            letter-spacing: 0.07em;
            text-transform: uppercase;
            color: var(--muted);
            margin-bottom: 8px;
        }

        .input-wrap { position: relative; }

        .input-wrap svg {
            position: absolute;
            left: 14px; top: 50%;
            transform: translateY(-50%);
            width: 16px; height: 16px;
            stroke: var(--muted);
            fill: none;
            stroke-width: 2;
            stroke-linecap: round;
            stroke-linejoin: round;
            pointer-events: none;
            transition: stroke 0.2s;
        }

        input[type="email"] {
            width: 100%;
            background: var(--input-bg);
            border: 1.5px solid var(--border);
            border-radius: 12px;
            color: var(--text);
            font-family: 'DM Sans', sans-serif;
            font-size: 0.95rem;
            padding: 13px 16px 13px 42px;
            outline: none;
            transition: border-color 0.2s, box-shadow 0.2s, background 0.2s;
        }

        input[type="email"]:focus {
            border-color: var(--accent);
            background: #fff;
            box-shadow: 0 0 0 3px rgba(107,72,255,0.10);
        }

        .input-wrap:focus-within svg { stroke: var(--accent); }

        .btn {
            width: 100%;
            margin-top: 4px;
            padding: 14px;
            background: var(--accent);
            color: #fff;
            border: none;
            border-radius: 12px;
            font-family: 'DM Sans', sans-serif;
            font-size: 0.95rem;
            font-weight: 600;
            cursor: pointer;
            letter-spacing: 0.02em;
            transition: background 0.2s, transform 0.15s, box-shadow 0.2s;
            box-shadow: 0 4px 16px rgba(107,72,255,0.28);
        }

        .btn:hover { background: #5538e6; transform: translateY(-1px); box-shadow: 0 6px 20px rgba(107,72,255,0.38); }
        .btn:active { transform: translateY(0); }

        .alert {
            display: flex;
            align-items: flex-start;
            gap: 10px;
            padding: 12px 14px;
            border-radius: 10px;
            font-size: 0.845rem;
            line-height: 1.5;
            margin-bottom: 20px;
        }

        .alert svg {
            width: 16px; height: 16px;
            flex-shrink: 0; margin-top: 2px;
            fill: none; stroke-width: 2;
            stroke-linecap: round; stroke-linejoin: round;
        }

        .alert-error { background: var(--error-bg); border: 1px solid rgba(224,82,82,0.2); color: var(--error); }
        .alert-error svg { stroke: var(--error); }

        /* Success state */
        .success-state { text-align: center; padding: 8px 0 4px; }

        .success-icon {
            width: 68px; height: 68px;
            border-radius: 50%;
            background: var(--success-bg);
            border: 1px solid rgba(46,158,107,0.2);
            display: flex; align-items: center; justify-content: center;
            margin: 0 auto 20px;
        }

        .success-icon svg {
            width: 30px; height: 30px;
            stroke: var(--success); fill: none;
            stroke-width: 2.5; stroke-linecap: round; stroke-linejoin: round;
        }

        .success-state h3 {
            font-family: 'Playfair Display', serif;
            font-size: 1.35rem;
            margin-bottom: 10px;
            color: var(--text);
        }

        .success-state p { font-size: 0.875rem; color: var(--muted); line-height: 1.65; }

        .back-link { text-align: center; margin-top: 22px; font-size: 0.83rem; color: var(--muted); }
        .back-link a { color: var(--accent); text-decoration: none; font-weight: 600; transition: opacity 0.2s; }
        .back-link a:hover { opacity: 0.75; }
    </style>
</head>
<body>
    <div class="container">
        <div class="brand">DUK<span>Academy</span></div>
        <div class="card">
            <c:choose>
                <c:when test="${not empty msg && msg == 'success'}">
                    <div class="success-state">
                        <div class="success-icon">
                            <svg viewBox="0 0 24 24"><polyline points="20 6 9 17 4 12"/></svg>
                        </div>
                        <h3>Email đã được gửi!</h3>
                        <p>Vui lòng kiểm tra hộp thư của bạn và làm theo hướng dẫn để đặt lại mật khẩu.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="icon-wrap">
                        <svg viewBox="0 0 24 24">
                            <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"/>
                            <polyline points="22,6 12,13 2,6"/>
                        </svg>
                    </div>
                    <h2>Quên mật khẩu?</h2>
                    <p class="subtitle">Nhập email đã đăng ký, chúng tôi sẽ gửi link đặt lại mật khẩu ngay cho bạn.</p>
                    <hr class="divider">
                    <c:if test="${not empty msg && msg != 'success'}">
                        <div class="alert alert-error">
                            <svg viewBox="0 0 24 24"><circle cx="12" cy="12" r="10"/><line x1="12" y1="8" x2="12" y2="12"/><line x1="12" y1="16" x2="12.01" y2="16"/></svg>
                            <span>${msg}</span>
                        </div>
                    </c:if>
                    <form action="${pageContext.request.contextPath}/mainController" method="POST">
                        <input type="hidden" name="action" value="forgotPassword"/>
                        <div class="field">
                            <label for="email">Địa chỉ Email</label>
                            <div class="input-wrap">
                                <input type="email" id="email" name="email" required placeholder="email@example.com" autocomplete="email"/>
                                <svg viewBox="0 0 24 24">
                                    <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"/>
                                    <polyline points="22,6 12,13 2,6"/>
                                </svg>
                            </div>
                        </div>
                        <button type="submit" class="btn">Gửi link đặt lại mật khẩu</button>
                    </form>
                </c:otherwise>
            </c:choose>
            <p class="back-link"><a href="${pageContext.request.contextPath}/login.jsp">← Quay lại đăng nhập</a></p>
        </div>
    </div>
</body>
</html>
