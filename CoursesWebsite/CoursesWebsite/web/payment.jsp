<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="vi_VN" scope="session"/>

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
    <link href="assets/css/payment.css" rel="stylesheet" type="text/css"/>
</head>
<body>

<!-- NAVBAR -->
<nav class="navbar-main" style="position:relative;" data-userid="${sessionScope.user.userId}">
    <a href="${pageContext.request.contextPath}/homePage.jsp" class="brand">DUK<span>Academy</span></a>
    <ul class="nav-links">
        <li><a href="${pageContext.request.contextPath}/homePage.jsp">Trang chủ</a></li>
        <li><a href="${pageContext.request.contextPath}/mainController?action=ExploreCourse">Khóa học</a></li>
            <a href="${pageContext.request.contextPath}/instructors.jsp"><i class="bi bi-person-video3"></i> Giảng viên</a>
        <c:if test="${sessionScope.user.role == 1}">
                    <li><a href="adminController?action=dashboard">Administrator Manager</a></li>
        </c:if>
        <c:if test="${sessionScope.user.role == 2}">
            <li><a href="${pageContext.request.contextPath}/instructorController?action=dashboard">Instructor Manager</a></li>
        </c:if>
        <li><a href="${pageContext.request.contextPath}/about.jsp">Thông tin Chung</a></li>
    </ul>
    <div class="nav-right">
        <%-- BALANCE PILL --%>
        <a href="${pageContext.request.contextPath}/mainController?action=payment" class="balance-pill">
            <i class="bi bi-wallet2"></i>
            <span class="balance-label">Số dư</span>
            <span class="balance-amount">
                <fmt:formatNumber value="${sessionScope.user.balance != null ? sessionScope.user.balance : 0}"
                                  type="number" maxFractionDigits="0"/> ₫
            </span>
        </a>
        <%-- WISHLIST PILL --%>
        <div class="wishlist-pill-wrap" id="wishlistWrap">
            <div class="wishlist-pill" onclick="toggleWishlistDD(event)">
                <i class="bi bi-heart-fill"></i>
                <span class="wishlist-pill-label">Yêu thích</span>
                <span class="wishlist-pill-count" id="wishCount">
                    ${not empty WISHLIST_IDS ? WISHLIST_IDS.size() : 0}
                </span>
            </div>
            <div class="wishlist-dropdown" id="wishlistDD">
                <div class="wishlist-dd-header">
                    <span class="wishlist-dd-title">
                        <i class="bi bi-heart-fill"></i> Khóa học yêu thích
                    </span>
                    <a href="${pageContext.request.contextPath}/wishlistController?action=view&userId=${sessionScope.user.userId}"
                       class="wishlist-dd-link">Xem tất cả</a>
                </div>
                <div class="wishlist-dd-list" id="wishlistDDList">
                    <c:choose>
                        <c:when test="${not empty WISHLIST_COURSES}">
                            <c:forEach var="wc" items="${WISHLIST_COURSES}">
                                <div class="wishlist-dd-item" id="wish-item-${wc.courseId}">
                                    <div class="wishlist-dd-thumb">
                                        <img src="${pageContext.request.contextPath}/img/courses/course${wc.courseId}.jpg"
                                             alt="${wc.courseName}" onerror="this.style.display='none';">
                                    </div>
                                    <div class="wishlist-dd-info">
                                        <div class="wishlist-dd-name">${wc.courseName}</div>
                                        <div class="wishlist-dd-price">
                                            <c:choose>
                                                <c:when test="${wc.fee == 0}">Miễn phí</c:when>
                                                <c:otherwise>
                                                    <fmt:formatNumber value="${wc.fee}" type="number"
                                                                      maxFractionDigits="0"/> ₫
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                    <button class="wishlist-dd-remove" title="Xóa khỏi yêu thích"
                                            onclick="removeWishItem(event, '${wc.courseId}')">
                                        <i class="bi bi-x"></i>
                                    </button>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="wishlist-dd-empty">
                                <i class="bi bi-heart"></i> Chưa có khóa học yêu thích
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
        <%-- USER MENU --%>
        <div class="user-menu" onclick="toggleDD()">
            <div class="user-avatar">${fn:substring(sessionScope.user.fullname, 0, 1)}</div>
            <span class="user-name">${sessionScope.user.fullname}</span>
            <i class="bi bi-chevron-down" style="color:rgba(255,255,255,0.6);font-size:0.75rem;"></i>
        </div>
        <div class="dropdown-menu-custom" id="userDD">
            <a href="${pageContext.request.contextPath}/user/myprofile.jsp"><i class="bi bi-person"></i> Hồ sơ của tôi</a>
            <a href="${pageContext.request.contextPath}/mainController?action=myCourses"><i class="bi bi-book"></i> Khóa học của tôi</a>
            <a href="${pageContext.request.contextPath}/mainController?action=payment"><i class="bi bi-wallet2"></i> Nạp tiền</a>
            <a href="${pageContext.request.contextPath}/mainController?action=myCertificates"><i class="bi bi-award"></i> Chứng chỉ</a>
            <a href="${pageContext.request.contextPath}/wishlistController?action=view&userId=${sessionScope.user.userId}">
                <i class="bi bi-heart"></i> Yêu thích
            </a>
            <div class="divider-drop"></div>
            <a href="${pageContext.request.contextPath}/mainController?action=logout" class="logout-link">
                <i class="bi bi-box-arrow-right"></i> Đăng xuất
            </a>
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
                    <fmt:formatNumber value="${sessionScope.user.balance != null ? sessionScope.user.balance : 0}"
                                      type="number" maxFractionDigits="0"/> ₫
                </div>
            </div>
        </div>
    </div>
</div>

<!-- MAIN -->
<div class="main-wrap">
    <div class="pay-card">
        <div class="pay-tabs">
            <%-- Tab MoMo: chỉ active khi chưa có QR và chưa confirm --%>
            <button class="pay-tab ${empty qrUrl and not waitingConfirm ? 'active' : ''}"
                    onclick="switchTab('momo',this)">
                <i class="bi bi-phone"></i> MoMo
            </button>
            <%-- Tab QR: active khi có QR hoặc đã confirm --%>
            <button class="pay-tab ${not empty qrUrl or waitingConfirm ? 'active' : ''}"
                    onclick="switchTab('qr',this)">
                <i class="bi bi-qr-code"></i> Chuyển khoản QR
            </button>
        </div>
        <div class="tab-body">

            <!-- TAB MOMO -->
            <div class="tab-pane ${empty qrUrl and not waitingConfirm ? 'active' : ''}" id="tab-momo">
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
            <div class="tab-pane ${not empty qrUrl or waitingConfirm ? 'active' : ''}" id="tab-qr">
                <div class="qr-layout">

                    <!-- CỘT TRÁI -->
                    <div>
                        <p class="sec-label">Ngân hàng nhận</p>
                        <div class="bank-grid">
                            <div class="bank-opt selected">
                                <div class="bank-tag">MB</div> MB Bank
                            </div>
                        </div>

                        <form action="mainController" method="post" id="formGenQR">
                            <input type="hidden" name="action" value="createQR"/>
                            <input type="hidden" name="bank"   value="MB"/>

                            <p class="sec-label">Số tiền nạp</p>
                            <div class="amount-grid" style="grid-template-columns:repeat(2,1fr);">
                                <div class="amount-chip ${qrAmount == 100000 ? 'selected' : ''}"
                                     onclick="pickAmt('qr',100000,this)">100.000 ₫</div>
                                <div class="amount-chip ${qrAmount == 200000 ? 'selected' : ''}"
                                     onclick="pickAmt('qr',200000,this)">200.000 ₫</div>
                                <div class="amount-chip ${qrAmount == 500000 ? 'selected' : ''}"
                                     onclick="pickAmt('qr',500000,this)">500.000 ₫</div>
                                <div class="amount-chip ${qrAmount == 1000000 ? 'selected' : ''}"
                                     onclick="pickAmt('qr',1000000,this)">1.000.000 ₫</div>
                            </div>
                            <div class="inp-wrap">
                                <span class="inp-pre"><i class="bi bi-cash-coin"></i></span>
                                <input type="number" name="amount" id="qrAmt"
                                       placeholder="Nhập số tiền..." min="10000" step="1000"
                                       value="${not empty qrAmount ? qrAmount : ''}"
                                       oninput="clearChips('qr')"/>
                                <span class="inp-suf">VNĐ</span>
                            </div>

                            <c:if test="${not empty payError}">
                                <div class="pay-error">
                                    <i class="bi bi-exclamation-circle-fill"></i> ${payError}
                                </div>
                            </c:if>

                            <button type="submit" class="btn-genqr">
                                <i class="bi bi-qr-code-scan"></i> Tạo mã QR
                            </button>
                        </form>

                        <div class="info-box">
                            <div class="info-row">
                                <span class="info-key"><i class="bi bi-bank"></i> Ngân hàng</span>
                                <span class="info-val">MB Bank</span>
                            </div>
                            <div class="info-row">
                                <span class="info-key"><i class="bi bi-credit-card"></i> Số tài khoản</span>
                                <span class="info-val">0332144439</span>
                            </div>
                            <div class="info-row">
                                <span class="info-key"><i class="bi bi-person"></i> Chủ TK</span>
                                <span class="info-val">LE HOANG KHANG</span>
                            </div>
                        </div>
                    </div>

                    <!-- CỘT PHẢI -->
                    <div style="display:flex;flex-direction:column;align-items:center;">
                        <div class="qr-box">
                            <c:choose>
                                <c:when test="${not empty qrUrl}">
                                    <img src="${qrUrl}" alt="QR MB Bank"
                                         style="width:200px;height:200px;border-radius:10px;"/>
                                    <div class="qr-amt">
                                        <fmt:formatNumber value="${qrAmount}" type="number"
                                                          maxFractionDigits="0"/> ₫
                                    </div>
                                    <div class="qr-oid">Mã: ${orderId}</div>
                                </c:when>
                                <c:otherwise>
                                    <i class="bi bi-qr-code"
                                       style="font-size:3rem;opacity:0.25;display:block;margin-bottom:10px;"></i>
                                    <p style="font-size:0.82rem;color:var(--muted);line-height:1.6;">
                                        Nhập số tiền rồi bấm<br><strong>Tạo mã QR</strong>
                                    </p>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <%-- Nút "Đã thanh toán": chỉ hiện khi có QR và chưa confirm --%>
                        <c:if test="${not empty qrUrl and not waitingConfirm}">
                            <form action="mainController" method="post" style="width:100%;margin-top:14px;">
                                <input type="hidden" name="action"  value="confirmPending"/>
                                <input type="hidden" name="orderId" value="${orderId}"/>
                                <button type="submit" class="btn-paid">
                                    <i class="bi bi-check-circle-fill"></i> Tôi đã thanh toán
                                </button>
                            </form>
                        </c:if>

                        <%-- Waiting box: hiện sau khi confirmPending --%>
                        <c:if test="${waitingConfirm == true}">
                            <div class="waiting-box">
                                <div class="w-icon">⏳</div>
                                <div class="w-title">Đang chờ admin xác nhận</div>
                                <div class="w-sub">Số dư sẽ được cộng sau khi admin duyệt.<br>Thường trong 5–15 phút.</div>
                                <div class="w-oid">Mã giao dịch: ${confirmedOrderId}</div>
                            </div>
                        </c:if>

                        <p style="font-size:0.75rem;color:var(--muted);text-align:center;margin-top:12px;line-height:1.7;">
                            <i class="bi bi-shield-check" style="color:var(--purple);"></i>
                            Quét QR bằng app ngân hàng, sau đó bấm<br>
                            <strong>"Tôi đã thanh toán"</strong> để thông báo admin.
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
<script src="assets/js/payment.js" type="text/javascript"></script>
</body>
</html>
