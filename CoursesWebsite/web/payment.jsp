<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Nạp tiền - DUKAcademy</title>
        <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&family=DM+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
        <link rel="icon" type="favicon" href="img/page/favicon.jpg">

        <style>
            :root {
                --purple:      #6C3FC5;
                --purple-dark: #4E2C96;
                --purple-deep: #1E0A4A;
                --purple-light:#F3EEFF;
                --purple-mid:  #9B72E8;
                --gold:        #D4A843;
                --text:        #1A1A2E;
                --muted:       #6B6B8A;
                --border:      #E2D9F3;
                --bg:          #F4F0FC;
                --momo:        #AE2070;
                --momo-dark:   #8B1857;
            }

            *, *::before, *::after {
                box-sizing: border-box;
                margin: 0;
                padding: 0;
            }

            body {
                font-family: 'DM Sans', sans-serif;
                background: var(--bg);
                color: var(--text);
                min-height: 100vh;
                display: flex;
                flex-direction: column;
            }

            /* NAVBAR */
            .navbar {
                background: var(--purple-deep);
                padding: 0 48px;
                height: 68px;
                display: flex;
                align-items: center;
                justify-content: space-between;
                box-shadow: 0 2px 20px rgba(0,0,0,0.25);
            }
            .brand {
                font-family: 'Playfair Display', serif;
                font-size: 1.5rem;
                font-weight: 700;
                color: #fff;
                text-decoration: none;
            }
            .brand span {
                color: var(--gold);
            }
            .back-link {
                display: flex;
                align-items: center;
                gap: 8px;
                color: rgba(255,255,255,0.7);
                text-decoration: none;
                font-size: 0.875rem;
                font-weight: 500;
                padding: 8px 16px;
                border-radius: 8px;
                border: 1px solid rgba(255,255,255,0.15);
                transition: all 0.15s;
            }
            .back-link:hover {
                background: rgba(255,255,255,0.08);
                color: #fff;
            }

            /* MAIN */
            .main {
                flex: 1;
                display: flex;
                align-items: center;
                justify-content: center;
                padding: 48px 20px;
            }

            .payment-wrapper {
                width: 100%;
                max-width: 520px;
                animation: fadeUp 0.4s ease;
            }

            @keyframes fadeUp {
                from {
                    opacity: 0;
                    transform: translateY(24px);
                }
                to   {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            /* HEADER CARD */
            .payment-header {
                background: linear-gradient(135deg, var(--purple-deep), #3A1A7A, #5B2DC5);
                border-radius: 20px 20px 0 0;
                padding: 32px;
                text-align: center;
                position: relative;
                overflow: hidden;
            }
            .payment-header::before {
                content: '';
                position: absolute;
                width: 200px;
                height: 200px;
                border-radius: 50%;
                background: rgba(212,168,67,0.08);
                top: -80px;
                right: -60px;
            }
            .header-icon {
                width: 64px;
                height: 64px;
                background: rgba(255,255,255,0.12);
                border-radius: 18px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1.8rem;
                margin: 0 auto 16px;
                backdrop-filter: blur(8px);
                border: 1px solid rgba(255,255,255,0.15);
            }
            .header-title {
                font-family: 'Playfair Display', serif;
                font-size: 1.5rem;
                font-weight: 700;
                color: #fff;
                margin-bottom: 6px;
            }
            .header-sub {
                font-size: 0.875rem;
                color: rgba(255,255,255,0.6);
            }

            /* AMOUNT DISPLAY */
            .amount-display {
                background: rgba(255,255,255,0.08);
                border: 1px solid rgba(255,255,255,0.12);
                border-radius: 12px;
                padding: 16px 24px;
                margin-top: 20px;
                display: flex;
                align-items: center;
                justify-content: space-between;
            }
            .amount-label {
                font-size: 0.8rem;
                color: rgba(255,255,255,0.55);
                font-weight: 500;
            }
            .amount-value {
                font-size: 1.5rem;
                font-weight: 700;
                color: var(--gold);
            }

            /* BODY CARD */
            .payment-body {
                background: #fff;
                border-radius: 0 0 20px 20px;
                padding: 28px;
                border: 1px solid var(--border);
                border-top: none;
                box-shadow: 0 16px 48px rgba(108,63,197,0.12);
            }

            .section-title {
                font-size: 0.78rem;
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: 1.5px;
                color: var(--muted);
                margin-bottom: 14px;
            }

            /* AMOUNT INPUT */
            .amount-input-wrap {
                position: relative;
                margin-bottom: 20px;
            }
            .amount-input-wrap .currency {
                position: absolute;
                left: 16px;
                top: 50%;
                transform: translateY(-50%);
                font-size: 0.9rem;
                font-weight: 700;
                color: var(--purple);
            }
            .amount-input {
                width: 100%;
                padding: 14px 16px 14px 48px;
                border: 2px solid var(--border);
                border-radius: 12px;
                font-size: 1.1rem;
                font-weight: 700;
                color: var(--text);
                font-family: 'DM Sans', sans-serif;
                outline: none;
                transition: border-color 0.15s;
            }
            .amount-input:focus {
                border-color: var(--purple);
            }

            /* QUICK AMOUNTS */
            .quick-amounts {
                display: grid;
                grid-template-columns: repeat(3, 1fr);
                gap: 8px;
                margin-bottom: 24px;
            }
            .quick-btn {
                padding: 10px;
                border: 1.5px solid var(--border);
                border-radius: 10px;
                background: #fff;
                color: var(--muted);
                font-size: 0.82rem;
                font-weight: 700;
                cursor: pointer;
                font-family: 'DM Sans', sans-serif;
                transition: all 0.15s;
                text-align: center;
            }
            .quick-btn:hover {
                border-color: var(--purple);
                color: var(--purple);
                background: var(--purple-light);
            }
            .quick-btn.active {
                border-color: var(--purple);
                color: var(--purple);
                background: var(--purple-light);
            }

            /* DIVIDER */
            .divider {
                height: 1px;
                background: var(--border);
                margin: 20px 0;
                position: relative;
                display: flex;
                align-items: center;
                justify-content: center;
            }
            .divider span {
                position: absolute;
                background: #fff;
                padding: 0 12px;
                font-size: 0.75rem;
                color: var(--muted);
                font-weight: 600;
            }

            /* PAYMENT METHODS */
            .method-tabs {
                display: flex;
                gap: 10px;
                margin-bottom: 20px;
            }
            .method-tab {
                flex: 1;
                padding: 12px;
                border: 2px solid var(--border);
                border-radius: 12px;
                background: #fff;
                cursor: pointer;
                text-align: center;
                transition: all 0.15s;
                font-family: 'DM Sans', sans-serif;
            }
            .method-tab:hover {
                border-color: var(--purple);
            }
            .method-tab.active {
                border-color: var(--purple);
                background: var(--purple-light);
            }
            .method-tab .tab-icon {
                font-size: 1.4rem;
                margin-bottom: 4px;
            }
            .method-tab .tab-label {
                font-size: 0.75rem;
                font-weight: 700;
                color: var(--text);
            }

            /* MOMO BUTTON */
            .btn-momo {
                width: 100%;
                padding: 15px;
                background: linear-gradient(135deg, var(--momo), var(--momo-dark));
                color: #fff;
                border: none;
                border-radius: 12px;
                font-size: 0.95rem;
                font-weight: 700;
                cursor: pointer;
                font-family: 'DM Sans', sans-serif;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 10px;
                transition: all 0.2s;
                box-shadow: 0 4px 20px rgba(174,32,112,0.3);
                margin-bottom: 10px;
            }
            .btn-momo:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 28px rgba(174,32,112,0.4);
            }
            .btn-momo:active {
                transform: translateY(0);
            }

            /* QR BUTTON */
            .btn-qr {
                width: 100%;
                padding: 15px;
                background: #fff;
                color: var(--purple);
                border: 2px solid var(--purple);
                border-radius: 12px;
                font-size: 0.95rem;
                font-weight: 700;
                cursor: pointer;
                font-family: 'DM Sans', sans-serif;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 10px;
                transition: all 0.2s;
            }
            .btn-qr:hover {
                background: var(--purple-light);
                transform: translateY(-2px);
            }

            /* QR SECTION */
            .qr-section {
                display: none;
                margin-top: 20px;
                text-align: center;
                padding: 24px;
                background: var(--bg);
                border-radius: 14px;
                border: 1px solid var(--border);
                animation: fadeIn 0.3s ease;
            }
            .qr-section.show {
                display: block;
            }
            @keyframes fadeIn {
                from {
                    opacity: 0;
                }
                to {
                    opacity: 1;
                }
            }

            .qr-title {
                font-size: 0.82rem;
                font-weight: 700;
                color: var(--muted);
                margin-bottom: 14px;
                text-transform: uppercase;
                letter-spacing: 1px;
            }
            .qr-img {
                width: 220px;
                height: 220px;
                border-radius: 12px;
                border: 3px solid var(--purple);
                padding: 6px;
                background: #fff;
            }
            .qr-info {
                margin-top: 14px;
                font-size: 0.8rem;
                color: var(--muted);
                line-height: 1.7;
            }
            .qr-info strong {
                color: var(--text);
            }

            /* SECURITY NOTE */
            .security-note {
                display: flex;
                align-items: center;
                gap: 8px;
                margin-top: 16px;
                padding: 10px 14px;
                background: #F0FDF4;
                border-radius: 8px;
                font-size: 0.78rem;
                color: #2E7D32;
                font-weight: 500;
            }

            /* FOOTER */
            footer {
                background: var(--purple-deep);
                padding: 20px 48px;
                text-align: center;
            }
            footer span {
                font-size: 0.75rem;
                color: rgba(255,255,255,0.3);
            }

            @media (max-width: 600px) {
                .navbar {
                    padding: 0 20px;
                }
                .payment-body {
                    padding: 20px;
                }
                footer {
                    padding: 20px;
                }
            }
        </style>
    </head>
    <body>

        <!-- NAVBAR -->
        <nav class="navbar">
            <a href="homePage.jsp" class="brand">DUK<span>Academy</span></a>
            <a href="homePage.jsp" class="back-link">
                <i class="bi bi-arrow-left"></i> Quay lại khóa học
            </a>
        </nav>

        <!-- MAIN -->
        <div class="main">
            <div class="payment-wrapper">

                <!-- HEADER -->
                <div class="payment-header">
                    <div class="header-icon">💳</div>
                    <div class="header-title">Nạp tiền vào tài khoản</div>
                    <div class="header-sub">Số dư sẽ được cộng ngay sau khi thanh toán thành công</div>

                    <div class="amount-display">
                        <span class="amount-label"><i class="bi bi-wallet2"></i> Số dư hiện tại</span>
                        <span class="amount-value">
                            <fmt:formatNumber value="${sessionScope.user.balance}" type="number"/> ₫
                        </span>
                    </div>
                </div>

                <!-- BODY -->
                <div class="payment-body">

                    <!-- NHẬP SỐ TIỀN -->
                    <div class="section-title">Chọn số tiền nạp</div>

                    <div class="amount-input-wrap">
                        <span class="currency">₫</span>
                        <input type="number" class="amount-input" id="amountInput"
                               placeholder="Nhập số tiền..." min="10000"
                               value="${not empty totalAmount ? totalAmount : ''}">
                    </div>

                    <div class="quick-amounts">
                        <button class="quick-btn" onclick="setAmount(50000)">50.000 ₫</button>
                        <button class="quick-btn" onclick="setAmount(100000)">100.000 ₫</button>
                        <button class="quick-btn" onclick="setAmount(200000)">200.000 ₫</button>
                        <button class="quick-btn" onclick="setAmount(500000)">500.000 ₫</button>
                        <button class="quick-btn" onclick="setAmount(1000000)">1.000.000 ₫</button>
                        <button class="quick-btn" onclick="setAmount(2000000)">2.000.000 ₫</button>
                    </div>

                    <div class="divider"><span>Chọn phương thức thanh toán</span></div>

                    <!-- METHOD TABS -->
                    <div class="method-tabs">
                        <div class="method-tab active" onclick="switchTab(this, 'momo')">
                            <div class="tab-icon">💜</div>
                            <div class="tab-label">MoMo</div>
                        </div>
                        <div class="method-tab" onclick="switchTab(this, 'qr')">
                            <div class="tab-icon">📱</div>
                            <div class="tab-label">QR Banking</div>
                        </div>
                    </div>

                    <!-- MOMO PANEL -->
                    <div id="panel-momo">
                        <form action="payment" method="post" onsubmit="return validateAmount()">
                            <input type="hidden" name="action" value="create">
                            <input type="hidden" name="amount" id="momoAmount" value="${totalAmount}">
                            <button type="submit" class="btn-momo" onclick="syncAmount()">
                                <span style="font-size:1.2rem;">💜</span>
                                Thanh toán qua MoMo
                            </button>
                        </form>
                    </div>

                    <!-- QR PANEL -->
                    <div id="panel-qr" style="display:none;">
                        <button class="btn-qr" onclick="generateQR()">
                            <i class="bi bi-qr-code"></i> Tạo mã QR thanh toán
                        </button>
                        <div class="qr-section" id="qrSection">
                            <div class="qr-title"><i class="bi bi-qr-code-scan"></i> Quét mã để thanh toán</div>
                            <img id="qrImg" class="qr-img" src="" alt="QR Code">
                            <div class="qr-info">
                                <strong>Ngân hàng:</strong> VietinBank<br>
                                <strong>Số tài khoản:</strong> 106879806456<br>
                                <strong>Chủ TK:</strong> LE HOANG KHANG<br>
                                <strong>Nội dung:</strong> <span id="qrContent">—</span>
                            </div>
                        </div>
                    </div>

                    <!-- SECURITY NOTE -->
                    <div class="security-note">
                        <i class="bi bi-shield-check-fill"></i>
                        Giao dịch được mã hóa và bảo mật an toàn
                    </div>

                </div>
            </div>
        </div>

        <!-- FOOTER -->
        <footer>
            <span>© 2026 DUK Academy. All rights reserved.</span>
        </footer>

        <script>
            function setAmount(val) {
                document.getElementById('amountInput').value = val;
                document.querySelectorAll('.quick-btn').forEach(b => b.classList.remove('active'));
                event.target.classList.add('active');
            }

            function syncAmount() {
                document.getElementById('momoAmount').value = document.getElementById('amountInput').value;
            }

            function validateAmount() {
                const amount = parseInt(document.getElementById('amountInput').value) || 0;
                if (amount < 10000) {
                    alert('Số tiền nạp tối thiểu là 10.000 ₫');
                    return false;
                }
                syncAmount();
                return true;
            }

            function switchTab(el, panel) {
                document.querySelectorAll('.method-tab').forEach(t => t.classList.remove('active'));
                el.classList.add('active');
                document.getElementById('panel-momo').style.display = panel === 'momo' ? 'block' : 'none';
                document.getElementById('panel-qr').style.display = panel === 'qr' ? 'block' : 'none';
            }

            function generateQR() {
                const amount = parseInt(document.getElementById('amountInput').value) || 0;
                if (amount < 10000) {
                    alert('Vui lòng nhập số tiền tối thiểu 10.000 ₫');
                    return;
                }
                const bank = "970415";
                const account = "106879806456";
                const name = "LE HOANG KHANG";
                const info = "DUK ${user.userId}";
                const url = "https://img.vietqr.io/image/"
                        + bank + "-" + account
                        + "-qr_only.png?amount=" + amount
                        + "&addInfo=" + encodeURIComponent(info)
                        + "&accountName=" + encodeURIComponent(name);

                document.getElementById('qrImg').src = url;
                document.getElementById('qrContent').textContent = info;
                document.getElementById('qrSection').classList.add('show');
            }

            // Sync amount input khi nhập tay
            document.getElementById('amountInput').addEventListener('input', function () {
                document.querySelectorAll('.quick-btn').forEach(b => b.classList.remove('active'));
            });
        </script>
    </body>
</html>
