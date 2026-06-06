/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */
function toggleDropdown() {
    document.getElementById('userDropdown').classList.toggle('show');
}

function toggleWishlistDD(e) {
    e.stopPropagation();
    document.getElementById('wishlistDD').classList.toggle('show');
    document.getElementById('userDropdown') && document.getElementById('userDropdown').classList.remove('show');
}

function removeWishItem(e, courseId) {
    e.stopPropagation();
    const userId = '${sessionScope.user.userId}';
    fetch('wishlistController?action=remove&courseId=' + courseId + '&userId=' + userId + '&ajax=1')
            .then(() => {
                const item = document.getElementById('wish-item-' + courseId);
                if (item)
                    item.remove();
                const el = document.getElementById('wishCount');
                if (el)
                    el.textContent = Math.max(0, parseInt(el.textContent || '0') - 1);
                const list = document.getElementById('wishlistDDList');
                if (list && list.querySelectorAll('.wishlist-dd-item').length === 0)
                    list.innerHTML = '<div class="wishlist-dd-empty"><i class="bi bi-heart"></i>Chưa có khóa học yêu thích</div>';
            });
}

document.addEventListener('click', function (e) {
    const menu = document.querySelector('.user-menu');
    const dd = document.getElementById('userDropdown');
    const ww = document.getElementById('wishlistWrap');
    const wd = document.getElementById('wishlistDD');
    if (dd && menu && !menu.contains(e.target) && !dd.contains(e.target))
        dd.classList.remove('show');
    if (wd && ww && !ww.contains(e.target))
        wd.classList.remove('show');
});

