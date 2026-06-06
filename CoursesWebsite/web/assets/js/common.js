/* ===================================================
   common.js — dùng chung cho tất cả trang
   =================================================== */

function toggleDropdown() {
    document.getElementById('userDropdown').classList.toggle('show');
}

function toggleWishlistDD(e) {
    e.stopPropagation();
    document.getElementById('wishlistDD').classList.toggle('show');
    const dd = document.getElementById('userDropdown');
    if (dd) dd.classList.remove('show');
}

function removeWishItem(e, courseId) {
    e.stopPropagation();
    const userIdEl = document.getElementById('currentUserId');
    const userId = userIdEl ? userIdEl.value : '';
    fetch('wishlistController?action=remove&courseId=' + courseId + '&userId=' + userId + '&ajax=1')
        .then(() => {
            const item = document.getElementById('wish-item-' + courseId);
            if (item) item.remove();
            const el = document.getElementById('wishCount');
            if (el) el.textContent = Math.max(0, parseInt(el.textContent || '0') - 1);
            const list = document.getElementById('wishlistDDList');
            if (list && !list.querySelector('.wishlist-dd-item'))
                list.innerHTML = '<div class="wishlist-dd-empty"><i class="bi bi-heart"></i> Chưa có khóa học yêu thích</div>';
        });
}

document.addEventListener('click', function(e) {
    const menu = document.querySelector('.user-menu');
    const dd   = document.getElementById('userDropdown');
    const ww   = document.getElementById('wishlistWrap');
    const wd   = document.getElementById('wishlistDD');
    if (dd && menu && !menu.contains(e.target) && !dd.contains(e.target))
        dd.classList.remove('show');
    if (wd && ww && !ww.contains(e.target))
        wd.classList.remove('show');
});