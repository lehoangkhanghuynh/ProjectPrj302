<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<fmt:setLocale value="vi_VN" scope="session"/>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Khóa học - DUK Academy</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&family=DM+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/assets/css/listCourse.css" rel="stylesheet" type="text/css"/>
        <link rel="icon" type="favicon" href="img/page/favicon.jpg">
    </head>
    <body>

        <%-- Toast & Loading --%>
        <div class="toast-noti" id="toastNoti">
            <i class="bi bi-heart-fill"></i>
            <span id="toastMsg">Đã thêm vào mục yêu thích</span>
        </div>
        <div class="enroll-loading" id="enrollLoading">
            <div class="enroll-spinner"></div>
            <div class="enroll-loading-text">Đang đăng ký khóa học...</div>
        </div>

        <%-- Inject server-side data cho JS --%>
        <input type="hidden" id="currentUserId"  value="${sessionScope.user.userId}">
        <input type="hidden" id="contextPath"    value="${pageContext.request.contextPath}">
        <input type="hidden" id="userBalance"    value="${sessionScope.user.balance}">
        <input type="hidden" id="paymentUrl"     value="${pageContext.request.contextPath}/paymentController">

        <!-- NAVBAR -->
        <nav class="navbar-main" style="position:relative;">
            <a href="${pageContext.request.contextPath}/homePage.jsp" class="brand">DUK<span>Academy</span></a>
            <ul class="nav-links">
                <li><a href="${pageContext.request.contextPath}/homePage.jsp">Trang chủ</a></li>
                <li><a href="${pageContext.request.contextPath}/courseController?action=ExploreCourse" class="active">Khóa học</a></li>
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
                <c:if test="${not empty sessionScope.user}">
                    <a href="${pageContext.request.contextPath}/paymentController" class="balance-pill">
                        <i class="bi bi-wallet2"></i>
                        <span class="balance-label">Số dư</span>
                        <span class="balance-amount">
                            <fmt:formatNumber value="${sessionScope.user.balance}" type="number"/> ₫
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
                                <a href="${pageContext.request.contextPath}/wishlistController?action=view"
                                   class="wishlist-dd-link">Xem tất cả</a>
                            </div>
                            <div class="wishlist-dd-list" id="wishlistDDList">
                                <c:choose>
                                    <c:when test="${not empty WISHLIST_COURSES}">
                                        <c:forEach var="wc" items="${WISHLIST_COURSES}">
                                            <div class="wishlist-dd-item" id="wish-item-${wc.courseId}">
                                                <div class="wishlist-dd-thumb">
                                                    <c:if test="${not empty wc.img}">
                                                        <img src="${pageContext.request.contextPath}/${wc.img}"
                                                             alt="${wc.courseName}"
                                                             onerror="this.style.display='none';">
                                                    </c:if>
                                                </div>
                                                <div class="wishlist-dd-info">
                                                    <div class="wishlist-dd-name">${wc.courseName}</div>
                                                    <div class="wishlist-dd-price">
                                                        <c:choose>
                                                            <c:when test="${wc.fee == 0}">Miễn phí</c:when>
                                                            <c:otherwise>
                                                                <fmt:formatNumber value="${wc.fee}" type="number"/> ₫
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </div>
                                                </div>
                                                <button class="wishlist-dd-remove"
                                                        title="Xóa khỏi yêu thích"
                                                        data-courseid="${wc.courseId}"
                                                        data-name="${fn:escapeXml(wc.courseName)}"
                                                        data-fee="${wc.fee}"
                                                        onclick="handleDDRemove(event, this)">
                                                    <i class="bi bi-x"></i>
                                                </button>
                                            </div>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="wishlist-dd-empty" id="wishEmptyMsg">
                                            <i class="bi bi-heart"></i> Chưa có khóa học yêu thích
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </c:if>

                <%-- USER MENU --%>
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <div class="user-menu" onclick="toggleDropdown()">
                            <div class="user-avatar">${fn:substring(sessionScope.user.fullname, 0, 1)}</div>
                            <span class="user-name">${sessionScope.user.fullname}</span>
                            <i class="bi bi-chevron-down" style="color:rgba(255,255,255,0.6);font-size:0.75rem;"></i>
                        </div>
                        <div class="dropdown-menu-custom" id="userDropdown">
                            <a href="${pageContext.request.contextPath}/user/myprofile.jsp"><i class="bi bi-person"></i> Hồ sơ của tôi</a>
                            <a href="${pageContext.request.contextPath}/mainController?action=myCourses"><i class="bi bi-book"></i> Khóa học của tôi</a>
                            <a href="paymentController"><i class="bi bi-wallet2"></i> Nạp tiền</a>
                            <a href="${pageContext.request.contextPath}/mainController?action=myCertificates"><i class="bi bi-award"></i> Chứng chỉ</a>
                            <a href="${pageContext.request.contextPath}/wishlistController?action=view"><i class="bi bi-heart"></i> Yêu thích</a>
                            <div class="divider-drop"></div>
                            <a href="${pageContext.request.contextPath}/mainController?action=logout" class="logout-link">
                                <i class="bi bi-box-arrow-right"></i> Đăng xuất
                            </a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/login.jsp"
                           style="color:rgba(255,255,255,0.75);text-decoration:none;font-size:0.875rem;font-weight:500;">
                            Đăng nhập
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>
        </nav>

        <!-- PAGE HEADER -->
        <div class="page-header">
            <div class="page-header-inner">
                <div class="page-eyebrow">✦ Thư viện khóa học</div>
                <h1 class="page-title">Khám phá & Học tập</h1>
                <p class="page-subtitle">Hàng trăm khóa học chất lượng cao từ các chuyên gia hàng đầu, học theo tốc độ của bạn.</p>
                <div class="stats-row">
                    <div class="stat-item">
                        <div class="stat-num">${not empty COURSE_LIST ? COURSE_LIST.size() : 0}+</div>
                        <div class="stat-lbl">Khóa học</div>
                    </div>
                    <div class="stat-item"><div class="stat-num">50K+</div><div class="stat-lbl">Học viên</div></div>
                    <div class="stat-item"><div class="stat-num">4.8 ★</div><div class="stat-lbl">Đánh giá TB</div></div>
                </div>
            </div>
        </div>

        <!-- SEARCH BAR -->
        <div class="search-bar-wrap">
            <form class="search-bar" action="${pageContext.request.contextPath}/courseController" method="get">
                <input type="hidden" name="action" value="ExploreCourse"/>
                <i class="bi bi-search" style="cursor:pointer;" onclick="this.closest('form').submit()"></i>
                <input type="text" name="keyword" id="searchInput"
                       placeholder="Tìm kiếm khóa học..."
                       value="${not empty KEYWORD ? KEYWORD : ''}">
                <c:if test="${not empty KEYWORD}">
                    <a href="${pageContext.request.contextPath}/courseController?action=ExploreCourse"
                       style="color:var(--muted);text-decoration:none;font-size:1.1rem;line-height:1;"
                       title="Xóa tìm kiếm">
                        <i class="bi bi-x-circle-fill"></i>
                    </a>
                </c:if>
            </form>
        </div>

        <!-- FILTER BAR -->
        <div class="filter-bar">
            <span class="filter-label"><i class="bi bi-funnel"></i> Lọc:</span>
            <span class="filter-chip active" onclick="filterByTopic(this, '')">Tất cả</span>
            <c:forEach var="cat" items="${CATEGORY_LIST}">
                <span class="filter-chip"
                      onclick="filterByTopic(this, '${fn:escapeXml(fn:toLowerCase(cat.categoryName))}')">
                    ${cat.categoryName}
                </span>
            </c:forEach>
        </div>

        <!-- MAIN CONTENT -->
        <div class="main-content">
            <c:if test="${not empty enrollmessage}">
                <div class="alert-custom alert-error"><i class="bi bi-exclamation-circle-fill"></i> ${enrollmessage}</div>
            </c:if>
            <c:if test="${not empty msg}">
                <div class="alert-custom alert-warn"><i class="bi bi-info-circle-fill"></i> ${msg}</div>
            </c:if>

            <!-- TRENDING -->
            <div class="trending-section">
                <div class="trending-title"><i class="bi bi-fire"></i> Khóa học nổi bật</div>
                <div class="trending-grid">

                    <%-- COL 1: Phổ biến nhất --%>
                    <div class="trending-col">
                        <div class="trending-col-header">
                            <span class="trending-col-title">🏆 Phổ biến nhất</span>
                            <a href="#all-courses" class="trending-col-link">Xem tất cả <i class="bi bi-arrow-right"></i></a>
                        </div>
                        <c:forEach var="course" items="${COURSE_LIST}" begin="0" end="2">
                            <c:set var="tAvg"      value="${AVG_RATING_MAP[course.courseId]}"/>
                            <c:set var="tCount"    value="${REVIEW_COUNT_MAP[course.courseId]}"/>
                            <c:set var="tEnrolled" value="false"/>
                            <c:forEach var="eid" items="${ENROLLED_IDS}">
                                <c:if test="${eid == course.courseId}"><c:set var="tEnrolled" value="true"/></c:if>
                            </c:forEach>
                            <div class="mini-course-card"
                                 data-courseid="${course.courseId}"
                                 data-name="${fn:escapeXml(course.courseName)}"
                                 data-fee="${course.fee}"
                                 data-enrolled="${tEnrolled}"
                                 onclick="handleMiniCardClick(this)">
                                <div class="mini-thumb bg1">
                                    <c:if test="${not empty course.img}">
                                        <img src="${pageContext.request.contextPath}/${course.img}"
                                             alt="${course.courseName}" onerror="this.style.display='none';">
                                    </c:if>
                                </div>
                                <div class="mini-info">
                                    <div class="mini-org"><i class="bi bi-building"></i> DUK Academy</div>
                                    <div class="mini-name">${course.courseName}</div>
                                    <div class="mini-meta">
                                        <c:choose>
                                            <c:when test="${tCount > 0}">
                                                <span class="star-row">
                                                    <c:forEach begin="1" end="5" var="i">
                                                        <c:choose>
                                                            <c:when test="${tAvg >= i}"><span class="star-full">★</span></c:when>
                                                            <c:when test="${tAvg + 0.5 >= i}"><span class="star-half">½</span></c:when>
                                                            <c:otherwise><span class="star-empty">★</span></c:otherwise>
                                                        </c:choose>
                                                    </c:forEach>
                                                </span>
                                                <span class="rating-num">
                                                    <fmt:formatNumber value="${tAvg}" minFractionDigits="1" maxFractionDigits="1"/>
                                                </span>
                                                <span>(${tCount})</span>
                                            </c:when>
                                            <c:otherwise><span class="rating-none">Chưa có đánh giá</span></c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                                <div class="mini-price">
                                    <c:choose>
                                        <c:when test="${course.fee == 0}">Miễn phí</c:when>
                                        <c:otherwise><fmt:formatNumber value="${course.fee}" type="number"/> ₫</c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <%-- COL 2: Mới nhất --%>
                    <div class="trending-col">
                        <div class="trending-col-header">
                            <span class="trending-col-title">✨ Mới nhất</span>
                            <a href="#all-courses" class="trending-col-link">Xem tất cả <i class="bi bi-arrow-right"></i></a>
                        </div>
                        <c:forEach var="course" items="${COURSE_LIST}" begin="3" end="5">
                            <c:set var="tAvg"      value="${AVG_RATING_MAP[course.courseId]}"/>
                            <c:set var="tCount"    value="${REVIEW_COUNT_MAP[course.courseId]}"/>
                            <c:set var="tEnrolled" value="false"/>
                            <c:forEach var="eid" items="${ENROLLED_IDS}">
                                <c:if test="${eid == course.courseId}"><c:set var="tEnrolled" value="true"/></c:if>
                            </c:forEach>
                            <div class="mini-course-card"
                                 data-courseid="${course.courseId}"
                                 data-name="${fn:escapeXml(course.courseName)}"
                                 data-fee="${course.fee}"
                                 data-enrolled="${tEnrolled}"
                                 onclick="handleMiniCardClick(this)">
                                <div class="mini-thumb bg2">
                                    <c:if test="${not empty course.img}">
                                        <img src="${pageContext.request.contextPath}/${course.img}"
                                             alt="${course.courseName}" onerror="this.style.display='none';">
                                    </c:if>
                                </div>
                                <div class="mini-info">
                                    <div class="mini-org"><i class="bi bi-building"></i> DUK Academy</div>
                                    <div class="mini-name">${course.courseName}</div>
                                    <div class="mini-meta">
                                        <c:choose>
                                            <c:when test="${tCount > 0}">
                                                <span class="star-row">
                                                    <c:forEach begin="1" end="5" var="i">
                                                        <c:choose>
                                                            <c:when test="${tAvg >= i}"><span class="star-full">★</span></c:when>
                                                            <c:when test="${tAvg + 0.5 >= i}"><span class="star-half">½</span></c:when>
                                                            <c:otherwise><span class="star-empty">★</span></c:otherwise>
                                                        </c:choose>
                                                    </c:forEach>
                                                </span>
                                                <span class="rating-num">
                                                    <fmt:formatNumber value="${tAvg}" minFractionDigits="1" maxFractionDigits="1"/>
                                                </span>
                                                <span>(${tCount})</span>
                                            </c:when>
                                            <c:otherwise><span class="rating-none">Chưa có đánh giá</span></c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                                <div class="mini-price">
                                    <c:choose>
                                        <c:when test="${course.fee == 0}">Miễn phí</c:when>
                                        <c:otherwise><fmt:formatNumber value="${course.fee}" type="number"/> ₫</c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <%-- COL 3: Kỹ năng AI hot --%>
                    <div class="trending-col">
                        <div class="trending-col-header">
                            <span class="trending-col-title">🤖 Kỹ năng AI hot</span>
                            <a href="#all-courses" class="trending-col-link">Xem tất cả <i class="bi bi-arrow-right"></i></a>
                        </div>
                        <c:forEach var="course" items="${COURSE_LIST}" begin="6" end="8">
                            <c:set var="tAvg"      value="${AVG_RATING_MAP[course.courseId]}"/>
                            <c:set var="tCount"    value="${REVIEW_COUNT_MAP[course.courseId]}"/>
                            <c:set var="tEnrolled" value="false"/>
                            <c:forEach var="eid" items="${ENROLLED_IDS}">
                                <c:if test="${eid == course.courseId}"><c:set var="tEnrolled" value="true"/></c:if>
                            </c:forEach>
                            <div class="mini-course-card"
                                 data-courseid="${course.courseId}"
                                 data-name="${fn:escapeXml(course.courseName)}"
                                 data-fee="${course.fee}"
                                 data-enrolled="${tEnrolled}"
                                 onclick="handleMiniCardClick(this)">
                                <div class="mini-thumb bg3">
                                    <c:if test="${not empty course.img}">
                                        <img src="${pageContext.request.contextPath}/${course.img}"
                                             alt="${course.courseName}" onerror="this.style.display='none';">
                                    </c:if>
                                </div>
                                <div class="mini-info">
                                    <div class="mini-org"><i class="bi bi-building"></i> DUK Academy</div>
                                    <div class="mini-name">${course.courseName}</div>
                                    <div class="mini-meta">
                                        <c:choose>
                                            <c:when test="${tCount > 0}">
                                                <span class="star-row">
                                                    <c:forEach begin="1" end="5" var="i">
                                                        <c:choose>
                                                            <c:when test="${tAvg >= i}"><span class="star-full">★</span></c:when>
                                                            <c:when test="${tAvg + 0.5 >= i}"><span class="star-half">½</span></c:when>
                                                            <c:otherwise><span class="star-empty">★</span></c:otherwise>
                                                        </c:choose>
                                                    </c:forEach>
                                                </span>
                                                <span class="rating-num">
                                                    <fmt:formatNumber value="${tAvg}" minFractionDigits="1" maxFractionDigits="1"/>
                                                </span>
                                                <span>(${tCount})</span>
                                            </c:when>
                                            <c:otherwise><span class="rating-none">Chưa có đánh giá</span></c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                                <div class="mini-price">
                                    <c:choose>
                                        <c:when test="${course.fee == 0}">Miễn phí</c:when>
                                        <c:otherwise><fmt:formatNumber value="${course.fee}" type="number"/> ₫</c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                </div>
            </div>

            <!-- ALL COURSES -->
            <div id="all-courses">
                <div class="all-courses-header">
                    <div class="all-courses-title">
                        <c:choose>
                            <c:when test="${not empty KEYWORD}">
                                Kết quả tìm kiếm: "<span style="color:var(--purple)">${KEYWORD}</span>"
                            </c:when>
                            <c:otherwise>Tất cả khóa học</c:otherwise>
                        </c:choose>
                    </div>
                    <span class="course-count-badge" id="courseCount">
                        ${not empty COURSE_LIST ? COURSE_LIST.size() : 0} khóa học
                    </span>
                </div>

                <div class="course-grid-full" id="courseGrid">
                    <c:choose>
                        <c:when test="${not empty COURSE_LIST}">
                            <c:forEach var="course" items="${COURSE_LIST}" varStatus="st">
                                <c:set var="isEnrolled"  value="false"/>
                                <c:set var="isCompleted" value="false"/>
                                <c:set var="inWishlist"  value="false"/>
                                <c:if test="${not empty sessionScope.user}">
                                    <c:forEach var="eid" items="${ENROLLED_IDS}">
                                        <c:if test="${eid == course.courseId}"><c:set var="isEnrolled" value="true"/></c:if>
                                    </c:forEach>
                                    <c:forEach var="cid" items="${COMPLETED_IDS}">
                                        <c:if test="${cid == course.courseId}"><c:set var="isCompleted" value="true"/></c:if>
                                    </c:forEach>
                                    <c:forEach var="wid" items="${WISHLIST_IDS}">
                                        <c:if test="${wid == course.courseId}"><c:set var="inWishlist" value="true"/></c:if>
                                    </c:forEach>
                                </c:if>
                                <c:set var="avgRating"   value="${AVG_RATING_MAP[course.courseId]}"/>
                                <c:set var="reviewCount" value="${REVIEW_COUNT_MAP[course.courseId]}"/>
                               <c:set var="courseIdKey">${course.courseId}</c:set>
<c:set var="cardTopic" value="${COURSE_CATEGORY_MAP[courseIdKey]}"/>

                                <div class="course-card-full ${isCompleted ? 'completed' : ''}"
data-topic="${not empty cardTopic ? fn:toLowerCase(cardTopic) : ''}"
                                    data-name="${fn:toLowerCase(course.courseName)}">
                                    <div class="card-thumb bg${(st.index % 6) + 1}">
                                        <c:if test="${not empty course.img}">
                                            <img src="${pageContext.request.contextPath}/${course.img}"
                                                 alt="${course.courseName}" onerror="this.style.display='none';">
                                        </c:if>
                                        <div class="card-thumb-overlay"></div>
                                        <span class="card-topic-badge">
                                            ${not empty cardTopic ? cardTopic : course.topic}
                                        </span>
                                        <c:if test="${isCompleted}">
                                            <span class="card-completed-overlay">
                                                <i class="bi bi-trophy-fill"></i> Hoàn thành
                                            </span>
                                        </c:if>
                                        <c:if test="${not empty sessionScope.user}">
                                            <button class="btn-wishlist ${inWishlist ? 'in-wish' : ''}"
                                                    id="wish-btn-${course.courseId}"
                                                    title="${inWishlist ? 'Bỏ yêu thích' : 'Thêm yêu thích'}"
                                                    data-courseid="${course.courseId}"
                                                    data-name="${fn:escapeXml(course.courseName)}"
                                                    data-fee="${course.fee}"
                                                    onclick="toggleWishlist(event, this)">
                                                <i class="bi ${inWishlist ? 'bi-heart-fill' : 'bi-heart'}"></i>
                                            </button>
                                        </c:if>
                                    </div>

                                    <div class="card-body">
                                        <div class="card-org">DUK Academy</div>
                                        <a href="${pageContext.request.contextPath}/courseController?action=detail&courseId=${course.courseId}"
                                           class="card-name" style="text-decoration:none;color:inherit;display:block;">
                                            ${course.courseName}
                                            <span style="font-size:0.68rem;color:var(--purple);font-weight:600;display:block;margin-top:2px;">
                                                <i class="bi bi-chat-quote"></i> Xem đánh giá
                                            </span>
                                        </a>
                                        <div class="card-meta">
                                            <c:choose>
                                                <c:when test="${reviewCount > 0}">
                                                    <span class="star-row">
                                                        <c:forEach begin="1" end="5" var="i">
                                                            <c:choose>
                                                                <c:when test="${avgRating >= i}"><span class="star-full">★</span></c:when>
                                                                <c:when test="${avgRating + 0.5 >= i}"><span class="star-half">½</span></c:when>
                                                                <c:otherwise><span class="star-empty">★</span></c:otherwise>
                                                            </c:choose>
                                                        </c:forEach>
                                                    </span>
                                                    <span class="rating-num">
                                                        <fmt:formatNumber value="${avgRating}" minFractionDigits="1" maxFractionDigits="1"/>
                                                    </span>
                                                    <span class="rating-count">
                                                        (<fmt:formatNumber value="${reviewCount}" type="number"/> đánh giá)
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="rating-none"><i class="bi bi-star"></i> Chưa có đánh giá</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>

                                        <div class="card-footer-row">
                                            <c:choose>
                                                <c:when test="${isCompleted}">
                                                    <span class="card-price completed-label">
                                                        <i class="bi bi-trophy-fill"></i> Hoàn thành
                                                    </span>
                                                </c:when>
                                                <c:when test="${isEnrolled}">
                                                    <span class="card-price enrolled-label">
                                                        <i class="bi bi-check2-circle"></i> Đã đăng ký
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="card-price ${course.fee == 0 ? 'free' : ''}">
                                                        <c:choose>
                                                            <c:when test="${course.fee == 0}">Miễn phí</c:when>
                                                            <c:otherwise>
                                                                <fmt:formatNumber value="${course.fee}" type="number"/> ₫
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>

                                            <c:choose>
                                                <c:when test="${empty sessionScope.user}">
                                                    <a href="login.jsp" class="card-login-link">
                                                        <i class="bi bi-lock"></i> Đăng nhập
                                                    </a>
                                                </c:when>
                                                <c:when test="${isCompleted}">
                                                    <a href="${pageContext.request.contextPath}/courseController?action=lesson&courseId=${course.courseId}"
                                                       class="card-replay-btn">
                                                        <i class="bi bi-arrow-repeat"></i> Học lại
                                                    </a>
                                                </c:when>
                                                <c:when test="${isEnrolled}">
                                                    <a href="${pageContext.request.contextPath}/courseController?action=lesson&courseId=${course.courseId}"
                                                       class="card-study-btn">
                                                        <i class="bi bi-play-circle-fill"></i> Vào học
                                                    </a>
                                                </c:when>
                                                <c:otherwise>
                                                    <button type="button" class="card-enroll-btn"
                                                            data-courseid="${course.courseId}"
                                                            data-name="${fn:escapeXml(course.courseName)}"
                                                            data-fee="${course.fee}"
                                                            onclick="openModalFromBtn(this)">
                                                        <i class="bi bi-plus-circle"></i> Đăng ký
                                                    </button>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-state">
                                <div class="empty-icon">📚</div>
                                <div class="empty-title">Chưa có khóa học nào</div>
                                <div class="empty-sub">Vui lòng quay lại sau hoặc liên hệ quản trị viên.</div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <!-- FOOTER -->
        <footer style="background:var(--purple-deep);padding:32px 80px;margin-top:40px;">
            <div style="display:flex;justify-content:space-between;align-items:center;border-top:1px solid rgba(255,255,255,0.08);padding-top:20px;">
                <span style="font-family:'Playfair Display',serif;font-size:1.2rem;font-weight:700;color:#fff;">
                    DUK<span style="color:var(--gold);">Academy</span>
                </span>
                <span style="font-size:0.78rem;color:rgba(255,255,255,0.35);">© 2026 DUK Academy. All rights reserved.</span>
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
                    <span class="modal-info-label"><i class="bi bi-arrow-right-circle-fill"></i> Số dư sau đăng ký</span>
                    <span class="modal-info-value after-val" id="modalAfter">—</span>
                </div>
                <div class="modal-warning" id="modalWarning">
                    <i class="bi bi-exclamation-triangle-fill"></i>
                    Số dư không đủ!
                    <a href="${pageContext.request.contextPath}/paymentController"
                       style="color:#C62828;font-weight:700;">Nạp tiền ngay →</a>
                </div>
                <form id="enrollForm" action="${pageContext.request.contextPath}/courseController" method="post">
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
        <script src="${pageContext.request.contextPath}/assets/js/listcourse.js"></script>
    </body>
</html>
