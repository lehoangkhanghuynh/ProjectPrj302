<%-- 
    Document   : about
    Created on : Mar 10, 2026, 11:17:39 PM
    Author     : HOANG KHANG PC
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<fmt:setLocale value="vi_VN" scope="session"/>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>DUKAcademy - Về chúng tôi</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700;800&family=DM+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
        <link rel="icon" type="favicon" href="img/page/favicon.jpg">
        <link href="assets/css/about.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>

        <!-- NAVBAR -->
        <nav class="navbar-main" style="position:relative;">
            <a href="${pageContext.request.contextPath}/homePage.jsp" class="brand">DUK<span>Academy</span></a>
            <ul class="nav-links">
                <li><a href="${pageContext.request.contextPath}/homePage.jsp">Trang chủ</a></li>
                <li><a href="${pageContext.request.contextPath}/courseController?action=ExploreCourse">Khóa học</a></li>
            <a href="${pageContext.request.contextPath}/instructors.jsp"> Giảng viên</a>
                <c:if test="${sessionScope.user.role == 1}">
                    <li><a href="adminController?action=dashboard">Administrator Manager</a></li>
                </c:if>
                <c:if test="${sessionScope.user != null && sessionScope.user.role == 2}">
                    <li><a href="${pageContext.request.contextPath}/instructorController?action=dashboard">Instructor Manager</a></li>
                </c:if>
                <li><a href="${pageContext.request.contextPath}/about.jsp" class="active">Thông tin Chung</a></li>
            </ul>
            <div class="nav-right">
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <a href="${pageContext.request.contextPath}/paymentController" class="balance-pill-nav">
                            <i class="bi bi-wallet2"></i>
                            <span class="balance-label-nav">Số dư</span>
                            <span class="balance-amount-nav">
                                <fmt:formatNumber value="${sessionScope.user.balance}" type="number" maxFractionDigits="0"/> ₫
                            </span>
                        </a>
                        <div class="wishlist-pill-wrap" id="wishlistWrap">
                            <div class="wishlist-pill" onclick="toggleWishlistDD(event)">
                                <i class="bi bi-heart-fill"></i>
                                <span class="wishlist-pill-label">Yêu thích</span>
                                <span class="wishlist-pill-count" id="wishCount">${not empty WISHLIST_IDS ? WISHLIST_IDS.size() : 0}</span>
                            </div>
                            <div class="wishlist-dropdown" id="wishlistDD">
                                <div class="wishlist-dd-header">
                                    <span class="wishlist-dd-title"><i class="bi bi-heart-fill"></i> Khóa học yêu thích</span>
                                    <a href="${pageContext.request.contextPath}/wishlistController?action=view&userId=${sessionScope.user.userId}" class="wishlist-dd-link">Xem tất cả</a>
                                </div>
                                <div class="wishlist-dd-list" id="wishlistDDList">
                                    <c:choose>
                                        <c:when test="${not empty WISHLIST_COURSES}">
                                            <c:forEach var="wc" items="${WISHLIST_COURSES}">
                                                <div class="wishlist-dd-item" id="wish-item-${wc.courseId}">
                                                    <div class="wishlist-dd-thumb">
                                                        <img src="${pageContext.request.contextPath}/img/courses/course${wc.courseId}.jpg" alt="${wc.courseName}" onerror="this.style.display='none';">
                                                    </div>
                                                    <div class="wishlist-dd-info">
                                                        <div class="wishlist-dd-name">${wc.courseName}</div>
                                                        <div class="wishlist-dd-price">
                                                            <c:choose>
                                                                <c:when test="${wc.fee == 0}">Miễn phí</c:when>
                                                                <c:otherwise><fmt:formatNumber value="${wc.fee}" type="number" maxFractionDigits="0"/> ₫</c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                    </div>
                                                    <button class="wishlist-dd-remove" title="Xóa" onclick="removeWishItem(event,'${wc.courseId}')">
                                                        <i class="bi bi-x"></i>
                                                    </button>
                                                </div>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="wishlist-dd-empty"><i class="bi bi-heart"></i> Chưa có khóa học yêu thích</div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                        <div class="user-menu" onclick="toggleDropdown()">
                            <div class="user-avatar">${fn:substring(sessionScope.user.fullname, 0, 1)}</div>
                            <span class="user-name">${sessionScope.user.fullname}</span>
                            <i class="bi bi-chevron-down" style="color:rgba(255,255,255,0.6); font-size:0.75rem;"></i>
                        </div>
                        <div class="dropdown-menu-custom" id="userDropdown">
                            <a href="${pageContext.request.contextPath}/user/myprofile.jsp"><i class="bi bi-person"></i> Hồ sơ của tôi</a>
                            <a href="${pageContext.request.contextPath}/mainController?action=myCourses"><i class="bi bi-book"></i> Khóa học của tôi</a>
                            <a href="${pageContext.request.contextPath}/mainController?action=payment"><i class="bi bi-wallet2"></i> Nạp tiền</a>
                            <a href="${pageContext.request.contextPath}/mainController?action=myCertificates"><i class="bi bi-award"></i> Chứng chỉ</a>
                            <a href="${pageContext.request.contextPath}/wishlistController?action=view&userId=${sessionScope.user.userId}"><i class="bi bi-heart"></i>Yêu thích</a>
                            <div class="divider-drop"></div>
                            <a href="${pageContext.request.contextPath}/mainController?action=logout" class="logout-link"><i class="bi bi-box-arrow-right"></i> Đăng xuất</a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/login.jsp" style="color:rgba(255,255,255,0.75); text-decoration:none; font-size:0.875rem; font-weight:500;">Đăng nhập</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </nav>

        <!-- HERO -->
        <section class="about-hero">
            <div class="hero-eyebrow">✦ Câu chuyện của chúng tôi</div>
            <h1 class="fade-up">Nơi <em>tri thức</em> gặp<br>đam mê học hỏi</h1>
            <p class="fade-up delay-1">DUK Academy được xây dựng với một niềm tin đơn giản: ai cũng xứng đáng được tiếp cận giáo dục chất lượng cao, dù ở bất cứ đâu.</p>
        </section>

        <!-- STATS -->
        <div class="stats-bar">
            <div class="stats-inner">
                <div class="stat-item fade-up">
                    <div class="stat-number">50<span>K+</span></div>
                    <div class="stat-label">Học viên đang học</div>
                </div>
                <div class="stat-item fade-up delay-1">
                    <div class="stat-number">200<span>+</span></div>
                    <div class="stat-label">Khóa học chất lượng</div>
                </div>
                <div class="stat-item fade-up delay-2">
                    <div class="stat-number">80<span>+</span></div>
                    <div class="stat-label">Giảng viên chuyên gia</div>
                </div>
                <div class="stat-item fade-up delay-3">
                    <div class="stat-number">4.8<span>★</span></div>
                    <div class="stat-label">Đánh giá trung bình</div>
                </div>
            </div>
        </div>

        <!-- MISSION -->
        <section class="mission">
            <div class="mission-left fade-up">
                <div class="section-eyebrow">Sứ mệnh</div>
                <h2 class="section-title">Chúng tôi tin rằng<br><em>học tập không có giới hạn</em></h2>
                <p class="mission-text">DUK Academy ra đời từ mong muốn phá vỡ rào cản địa lý và tài chính trong giáo dục. Chúng tôi kết nối những học viên khát khao tri thức với các chuyên gia hàng đầu trong nhiều lĩnh vực.</p>
                <p class="mission-text">Từng khóa học được thiết kế kỹ lưỡng, thực tiễn và luôn cập nhật theo xu hướng thị trường — để bạn không chỉ học lý thuyết mà thực sự sẵn sàng cho thế giới công việc.</p>
            </div>
            <div class="mission-right">
                <div class="value-card">
                    <div class="value-icon"><i class="bi bi-lightbulb-fill"></i></div>
                    <div>
                        <h4>Học thực tế, không hàn lâm</h4>
                        <p>Mỗi khóa học được xây dựng từ kinh nghiệm thực chiến, tập trung vào kỹ năng ứng dụng ngay.</p>
                    </div>
                </div>
                <div class="value-card">
                    <div class="value-icon gold"><i class="bi bi-people-fill"></i></div>
                    <h4>Cộng đồng học tập</h4>
                    <p>Kết nối với hàng chục nghìn học viên cùng chí hướng, hỗ trợ nhau trên hành trình phát triển.</p>
                </div>
                <div class="value-card">
                    <div class="value-icon dark"><i class="bi bi-award-fill"></i></div>
                    <h4>Chứng chỉ có giá trị</h4>
                    <p>Chứng chỉ hoàn thành được nhà tuyển dụng công nhận, giúp bạn tự tin trong hồ sơ xin việc.</p>
                </div>
            </div>
        </section>

        <!-- STORY -->
        <section class="story">
            <div class="story-inner">
                <div class="section-eyebrow">Lịch sử hình thành</div>
                <h2 class="section-title">Từ một ý tưởng nhỏ đến nền tảng lớn</h2>
                <p class="story-text">DUK Academy được thành lập năm <strong>2024</strong> bởi nhóm sinh viên Đại học FPT với khát vọng tạo ra một không gian học tập trực tuyến thực sự dành cho người Việt.</p>
                <p class="story-text">Tên "<strong>DUK</strong>" được lấy cảm hứng từ tinh thần <strong>Dream – Upgrade – Knowledge</strong> ba giá trị cốt lõi mà chúng tôi muốn truyền tải đến mỗi học viên trên hành trình chinh phục tri thức.</p>
                <p class="story-text">Từ vài chục khóa học ban đầu, ngày nay DUK Academy đã phát triển thành nền tảng với hơn <strong>200 khóa học</strong>, phục vụ hơn <strong>50.000 học viên</strong> trên toàn quốc.</p>
            </div>
        </section>

        <!-- TEAM -->
        <section class="team">
            <div class="team-header">
                <div class="section-eyebrow">Đội ngũ</div>
                <h2 class="section-title">Những người xây dựng DUK Academy</h2>
            </div>
            <div class="team-grid">
                <div class="team-card fade-up">
                    <div class="team-avatar av-purple">
                        <img src="${pageContext.request.contextPath}/img/instructors/gv1t.jpg" alt="Lê Hoàng Khang" onerror="this.style.display='none';">
                    </div>
                    <div class="team-name">Lê Hoàng Khang</div>
                    <div class="team-role">Co-founder · Lead Developer</div>
                    <p class="team-bio">Sinh viên CNTT đam mê AI và Machine Learning. Kiến trúc sư chính của nền tảng DUK Academy.</p>
                </div>
                <div class="team-card fade-up delay-1">
                    <div class="team-avatar av-gold">
                        <img src="${pageContext.request.contextPath}/img/instructors/gv2.jpg" alt="Trần Lê Phương Uyên" onerror="this.style.display='none';">
                    </div>
                    <div class="team-name">Trần Lê Phương Uyên</div>
                    <div class="team-role">Co-founder · UI/UX Designer</div>
                    <p class="team-bio">Chuyên gia thiết kế trải nghiệm người dùng. Người tạo ra giao diện thân thiện và đẹp mắt của DUK Academy.</p>
                </div>
                <div class="team-card fade-up delay-2">
                    <div class="team-avatar av-teal">
                        <img src="${pageContext.request.contextPath}/img/instructors/gv3.jpg" alt="Nguyễn Ngọc Huyền Diệu" onerror="this.style.display='none';">
                    </div>
                    <div class="team-name">Nguyễn Ngọc Huyền Diệu</div>
                    <div class="team-role">Co-founder · Content Director</div>
                    <p class="team-bio">Chuyên gia Data Science và Python. Phụ trách xây dựng nội dung và chương trình học chất lượng cao.</p>
                </div>
            </div>
        </section>

        <!-- WHY US -->
        <section class="why">
            <div class="why-header">
                <div class="section-eyebrow">Tại sao chọn chúng tôi</div>
                <h2 class="section-title">DUK Academy khác biệt như thế nào?</h2>
            </div>
            <div class="why-grid">
                <div class="why-card fade-up">
                    <div class="why-icon"><i class="bi bi-play-circle-fill"></i></div>
                    <h4>Học theo tiến độ của bạn</h4>
                    <p>Không có lịch cố định. Học bất cứ lúc nào, tạm dừng rồi tiếp tục, hoàn toàn linh hoạt theo lịch của bạn.</p>
                </div>
                <div class="why-card fade-up delay-1">
                    <div class="why-icon"><i class="bi bi-patch-check-fill"></i></div>
                    <h4>Nội dung được kiểm duyệt kỹ</h4>
                    <p>Mọi khóa học đều được đội ngũ chuyên gia đánh giá trước khi xuất bản, đảm bảo chất lượng và độ chính xác.</p>
                </div>
                <div class="why-card fade-up delay-2">
                    <div class="why-icon"><i class="bi bi-currency-dollar"></i></div>
                    <h4>Học phí hợp lý</h4>
                    <p>Nhiều khóa học miễn phí. Các khóa có phí được định giá phù hợp với học viên Việt Nam, không đắt như nền tảng nước ngoài.</p>
                </div>
                <div class="why-card fade-up">
                    <div class="why-icon"><i class="bi bi-chat-dots-fill"></i></div>
                    <h4>Hỗ trợ tận tình</h4>
                    <p>Đội ngũ hỗ trợ luôn sẵn sàng giải đáp thắc mắc, cùng với diễn đàn cộng đồng năng động.</p>
                </div>
                <div class="why-card fade-up delay-1">
                    <div class="why-icon"><i class="bi bi-phone-fill"></i></div>
                    <h4>Học trên mọi thiết bị</h4>
                    <p>Giao diện tương thích hoàn toàn trên máy tính, tablet và điện thoại — học ở bất cứ đâu bạn muốn.</p>
                </div>
                <div class="why-card fade-up delay-2">
                    <div class="why-icon"><i class="bi bi-graph-up-arrow"></i></div>
                    <h4>Cập nhật liên tục</h4>
                    <p>Chương trình học được cập nhật thường xuyên theo xu hướng công nghệ và nhu cầu thị trường lao động.</p>
                </div>
            </div>
        </section>

        <!-- CTA -->
        <c:if test="${sessionScope.user != null}">
            <section class="cta-join">
                <h2>Sẵn sàng bắt đầu <em>hành trình</em> của bạn?</h2>
                <p>Tham gia cùng hơn 50.000 học viên đang học tập và phát triển mỗi ngày trên DUK Academy.</p>
                <div class="cta-btns">
                    <a href="${pageContext.request.contextPath}/courseController?action=ExploreCourse" class="btn-cta-primary"><i class="bi bi-play-fill"></i> Khám phá khóa học</a>
                    <a href="mailto:lonhkim82@gmail.com?subject=Đăng ký giảng dạy tại DUK Academy&body=Xin chào,%0A%0ATôi muốn đăng ký trở thành giảng viên tại DUK Academy.%0A%0AThông tin của tôi:%0A- Họ tên:%0A- Lĩnh vực chuyên môn:%0A- Kinh nghiệm:%0A%0ATôi xin đính kèm CV theo email này.%0A%0AXin cảm ơn!" class="btn-cta-secondary"><i class="bi bi-mortarboard-fill"></i> Đăng ký giảng dạy</a>
                </div>
            </section>
        </c:if>

        <!-- FOOTER -->
        <footer>
            <div class="footer-grid">
                <div>
                    <span class="footer-brand-text">DUK<span>Academy</span></span>
                    <p class="footer-desc">Nền tảng học trực tuyến hàng đầu, kết nối học viên với kiến thức và cơ hội nghề nghiệp tốt nhất.</p>
                    <div class="footer-social">
                        <a href="#"><i class="bi bi-facebook"></i></a>
                        <a href="#"><i class="bi bi-youtube"></i></a>
                        <a href="#"><i class="bi bi-linkedin"></i></a>
                        <a href="#"><i class="bi bi-instagram"></i></a>
                    </div>
                </div>
                <div class="footer-col">
                    <h4>Công ty</h4>
                    <a href="about.jsp">Về chúng tôi</a>
                    <a href="#">Blog</a>
                    <a href="#">Tuyển dụng</a>
                    <a href="#">Báo chí</a>
                </div>
                <div class="footer-col">
                    <h4>Cộng đồng</h4>
                    <a href="#">Học viên</a>
                    <a href="#">Giảng viên</a>
                    <a href="#">Đối tác</a>
                    <a href="#">Diễn đàn</a>
                </div>
                <div class="footer-col">
                    <h4>Hỗ trợ</h4>
                    <a href="#">Trung tâm trợ giúp</a>
                    <a href="#">Liên hệ</a>
                    <a href="#">Điều khoản</a>
                    <a href="#">Chính sách</a>
                </div>
            </div>
            <div class="footer-bottom">
                <span>© 2026 DUK Academy. All rights reserved.</span>
                <span>Được làm với ❤️ tại Việt Nam</span>
            </div>
        </footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/common.js"></script>
    </body>
</html>
