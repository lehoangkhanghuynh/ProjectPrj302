<%-- 
    Document   : resetPassword
    Created on : Mar 10, 2026, 7:42:29 PM
    Author     : HOANG KHANG PC
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Đặt lại mật khẩu – DUKAcademy</title>
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
            display: flex; align-items: center; justify-content: center;
            margin-bottom: 24px;
        }

        .icon-wrap svg {
            width: 26px; height: 26px;
            stroke: var(--accent); fill: none;
            stroke-width: 2; stroke-linecap: round; stroke-linejoin: round;
        }

        h2 {
            font-family: 'Playfair Display', serif;
            font-size: 1.75rem; font-weight: 600;
            color: var(--text); margin-bottom: 8px;
        }

        .subtitle {
            font-size: 0.875rem; color: var(--muted);
            line-height: 1.65; margin-bottom: 28px;
        }

        .divider { border: none; border-top: 1px solid var(--border); margin: 0 0 24px; }

        .field { margin-bottom: 20px; }

        label {
            display: block;
            font-size: 0.78rem; font-weight: 600;
            letter-spacing: 0.07em; text-transform: uppercase;
            color: var(--muted); margin-bottom: 8px;
        }

        .input-wrap { position: relative; }

        .input-wrap > svg {
            position: absolute;
            left: 14px; top: 50%;
            transform: translateY(-50%);
            width: 16px; height: 16px;
            stroke: var(--muted); fill: none;
            stroke-width: 2; stroke-linecap: round; stroke-linejoin: round;
            pointer-events: none;
            transition: stroke 0.2s;
            z-index: 1;
        }

        .input-wrap:focus-within > svg { stroke: var(--accent); }

        input[type="password"],
        input[type="text"] {
            width: 100%;
            background: var(--input-bg);
            border: 1.5px solid var(--border);
            border-radius: 12px;
            color: var(--text);
            font-family: 'DM Sans', sans-serif;
            font-size: 0.95rem;
            padding: 13px 44px 13px 42px;
            outline: none;
            transition: border-color 0.2s, box-shadow 0.2s, background 0.2s;
        }

        input:focus {
            border-color: var(--accent);
            background: #fff;
            box-shadow: 0 0 0 3px rgba(107,72,255,0.10);
        }

        .toggle-eye {
            position: absolute;
            right: 13px; top: 50%;
            transform: translateY(-50%);
            background: none; border: none;
            cursor: pointer; padding: 3px;
            display: flex; align-items: center;
        }

        .toggle-eye svg {
            width: 17px; height: 17px;
            stroke: var(--muted); fill: none;
            stroke-width: 2; stroke-linecap: round; stroke-linejoin: round;
            transition: stroke 0.2s;
        }

        .toggle-eye:hover svg { stroke: var(--accent); }

        /* Strength bar */
        .strength-bar {
            display: flex; gap: 4px;
            margin-top: 8px; height: 3px;
        }

        .strength-bar span {
            flex: 1; border-radius: 99px;
            background: var(--border);
            transition: background 0.3s;
        }

        .strength-label {
            font-size: 0.73rem; color: var(--muted);
            margin-top: 5px; min-height: 16px;
            transition: color 0.3s;
        }

        .match-hint {
            font-size: 0.73rem;
            margin-top: 5px; min-height: 16px;
            transition: color 0.3s;
        }

        .btn {
            width: 100%; margin-top: 8px; padding: 14px;
            background: var(--accent); color: #fff;
            border: none; border-radius: 12px;
            font-family: 'DM Sans', sans-serif;
            font-size: 0.95rem; font-weight: 600;
            cursor: pointer; letter-spacing: 0.02em;
            transition: background 0.2s, transform 0.15s, box-shadow 0.2s;
            box-shadow: 0 4px 16px rgba(107,72,255,0.28);
        }

        .btn:hover { background: #5538e6; transform: translateY(-1px); box-shadow: 0 6px 20px rgba(107,72,255,0.38); }
        .btn:active { transform: translateY(0); }

        .back-link { text-align: center; margin-top: 22px; font-size: 0.83rem; color: var(--muted); }
        .back-link a { color: var(--accent); text-decoration: none; font-weight: 600; transition: opacity 0.2s; }
        .back-link a:hover { opacity: 0.75; }
    </style>
</head>
<body>
    <div class="container">
        <div class="brand">DUK<span>Academy</span></div>
        <div class="card">
            <div class="icon-wrap">
                <svg viewBox="0 0 24 24">
                    <rect x="3" y="11" width="18" height="11" rx="2" ry="2"/>
                    <path d="M7 11V7a5 5 0 0 1 10 0v4"/>
                </svg>
            </div>

            <h2>Đặt lại mật khẩu</h2>
            <p class="subtitle">Tạo mật khẩu mới an toàn cho tài khoản của bạn.</p>

            <hr class="divider">

            <form action="${pageContext.request.contextPath}/mainController" method="POST" id="resetForm">
                <input type="hidden" name="action" value="resetPassword"/>
                <input type="hidden" name="token" value="${param.token}" />

                <div class="field">
                    <label for="password">Mật khẩu mới</label>
                    <div class="input-wrap">
                        <svg viewBox="0 0 24 24">
                            <rect x="3" y="11" width="18" height="11" rx="2"/>
                            <path d="M7 11V7a5 5 0 0 1 10 0v4"/>
                        </svg>
                        <input type="password" id="password" name="password" required
                               placeholder="Nhập mật khẩu mới" autocomplete="new-password"
                               oninput="checkStrength(this.value)"/>
                        <button type="button" class="toggle-eye" onclick="toggleVis('password',this)" tabindex="-1">
                            <svg viewBox="0 0 24 24"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/></svg>
                        </button>
                    </div>
                    <div class="strength-bar">
                        <span id="s1"></span><span id="s2"></span><span id="s3"></span><span id="s4"></span>
                    </div>
                    <div class="strength-label" id="strength-label"></div>
                </div>

                <div class="field">
                    <label for="confirmPassword">Xác nhận mật khẩu</label>
                    <div class="input-wrap">
                        <svg viewBox="0 0 24 24">
                            <path d="M9 12l2 2 4-4"/>
                            <rect x="3" y="11" width="18" height="11" rx="2"/>
                            <path d="M7 11V7a5 5 0 0 1 10 0v4"/>
                        </svg>
                        <input type="password" id="confirmPassword" name="confirmPassword" required
                               placeholder="Nhập lại mật khẩu" autocomplete="new-password"
                               oninput="checkMatch()"/>
                        <button type="button" class="toggle-eye" onclick="toggleVis('confirmPassword',this)" tabindex="-1">
                            <svg viewBox="0 0 24 24"><path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/></svg>
                        </button>
                    </div>
                    <div class="match-hint" id="match-hint"></div>
                </div>

                <button type="submit" class="btn">Đổi mật khẩu</button>
            </form>

            <p class="back-link"><a href="${pageContext.request.contextPath}/login.jsp">← Quay lại đăng nhập</a></p>
        </div>
    </div>

    <script>
        function toggleVis(id, btn) {
            const input = document.getElementById(id);
            const isText = input.type === 'text';
            input.type = isText ? 'password' : 'text';
            btn.querySelector('svg').innerHTML = isText
                ? '<path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/><circle cx="12" cy="12" r="3"/>'
                : '<path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19m-6.72-1.07a3 3 0 1 1-4.24-4.24"/><line x1="1" y1="1" x2="23" y2="23"/>';
        }

        function checkStrength(val) {
            const segs = ['s1','s2','s3','s4'].map(id => document.getElementById(id));
            const label = document.getElementById('strength-label');
            const colors = ['#e05252','#e09052','#b8c840','#2e9e6b'];
            const labels = ['Rất yếu','Yếu','Khá tốt','Mạnh'];
            let score = 0;
            if (val.length >= 8) score++;
            if (/[A-Z]/.test(val)) score++;
            if (/[0-9]/.test(val)) score++;
            if (/[^A-Za-z0-9]/.test(val)) score++;
            segs.forEach((s,i) => { s.style.background = i < score ? colors[score-1] : 'var(--border)'; });
            label.textContent = val.length ? labels[score-1] || '' : '';
            label.style.color = val.length ? colors[score-1] : 'var(--muted)';
            checkMatch();
        }

        function checkMatch() {
            const pw = document.getElementById('password').value;
            const cp = document.getElementById('confirmPassword').value;
            const hint = document.getElementById('match-hint');
            if (!cp) { hint.textContent = ''; return; }
            if (pw === cp) {
                hint.textContent = '✓ Mật khẩu khớp';
                hint.style.color = 'var(--success)';
            } else {
                hint.textContent = '✗ Mật khẩu không khớp';
                hint.style.color = 'var(--error)';
            }
        }

        document.getElementById('resetForm').addEventListener('submit', function(e) {
            const pw = document.getElementById('password').value;
            const cp = document.getElementById('confirmPassword').value;
            if (pw !== cp) {
                e.preventDefault();
                document.getElementById('match-hint').textContent = '✗ Mật khẩu không khớp';
                document.getElementById('match-hint').style.color = 'var(--error)';
            }
        });
    </script>
</body>
</html>
