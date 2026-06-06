/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


/* ── WISHLIST DROPDOWN ── */
function toggleWishlistDD(e) {
    e.stopPropagation();
    document.getElementById('wishlistDD').classList.toggle('show');
    var _ud = document.getElementById('userDD');
    if (_ud)
        _ud.classList.remove('show');
}

// FIX: bỏ userId khỏi fetch URL
function removeWishItem(e, btnEl) {
    e.stopPropagation();
    const courseId = btnEl.dataset.courseid;
    fetch('wishlistController?action=remove&courseId=' + courseId + '&ajax=1')
            .then(res => {
                if (!res.ok)
                    throw new Error('error');
                const item = document.getElementById('wish-item-' + courseId);
                if (item)
                    item.remove();
                const el = document.getElementById('wishCount');
                if (el)
                    el.textContent = Math.max(0, parseInt(el.textContent || '0') - 1);
                const list = document.getElementById('wishlistDDList');
                if (list && !list.querySelector('.wishlist-dd-item'))
                    list.innerHTML = '<div class="wishlist-dd-empty"><i class="bi bi-heart"></i> Chưa có khóa học yêu thích</div>';
            });
}

/* ── USER DROPDOWN ── */
function toggleDD() {
    document.getElementById('userDD').classList.toggle('show');
    var _wd = document.getElementById('wishlistDD');
    if (_wd)
        _wd.classList.remove('show');
}

document.addEventListener('click', function (e) {
    const ud = document.getElementById('userDD');
    const um = document.querySelector('.user-menu');
    const ww = document.getElementById('wishlistWrap');
    const wd = document.getElementById('wishlistDD');
    if (ud && um && !um.contains(e.target) && !ud.contains(e.target))
        ud.classList.remove('show');
    if (wd && ww && !ww.contains(e.target))
        wd.classList.remove('show');
});

/* ── MODAL ── */
function fmt(val) {
    return Number(val).toLocaleString('vi-VN') + ' ₫';
}

function openModal(courseId, courseName, fee, balance) {
    const feeNum = parseFloat(fee) || 0;
    const balNum = parseFloat(balance) || 0;
    const after = balNum - feeNum;

    document.getElementById('modalCourseId').value = courseId;
    document.getElementById('modalCourseName').textContent = courseName;
    document.getElementById('modalFee').textContent = fmt(feeNum);
    document.getElementById('modalBalance').textContent = fmt(balNum);

    const afterEl = document.getElementById('modalAfter');
    const warnEl = document.getElementById('modalWarning');
    const confirmEl = document.getElementById('btnConfirm');

    if (after < 0) {
        afterEl.textContent = 'Không đủ số dư!';
        afterEl.className = 'modal-info-value danger-val';
        warnEl.style.display = 'block';
        confirmEl.disabled = true;
    } else {
        afterEl.textContent = fmt(after);
        afterEl.className = 'modal-info-value after-val';
        warnEl.style.display = 'none';
        confirmEl.disabled = false;
    }
    document.getElementById('enrollModal').classList.add('show');
    document.body.style.overflow = 'hidden';
}

function closeModal() {
    document.getElementById('enrollModal').classList.remove('show');
    document.body.style.overflow = '';
}
function closeModalOutside(e) {
    if (e.target === document.getElementById('enrollModal'))
        closeModal();
}
document.addEventListener('keydown', e => {
    if (e.key === 'Escape')
        closeModal();
});

/* ── TOAST ── */
let toastTimer;
function showToast(msg) {
    const toast = document.getElementById('toastNoti');
    document.getElementById('toastMsg').textContent = msg;
    toast.classList.add('show');
    clearTimeout(toastTimer);
    toastTimer = setTimeout(() => toast.classList.remove('show'), 2500);
}

/* ── REMOVE CARD ── */
// FIX: gọi AJAX trước, redirect sau khi thành công
function confirmRemove(btn) {
    const wishlistId = btn.dataset.wishid;
    const courseId = btn.dataset.courseid;
    const card = document.getElementById('card-' + wishlistId);
    if (!card)
        return;

    btn.disabled = true;
    card.style.transition = 'all 0.3s ease';
    card.style.opacity = '0';
    card.style.transform = 'translateX(40px)';

    // FIX: chỉ dùng courseId, bỏ userId khỏi URL
    fetch('wishlistController?action=remove&courseId=' + courseId + '&from=wishlist&ajax=1')
            .then(res => {
                if (!res.ok)
                    throw new Error('error');
                showToast('Đã xóa khỏi danh sách yêu thích');
                setTimeout(() => {
                    card.style.maxHeight = card.offsetHeight + 'px';
                    card.style.overflow = 'hidden';
                    card.style.padding = '0';
                    card.style.margin = '0';
                    card.style.border = 'none';
                    requestAnimationFrame(() => {
                        card.style.transition = 'all 0.3s ease';
                        card.style.maxHeight = '0';
                    });
                    setTimeout(() => {
                        card.remove();
                        const remaining = document.querySelectorAll('.wish-card').length;
                        document.getElementById('statNum').textContent = remaining;
                        const wishCnt = document.getElementById('wishCount');
                        if (wishCnt)
                            wishCnt.textContent = Math.max(0, +wishCnt.textContent - 1);
                    }, 320);
                }, 300);
            })
            .catch(() => {
                btn.disabled = false;
                card.style.opacity = '1';
                card.style.transform = 'none';
                showToast('Có lỗi xảy ra, thử lại sau');
            });
}