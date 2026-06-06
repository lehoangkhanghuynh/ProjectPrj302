/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


    /* ── TABS ── */
    function switchTab(t, el) {
        document.querySelectorAll('.pay-tab').forEach(x => x.classList.remove('active'));
        document.querySelectorAll('.tab-pane').forEach(x => x.classList.remove('active'));
        el.classList.add('active');
        document.getElementById('tab-' + t).classList.add('active');
    }

    /* ── AMOUNT CHIPS ── */
    function pickAmt(type, amt, el) {
        document.querySelectorAll(type === 'momo' ? '#tab-momo .amount-chip' : '#tab-qr .amount-chip')
            .forEach(c => c.classList.remove('selected'));
        el.classList.add('selected');
        const inp = document.getElementById(type === 'momo' ? 'momoAmt' : 'qrAmt');
        if (amt > 0) inp.value = amt;
        else { inp.value = ''; inp.focus(); }
    }
    function clearChips(type) {
        document.querySelectorAll(type === 'momo' ? '#tab-momo .amount-chip' : '#tab-qr .amount-chip')
            .forEach(c => c.classList.remove('selected'));
    }

    /* ── MOMO ── */
    function payMomo() {
        const amt = parseInt(document.getElementById('momoAmt').value);
        if (!amt || amt < 10000) { alert('Vui lòng nhập số tiền tối thiểu 10.000 ₫'); return; }
        alert('Tính năng MoMo đang được phát triển. Vui lòng dùng chuyển khoản QR.');
    }

    /* ── WISHLIST DROPDOWN ── */
    function toggleWishlistDD(e) {
        e.stopPropagation();
        document.getElementById('wishlistDD').classList.toggle('show');
        const ud = document.getElementById('userDD');
        if (ud) ud.classList.remove('show');
    }
    function removeWishItem(e, courseId) {
        e.stopPropagation();
        const userId = document.querySelector('.navbar-main').dataset.userid;
        fetch('wishlistController?action=remove&courseId=' + courseId + '&userId=' + userId + '&ajax=1')
            .then(() => {
                const item = document.getElementById('wish-item-' + courseId);
                if (item) item.remove();
                const el = document.getElementById('wishCount');
                if (el) el.textContent = Math.max(0, parseInt(el.textContent || '0') - 1);
                const list = document.getElementById('wishlistDDList');
                if (list && list.querySelectorAll('.wishlist-dd-item').length === 0)
                    list.innerHTML = '<div class="wishlist-dd-empty"><i class="bi bi-heart"></i> Chưa có khóa học yêu thích</div>';
            });
    }

    /* ── USER DROPDOWN ── */
    function toggleDD() {
        document.getElementById('userDD').classList.toggle('show');
        const wd = document.getElementById('wishlistDD');
        if (wd) wd.classList.remove('show');
    }

    /* ── CLICK OUTSIDE ── */
    document.addEventListener('click', e => {
        const userMenu = document.querySelector('.user-menu');
        const userDD   = document.getElementById('userDD');
        const ww       = document.getElementById('wishlistWrap');
        const wd       = document.getElementById('wishlistDD');
        if (userDD && userMenu && !userMenu.contains(e.target) && !userDD.contains(e.target))
            userDD.classList.remove('show');
        if (wd && ww && !ww.contains(e.target))
            wd.classList.remove('show');
    });