<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%-- 
    Document   : welcome
    Author     : HOANG KHANG PC
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<c:if test="${not empty sessionScope.user}">
    <c:redirect url="homePage.jsp"/>
</c:if>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>DUKAcademy</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&family=DM+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
        <link rel="icon" type="favicon" href="img/page/favicon.jpg">
        <link href="assets/css/login.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>

        <!-- NAVBAR -->
        <nav class="navbar-main">
            <a href="${pageContext.request.contextPath}/admin/administrator.jsp" class="brand">DUK<span>Academy</span></a>
            <div class="nav-right">
                <c:choose>
                    <c:when test="${not empty user}">
                        <div class="user-chip" onclick="toggleDD()">
                            <div class="u-avatar">${fn:substring(user.userId, 0, 1)}</div>
                            <span class="u-name">${user.userId}</span>
                            <i class="bi bi-chevron-down" style="color:rgba(255,255,255,0.5);font-size:0.7rem;"></i>
                            <div class="user-dropdown" id="userDD">
                                <a href="#"><i class="bi bi-person"></i> Hồ sơ</a>
                                <a href="#"><i class="bi bi-book"></i> Khóa học của tôi</a>
                                <a href="#"><i class="bi bi-award"></i> Chứng chỉ</a>
                                <div class="dd-sep"></div>
                                <a href="${pageContext.request.contextPath}/mainController?action=logout" class="logout-link"><i class="bi bi-box-arrow-right"></i> Đăng xuất</a>
                            </div>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <button class="btn-nav-login" onclick="openModal('login')">Đăng nhập</button>
                        <button class="btn-nav-join"  onclick="openModal('register')">Tham gia miễn phí</button>
                    </c:otherwise>
                </c:choose>
            </div>
        </nav>

        <!-- HERO -->
        <div class="hero">
            <div class="hero-content">
                <c:if test="${not empty user}">
                    <div style="display:inline-flex;align-items:center;gap:10px;background:rgba(255,255,255,0.08);border:1px solid rgba(255,255,255,0.15);border-radius:10px;padding:9px 16px;margin-bottom:18px;color:rgba(255,255,255,0.9);font-size:0.875rem;">
                        👋 Chào mừng trở lại, <strong style="color:var(--gold);margin-left:4px;">${user.userId}</strong>!
                    </div>
                </c:if>
                <div class="hero-eyebrow">✦ Nền tảng học trực tuyến</div>
                <h1>Học không<br>giới hạn,<br><em>thành công</em><br>thật sự</h1>
                <p>Hàng nghìn khóa học từ chuyên gia hàng đầu. Học bất cứ lúc nào, bất cứ nơi đâu.</p>
                <div class="hero-btns">
                    <button class="btn-gold" onclick="openModal('register')">Bắt đầu miễn phí</button>
                    <button class="btn-outline-w" onclick="openModal('login')">Đăng nhập</button>
                </div>
            </div>
            <div class="hero-right">
                <div class="hero-cards">
                    <div class="mini-card"><div class="mini-icon ic1">🤖</div><div class="mini-info"><h4>Machine Learning A-Z</h4><p><span class="mstars">★★★★★</span> 4.9 · 125K học viên</p></div></div>
                    <div class="mini-card"><div class="mini-icon ic2">🎨</div><div class="mini-info"><h4>UI/UX Design Pro</h4><p><span class="mstars">★★★★★</span> 4.8 · 89K học viên</p></div></div>
                    <div class="mini-card"><div class="mini-icon ic3">📊</div><div class="mini-info"><h4>Python Data Science</h4><p><span class="mstars">★★★★½</span> 4.7 · 240K học viên</p></div></div>
                </div>
            </div>
        </div>

        <!-- CATEGORIES -->
        <section style="background:#fff;">
            <div class="sec-label">Danh mục</div>
            <div class="sec-title">Khám phá theo lĩnh vực</div>
            <p class="sec-sub">Chọn chủ đề phù hợp với mục tiêu của bạn</p>
            <div class="cat-grid">
                <a href="#" class="cat-card"><div class="cat-icon">💻</div><h3>Lập trình & Công nghệ</h3><p>668 khóa học</p></a>
                <a href="#" class="cat-card"><div class="cat-icon">📊</div><h3>Khoa học dữ liệu</h3><p>425 khóa học</p></a>
                <a href="#" class="cat-card"><div class="cat-icon">💼</div><h3>Kinh doanh</h3><p>1,095 khóa học</p></a>
                <a href="#" class="cat-card"><div class="cat-icon">🎨</div><h3>Thiết kế sáng tạo</h3><p>312 khóa học</p></a>
                <a href="#" class="cat-card"><div class="cat-icon">🧠</div><h3>Trí tuệ nhân tạo</h3><p>245 khóa học</p></a>
                <a href="#" class="cat-card"><div class="cat-icon">🌐</div><h3>Ngoại ngữ</h3><p>186 khóa học</p></a>
                <a href="#" class="cat-card"><div class="cat-icon">📣</div><h3>Marketing</h3><p>278 khóa học</p></a>
                <a href="#" class="cat-card"><div class="cat-icon">💰</div><h3>Tài chính</h3><p>197 khóa học</p></a>
            </div>
        </section>

        <!-- COURSES -->
        <section class="courses" style="background:#F8F5FF;">
            <div class="sec-label">Nổi bật</div>
            <div class="sec-title">Khóa học được yêu thích nhất</div>
            <p class="sec-sub">Hàng triệu học viên đang theo học các khóa học này</p>
            <div class="course-grid">
                <a href="#" class="course-card">
                    <div class="course-thumb th1">
                        <img src="${pageContext.request.contextPath}/img/courses/course1t1.jpg" alt="Machine Learning" onerror="this.style.display='none';">
                    </div>
                    <div class="course-body">
                        <div class="course-org">DeepLearning.AI</div>
                        <h3>Machine Learning Specialization</h3>
                        <div class="course-meta"><span class="course-stars">★★★★★</span><span class="course-score">4.9</span><span class="course-count">(125K)</span></div>
                        <span class="course-tag">Dành cho người mới</span>
                    </div>
                </a>
                <a href="#" class="course-card">
                    <div class="course-thumb th2">
                        <img src="${pageContext.request.contextPath}/img/courses/course2.jpg" alt="Python Data Science" onerror="this.style.display='none';">
                    </div>
                    <div class="course-body">
                        <div class="course-org">Đại học Bách Khoa</div>
                        <h3>Python cho Khoa học Dữ liệu</h3>
                        <div class="course-meta"><span class="course-stars">★★★★★</span><span class="course-score">4.8</span><span class="course-count">(240K)</span></div>
                        <span class="course-tag">Nhiều người học nhất</span>
                    </div>
                </a>
                <a href="#" class="course-card">
                    <div class="course-thumb th3">
                        <img src="${pageContext.request.contextPath}/img/courses/course3.jpg" alt="UX Design" onerror="this.style.display='none';">
                    </div>
                    <div class="course-body">
                        <div class="course-org">Google · UX Design</div>
                        <h3>Google UX Design Professional</h3>
                        <div class="course-meta"><span class="course-stars">★★★★½</span><span class="course-score">4.7</span><span class="course-count">(89K)</span></div>
                        <span class="course-tag">Chứng chỉ chuyên nghiệp</span>
                    </div>
                </a>
                <a href="#" class="course-card">
                    <div class="course-thumb th4">
                        <img src="${pageContext.request.contextPath}/img/courses/course4t.jpg" alt="Data Science" onerror="this.style.display='none';">
                    </div>
                    <div class="course-body">
                        <div class="course-org">IBM · Data Science</div>
                        <h3>IBM Data Science Professional</h3>
                        <div class="course-meta"><span class="course-stars">★★★★★</span><span class="course-score">4.6</span><span class="course-count">(67K)</span></div>
                        <span class="course-tag">Cầu nghề cao</span>
                    </div>
                </a>
            </div>
        </section>

        <!-- STATS -->
        <div class="stats-bar">
            <div><span class="stat-num">500K+</span><span class="stat-lbl">Học viên</span></div>
            <div><span class="stat-num">7,000+</span><span class="stat-lbl">Khóa học</span></div>
            <div><span class="stat-num">98%</span><span class="stat-lbl">Hài lòng</span></div>
            <div><span class="stat-num">325+</span><span class="stat-lbl">Đối tác</span></div>
        </div>

        <!-- CTA -->
        <div class="cta-sec">
            <h2>Bắt đầu học ngay hôm nay</h2>
            <p>Tham gia miễn phí — không cần thẻ tín dụng</p>
            <button class="btn-gold" onclick="openModal('register')"><i class="bi bi-rocket-takeoff me-2"></i>Tạo tài khoản miễn phí</button>
        </div>

        <!-- FOOTER -->
        <footer>
            <div class="footer-grid">
                <div><span class="f-brand">Learn<span>Verse</span></span><p class="f-desc">Nền tảng học trực tuyến kết nối bạn với tri thức và cơ hội nghề nghiệp tốt nhất.</p></div>
                <div class="f-col"><h4>Công ty</h4><a href="#">Về chúng tôi</a><a href="#">Blog</a><a href="#">Tuyển dụng</a></div>
                <div class="f-col"><h4>Hỗ trợ</h4><a href="#">Trợ giúp</a><a href="#">Liên hệ</a><a href="#">Điều khoản</a></div>
                <div class="f-col"><h4>Theo dõi</h4><a href="#">Facebook</a><a href="#">Youtube</a><a href="#">LinkedIn</a></div>
            </div>
            <div class="footer-bottom"><span>© 2026 LearnVerse</span><span>Made with ❤️ tại Việt Nam</span></div>
        </footer>

        <!-- ===== AUTH MODAL ===== -->
        <div class="modal-overlay" id="modalOverlay" onclick="handleOverlay(event)">
            <div class="auth-modal" id="authModal">
                <button class="modal-close" onclick="closeModal()"><i class="bi bi-x"></i></button>

                <div class="modal-title">Đăng nhập hoặc tạo tài khoản</div>
                <div class="modal-sub">Học từ các chuyên gia hàng đầu, bất cứ lúc nào.</div>

                <div class="tab-switch">
                    <button class="tab-btn active" id="tabLogin" onclick="switchTab('login')">Đăng nhập</button>
                    <button class="tab-btn"        id="tabReg"   onclick="switchTab('register')">Đăng ký</button>
                </div>

                <!-- LOGIN -->
                <div class="form-panel active" id="panelLogin">
                    <c:if test="${not empty message}">
                        <div class="alert-err"><i class="bi bi-exclamation-circle-fill"></i>${message}</div>
                    </c:if>
                    <div class="social-grid">
                    </div>
                    <div class="or-div">hoặc dùng tài khoản</div>
                    <form action="${pageContext.request.contextPath}/mainController" method="POST">
                        <input type="hidden" name="action" value="login" />
                        <div style="margin-bottom:13px;">
                            <label class="f-label">Tên đăng nhập</label>
                            <input type="text" class="f-input" name="userName" placeholder="Nhập tên đăng nhập" required />
                        </div>
                        <div style="margin-bottom:10px;">
                            <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:5px;">
                                <label class="f-label" style="margin:0;">Mật khẩu</label>
                                <a href="${pageContext.request.contextPath}/password/forgotPassword.jsp" class="forgot">Quên mật khẩu?</a>
                            </div>
                            <div class="pw-wrap">
                                <input type="password" class="f-input" name="password" id="lPw" placeholder="Nhập mật khẩu" required />
                                <button type="button" class="pw-eye" onclick="tpw('lPw', 'lEye')"><i class="bi bi-eye" id="lEye"></i></button>
                            </div>
                        </div>
                        <div style="margin-bottom:18px;">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="rem">
                                <label class="form-check-label" for="rem" style="font-size:0.78rem;color:var(--muted);">Ghi nhớ đăng nhập</label>
                            </div>
                        </div>
                        <button type="submit" class="btn-submit"><i class="bi bi-box-arrow-in-right"></i>Đăng nhập</button>
                    </form>
                </div>

                <!-- REGISTER -->
                <div class="form-panel" id="panelReg">
                    <c:if test="${not empty registerMessage}">
                        <div class="${isSuccess ? 'alert-success' : 'alert-err'}" 
                             style="padding: 12px; margin-bottom: 15px; border-radius: 8px; font-size: 0.85rem; border: 1px solid;
                             ${isSuccess ? 'background-color: #d4edda; color: #155724; border-color: #c3e6cb;' : 'background-color: #f8d7da; color: #721c24; border-color: #f5c6cb;'}">
                            <i class="bi ${isSuccess ? 'bi-check-circle-fill' : 'bi-exclamation-circle-fill'}"></i> 
                            ${registerMessage}
                        </div>
                    </c:if>
                    <form action="${pageContext.request.contextPath}/mainController" method="POST" id="regForm">
                        <input type="hidden" name="action" value="register" />
                        <div style="margin-bottom:11px;"><label class="f-label">Tên đăng nhập</label><input type="text" class="f-input" name="userName" placeholder="username" required /></div>
                        <div style="margin-bottom:11px;"><label class="f-label">Họ & Tên</label><input type="text" class="f-input" name="fullname" placeholder="Nguyễn Văn A" required /></div>
                        <div style="margin-bottom:11px;"><label class="f-label">Email</label><input type="email" class="f-input" name="email" placeholder="email@example.com" required /></div>
                        <div style="margin-bottom:11px;">
                            <label class="f-label">Mật khẩu</label>
                            <div class="pw-wrap">
                                <input type="password" class="f-input" name="password" id="rPw" placeholder="Tạo mật khẩu mạnh" required oninput="chkStr(this.value)" />
                                <button type="button" class="pw-eye" onclick="tpw('rPw', 'rEye')"><i class="bi bi-eye" id="rEye"></i></button>
                            </div>
                            <div class="str-bar"><div class="str-seg" id="st1"></div><div class="str-seg" id="st2"></div><div class="str-seg" id="st3"></div><div class="str-seg" id="st4"></div></div>
                            <div class="str-lbl" id="stLbl"></div>
                        </div>
                        <div style="margin-bottom:11px;">
                            <label class="f-label">Xác nhận mật khẩu</label>
                            <div class="pw-wrap">
                                <input type="password" class="f-input" name="confirmPassword" id="rCpw" placeholder="Nhập lại mật khẩu" required />
                                <button type="button" class="pw-eye" onclick="tpw('rCpw', 'rEye2')"><i class="bi bi-eye" id="rEye2"></i></button>
                            </div>
                            <div id="cpwErr" style="font-size:0.68rem;color:#CC0000;margin-top:2px;"></div>
                        </div>
                        <div style="margin-bottom:16px;">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" id="terms" required>
                                <label class="form-check-label" for="terms" style="font-size:0.73rem;color:var(--muted);line-height:1.5;">
                                    Tôi đồng ý với <a href="#" style="color:var(--purple);font-weight:600;">Điều khoản</a> và <a href="#" style="color:var(--purple);font-weight:600;">Chính sách bảo mật</a>
                                </label>
                            </div>
                        </div>
                        <button type="submit" class="btn-submit"><i class="bi bi-person-plus"></i>Tạo tài khoản</button>
                    </form>
                </div>
            </div>
        </div>

        <input type="hidden" id="hasMessage"         value="${not empty message}">
        <input type="hidden" id="hasRegisterMessage" value="${not empty registerMessage}">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            window.onload = function () {
                <c:if test="${not empty registerMessage}">
                document.getElementById('modalOverlay').classList.add('show');
                document.body.style.overflow = 'hidden';
                switchTab('register');
                </c:if>
                <c:if test="${not empty message}">
                document.getElementById('modalOverlay').classList.add('show');
                document.body.style.overflow = 'hidden';
                switchTab('login');
                </c:if>
            };

            function openModal(tab) {
                document.getElementById('modalOverlay').classList.add('show');
                document.body.style.overflow = 'hidden';
                switchTab(tab || 'login');
            }
            function closeModal() {
                document.getElementById('modalOverlay').classList.remove('show');
                document.body.style.overflow = '';
            }
            function handleOverlay(e) {
                if (e.target === document.getElementById('modalOverlay')) closeModal();
            }
            document.addEventListener('keydown', e => { if (e.key === 'Escape') closeModal(); });

            function switchTab(tab) {
                ['login', 'register'].forEach(t => {
                    document.getElementById('panel' + (t === 'login' ? 'Login' : 'Reg')).classList.toggle('active', t === tab);
                    document.getElementById('tab'   + (t === 'login' ? 'Login' : 'Reg')).classList.toggle('active', t === tab);
                });
            }

            function tpw(iId, eId) {
                const i = document.getElementById(iId), e = document.getElementById(eId);
                i.type = i.type === 'password' ? 'text' : 'password';
                e.className = i.type === 'password' ? 'bi bi-eye' : 'bi bi-eye-slash';
            }

            function chkStr(v) {
                const segs = ['st1','st2','st3','st4'].map(id => document.getElementById(id));
                const lbl  = document.getElementById('stLbl');
                let s = 0;
                if (v.length >= 8)          s++;
                if (/[A-Z]/.test(v))        s++;
                if (/[0-9]/.test(v))        s++;
                if (/[^A-Za-z0-9]/.test(v)) s++;
                const c = ['#CC0000','#E65100','#D4A843','#2E7D32'];
                const l = ['Yếu','Trung bình','Khá','Mạnh'];
                segs.forEach((seg, i) => seg.style.background = i < s ? c[s-1] : '#E2D9F3');
                lbl.textContent = v.length ? (l[s-1] || 'Yếu') : '';
                lbl.style.color = c[s-1] || '#CC0000';
            }

            document.getElementById('regForm').addEventListener('submit', function(e) {
                if (document.getElementById('rPw').value !== document.getElementById('rCpw').value) {
                    e.preventDefault();
                    document.getElementById('rCpw').style.borderColor = '#CC0000';
                    document.getElementById('cpwErr').textContent = '⚠ Mật khẩu không khớp!';
                }
            });
            document.getElementById('rCpw').addEventListener('input', function() {
                this.style.borderColor = '';
                document.getElementById('cpwErr').textContent = '';
            });

            function toggleDD() { document.getElementById('userDD')?.classList.toggle('show'); }
            document.addEventListener('click', e => {
                const chip = document.querySelector('.user-chip');
                const dd   = document.getElementById('userDD');
                if (dd && chip && !chip.contains(e.target)) dd.classList.remove('show');
            });
        </script>
    </body>
</html>
