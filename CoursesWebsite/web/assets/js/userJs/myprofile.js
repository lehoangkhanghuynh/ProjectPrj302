/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


   function togglePw(id, btn) {
        const inp = document.getElementById(id);
        const ico = btn.querySelector('i');
        if (inp.type === 'password') { inp.type = 'text'; ico.className = 'bi bi-eye-slash'; }
        else { inp.type = 'password'; ico.className = 'bi bi-eye'; }
    }
    function confirmPw() {
        const old  = document.getElementById('oldPassword').value.trim();
        const pw   = document.getElementById('newPassword').value;
        const conf = document.getElementById('confirmPassword').value;
        if (!old)          { alert('Vui lòng nhập mật khẩu cũ!'); return false; }
        if (pw.length < 6) { alert('Mật khẩu mới phải có ít nhất 6 ký tự!'); return false; }
        if (pw !== conf)   { alert('Mật khẩu xác nhận không khớp!'); return false; }
        return confirm('Bạn có chắc muốn đổi mật khẩu không?');
    }

    /* WISHLIST */
    function toggleWishlistDD(e) {
        e.stopPropagation();
        document.getElementById('wishlistDD').classList.toggle('show');
        document.getElementById('userDD') && document.getElementById('userDD').classList.remove('show');
    }
    function removeWishItem(e, courseId) {
        e.stopPropagation();
        const userId = '${sessionScope.user.userId}';
        fetch('wishlistController?action=remove&courseId=' + courseId + '&userId=' + userId + '&ajax=1')
            .then(() => {
                const item = document.getElementById('wish-item-' + courseId);
                if (item) item.remove();
                const el = document.getElementById('wishCount');
                if (el) el.textContent = Math.max(0, parseInt(el.textContent || '0') - 1);
                const list = document.getElementById('wishlistDDList');
                if (list && list.querySelectorAll('.wishlist-dd-item').length === 0)
                    list.innerHTML = '<div class="wishlist-dd-empty"><i class="bi bi-heart"></i>Chưa có khóa học yêu thích</div>';
            });
    }

    function toggleDD() { document.getElementById('userDD').classList.toggle('show'); }
    document.addEventListener('click', e => {
        const m = document.querySelector('.user-menu');
        const d = document.getElementById('userDD');
        const ww = document.getElementById('wishlistWrap');
        const wd = document.getElementById('wishlistDD');
        if (d && m && !m.contains(e.target) && !d.contains(e.target)) d.classList.remove('show');
        if (wd && ww && !ww.contains(e.target)) wd.classList.remove('show');
    });