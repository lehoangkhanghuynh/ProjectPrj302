/* ================================================================
   listCourse.js  —  DUK Academy
   ================================================================ */

// ── Đọc data từ hidden inputs inject bởi JSP ─────────────────
var _userId      = (document.getElementById('currentUserId')  || {}).value || '';
var _contextPath = (document.getElementById('contextPath')    || {}).value || '';
var _userBalance = parseFloat((document.getElementById('userBalance') || {}).value || '0');

// ── Helper ────────────────────────────────────────────────────
function el(id) { return document.getElementById(id); }

function fmt(val) {
    return Number(val).toLocaleString('vi-VN') + ' ₫';
}

function safeToggle(id, cls) {
    var e = el(id);
    if (e) e.classList.toggle(cls);
}

function safeRemove(id, cls) {
    var e = el(id);
    if (e) e.classList.remove(cls);
}

function safeAdd(id, cls) {
    var e = el(id);
    if (e) e.classList.add(cls);
}

// ── Hamburger / Mobile Nav ────────────────────────────────────
function toggleMobileNav() {
    var nav = el('mobileNav');
    var btn = el('hamburger');
    if (!nav || !btn) return;
    nav.classList.toggle('open');
    btn.classList.toggle('open');
    document.body.style.overflow = nav.classList.contains('open') ? 'hidden' : '';
}

// ── Dropdown user ────────────────────────────────────────────
function toggleDropdown() {
    safeToggle('userDropdown', 'show');
}

// ── Dropdown wishlist ─────────────────────────────────────────
function toggleWishlistDD(e) {
    e.stopPropagation();
    safeToggle('wishlistDD', 'show');
    safeRemove('userDropdown', 'show');
}

// Đóng khi click ngoài
document.addEventListener('click', function(e) {
    var userMenu  = document.querySelector('.user-menu');
    var wishWrap  = el('wishlistWrap');
    var mobileNav = el('mobileNav');
    var hamburger = el('hamburger');

    if (!userMenu || !userMenu.contains(e.target)) {
        safeRemove('userDropdown', 'show');
    }
    if (!wishWrap || !wishWrap.contains(e.target)) {
        safeRemove('wishlistDD', 'show');
    }
    // Đóng mobile nav khi click ngoài
    if (mobileNav && hamburger
        && mobileNav.classList.contains('open')
        && !mobileNav.contains(e.target)
        && !hamburger.contains(e.target)) {
        mobileNav.classList.remove('open');
        hamburger.classList.remove('open');
        document.body.style.overflow = '';
    }
});

// Đóng mobile nav khi nhấn Escape
document.addEventListener('keydown', function(e) {
    if (e.key === 'Escape') {
        var nav = el('mobileNav');
        var btn = el('hamburger');
        if (nav && nav.classList.contains('open')) {
            nav.classList.remove('open');
            if (btn) btn.classList.remove('open');
            document.body.style.overflow = '';
        }
        closeModal();
    }
});

// ── Toast ────────────────────────────────────────────────────
var toastTimer;
function showToast(msg, type) {
    var toast    = el('toastNoti');
    var toastMsg = el('toastMsg');
    if (!toast || !toastMsg) return;
    toastMsg.textContent = msg;
    toast.querySelector('i').className = type === 'add' ? 'bi bi-heart-fill' : 'bi bi-heart';
    toast.className = 'toast-noti ' + type + ' show';
    clearTimeout(toastTimer);
    toastTimer = setTimeout(function() { toast.classList.remove('show'); }, 2800);
}

// ── Wishlist AJAX ─────────────────────────────────────────────
function toggleWishlist(e, btnEl) {
    e.preventDefault();
    e.stopPropagation();

    var courseId   = btnEl.dataset.courseid;
    var courseName = btnEl.dataset.name;
    var fee        = btnEl.dataset.fee;
    var isIn       = btnEl.classList.contains('in-wish');
    var action     = isIn ? 'remove' : 'add';

    fetch('wishlistController?action=' + action + '&courseId=' + courseId + '&ajax=1')
        .then(function(res) {
            if (!res.ok) throw new Error('Server error ' + res.status);

            var wishList = el('wishlistDDList');
            var wishCnt  = el('wishCount');

            if (!isIn) {
                btnEl.classList.add('in-wish');
                btnEl.querySelector('i').className = 'bi bi-heart-fill';
                btnEl.title = 'Bỏ yêu thích';

                var emptyMsg = el('wishEmptyMsg');
                if (emptyMsg) emptyMsg.remove();

                if (!el('wish-item-' + courseId) && wishList) {
                    var feeText = parseFloat(fee) === 0 ? 'Miễn phí' : fmt(fee);
                    var div = document.createElement('div');
                    div.className = 'wishlist-dd-item';
                    div.id = 'wish-item-' + courseId;
                    div.innerHTML =
                        '<div class="wishlist-dd-thumb">📚</div>' +
                        '<div class="wishlist-dd-info">' +
                            '<div class="wishlist-dd-name">' + courseName + '</div>' +
                            '<div class="wishlist-dd-price">' + feeText + '</div>' +
                        '</div>' +
                        '<button class="wishlist-dd-remove" title="Xóa" ' +
                            'data-courseid="' + courseId + '" ' +
                            'data-name="' + courseName + '" ' +
                            'data-fee="' + fee + '" ' +
                            'onclick="handleDDRemove(event, this)">' +
                            '<i class="bi bi-x"></i>' +
                        '</button>';
                    wishList.insertBefore(div, wishList.firstChild);
                }

                if (wishCnt) wishCnt.textContent = +wishCnt.textContent + 1;
                showToast('Đã thêm vào mục yêu thích ❤️', 'add');

            } else {
                btnEl.classList.remove('in-wish');
                btnEl.querySelector('i').className = 'bi bi-heart';
                btnEl.title = 'Thêm yêu thích';

                var item = el('wish-item-' + courseId);
                if (item) item.remove();
                if (wishCnt) wishCnt.textContent = Math.max(0, +wishCnt.textContent - 1);

                if (wishList && !wishList.querySelector('.wishlist-dd-item')) {
                    wishList.innerHTML =
                        '<div class="wishlist-dd-empty" id="wishEmptyMsg">' +
                        '<i class="bi bi-heart"></i> Chưa có khóa học yêu thích</div>';
                }
                showToast('Đã xóa khỏi mục yêu thích', 'remove');
            }
        })
        .catch(function() { showToast('Có lỗi xảy ra, thử lại sau', 'remove'); });
}

// ── Xóa item trong dropdown wishlist ─────────────────────────
function handleDDRemove(e, btnEl) {
    e.preventDefault();
    e.stopPropagation();

    var courseId = btnEl.dataset.courseid;
    var wishList = el('wishlistDDList');
    var wishCnt  = el('wishCount');

    fetch('wishlistController?action=remove&courseId=' + courseId + '&ajax=1')
        .then(function(res) {
            if (!res.ok) throw new Error('Server error');

            var item = el('wish-item-' + courseId);
            if (item) item.remove();
            if (wishCnt) wishCnt.textContent = Math.max(0, +wishCnt.textContent - 1);

            var cardBtn = el('wish-btn-' + courseId);
            if (cardBtn) {
                cardBtn.classList.remove('in-wish');
                cardBtn.querySelector('i').className = 'bi bi-heart';
                cardBtn.title = 'Thêm yêu thích';
            }

            if (wishList && !wishList.querySelector('.wishlist-dd-item')) {
                wishList.innerHTML =
                    '<div class="wishlist-dd-empty" id="wishEmptyMsg">' +
                    '<i class="bi bi-heart"></i> Chưa có khóa học yêu thích</div>';
            }
            showToast('Đã xóa khỏi mục yêu thích', 'remove');
        })
        .catch(function() { showToast('Có lỗi xảy ra, thử lại sau', 'remove'); });
}

// ── Modal đăng ký ─────────────────────────────────────────────
function openModal(courseId, courseName, fee, balance) {
    var feeNum       = parseFloat(fee)     || 0;
    var balNum       = parseFloat(balance) || 0;
    var after        = balNum - feeNum;
    var insufficient = after < 0;

    el('modalCourseId').value         = courseId;
    el('modalCourseName').textContent = courseName;
    el('modalFee').textContent        = fmt(feeNum);
    el('modalBalance').textContent    = fmt(balNum);

    var afterEl = el('modalAfter');
    afterEl.textContent = insufficient ? 'Không đủ số dư!' : fmt(after);
    afterEl.className   = 'modal-info-value ' + (insufficient ? 'danger-val' : 'after-val');

    el('modalWarning').style.display = insufficient ? 'block' : 'none';
    el('btnConfirm').disabled        = insufficient;

    safeAdd('enrollModal', 'show');
    document.body.style.overflow = 'hidden';
}

function openModalFromBtn(btnEl) {
    openModal(btnEl.dataset.courseid, btnEl.dataset.name, btnEl.dataset.fee, _userBalance);
}

function closeModal() {
    safeRemove('enrollModal', 'show');
    document.body.style.overflow = '';
}

function closeModalOutside(e) {
    if (e.target === el('enrollModal')) closeModal();
}

// ── Mini card click ───────────────────────────────────────────
function handleMiniCardClick(cardEl) {
    if (!_userId) {
        location.href = _contextPath + '/login.jsp';
        return;
    }
    var courseId   = cardEl.dataset.courseid;
    var courseName = cardEl.dataset.name;
    var fee        = cardEl.dataset.fee;
    var isEnrolled = cardEl.dataset.enrolled;

    if (isEnrolled === 'true') {
        location.href = _contextPath + '/courseController?action=lesson&courseId=' + courseId;
        return;
    }
    openModal(courseId, courseName, fee, _userBalance);
}

// ── Filter theo category ──────────────────────────────────────
var currentTopic = '';

function filterByTopic(chipEl, topic) {
    document.querySelectorAll('.filter-chip').forEach(function(c) {
        c.classList.remove('active');
    });
    chipEl.classList.add('active');
    currentTopic = topic.trim().toLowerCase();
    applyFilters();
}

function applyFilters() {
    var visible = 0;
    document.querySelectorAll('.course-card-full').forEach(function(card) {
        var cardTopic = (card.dataset.topic || '').trim().toLowerCase();
        var ok = !currentTopic || cardTopic === currentTopic;
        card.style.display = ok ? '' : 'none';
        if (ok) visible++;
    });
    var b = el('courseCount');
    if (b) b.textContent = visible + ' khóa học';
}

// ── Search Enter ──────────────────────────────────────────────
var searchInput = el('searchInput');
if (searchInput) {
    searchInput.addEventListener('keydown', function(e) {
        if (e.key === 'Enter') this.closest('form').submit();
    });
}