/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


/* USER DROPDOWN */
function toggleDD() {
    const dd = document.getElementById("userDD");
    dd.classList.toggle("show");
}

/* WISHLIST DROPDOWN */
function toggleWishlistDD(e) {
    e.stopPropagation();
    const wd = document.getElementById("wishlistDD");
    wd.classList.toggle("show");
}

/* CLICK OUTSIDE TO CLOSE */
document.addEventListener("click", function (e) {

    const userMenu = document.querySelector(".user-menu");
    const userDD = document.getElementById("userDD");

    const wishWrap = document.getElementById("wishlistWrap");
    const wishDD = document.getElementById("wishlistDD");

    if (userDD && userMenu && !userMenu.contains(e.target) && !userDD.contains(e.target)) {
        userDD.classList.remove("show");
    }

    if (wishDD && wishWrap && !wishWrap.contains(e.target)) {
        wishDD.classList.remove("show");
    }

});

function filterTab(btn, type) {
    // Đổi active cho tab button
    document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
    btn.classList.add('active');

    // Lọc các card
    document.querySelectorAll('.course-card').forEach(card => {
        if (type === 'all') {
            card.classList.remove('hidden');
        } else {
            if (card.dataset.status === type) {
                card.classList.remove('hidden');
            } else {
                card.classList.add('hidden');
            }
        }
    });
}