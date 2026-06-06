<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core"      prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt"       prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<fmt:setLocale value="vi_VN"/>

<c:if test="${empty sessionScope.user}">
    <c:redirect url="login.jsp"/>
</c:if>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Yêu thích - DUK Academy</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&family=DM+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
        <link rel="icon" type="image/jpeg" href="img/page/favicon.jpg">
        <link href="${pageContext.request.contextPath}/assets/css/userCss/wishlist.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>

        <div class="toast-noti" id="toastNoti">
            <i class="bi bi-trash3-fill"></i>
            <span id="toastMsg">Đã xóa khỏi danh sách yêu thích</span>
        </div>

        <!-- NAVBAR -->
        <nav class="navbar-main" style="position:relative;">
            <a href="${pageContext.request.contextPath}/homePage.jsp" class="brand">DUK<span>Academy</span></a>
            <ul class="nav-links">
                <li><a href="${pageContext.request.contextPath}/homePage.jsp">Trang chủ</a></li>
                <li><a href="${pageContext.request.contextPath}/courseController?action=ExploreCourse">Khóa học</a></li>
                <li><a href="${pageContext.request.contextPath}/instructors.jsp">Giảng viên</a></li>
                    <c:if test="${sessionScope.user.role == 1}">
                    <li><a href="adminController?action=dashboard">Administrator Manager</a></li>
                    </c:if>
                    <c:if test="${sessionScope.user != null && sessionScope.user.role == 2}">
                    <li><a href="${pageContext.request.contextPath}/instructorController?action=dashboard">Instructor Manager</a></li>
                    </c:if>
                <li><a href="${pageContext.request.contextPath}/about.jsp">Thông tin Chung</a></li>
            </ul>

            <div class="nav-right">
                <a href="${pageContext.request.contextPath}/paymentController" class="balance-pill">
                    <i class="bi bi-wallet2"></i>
                    <span class="balance-label">Số dư</span>
                    <span class="balance-amount">
                        <fmt:formatNumber value="${sessionScope.user.balance != null ? sessionScope.user.balance : 0}"
                                          type="number" maxFractionDigits="0"/> ₫
                    </span>
                </a>

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
                            <%-- FIX: bỏ userId --%>
                            <a href="${pageContext.request.contextPath}/wishlistController?action=view"
                               class="wishlist-dd-link">Xem tất cả</a>
                        </div>
                        <div class="wishlist-dd-list" id="wishlistDDList">
                            <c:choose>
                                <c:when test="${not empty WISHLIST_COURSES}">
                                    <c:forEach var="wc" items="${WISHLIST_COURSES}">
                                        <div class="wishlist-dd-item" id="wish-item-${wc.courseId}">
                                            <div class="wishlist-dd-thumb">
                                                <c:choose>
                                                    <c:when test="${not empty wc.img}">
                                                        <img src="${pageContext.request.contextPath}/${wc.img}"
                                                             alt="${wc.courseName}" onerror="this.style.display='none';">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <img src="${pageContext.request.contextPath}/img/courses/course${wc.courseId}.jpg"
                                                             alt="${wc.courseName}" onerror="this.style.display='none';">
                                                    </c:otherwise>
                                                </c:choose>
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
                                            <%-- FIX: dùng data-* --%>
                                            <button class="wishlist-dd-remove" title="Xóa khỏi yêu thích"
                                                    data-courseid="${wc.courseId}"
                                                    onclick="removeWishItem(event, this)">
                                                <i class="bi bi-x"></i>
                                            </button>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <div class="wishlist-dd-empty" id="wishEmptyMsg">
                                        <i class="bi bi-heart"></i>
                                        Chưa có khóa học yêu thích
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>

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
                    <a href="${pageContext.request.contextPath}/wishlistController?action=view">
                        <i class="bi bi-heart"></i> Yêu thích
                    </a>
                    <div class="divider-drop"></div>
                    <a href="${pageContext.request.contextPath}/mainController?action=logout" class="logout-link">
                        <i class="bi bi-box-arrow-right"></i> Đăng xuất
                    </a>
                </div>
            </div>
        </nav>

        <!-- PAGE HEADER -->
        <div class="page-header">
            <div class="header-hearts">
                <span>♥</span><span>♥</span><span>♥</span><span>♥</span><span>♥</span>
            </div>
            <div class="page-header-inner">
                <div class="page-eyebrow">
                    <i class="bi bi-heart-fill" style="color:#FF6B6B;"></i>
                    Danh sách yêu thích
                </div>
                <h1 class="page-title">
                    <i class="bi bi-heart-fill heart-icon"></i>
                    Khóa học của tôi
                </h1>
                <p class="page-subtitle">Những khóa học bạn đã lưu lại — sẵn sàng để bắt đầu bất cứ lúc nào.</p>
                <div class="header-stat">
                    <span class="header-stat-num" id="statNum">${not empty wishlist ? fn:length(wishlist) : 0}</span>
                    <span class="header-stat-lbl">khóa học đang chờ bạn</span>
                </div>
            </div>
        </div>

        <!-- MAIN -->
        <div class="main-wrap">
            <div class="list-topbar">
                <div class="list-title">
                    <i class="bi bi-heart-fill"></i>
                    Tất cả khóa học yêu thích
                </div>
                <a href="${pageContext.request.contextPath}/homePage.jsp" class="btn-back">
                    <i class="bi bi-arrow-left"></i> Về trang chủ
                </a>
            </div>

            <c:choose>
                <c:when test="${not empty wishlist}">
                    <div class="wishlist-list" id="wishlistList">
                        <c:forEach var="w" items="${wishlist}" varStatus="st">

                            <c:set var="isEnrolled" value="false"/>
                            <c:forEach var="eid" items="${enrolledIds}">
                                <c:if test="${eid == w.courseId}">
                                    <c:set var="isEnrolled" value="true"/>
                                </c:if>
                            </c:forEach>

                            <c:set var="courseFee"  value="${not empty feeMap[w.courseId] ? feeMap[w.courseId] : 0}"/>
                            <%-- FIX: dùng courseNameMap thay vì courseNameMap trống --%>
                            <c:set var="courseName" value="${not empty courseNameMap[w.courseId] ? courseNameMap[w.courseId] : 'Khóa học #'.concat(w.courseId)}"/>

                            <div class="wish-card" id="card-${w.wishlistId}"
                                 style="animation-delay:${st.index * 0.06}s">

                                <div class="wish-card-thumb">
                                    <c:choose>
                                        <c:when test="${not empty imgMap[w.courseId]}">
                                            <img src="${pageContext.request.contextPath}/${imgMap[w.courseId]}"
                                                 alt="Course ${w.courseId}" onerror="this.style.display='none';">
                                        </c:when>
                                        <c:otherwise>
                                            <img src="${pageContext.request.contextPath}/img/courses/course${w.courseId}.jpg"
                                                 alt="Course ${w.courseId}" onerror="this.style.display='none';">
                                        </c:otherwise>
                                    </c:choose>
                                    <div class="thumb-overlay"></div>
                                </div>

                                <div class="wish-card-info">
                                    <div class="wish-card-meta">
                                        <i class="bi bi-building"></i> DUK Academy
                                    </div>
                                    <div class="wish-card-name">${courseName}</div>
                                    <div class="wish-card-details">
                                        <span class="wish-card-badge badge-id">
                                            <i class="bi bi-hash"></i> ID: ${w.wishlistId}
                                        </span>
                                        <span class="wish-card-badge badge-date">
                                            <i class="bi bi-calendar3"></i>
                                            <fmt:formatDate value="${w.createdAt}" pattern="dd/MM/yyyy"/>
                                        </span>
                                        <span class="wish-card-badge badge-date"
                                              style="background:#EFF6FF;color:#1D4ED8;">
                                            <i class="bi bi-clock"></i>
                                            <fmt:formatDate value="${w.createdAt}" pattern="HH:mm"/>
                                        </span>
                                        <span class="wish-card-badge"
                                              style="background:var(--purple-light);color:var(--purple);">
                                            <i class="bi bi-tag"></i>
                                            <c:choose>
                                                <c:when test="${courseFee == 0}">Miễn phí</c:when>
                                                <c:otherwise>
                                                    <fmt:formatNumber value="${courseFee}" type="number"
                                                                      maxFractionDigits="0"/> ₫
                                                </c:otherwise>
                                            </c:choose>
                                        </span>
                                    </div>
                                </div>

                                <div class="wish-card-actions">
                                    <c:choose>
                                        <c:when test="${isEnrolled == 'true'}">
                                            <a href="${pageContext.request.contextPath}/courseController?action=lesson&courseId=${w.courseId}" class="btn-study">
                                                <i class="bi bi-play-circle-fill"></i> Học ngay
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <button type="button" class="btn-enroll"
                                                    onclick="openModal(
                                                                    '${w.courseId}',
                                                                    '${fn:escapeXml(courseName)}',
                                                                    '${courseFee}',
                                                                    '${sessionScope.user.balance}')">
                                                <i class="bi bi-cart3"></i> Đăng ký học
                                            </button>
                                        </c:otherwise>
                                    </c:choose>

                                    <%-- FIX: dùng data-* thay vì inline href --%>
                                    <button type="button" class="btn-remove"
                                            data-wishid="${w.wishlistId}"
                                            data-courseid="${w.courseId}"
                                            onclick="confirmRemove(this)">
                                        <i class="bi bi-trash3"></i> Xóa
                                    </button>
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <div style="text-align:center;margin-top:40px;padding-top:32px;border-top:1px solid var(--border);">
                        <p style="font-size:0.875rem;color:var(--muted);margin-bottom:16px;">
                            Khám phá thêm khóa học mới?
                        </p>
                        <a href="${pageContext.request.contextPath}/courseController?action=ExploreCourse" class="btn-explore">
                            <i class="bi bi-compass"></i> Khám phá khóa học
                        </a>
                    </div>
                </c:when>

                <c:otherwise>
                    <div class="empty-wrap">
                        <span class="empty-heart">🤍</span>
                        <div class="empty-title">Chưa có khóa học yêu thích</div>
                        <p class="empty-sub">Hãy thêm những khóa học bạn quan tâm để dễ dàng tìm lại sau này.</p>
                        <a href="${pageContext.request.contextPath}/courseController?action=ExploreCourse" class="btn-explore">
                            <i class="bi bi-compass"></i> Khám phá khóa học ngay
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <footer>
            <div class="inner">
                <span style="font-family:'Playfair Display',serif;font-size:1.2rem;font-weight:700;color:#fff;">
                    DUK<span style="color:var(--gold);">Academy</span>
                </span>
                <span style="font-size:0.78rem;color:rgba(255,255,255,0.35);">
                    © 2026 DUK Academy. All rights reserved.
                </span>
            </div>
        </footer>

        <!-- MODAL ĐĂNG KÝ -->
        <div class="modal-overlay" id="enrollModal" onclick="closeModalOutside(event)">
            <div class="modal-box">
                <div class="modal-icon">🎓</div>
                <div class="modal-title">Xác nhận đăng ký</div>
                <div class="modal-course-name" id="modalCourseName">—</div>
                <div class="modal-info-row">
                    <span class="modal-info-label"><i class="bi bi-tag-fill"></i> Học phí</span>
                    <span class="modal-info-value fee-val" id="modalFee">—</span>
                </div>
                <div class="modal-info-row">
                    <span class="modal-info-label"><i class="bi bi-wallet2"></i> Số dư hiện tại</span>
                    <span class="modal-info-value balance-val" id="modalBalance">—</span>
                </div>
                <div class="modal-divider"></div>
                <div class="modal-info-row">
                    <span class="modal-info-label">
                        <i class="bi bi-arrow-right-circle-fill"></i> Số dư sau đăng ký
                    </span>
                    <span class="modal-info-value after-val" id="modalAfter">—</span>
                </div>
                <div class="modal-warning" id="modalWarning">
                    <i class="bi bi-exclamation-triangle-fill"></i>
                    Số dư không đủ!
                    <a href="${pageContext.request.contextPath}/mainController?action=payment" style="color:#C62828;font-weight:700;">Nạp tiền ngay →</a>
                </div>
                <form action="courseController" method="post">
                    <input type="hidden" name="action" value="enroll">
                    <input type="hidden" name="courseId" id="modalCourseId">
                    <div class="modal-actions">
                        <button type="button" class="btn-cancel" onclick="closeModal()">
                            <i class="bi bi-x-circle"></i> Hủy
                        </button>
                        <button type="submit" class="btn-confirm" id="btnConfirm">
                            <i class="bi bi-check-circle-fill"></i> Xác nhận đăng ký
                        </button>
                    </div>
                </form>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/wishlist.js" type="text/javascript"></script>

    </body>
</html>
