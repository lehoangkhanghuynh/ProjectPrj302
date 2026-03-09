<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%!
    public String fmtBal(Object bal) {
        if (bal == null) return "0";
        try {
            double d = Double.parseDouble(bal.toString().trim());
            long v = (long) d;
            return String.format("%,d", v).replace(',', '.');
        } catch (Exception e) { return "0"; }
    }
%>
<%-- Chưa đăng nhập → về login --%>
<c:if test="${empty sessionScope.user}">
    <c:redirect url="login.jsp"/>
</c:if>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nạp tiền - DUK Academy</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&family=DM+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link rel="icon" type="image/jpeg" href="img/page/favicon.jpg">
    <style>
        :root {
            --purple:#6C3FC5; --purple-dark:#4E2C96; --purple-deep:#1E0A4A;
            --purple-light:#F3EEFF; --purple-mid:#9B72E8;
            --gold:#D4A843; --text:#1A1A2E; --muted:#6B6B8A;
            --border:#E2D9F3; --bg:#F4F0FC;
        }
        *,*::before,*::after{box-sizing:border-box;margin:0;padding:0;}
        body{font-family:'DM Sans',sans-serif;color:var(--text);background:var(--bg);}

        .navbar-main{background:var(--purple-deep);padding:0 48px;height:68px;display:flex;align-items:center;justify-content:space-between;position:sticky;top:0;z-index:100;box-shadow:0 2px 20px rgba(0,0,0,0.25);}
        .brand{font-family:'Playfair Display',serif;font-size:1.55rem;font-weight:700;color:#fff;text-decoration:none;}
        .brand span{color:var(--gold);}
        .nav-links{display:flex;align-items:center;gap:4px;list-style:none;}
        .nav-links a{font-size:0.9rem;font-weight:500;color:rgba(255,255,255,0.75);text-decoration:none;padding:7px 14px;border-radius:6px;transition:all 0.15s;}
        .nav-links a:hover{background:rgba(255,255,255,0.1);color:#fff;}
        .nav-right{display:flex;align-items:center;gap:12px;}
        .balance-pill{display:flex;align-items:center;gap:7px;background:rgba(212,168,67,0.12);border:1px solid rgba(212,168,67,0.35);border-radius:8px;padding:7px 14px;text-decoration:none;cursor:pointer;transition:background 0.15s;}
        .balance-pill:hover{background:rgba(212,168,67,0.22);}
        .balance-pill i{color:var(--gold);}
        .balance-label{font-size:0.75rem;font-weight:500;color:rgba(255,255,255,0.6);}
        .balance-amount{font-size:0.875rem;font-weight:700;color:var(--gold);}
        .user-menu{display:flex;align-items:center;gap:10px;cursor:pointer;padding:6px 12px;border-radius:8px;border:1px solid rgba(255,255,255,0.15);transition:background 0.15s;}
        .user-menu:hover{background:rgba(255,255,255,0.08);}
        .user-avatar{width:34px;height:34px;border-radius:50%;background:linear-gradient(135deg,var(--purple-mid),var(--gold));display:flex;align-items:center;justify-content:center;font-size:0.9rem;font-weight:700;color:#fff;}
        .user-name{font-size:0.875rem;font-weight:600;color:#fff;max-width:120px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap;}
        .dropdown-menu-custom{position:absolute;top:76px;right:48px;background:#fff;border:1px solid var(--border);border-radius:10px;padding:8px;min-width:200px;box-shadow:0 8px 32px rgba(0,0,0,0.15);display:none;z-index:200;}
        .dropdown-menu-custom.show{display:block;}
        .dropdown-menu-custom a{display:flex;align-items:center;gap:10px;padding:10px 14px;border-radius:7px;font-size:0.875rem;color:var(--text);text-decoration:none;font-weight:500;transition:background 0.12s;}
        .dropdown-menu-custom a:hover{background:var(--purple-light);color:var(--purple);}
        .dropdown-menu-custom .divider-drop{height:1px;background:var(--border);margin:6px 0;}
        .dropdown-menu-custom .logout-link{color:#CC0000;}
        .dropdown-menu-custom .logout-link:hover{background:#FFF3F3;color:#CC0000;}

        .page-header{background:linear-gradient(135deg,var(--purple-deep) 0%,#3A1A7A 60%,#5B2DC5 100%);padding:48px 80px 52px;position:relative;overflow:hidden;}
        .page-header::before{content:'';position:absolute;width:400px;height:400px;border-radius:50%;background:rgba(212,168,67,0.06);top:-150px;right:-80px;}
        .page-header-inner{position:relative;z-index:1;}
        .page-eyebrow{font-size:0.72rem;font-weight:700;text-transform:uppercase;letter-spacing:2px;color:var(--gold);margin-bottom:10px;}
        .page-title{font-family:'Playfair Display',serif;font-size:2.4rem;font-weight:700;color:#fff;margin-bottom:10px;}
        .page-subtitle{font-size:1rem;color:rgba(255,255,255,0.65);}
        .balance-hero{display:inline-flex;align-items:center;gap:10px;background:rgba(212,168,67,0.15);border:1px solid rgba(212,168,67,0.3);border-radius:12px;padding:12px 20px;margin-top:20px;}
        .balance-hero-label{font-size:0.82rem;color:rgba(255,255,255,0.65);}
        .balance-hero-val{font-size:1.4rem;font-weight:700;color:var(--gold);}

        .main-wrap{padding:40px 80px 80px;}
        .pay-card{background:#fff;border-radius:20px;box-shadow:0 8px 40px rgba(108,63,197,0.1);overflow:hidden;max-width:860px;margin:0 auto;}
        .pay-tabs{display:flex;border-bottom:1px solid var(--border);}
        .pay-tab{flex:1;display:flex;align-items:center;justify-content:center;gap:8px;padding:18px;font-size:0.9rem;font-weight:700;color:var(--muted);cursor:pointer;border-bottom:3px solid transparent;background:none;border-left:none;border-right:none;border-top:none;font-family:'DM Sans',sans-serif;transition:all 0.15s;}
        .pay-tab:hover{color:var(--purple);background:var(--purple-light);}
        .pay-tab.active{color:var(--purple);border-bottom-color:var(--purple);background:var(--purple-light);}
        .tab-body{padding:36px;}
        .tab-pane{display:none;}
        .tab-pane.active{display:block;}

        .sec-label{font-size:0.78rem;font-weight:700;text-transform:uppercase;letter-spacing:1px;color:var(--muted);margin-bottom:12px;}
        .amount-grid{display:grid;grid-template-columns:repeat(4,1fr);gap:10px;margin-bottom:20px;}
        .amount-chip{padding:12px;border:1.5px solid var(--border);border-radius:10px;text-align:center;font-size:0.88rem;font-weight:700;color:var(--purple);cursor:pointer;transition:all 0.15s;background:#fff;}
        .amount-chip:hover{border-color:var(--purple);background:var(--purple-light);}
        .amount-chip.selected{border-color:var(--purple);background:var(--purple);color:#fff;}
        .inp-wrap{display:flex;align-items:center;border:1.5px solid var(--border);border-radius:10px;overflow:hidden;margin-bottom:24px;}
        .inp-wrap:focus-within{border-color:var(--purple);box-shadow:0 0 0 3px rgba(108,63,197,0.12);}
        .inp-pre{padding:13px 16px;background:var(--bg);color:var(--muted);font-size:0.88rem;font-weight:600;border-right:1px solid var(--border);}
        .inp-wrap input{flex:1;border:none;outline:none;padding:13px 16px;font-size:1rem;font-weight:700;color:var(--text);font-family:'DM Sans',sans-serif;}
        .inp-suf{padding:13px 16px;color:var(--muted);font-size:0.82rem;font-weight:600;}

        .btn-momo{width:100%;padding:15px;border-radius:12px;border:none;background:linear-gradient(135deg,#A50064,#D41977);color:#fff;font-size:1rem;font-weight:700;cursor:pointer;font-family:'DM Sans',sans-serif;display:flex;align-items:center;justify-content:center;gap:10px;transition:all 0.15s;}
        .btn-momo:hover{transform:translateY(-1px);box-shadow:0 8px 24px rgba(165,0,100,0.4);}
        .btn-genqr{width:100%;padding:14px;border-radius:12px;border:none;background:linear-gradient(135deg,var(--purple),var(--purple-dark));color:#fff;font-size:0.95rem;font-weight:700;cursor:pointer;font-family:'DM Sans',sans-serif;display:flex;align-items:center;justify-content:center;gap:8px;transition:all 0.15s;margin-bottom:16px;}
        .btn-genqr:hover:not(:disabled){transform:translateY(-1px);box-shadow:0 6px 20px rgba(108,63,197,0.4);}
        .btn-genqr:disabled{opacity:0.5;cursor:not-allowed;}
        .btn-paid{width:100%;padding:14px;border-radius:12px;border:none;background:linear-gradient(135deg,#2E7D32,#388E3C);color:#fff;font-size:0.95rem;font-weight:700;cursor:pointer;font-family:'DM Sans',sans-serif;display:flex;align-items:center;justify-content:center;gap:8px;transition:all 0.15s;margin-top:14px;}
        .btn-paid:hover:not(:disabled){transform:translateY(-1px);box-shadow:0 6px 20px rgba(46,125,50,0.4);}
        .btn-paid:disabled{opacity:0.6;cursor:not-allowed;}

        .qr-layout{display:grid;grid-template-columns:1fr 1fr;gap:36px;align-items:start;}
        .bank-grid{display:grid;grid-template-columns:1fr 1fr;gap:10px;margin-bottom:20px;}
        .bank-opt{padding:11px 14px;border:1.5px solid var(--border);border-radius:10px;cursor:pointer;display:flex;align-items:center;gap:8px;font-size:0.82rem;font-weight:600;color:var(--text);transition:all 0.15s;}
        .bank-opt:hover{border-color:var(--purple);}
        .bank-opt.selected{border-color:var(--purple);background:var(--purple-light);color:var(--purple);}
        .bank-tag{width:32px;height:32px;border-radius:6px;background:var(--purple-light);display:flex;align-items:center;justify-content:center;font-size:0.58rem;font-weight:700;color:var(--purple);flex-shrink:0;}

        .qr-box{background:var(--bg);border:1.5px solid var(--border);border-radius:16px;padding:24px;width:100%;text-align:center;min-height:280px;display:flex;flex-direction:column;align-items:center;justify-content:center;}
        #qrPlaceholder i{font-size:3rem;opacity:0.25;display:block;margin-bottom:10px;}
        #qrPlaceholder p{font-size:0.82rem;color:var(--muted);line-height:1.6;}
        #qrResult{display:none;flex-direction:column;align-items:center;}
        #qrImage{width:200px;height:200px;border-radius:10px;}
        .qr-amt{font-size:1.1rem;font-weight:700;color:var(--purple);margin-top:10px;}
        .qr-oid{font-size:0.72rem;font-weight:700;color:var(--muted);background:#fff;border:1px solid var(--border);border-radius:6px;padding:3px 10px;margin-top:6px;}

        .waiting-box{display:none;background:#E8F5E9;border:1.5px solid #A5D6A7;border-radius:14px;padding:20px;text-align:center;margin-top:14px;}
        .waiting-box .w-icon{font-size:2rem;margin-bottom:6px;}
        .waiting-box .w-title{font-size:0.95rem;font-weight:700;color:#2E7D32;margin-bottom:4px;}
        .waiting-box .w-sub{font-size:0.82rem;color:#388E3C;line-height:1.6;}
        .waiting-box .w-oid{font-size:0.72rem;color:var(--muted);margin-top:8px;font-weight:700;}

        .info-box{background:var(--purple-light);border:1px solid rgba(108,63,197,0.15);border-radius:12px;padding:16px 18px;margin-top:16px;}
        .info-row{display:flex;justify-content:space-between;align-items:center;padding:7px 0;border-bottom:1px solid rgba(108,63,197,0.08);font-size:0.82rem;}
        .info-row:last-child{border-bottom:none;padding-bottom:0;}
        .info-key{color:var(--muted);font-weight:500;}
        .info-val{font-weight:700;color:var(--text);}

        .spinner{display:inline-block;width:16px;height:16px;border:2px solid rgba(255,255,255,0.4);border-top-color:#fff;border-radius:50%;animation:spin 0.7s linear infinite;}
        @keyframes spin{to{transform:rotate(360deg);}}

        footer{background:var(--purple-deep);padding:24px 80px;}
        .footer-bottom{display:flex;justify-content:space-between;align-items:center;border-top:1px solid rgba(255,255,255,0.08);padding-top:20px;font-size:0.78rem;color:rgba(255,255,255,0.35);}

        @media(max-width:768px){
            .qr-layout{grid-template-columns:1fr;}
            .main-wrap{padding:24px 16px 60px;}
            .page-header{padding:32px 20px;}
            .navbar-main{padding:0 20px;}
            .amount-grid{grid-template-columns:repeat(2,1fr);}
            .tab-body{padding:20px;}
            .dropdown-menu-custom{right:16px;}
        }
    </style>
</head>
<body>

<!-- NAVBAR -->
<nav class="navbar-main" style="position:relative;">
    <a href="homePage.jsp" class="brand">DUK<span>Academy</span></a>
    <ul class="nav-links">
        <li><a href="homePage.jsp">Trang chủ</a></li>
        <li><a href="mainController?action=ExploreCourse">Khóa học</a></li>
        <li><a href="instructors.jsp">Giảng viên</a></li>
    </ul>
    <div class="nav-right">
        <a href="paymentController" class="balance-pill">
            <i class="bi bi-wallet2"></i>
            <span class="balance-label">Số dư</span>
            <span class="balance-amount">
                <%= fmtBal(((model.UserDTO)session.getAttribute("user")).getBalance()) %> ₫
            </span>
        </a>
        <div class="user-menu" onclick="toggleDD()">
            <div class="user-avatar">${fn:substring(sessionScope.user.fullname, 0, 1)}</div>
            <span class="user-name">${sessionScope.user.fullname}</span>
            <i class="bi bi-chevron-down" style="color:rgba(255,255,255,0.6);font-size:0.75rem;"></i>
        </div>
        <div class="dropdown-menu-custom" id="userDD">
            <a href="myprofile.jsp"><i class="bi bi-person"></i> Hồ sơ của tôi</a>
            <a href="myCourses"><i class="bi bi-book"></i> Khóa học của tôi</a>
            <a href="paymentController"><i class="bi bi-wallet2"></i> Nạp tiền</a>
            <a href="Certificates.jsp"><i class="bi bi-award"></i> Chứng chỉ</a>
            <div class="divider-drop"></div>
            <a href="mainController?action=logout" class="logout-link"><i class="bi bi-box-arrow-right"></i> Đăng xuất</a>
        </div>
    </div>
</nav>

<!-- HEADER -->
<div class="page-header">
    <div class="page-header-inner">
        <div class="page-eyebrow">✦ Ví DUK Academy</div>
        <h1 class="page-title">Nạp tiền vào tài khoản</h1>
        <p class="page-subtitle">Hỗ trợ MoMo và chuyển khoản VietQR.</p>
        <div class="balance-hero">
            <i class="bi bi-wallet2" style="color:var(--gold);font-size:1.2rem;"></i>
            <div>
                <div class="balance-hero-label">Số dư hiện tại</div>
                <div class="balance-hero-val">
                    <%= fmtBal(((model.UserDTO)session.getAttribute("user")).getBalance()) %> ₫
                </div>
            </div>
        </div>
    </div>
</div>

<!-- MAIN -->
<div class="main-wrap">
    <div class="pay-card">
        <div class="pay-tabs">
            <button class="pay-tab active" onclick="switchTab('momo',this)">
                <i class="bi bi-phone"></i> MoMo
            </button>
            <button class="pay-tab" onclick="switchTab('qr',this)">
                <i class="bi bi-qr-code"></i> Chuyển khoản QR
            </button>
        </div>

        <div class="tab-body">
            <!-- TAB MOMO -->
            <div class="tab-pane active" id="tab-momo">
                <div style="max-width:440px;margin:0 auto;">
                    <p class="sec-label">Chọn số tiền nạp</p>
                    <div class="amount-grid">
                        <div class="amount-chip" onclick="pickAmt('momo',50000,this)">50.000 ₫</div>
                        <div class="amount-chip" onclick="pickAmt('momo',100000,this)">100.000 ₫</div>
                        <div class="amount-chip" onclick="pickAmt('momo',200000,this)">200.000 ₫</div>
                        <div class="amount-chip" onclick="pickAmt('momo',500000,this)">500.000 ₫</div>
                        <div class="amount-chip" onclick="pickAmt('momo',1000000,this)">1.000.000 ₫</div>
                        <div class="amount-chip" onclick="pickAmt('momo',2000000,this)">2.000.000 ₫</div>
                        <div class="amount-chip" onclick="pickAmt('momo',5000000,this)">5.000.000 ₫</div>
                        <div class="amount-chip" onclick="pickAmt('momo',0,this)">Tùy chọn</div>
                    </div>
                    <p class="sec-label">Hoặc nhập số tiền</p>
                    <div class="inp-wrap">
                        <span class="inp-pre"><i class="bi bi-cash-coin"></i></span>
                        <input type="number" id="momoAmt" placeholder="Nhập số tiền..." min="10000" step="1000" oninput="clearChips('momo')">
                        <span class="inp-suf">VNĐ</span>
                    </div>
                    <button class="btn-momo" onclick="payMomo()">
                        <i class="bi bi-phone-fill"></i> Thanh toán qua MoMo
                    </button>
                    <div class="info-box" style="margin-top:16px;">
                        <i class="bi bi-info-circle-fill" style="color:var(--purple);"></i>
                        Bạn sẽ được chuyển đến app MoMo để hoàn tất thanh toán.
                    </div>
                </div>
            </div>

            <!-- TAB VIETQR -->
            <div class="tab-pane" id="tab-qr">
                <div class="qr-layout">
                    <!-- LEFT -->
                    <div>
                        <p class="sec-label">Chọn ngân hàng</p>
                        <div class="bank-grid">
                            <div class="bank-opt selected" onclick="pickBank('BIDV',this)">
                                <div class="bank-tag">BIDV</div> BIDV
                            </div>
                            <div class="bank-opt" onclick="pickBank('VCB',this)">
                                <div class="bank-tag">VCB</div> Vietcombank
                            </div>
                            <div class="bank-opt" onclick="pickBank('TCB',this)">
                                <div class="bank-tag">TCB</div> Techcombank
                            </div>
                            <div class="bank-opt" onclick="pickBank('MB',this)">
                                <div class="bank-tag">MB</div> MB Bank
                            </div>
                        </div>

                        <p class="sec-label">Số tiền nạp</p>
                        <div class="amount-grid" style="grid-template-columns:repeat(2,1fr);">
                            <div class="amount-chip" onclick="pickAmt('qr',100000,this)">100.000 ₫</div>
                            <div class="amount-chip" onclick="pickAmt('qr',200000,this)">200.000 ₫</div>
                            <div class="amount-chip" onclick="pickAmt('qr',500000,this)">500.000 ₫</div>
                            <div class="amount-chip" onclick="pickAmt('qr',1000000,this)">1.000.000 ₫</div>
                        </div>
                        <div class="inp-wrap">
                            <span class="inp-pre"><i class="bi bi-cash-coin"></i></span>
                            <input type="number" id="qrAmt" placeholder="Nhập số tiền..." min="10000" step="1000" oninput="clearChips('qr')">
                            <span class="inp-suf">VNĐ</span>
                        </div>

                        <button class="btn-genqr" id="btnGenQR" onclick="genQR()">
                            <i class="bi bi-qr-code-scan"></i> Tạo mã QR
                        </button>

                        <div class="info-box">
                            <div class="info-row">
                                <span class="info-key"><i class="bi bi-bank"></i> Ngân hàng</span>
                                <span class="info-val" id="dispBank">BIDV</span>
                            </div>
                            <div class="info-row">
                                <span class="info-key"><i class="bi bi-credit-card"></i> Số tài khoản</span>
                                <span class="info-val">1234 5678 9012</span>
                            </div>
                            <div class="info-row">
                                <span class="info-key"><i class="bi bi-person"></i> Chủ TK</span>
                                <span class="info-val">DUK ACADEMY</span>
                            </div>
                        </div>
                    </div>

                    <!-- RIGHT -->
                    <div style="display:flex;flex-direction:column;align-items:center;">
                        <div class="qr-box">
                            <div id="qrPlaceholder">
                                <i class="bi bi-qr-code"></i>
                                <p>Chọn ngân hàng và số tiền<br>rồi bấm <strong>Tạo mã QR</strong></p>
                            </div>
                            <div id="qrResult">
                                <img id="qrImage" src="" alt="QR">
                                <div class="qr-amt" id="qrAmtLabel"></div>
                                <div class="qr-oid" id="qrOid"></div>
                            </div>
                        </div>

                        <button class="btn-paid" id="btnPaid" style="display:none;" onclick="confirmPaid()">
                            <i class="bi bi-check-circle-fill"></i> Tôi đã thanh toán
                        </button>

                        <div class="waiting-box" id="waitingBox">
                            <div class="w-icon">⏳</div>
                            <div class="w-title">Đang chờ admin xác nhận</div>
                            <div class="w-sub">Số dư sẽ được cộng sau khi admin duyệt.<br>Thường trong 5–15 phút.</div>
                            <div class="w-oid" id="waitOid"></div>
                        </div>

                        <p style="font-size:0.75rem;color:var(--muted);text-align:center;margin-top:12px;line-height:1.7;">
                            <i class="bi bi-shield-check" style="color:var(--purple);"></i>
                            Quét QR bằng app ngân hàng, sau đó bấm<br><strong>"Tôi đã thanh toán"</strong> để thông báo admin.
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- FOOTER -->
<footer>
    <div class="footer-bottom">
        <span style="font-family:'Playfair Display',serif;font-size:1.1rem;font-weight:700;color:#fff;">
            DUK<span style="color:var(--gold);">Academy</span>
        </span>
        <span>© 2026 DUK Academy. All rights reserved.</span>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    const BANKS = {
        BIDV: { id:'BIDV', acc:'1234567890',  name:'DUK ACADEMY' },
        VCB:  { id:'VCB',  acc:'9876543210',  name:'DUK ACADEMY' },
        TCB:  { id:'TCB',  acc:'1122334455',  name:'DUK ACADEMY' },
        MB:   { id:'MB',   acc:'5566778899',  name:'DUK ACADEMY' },
    };
    let selBank = 'BIDV';
    let curOrderId = null;

    function switchTab(t, el) {
        document.querySelectorAll('.pay-tab').forEach(x => x.classList.remove('active'));
        document.querySelectorAll('.tab-pane').forEach(x => x.classList.remove('active'));
        el.classList.add('active');
        document.getElementById('tab-' + t).classList.add('active');
    }

    function pickAmt(type, amt, el) {
        document.querySelectorAll(type === 'momo' ? '#tab-momo .amount-chip' : '#tab-qr .amount-chip')
                .forEach(c => c.classList.remove('selected'));
        el.classList.add('selected');
        const inp = document.getElementById(type === 'momo' ? 'momoAmt' : 'qrAmt');
        if (amt > 0) inp.value = amt;
        else { inp.value = ''; inp.focus(); }
    }
    function clearChips(type) {
        document.querySelectorAll(type === 'momo' ? '#tab-momo .amount-chip' : '#tab-qr .amount-chip')
                .forEach(c => c.classList.remove('selected'));
    }

    function pickBank(b, el) {
        document.querySelectorAll('.bank-opt').forEach(x => x.classList.remove('selected'));
        el.classList.add('selected');
        selBank = b;
        document.getElementById('dispBank').textContent = b;
        resetQR();
    }

    function payMomo() {
        const amt = parseInt(document.getElementById('momoAmt').value);
        if (!amt || amt < 10000) { alert('Vui lòng nhập số tiền tối thiểu 10.000 ₫'); return; }
        alert('Tính năng MoMo đang được phát triển. Vui lòng dùng chuyển khoản QR.');
    }

    async function genQR() {
        const amt = parseInt(document.getElementById('qrAmt').value);
        if (!amt || amt < 10000) { alert('Vui lòng nhập số tiền tối thiểu 10.000 ₫'); return; }
        const btn = document.getElementById('btnGenQR');
        btn.disabled = true;
        btn.innerHTML = '<span class="spinner"></span> Đang tạo...';
        resetQR();
        try {
            const res = await fetch('paymentController?action=createQR', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: 'amount=' + amt
            });
            const data = await res.json();
            if (data.status !== 'success') {
                alert('Lỗi: ' + (data.message || 'Không thể tạo QR'));
                return;
            }
            curOrderId = data.orderId;
            const bank = BANKS[selBank];
            const note = encodeURIComponent('NAP TIEN DUK ' + data.orderId);
            const qrUrl = 'https://img.vietqr.io/image/' + bank.id + '-' + bank.acc + '-qr_only.png'
                        + '?amount=' + amt
                        + '&addInfo=' + note
                        + '&accountName=' + encodeURIComponent(bank.name);
            const img = document.getElementById('qrImage');
            img.onload = () => {
                document.getElementById('qrPlaceholder').style.display = 'none';
                document.getElementById('qrResult').style.display = 'flex';
                document.getElementById('qrAmtLabel').textContent = amt.toLocaleString('vi-VN') + ' ₫';
                document.getElementById('qrOid').textContent = 'Ma: ' + data.orderId;
                document.getElementById('btnPaid').style.display = 'flex';
            };
            img.onerror = () => alert('Không tải được ảnh QR, vui lòng thử lại.');
            img.src = qrUrl;
        } catch(e) {
            alert('Lỗi kết nối. Vui lòng thử lại.');
        } finally {
            btn.disabled = false;
            btn.innerHTML = '<i class="bi bi-qr-code-scan"></i> Tạo mã QR';
        }
    }

    async function confirmPaid() {
        if (!curOrderId) return;
        const btn = document.getElementById('btnPaid');
        btn.disabled = true;
        btn.innerHTML = '<span class="spinner"></span> Đang gửi...';
        try {
            const res = await fetch('paymentController?action=confirmPending', {
                method: 'POST',
                headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                body: 'orderId=' + curOrderId
            });
            const data = await res.json();
            if (data.status === 'success' || data.status === 'already') {
                btn.style.display = 'none';
                document.getElementById('waitingBox').style.display = 'block';
                document.getElementById('waitOid').textContent = 'Ma giao dich: ' + curOrderId;
            } else {
                alert('Lỗi: ' + (data.message || 'Vui lòng thử lại'));
                btn.disabled = false;
                btn.innerHTML = '<i class="bi bi-check-circle-fill"></i> Tôi đã thanh toán';
            }
        } catch(e) {
            alert('Lỗi kết nối.');
            btn.disabled = false;
            btn.innerHTML = '<i class="bi bi-check-circle-fill"></i> Tôi đã thanh toán';
        }
    }

    function resetQR() {
        curOrderId = null;
        document.getElementById('qrPlaceholder').style.display = 'block';
        document.getElementById('qrResult').style.display = 'none';
        document.getElementById('btnPaid').style.display = 'none';
        document.getElementById('waitingBox').style.display = 'none';
        document.getElementById('qrImage').src = '';
    }

    function toggleDD() { document.getElementById('userDD').classList.toggle('show'); }
    document.addEventListener('click', e => {
        const m = document.querySelector('.user-menu');
        const d = document.getElementById('userDD');
        if (d && m && !m.contains(e.target) && !d.contains(e.target)) d.classList.remove('show');
    });
</script>
</body>
</html>
