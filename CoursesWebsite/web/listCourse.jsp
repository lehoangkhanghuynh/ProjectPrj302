<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<fmt:setLocale value="vi_VN"/>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Khóa học - DUK Academy</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&family=DM+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link rel="icon" type="favicon" href="img/page/favicon.jpg">
    <style>
        :root {
            --purple:      #6C3FC5;
            --purple-dark: #4E2C96;
            --purple-deep: #1E0A4A;
            --purple-light:#F3EEFF;
            --purple-mid:  #9B72E8;
            --gold:        #D4A843;
            --text:        #1A1A2E;
            --muted:       #6B6B8A;
            --border:      #E2D9F3;
            --bg:          #F4F0FC;
        }
        *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'DM Sans', sans-serif; color: var(--text); background: var(--bg); }

        /* NAVBAR */
        .navbar-main { background: var(--purple-deep); padding: 0 48px; height: 68px; display: flex; align-items: center; justify-content: space-between; position: sticky; top: 0; z-index: 100; box-shadow: 0 2px 20px rgba(0,0,0,0.25); }
        .brand { font-family: 'Playfair Display', serif; font-size: 1.55rem; font-weight: 700; color: #fff; text-decoration: none; }
        .brand span { color: var(--gold); }
        .nav-links { display: flex; align-items: center; gap: 4px; list-style: none; }
        .nav-links a { font-size: 0.9rem; font-weight: 500; color: rgba(255,255,255,0.75); text-decoration: none; padding: 7px 14px; border-radius: 6px; transition: background 0.15s, color 0.15s; }
        .nav-links a:hover, .nav-links a.active { background: rgba(255,255,255,0.1); color: #fff; }
        .nav-right { display: flex; align-items: center; gap: 12px; }
        .search-bar { display: flex; align-items: center; background: rgba(255,255,255,0.1); border: 1px solid rgba(255,255,255,0.15); border-radius: 8px; padding: 7px 14px; gap: 8px; }
        .search-bar input { background: none; border: none; outline: none; color: #fff; font-size: 0.875rem; font-family: 'DM Sans', sans-serif; width: 180px; }
        .search-bar input::placeholder { color: rgba(255,255,255,0.5); }
        .search-bar i { color: rgba(255,255,255,0.6); }

        /* BALANCE PILL */
        .balance-pill { display: flex; align-items: center; gap: 7px; background: rgba(212,168,67,0.12); border: 1px solid rgba(212,168,67,0.35); border-radius: 8px; padding: 7px 14px; text-decoration: none; }
        .balance-pill i { color: var(--gold); }
        .balance-label { font-size: 0.75rem; font-weight: 500; color: rgba(255,255,255,0.6); }
        .balance-amount { font-size: 0.875rem; font-weight: 700; color: var(--gold); }

        /* WISHLIST PILL */
        .wishlist-pill-wrap { position: relative; }
        .wishlist-pill { display: flex; align-items: center; gap: 7px; background: rgba(229,57,53,0.12); border: 1px solid rgba(229,57,53,0.35); border-radius: 8px; padding: 7px 14px; cursor: pointer; transition: background 0.15s; user-select: none; }
        .wishlist-pill:hover { background: rgba(229,57,53,0.2); }
        .wishlist-pill i { color: #FF6B6B; font-size: 1rem; }
        .wishlist-pill-label { font-size: 0.75rem; font-weight: 500; color: rgba(255,255,255,0.6); }
        .wishlist-pill-count { font-size: 0.875rem; font-weight: 700; color: #FF6B6B; }
        .wishlist-dropdown { position: absolute; top: calc(100% + 10px); right: 0; background: #fff; border: 1px solid var(--border); border-radius: 14px; min-width: 320px; max-width: 360px; box-shadow: 0 12px 40px rgba(0,0,0,0.18); display: none; z-index: 300; overflow: hidden; }
        .wishlist-dropdown.show { display: block; animation: ddIn 0.18s ease; }
        @keyframes ddIn { from { opacity:0; transform:translateY(-8px); } to { opacity:1; transform:translateY(0); } }
        .wishlist-dd-header { padding: 14px 18px 10px; border-bottom: 1px solid var(--border); display: flex; align-items: center; justify-content: space-between; }
        .wishlist-dd-title { font-size: 0.9rem; font-weight: 700; color: var(--text); display: flex; align-items: center; gap: 7px; }
        .wishlist-dd-title i { color: #E53935; }
        .wishlist-dd-link { font-size: 0.75rem; font-weight: 600; color: var(--purple); text-decoration: none; }
        .wishlist-dd-link:hover { text-decoration: underline; }
        .wishlist-dd-list { max-height: 320px; overflow-y: auto; padding: 8px; }
        .wishlist-dd-item { display: flex; align-items: center; gap: 10px; padding: 10px; border-radius: 10px; transition: background 0.12s; }
        .wishlist-dd-item:hover { background: var(--purple-light); }
        .wishlist-dd-thumb { width: 44px; height: 44px; border-radius: 8px; overflow: hidden; flex-shrink: 0; background: linear-gradient(135deg, var(--purple-deep), var(--purple)); display: flex; align-items: center; justify-content: center; font-size: 1.2rem; }
        .wishlist-dd-thumb img { width: 100%; height: 100%; object-fit: cover; }
        .wishlist-dd-info { flex: 1; min-width: 0; }
        .wishlist-dd-name { font-size: 0.8rem; font-weight: 700; color: var(--text); white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
        .wishlist-dd-price { font-size: 0.72rem; color: var(--purple); font-weight: 600; margin-top: 2px; }
        .wishlist-dd-remove { background: none; border: none; color: #ccc; cursor: pointer; font-size: 1rem; padding: 4px 6px; border-radius: 50%; transition: color 0.15s, background 0.15s; flex-shrink: 0; }
        .wishlist-dd-remove:hover { color: #E53935; background: #FFF3F3; }
        .wishlist-dd-empty { padding: 32px 16px; text-align: center; color: var(--muted); font-size: 0.85rem; }
        .wishlist-dd-empty i { font-size: 2rem; display: block; margin-bottom: 8px; opacity: 0.4; }

        /* USER MENU */
        .user-menu { display: flex; align-items: center; gap: 10px; cursor: pointer; padding: 6px 12px; border-radius: 8px; border: 1px solid rgba(255,255,255,0.15); transition: background 0.15s; }
        .user-menu:hover { background: rgba(255,255,255,0.08); }
        .user-avatar { width: 34px; height: 34px; border-radius: 50%; background: linear-gradient(135deg, var(--purple-mid), var(--gold)); display: flex; align-items: center; justify-content: center; font-size: 0.9rem; font-weight: 700; color: #fff; flex-shrink: 0; }
        .user-name { font-size: 0.875rem; font-weight: 600; color: #fff; max-width: 120px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }
        .dropdown-menu-custom { position: absolute; top: 76px; right: 48px; background: #fff; border: 1px solid var(--border); border-radius: 10px; padding: 8px; min-width: 200px; box-shadow: 0 8px 32px rgba(0,0,0,0.15); display: none; z-index: 200; }
        .dropdown-menu-custom.show { display: block; }
        .dropdown-menu-custom a { display: flex; align-items: center; gap: 10px; padding: 10px 14px; border-radius: 7px; font-size: 0.875rem; color: var(--text); text-decoration: none; font-weight: 500; transition: background 0.12s; }
        .dropdown-menu-custom a:hover { background: var(--purple-light); color: var(--purple); }
        .dropdown-menu-custom .divider-drop { height: 1px; background: var(--border); margin: 6px 0; }
        .dropdown-menu-custom .logout-link { color: #CC0000; }
        .dropdown-menu-custom .logout-link:hover { background: #FFF3F3; color: #CC0000; }

        /* TOAST */
        .toast-noti { position: fixed; bottom: 32px; left: 50%; transform: translateX(-50%) translateY(20px); background: #1E0A4A; color: #fff; padding: 13px 24px; border-radius: 50px; font-size: 0.875rem; font-weight: 600; display: flex; align-items: center; gap: 10px; box-shadow: 0 8px 32px rgba(0,0,0,0.25); z-index: 9999; opacity: 0; transition: opacity 0.3s, transform 0.3s; pointer-events: none; white-space: nowrap; }
        .toast-noti.show { opacity: 1; transform: translateX(-50%) translateY(0); }
        .toast-noti.add  i { color: #FF6B6B; }
        .toast-noti.remove i { color: #aaa; }

        /* PAGE HEADER */
        .page-header { background: linear-gradient(135deg, var(--purple-deep) 0%, #3A1A7A 60%, #5B2DC5 100%); padding: 48px 80px 52px; position: relative; overflow: hidden; }
        .page-header::before { content: ''; position: absolute; width: 400px; height: 400px; border-radius: 50%; background: rgba(212,168,67,0.06); top: -150px; right: -80px; }
        .page-header::after { content: ''; position: absolute; width: 200px; height: 200px; border-radius: 50%; background: rgba(155,114,232,0.1); bottom: -60px; left: 200px; }
        .page-header-inner { position: relative; z-index: 1; }
        .page-eyebrow { font-size: 0.72rem; font-weight: 700; text-transform: uppercase; letter-spacing: 2px; color: var(--gold); margin-bottom: 10px; }
        .page-title { font-family: 'Playfair Display', serif; font-size: 2.4rem; font-weight: 700; color: #fff; margin-bottom: 10px; }
        .page-subtitle { font-size: 1rem; color: rgba(255,255,255,0.65); max-width: 480px; }
        .stats-row { display: flex; gap: 32px; margin-top: 28px; }
        .stat-num { font-size: 1.5rem; font-weight: 700; color: var(--gold); }
        .stat-lbl { font-size: 0.78rem; color: rgba(255,255,255,0.55); margin-top: 2px; }

        /* FILTER BAR */
        .filter-bar { background: #fff; border-bottom: 1px solid var(--border); padding: 14px 80px; display: flex; align-items: center; gap: 10px; flex-wrap: wrap; }
        .filter-chip { display: inline-flex; align-items: center; gap: 6px; padding: 6px 16px; border-radius: 20px; font-size: 0.82rem; font-weight: 600; border: 1.5px solid var(--border); background: #fff; color: var(--muted); cursor: pointer; transition: all 0.15s; }
        .filter-chip:hover { border-color: var(--purple); color: var(--purple); }
        .filter-chip.active { background: var(--purple); border-color: var(--purple); color: #fff; }
        .filter-label { font-size: 0.82rem; font-weight: 600; color: var(--muted); margin-right: 4px; }

        /* MAIN */
        .main-content { padding: 40px 80px 60px; }
        .alert-custom { display: flex; align-items: center; gap: 10px; padding: 12px 18px; border-radius: 10px; font-size: 0.875rem; font-weight: 500; margin-bottom: 24px; }
        .alert-error { background: #FFF3F3; border: 1px solid #FFCDD2; color: #C62828; }
        .alert-warn  { background: #FFF8E1; border: 1px solid #FFE082; color: #E65100; }

        /* TRENDING */
        .trending-section { margin-bottom: 48px; }
        .trending-title { font-family: 'Playfair Display', serif; font-size: 1.5rem; font-weight: 700; color: var(--text); margin-bottom: 20px; display: flex; align-items: center; gap: 10px; }
        .trending-title i { color: var(--purple); font-size: 1.3rem; }
        .trending-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 20px; }
        .trending-col { background: #EEE8FA; border-radius: 14px; padding: 20px; border: 1px solid rgba(108,63,197,0.1); }
        .trending-col-header { display: flex; align-items: center; justify-content: space-between; margin-bottom: 16px; }
        .trending-col-title { font-size: 0.92rem; font-weight: 700; color: var(--purple-dark); }
        .trending-col-link { font-size: 0.78rem; font-weight: 600; color: var(--purple); text-decoration: none; display: flex; align-items: center; gap: 3px; }
        .trending-col-link:hover { color: var(--purple-dark); }
        .mini-course-card { background: #fff; border-radius: 10px; padding: 12px; display: flex; gap: 12px; align-items: center; margin-bottom: 10px; text-decoration: none; color: var(--text); border: 1px solid transparent; transition: border-color 0.15s, box-shadow 0.15s; cursor: pointer; }
        .mini-course-card:last-child { margin-bottom: 0; }
        .mini-course-card:hover { border-color: var(--purple-mid); box-shadow: 0 4px 16px rgba(108,63,197,0.1); color: var(--text); }
        .mini-thumb { width: 60px; height: 60px; border-radius: 8px; overflow: hidden; flex-shrink: 0; background: linear-gradient(135deg, var(--purple-deep), var(--purple)); display: flex; align-items: center; justify-content: center; font-size: 1.4rem; }
        .mini-thumb img { width: 100%; height: 100%; object-fit: cover; }
        .mini-info { flex: 1; min-width: 0; }
        .mini-org { font-size: 0.65rem; font-weight: 700; color: var(--muted); text-transform: uppercase; letter-spacing: 0.5px; margin-bottom: 3px; display: flex; align-items: center; gap: 4px; }
        .mini-name { font-size: 0.82rem; font-weight: 700; color: var(--text); line-height: 1.35; margin-bottom: 5px; }
        .mini-meta { font-size: 0.68rem; color: var(--muted); display: flex; align-items: center; gap: 6px; }
        .mini-star { color: var(--gold); }
        .mini-price { font-size: 0.75rem; font-weight: 700; color: var(--purple); white-space: nowrap; flex-shrink: 0; }

        /* ALL COURSES */
        .all-courses-header { display: flex; align-items: center; justify-content: space-between; margin-bottom: 20px; }
        .all-courses-title { font-family: 'Playfair Display', serif; font-size: 1.5rem; font-weight: 700; color: var(--text); }
        .course-count-badge { background: var(--purple-light); color: var(--purple); font-size: 0.78rem; font-weight: 700; padding: 4px 12px; border-radius: 20px; }
        .course-grid-full { display: grid; grid-template-columns: repeat(4, 1fr); gap: 20px; }
        .course-card-full { background: #fff; border: 1px solid var(--border); border-radius: 14px; overflow: hidden; color: var(--text); transition: box-shadow 0.2s, transform 0.2s; display: flex; flex-direction: column; }
        .course-card-full:hover { box-shadow: 0 12px 36px rgba(108,63,197,0.15); transform: translateY(-4px); }
        .course-card-full.completed { border-color: #FFD54F; }
        .card-thumb { height: 150px; overflow: hidden; position: relative; background: linear-gradient(135deg, var(--purple-deep), var(--purple)); display: flex; align-items: center; justify-content: center; font-size: 3rem; }
        .card-thumb img { width: 100%; height: 100%; object-fit: cover; object-position: center; position: absolute; top: 0; left: 0; }
        .card-thumb-overlay { position: absolute; inset: 0; background: linear-gradient(to top, rgba(30,10,74,0.5) 0%, transparent 60%); }
        .card-topic-badge { position: absolute; top: 10px; left: 10px; background: rgba(255,255,255,0.92); color: var(--purple); font-size: 0.62rem; font-weight: 700; padding: 3px 9px; border-radius: 4px; text-transform: uppercase; letter-spacing: 0.5px; z-index: 2; }
        .card-completed-overlay { position: absolute; top: 10px; right: 48px; background: linear-gradient(135deg, #FFB300, #FF8F00); color: #fff; font-size: 0.62rem; font-weight: 700; padding: 3px 9px; border-radius: 4px; display: flex; align-items: center; gap: 4px; z-index: 2; }

        /* WISHLIST BTN ON CARD */
        .btn-wishlist { position: absolute; top: 8px; right: 8px; width: 30px; height: 30px; border-radius: 50%; background: rgba(255,255,255,0.92); border: none; cursor: pointer; display: flex; align-items: center; justify-content: center; font-size: 0.9rem; transition: all 0.15s; z-index: 3; box-shadow: 0 2px 8px rgba(0,0,0,0.15); }
        .btn-wishlist:hover { background: #fff; transform: scale(1.2); }
        .btn-wishlist.in-wish { color: #E53935; }
        .btn-wishlist:not(.in-wish) { color: #bbb; }

        .card-body { padding: 16px; flex: 1; display: flex; flex-direction: column; }
        .card-org { font-size: 0.68rem; font-weight: 700; color: var(--muted); text-transform: uppercase; letter-spacing: 0.5px; margin-bottom: 6px; }
        .card-name { font-size: 0.88rem; font-weight: 700; line-height: 1.4; color: var(--text); margin-bottom: 10px; flex: 1; }
        .card-meta { display: flex; align-items: center; gap: 6px; font-size: 0.72rem; color: var(--muted); margin-bottom: 12px; }
        .card-stars { color: var(--gold); font-size: 0.7rem; }
        .card-footer-row { display: flex; align-items: center; justify-content: space-between; padding-top: 12px; border-top: 1px solid var(--border); }
        .card-price { font-size: 1rem; font-weight: 700; color: var(--purple); }
        .card-price.free { color: #2E7D32; }
        .card-enroll-btn { background: var(--purple); color: #fff; border: none; padding: 7px 16px; border-radius: 7px; font-size: 0.78rem; font-weight: 700; cursor: pointer; transition: background 0.15s, transform 0.1s; font-family: 'DM Sans', sans-serif; }
        .card-enroll-btn:hover { background: var(--purple-dark); transform: translateY(-1px); }
        .card-study-btn { display: inline-flex; align-items: center; gap: 6px; background: linear-gradient(135deg, #2E7D32, #388E3C); color: #fff; font-size: 0.78rem; font-weight: 700; padding: 7px 16px; border-radius: 7px; text-decoration: none; transition: all 0.15s; }
        .card-study-btn:hover { background: linear-gradient(135deg, #1B5E20, #2E7D32); transform: translateY(-1px); color: #fff; }
        .card-replay-btn { display: inline-flex; align-items: center; gap: 6px; background: linear-gradient(135deg, #F59E0B, #D97706); color: #fff; font-size: 0.78rem; font-weight: 700; padding: 7px 16px; border-radius: 7px; text-decoration: none; transition: all 0.15s; }
        .card-replay-btn:hover { background: linear-gradient(135deg, #D97706, #B45309); transform: translateY(-1px); color: #fff; }
        .card-price.enrolled-label { font-size: 0.72rem; font-weight: 700; color: #2E7D32; background: #E8F5E9; padding: 4px 10px; border-radius: 20px; border: 1px solid #C8E6C9; }
        .card-price.completed-label { font-size: 0.72rem; font-weight: 700; color: #B8860B; background: #FFF9C4; padding: 4px 10px; border-radius: 20px; border: 1px solid #FFD54F; }
        .card-login-link { font-size: 0.78rem; font-weight: 600; color: var(--purple); text-decoration: none; }
        .card-login-link:hover { text-decoration: underline; }
        .empty-state { text-align: center; padding: 80px 20px; grid-column: 1 / -1; }
        .empty-icon { font-size: 4rem; margin-bottom: 16px; opacity: 0.4; }
        .empty-title { font-size: 1.2rem; font-weight: 700; color: var(--muted); margin-bottom: 8px; }
        .empty-sub { font-size: 0.9rem; color: var(--muted); }
        .bg1 { background: linear-gradient(135deg, #1E0A4A, #6C3FC5); }
        .bg2 { background: linear-gradient(135deg, #3A1A7A, #9B72E8); }
        .bg3 { background: linear-gradient(135deg, #4E2C96, #D4A843); }
        .bg4 { background: linear-gradient(135deg, #1A0D35, #5B2DC5); }
        .bg5 { background: linear-gradient(135deg, #0D47A1, #1565C0); }
        .bg6 { background: linear-gradient(135deg, #1B5E20, #388E3C); }

        /* MODAL */
        .modal-overlay { display: none; position: fixed; inset: 0; background: rgba(10,5,30,0.65); backdrop-filter: blur(5px); z-index: 1000; align-items: center; justify-content: center; }
        .modal-overlay.show { display: flex; }
        .modal-box { background: #fff; border-radius: 20px; padding: 36px; width: 440px; max-width: 95vw; box-shadow: 0 24px 64px rgba(108,63,197,0.3); animation: modalIn 0.25s cubic-bezier(0.34,1.56,0.64,1); }
        @keyframes modalIn { from { transform: scale(0.88) translateY(24px); opacity: 0; } to { transform: scale(1) translateY(0); opacity: 1; } }
        .modal-icon { width: 58px; height: 58px; border-radius: 16px; background: var(--purple-light); display: flex; align-items: center; justify-content: center; font-size: 1.7rem; margin-bottom: 18px; }
        .modal-title { font-family: 'Playfair Display', serif; font-size: 1.35rem; font-weight: 700; color: var(--text); margin-bottom: 6px; }
        .modal-course-name { font-size: 0.88rem; font-weight: 600; color: var(--purple); margin-bottom: 22px; line-height: 1.4; }
        .modal-info-row { display: flex; justify-content: space-between; align-items: center; background: var(--bg); border-radius: 10px; padding: 13px 16px; margin-bottom: 8px; }
        .modal-info-label { font-size: 0.82rem; color: var(--muted); font-weight: 500; display: flex; align-items: center; gap: 6px; }
        .modal-info-value { font-size: 0.9rem; font-weight: 700; }
        .modal-info-value.fee-val     { color: var(--purple); font-size: 1rem; }
        .modal-info-value.balance-val { color: #2E7D32; }
        .modal-info-value.after-val   { color: var(--gold); }
        .modal-info-value.danger-val  { color: #C62828; }
        .modal-divider { height: 1px; background: var(--border); margin: 14px 0; }
        .modal-actions { display: flex; gap: 10px; margin-top: 22px; }
        .btn-cancel { flex: 1; padding: 12px; border-radius: 10px; border: 1.5px solid var(--border); background: #fff; color: var(--muted); font-size: 0.88rem; font-weight: 700; cursor: pointer; font-family: 'DM Sans', sans-serif; transition: all 0.15s; }
        .btn-cancel:hover { border-color: var(--purple); color: var(--purple); }
        .btn-confirm { flex: 2; padding: 12px; border-radius: 10px; border: none; background: linear-gradient(135deg, var(--purple), var(--purple-dark)); color: #fff; font-size: 0.88rem; font-weight: 700; cursor: pointer; font-family: 'DM Sans', sans-serif; transition: all 0.15s; display: flex; align-items: center; justify-content: center; gap: 8px; }
        .btn-confirm:hover:not(:disabled) { transform: translateY(-1px); box-shadow: 0 6px 20px rgba(108,63,197,0.4); }
        .btn-confirm:disabled { opacity: 0.5; cursor: not-allowed; }
        .modal-warning { display: none; background: #FFF3F3; border: 1px solid #FFCDD2; border-radius: 8px; padding: 10px 14px; margin-top: 12px; font-size: 0.82rem; color: #C62828; font-weight: 600; }

        /* LOADING OVERLAY khi đang enroll */
        .enroll-loading { display: none; position: fixed; inset: 0; background: rgba(10,5,30,0.55); backdrop-filter: blur(4px); z-index: 2000; align-items: center; justify-content: center; flex-direction: column; gap: 16px; }
        .enroll-loading.show { display: flex; }
        .enroll-spinner { width: 52px; height: 52px; border: 4px solid rgba(255,255,255,0.2); border-top-color: #fff; border-radius: 50%; animation: spin 0.8s linear infinite; }
        @keyframes spin { to { transform: rotate(360deg); } }
        .enroll-loading-text { color: #fff; font-size: 0.95rem; font-weight: 600; }

        @media (max-width: 1200px) { .course-grid-full { grid-template-columns: repeat(3, 1fr); } .trending-grid { grid-template-columns: repeat(2, 1fr); } }
        @media (max-width: 900px) { .course-grid-full { grid-template-columns: repeat(2, 1fr); } .trending-grid { grid-template-columns: 1fr; } .main-content, .page-header, .filter-bar { padding-left: 20px; padding-right: 20px; } .navbar-main { padding: 0 20px; } .search-bar { display: none; } }
        @media (max-width: 600px) { .course-grid-full { grid-template-columns: 1fr; } }
    </style>
</head>
<body>

<!-- TOAST NOTIFICATION -->
<div class="toast-noti" id="toastNoti">
    <i class="bi bi-heart-fill"></i>
    <span id="toastMsg">Đã thêm vào mục yêu thích</span>
</div>

<!-- LOADING OVERLAY khi enroll -->
<div class="enroll-loading" id="enrollLoading">
    <div class="enroll-spinner"></div>
    <div class="enroll-loading-text">Đang đăng ký khóa học...</div>
</div>

<!-- NAVBAR -->
<nav class="navbar-main" style="position:relative;">
    <a href="homePage.jsp" class="brand">DUK<span>Academy</span></a>
    <ul class="nav-links">
        <li><a href="homePage.jsp">Trang chủ</a></li>
        <li><a href="courseController?action=ExploreCourse" class="active">Khóa học</a></li>
        <li><a href="instructors.jsp">Giảng viên</a></li>
        <li><a href="#">Về chúng tôi</a></li>
        <li><a href="dating.jsp">study and date</a></li>
    </ul>
    <div class="nav-right">
        <div class="search-bar">
            <i class="bi bi-search"></i>
            <input type="text" placeholder="Tìm khóa học..." id="searchInput" oninput="filterCourses()">
        </div>

        <c:if test="${not empty sessionScope.user}">
            <!-- BALANCE PILL -->
            <a href="paymentController" class="balance-pill">
                <i class="bi bi-wallet2"></i>
                <span class="balance-label">Số dư</span>
                <span class="balance-amount"><fmt:formatNumber value="${sessionScope.user.balance}" type="number"/> ₫</span>
            </a>

            <!-- WISHLIST PILL + DROPDOWN -->
            <div class="wishlist-pill-wrap" id="wishlistWrap">
                <div class="wishlist-pill" onclick="toggleWishlistDD(event)">
                    <i class="bi bi-heart-fill"></i>
                    <span class="wishlist-pill-label">Yêu thích</span>
                    <span class="wishlist-pill-count" id="wishCount">${not empty WISHLIST_IDS ? WISHLIST_IDS.size() : 0}</span>
                </div>
                <div class="wishlist-dropdown" id="wishlistDD">
                    <div class="wishlist-dd-header">
                        <span class="wishlist-dd-title"><i class="bi bi-heart-fill"></i> Khóa học yêu thích</span>
                        <a href="wishlistController?action=view&userId=${sessionScope.user.userId}" class="wishlist-dd-link">Xem tất cả</a>
                    </div>
                    <div class="wishlist-dd-list" id="wishlistDDList">
                        <c:choose>
                            <c:when test="${not empty WISHLIST_COURSES}">
                                <c:forEach var="wc" items="${WISHLIST_COURSES}">
                                    <div class="wishlist-dd-item" id="wish-item-${wc.courseId}">
                                        <div class="wishlist-dd-thumb">
                                            <img src="${pageContext.request.contextPath}/img/courses/course${wc.courseId}.jpg"
                                                 alt="${wc.courseName}" onerror="this.style.display='none';">
                                        </div>
                                        <div class="wishlist-dd-info">
                                            <div class="wishlist-dd-name">${wc.courseName}</div>
                                            <div class="wishlist-dd-price">
                                                <c:choose>
                                                    <c:when test="${wc.fee == 0}">Miễn phí</c:when>
                                                    <c:otherwise><fmt:formatNumber value="${wc.fee}" type="number"/> ₫</c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                        <button class="wishlist-dd-remove" title="Xóa khỏi yêu thích"
                                                onclick="toggleWishlist(event, '${wc.courseId}', '${fn:escapeXml(wc.courseName)}', '${wc.fee}')">
                                            <i class="bi bi-x"></i>
                                        </button>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div class="wishlist-dd-empty" id="wishEmptyMsg">
                                    <i class="bi bi-heart"></i>
                                    Chưa có khóa học yêu thích
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </c:if>

        <c:choose>
            <c:when test="${not empty sessionScope.user}">
                <div class="user-menu" onclick="toggleDropdown()">
                    <div class="user-avatar">${fn:substring(sessionScope.user.fullname, 0, 1)}</div>
                    <span class="user-name">${sessionScope.user.fullname}</span>
                    <i class="bi bi-chevron-down" style="color:rgba(255,255,255,0.6); font-size:0.75rem;"></i>
                </div>
                <div class="dropdown-menu-custom" id="userDropdown">
                    <a href="myprofile.jsp"><i class="bi bi-person"></i> Hồ sơ của tôi</a>
                    <a href="myCourses"><i class="bi bi-book"></i> Khóa học của tôi</a>
                    <a href="paymentController"><i class="bi bi-wallet2"></i> Nạp tiền</a>
                    <a href="Certificates.jsp"><i class="bi bi-award"></i> Chứng chỉ</a>
                    <div class="divider-drop"></div>
                    <a href="mainController?action=logout" class="logout-link"><i class="bi bi-box-arrow-right"></i> Đăng xuất</a>
                </div>
            </c:when>
            <c:otherwise>
                <a href="login.jsp" style="color:rgba(255,255,255,0.75); text-decoration:none; font-size:0.875rem; font-weight:500;">Đăng nhập</a>
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

<!-- FILTER BAR -->
<div class="filter-bar">
    <span class="filter-label"><i class="bi bi-funnel"></i> Lọc:</span>
    <span class="filter-chip active" onclick="filterByTopic(this, '')">Tất cả</span>
    <span class="filter-chip" onclick="filterByTopic(this, 'ai')">🤖 AI & ML</span>
    <span class="filter-chip" onclick="filterByTopic(this, 'data')">📊 Data Science</span>
    <span class="filter-chip" onclick="filterByTopic(this, 'web')">💻 Web Dev</span>
    <span class="filter-chip" onclick="filterByTopic(this, 'design')">🎨 Design</span>
    <span class="filter-chip" onclick="filterByTopic(this, 'business')">💼 Business</span>
    <span class="filter-chip" onclick="filterByTopic(this, 'mobile')">📱 Mobile</span>
    <span class="filter-chip" onclick="filterByTopic(this, 'cloud')">☁️ Cloud</span>
    <span class="filter-chip" onclick="filterByTopic(this, 'security')">🔐 Security</span>
    <span class="filter-chip" onclick="filterByTopic(this, 'language')">🌐 Ngôn ngữ</span>
    <span class="filter-chip" onclick="filterByTopic(this, 'programming')">⌨️ Lập trình</span>
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
            <div class="trending-col">
                <div class="trending-col-header"><span class="trending-col-title">🏆 Phổ biến nhất</span><a href="#all-courses" class="trending-col-link">Xem tất cả <i class="bi bi-arrow-right"></i></a></div>
                <c:forEach var="course" items="${COURSE_LIST}" begin="0" end="2">
                    <div class="mini-course-card">
                        <div class="mini-thumb bg1"><img src="${pageContext.request.contextPath}/img/courses/course${course.courseId}.jpg" alt="${course.courseName}" onerror="this.style.display='none';"></div>
                        <div class="mini-info">
                            <div class="mini-org"><i class="bi bi-building"></i> DUK Academy</div>
                            <div class="mini-name">${course.courseName}</div>
                            <div class="mini-meta"><span class="mini-star">★★★★★</span><span>${course.topic}</span></div>
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
            <div class="trending-col">
                <div class="trending-col-header"><span class="trending-col-title">✨ Mới nhất</span><a href="#all-courses" class="trending-col-link">Xem tất cả <i class="bi bi-arrow-right"></i></a></div>
                <c:forEach var="course" items="${COURSE_LIST}" begin="3" end="5">
                    <div class="mini-course-card">
                        <div class="mini-thumb bg2"><img src="${pageContext.request.contextPath}/img/courses/course${course.courseId}.jpg" alt="${course.courseName}" onerror="this.style.display='none';"></div>
                        <div class="mini-info">
                            <div class="mini-org"><i class="bi bi-building"></i> DUK Academy</div>
                            <div class="mini-name">${course.courseName}</div>
                            <div class="mini-meta"><span class="mini-star">★★★★★</span><span>${course.topic}</span></div>
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
            <div class="trending-col">
                <div class="trending-col-header"><span class="trending-col-title">🤖 Kỹ năng AI hot</span><a href="#all-courses" class="trending-col-link">Xem tất cả <i class="bi bi-arrow-right"></i></a></div>
                <c:forEach var="course" items="${COURSE_LIST}" begin="6" end="8">
                    <div class="mini-course-card">
                        <div class="mini-thumb bg3"><img src="${pageContext.request.contextPath}/img/courses/course${course.courseId}.jpg" alt="${course.courseName}" onerror="this.style.display='none';"></div>
                        <div class="mini-info">
                            <div class="mini-org"><i class="bi bi-building"></i> DUK Academy</div>
                            <div class="mini-name">${course.courseName}</div>
                            <div class="mini-meta"><span class="mini-star">★★★★★</span><span>${course.topic}</span></div>
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
            <div class="all-courses-title">Tất cả khóa học</div>
            <span class="course-count-badge" id="courseCount">${not empty COURSE_LIST ? COURSE_LIST.size() : 0} khóa học</span>
        </div>
        <div class="course-grid-full" id="courseGrid">
            <c:choose>
                <c:when test="${not empty COURSE_LIST}">
                    <c:forEach var="course" items="${COURSE_LIST}" varStatus="st">
                        <c:set var="isEnrolled"  value="false"/>
                        <c:set var="isCompleted" value="false"/>
                        <c:set var="inWishlist"  value="false"/>
                        <c:if test="${not empty sessionScope.user}">
                            <c:forEach var="eid" items="${ENROLLED_IDS}"><c:if test="${eid == course.courseId}"><c:set var="isEnrolled" value="true"/></c:if></c:forEach>
                            <c:forEach var="cid" items="${COMPLETED_IDS}"><c:if test="${cid == course.courseId}"><c:set var="isCompleted" value="true"/></c:if></c:forEach>
                            <c:forEach var="wid" items="${WISHLIST_IDS}"><c:if test="${wid == course.courseId}"><c:set var="inWishlist" value="true"/></c:if></c:forEach>
                        </c:if>

                        <div class="course-card-full ${isCompleted ? 'completed' : ''}"
                             data-topic="${course.topic}" data-name="${course.courseName}">
                            <div class="card-thumb bg${(st.index % 6) + 1}">
                                <img src="${pageContext.request.contextPath}/img/courses/course${course.courseId}.jpg"
                                     alt="${course.courseName}" onerror="this.style.display='none';">
                                <div class="card-thumb-overlay"></div>
                                <span class="card-topic-badge">${course.topic}</span>
                                <c:if test="${isCompleted}">
                                    <span class="card-completed-overlay"><i class="bi bi-trophy-fill"></i> Hoàn thành</span>
                                </c:if>
                                <c:if test="${not empty sessionScope.user}">
                                    <button class="btn-wishlist ${inWishlist ? 'in-wish' : ''}"
                                            id="wish-btn-${course.courseId}"
                                            title="${inWishlist ? 'Bỏ yêu thích' : 'Thêm yêu thích'}"
                                            onclick="toggleWishlist(event, '${course.courseId}', '${fn:escapeXml(course.courseName)}', '${course.fee}')">
                                        <i class="bi ${inWishlist ? 'bi-heart-fill' : 'bi-heart'}"></i>
                                    </button>
                                </c:if>
                            </div>
                            <div class="card-body">
                                <div class="card-org">DUK Academy</div>
                                <div class="card-name">${course.courseName}</div>
                                <div class="card-meta">
                                    <span class="card-stars">★★★★★</span><span>4.8</span><span>·</span>
                                    <span><i class="bi bi-people"></i> 1.2K học viên</span>
                                </div>
                                <div class="card-footer-row">
                                    <c:choose>
                                        <c:when test="${isCompleted}"><span class="card-price completed-label"><i class="bi bi-trophy-fill"></i> Hoàn thành</span></c:when>
                                        <c:when test="${isEnrolled}"><span class="card-price enrolled-label"><i class="bi bi-check2-circle"></i> Đã đăng ký</span></c:when>
                                        <c:otherwise>
                                            <span class="card-price ${course.fee == 0 ? 'free' : ''}">
                                                <c:choose>
                                                    <c:when test="${course.fee == 0}">Miễn phí</c:when>
                                                    <c:otherwise><fmt:formatNumber value="${course.fee}" type="number"/> ₫</c:otherwise>
                                                </c:choose>
                                            </span>
                                        </c:otherwise>
                                    </c:choose>
                                    <c:choose>
                                        <c:when test="${empty sessionScope.user}"><a href="login.jsp" class="card-login-link"><i class="bi bi-lock"></i> Đăng nhập</a></c:when>
                                        <c:when test="${isCompleted}"><a href="lesson?courseId=${course.courseId}" class="card-replay-btn"><i class="bi bi-arrow-repeat"></i> Học lại</a></c:when>
                                        <c:when test="${isEnrolled}"><a href="lesson?courseId=${course.courseId}" class="card-study-btn"><i class="bi bi-play-circle-fill"></i> Vào học</a></c:when>
                                        <c:otherwise>
                                            <button type="button" class="card-enroll-btn"
                                                onclick="openModal('${course.courseId}','${fn:escapeXml(course.courseName)}','${course.fee}','${sessionScope.user.balance}')">
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
                    <div class="empty-state"><div class="empty-icon">📚</div><div class="empty-title">Chưa có khóa học nào</div><div class="empty-sub">Vui lòng quay lại sau hoặc liên hệ quản trị viên.</div></div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<!-- FOOTER -->
<footer style="background: var(--purple-deep); padding: 32px 80px; margin-top: 40px;">
    <div style="display:flex; justify-content:space-between; align-items:center; border-top:1px solid rgba(255,255,255,0.08); padding-top:20px;">
        <span style="font-family:'Playfair Display',serif; font-size:1.2rem; font-weight:700; color:#fff;">DUK<span style="color:var(--gold);">Academy</span></span>
        <span style="font-size:0.78rem; color:rgba(255,255,255,0.35);">© 2026 DUK Academy. All rights reserved.</span>
    </div>
</footer>

<!-- MODAL XÁC NHẬN ĐĂNG KÝ -->
<div class="modal-overlay" id="enrollModal" onclick="closeModalOutside(event)">
    <div class="modal-box">
        <div class="modal-icon">🎓</div>
        <div class="modal-title">Xác nhận đăng ký</div>
        <div class="modal-course-name" id="modalCourseName">—</div>
        <div class="modal-info-row"><span class="modal-info-label"><i class="bi bi-tag-fill"></i> Học phí</span><span class="modal-info-value fee-val" id="modalFee">—</span></div>
        <div class="modal-info-row"><span class="modal-info-label"><i class="bi bi-wallet2"></i> Số dư hiện tại</span><span class="modal-info-value balance-val" id="modalBalance">—</span></div>
        <div class="modal-divider"></div>
        <div class="modal-info-row"><span class="modal-info-label"><i class="bi bi-arrow-right-circle-fill"></i> Số dư sau đăng ký</span><span class="modal-info-value after-val" id="modalAfter">—</span></div>
        <div class="modal-warning" id="modalWarning">
            <i class="bi bi-exclamation-triangle-fill"></i>
            Số dư không đủ! <a href="paymentController" style="color:#C62828; font-weight:700;">Nạp tiền ngay →</a>
        </div>
        <%--
            FIX: Form enroll giờ submit qua JS để có thể show loading overlay
            trước khi redirect. EnrollServlet phải redirect về:
              lesson?courseId=X&lessonId=<first_lesson_id>
            để trang lesson.jsp load đúng bài đầu tiên kèm video ngay lập tức.
        --%>
        <form id="enrollForm" action="enroll" method="post" onsubmit="onEnrollSubmit()">
            <input type="hidden" name="courseId" id="modalCourseId">
            <div class="modal-actions">
                <button type="button" class="btn-cancel" onclick="closeModal()"><i class="bi bi-x-circle"></i> Hủy</button>
                <button type="submit" class="btn-confirm" id="btnConfirm"><i class="bi bi-check-circle-fill"></i> Xác nhận đăng ký</button>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    const USER_ID = '${sessionScope.user.userId}';

    /* ===== DROPDOWN USER ===== */
    function toggleDropdown() { document.getElementById('userDropdown').classList.toggle('show'); }

    /* ===== DROPDOWN WISHLIST ===== */
    function toggleWishlistDD(e) {
        e.stopPropagation();
        document.getElementById('wishlistDD').classList.toggle('show');
        document.getElementById('userDropdown') && document.getElementById('userDropdown').classList.remove('show');
    }

    document.addEventListener('click', function(e) {
        const ud = document.getElementById('userDropdown');
        const um = document.querySelector('.user-menu');
        const wd = document.getElementById('wishlistDD');
        const ww = document.getElementById('wishlistWrap');
        if (ud && um && !um.contains(e.target) && !ud.contains(e.target)) ud.classList.remove('show');
        if (wd && ww && !ww.contains(e.target)) wd.classList.remove('show');
    });

    /* ===== TOAST ===== */
    let toastTimer;
    function showToast(msg, type) {
        const el = document.getElementById('toastNoti');
        document.getElementById('toastMsg').textContent = msg;
        el.querySelector('i').className = type === 'add' ? 'bi bi-heart-fill' : 'bi bi-heart';
        el.className = 'toast-noti ' + type + ' show';
        clearTimeout(toastTimer);
        toastTimer = setTimeout(() => el.classList.remove('show'), 2800);
    }

    /* ===== WISHLIST AJAX ===== */
    function toggleWishlist(e, courseId, courseName, fee) {
        e.preventDefault();
        e.stopPropagation();
        if (!USER_ID) { window.location.href = 'login.jsp'; return; }

        const btn  = document.getElementById('wish-btn-' + courseId);
        const isIn = btn && btn.classList.contains('in-wish');
        const url  = 'wishlistController?action=' + (isIn ? 'remove' : 'add')
                   + '&courseId=' + courseId + '&userId=' + USER_ID + '&ajax=1';

        fetch(url).then(() => {
            if (!isIn) {
                if (btn) { btn.classList.add('in-wish'); btn.querySelector('i').className = 'bi bi-heart-fill'; btn.title = 'Bỏ yêu thích'; }
                addToWishlistDD(courseId, courseName, fee);
                updateWishCount(1);
                showToast('Đã thêm vào mục yêu thích ❤️', 'add');
            } else {
                if (btn) { btn.classList.remove('in-wish'); btn.querySelector('i').className = 'bi bi-heart'; btn.title = 'Thêm yêu thích'; }
                const item = document.getElementById('wish-item-' + courseId);
                if (item) item.remove();
                updateWishCount(-1);
                checkWishlistEmpty();
                showToast('Đã xóa khỏi mục yêu thích', 'remove');
            }
        }).catch(() => showToast('Có lỗi xảy ra, thử lại sau', 'remove'));
    }

    function addToWishlistDD(courseId, courseName, fee) {
        const list = document.getElementById('wishlistDDList');
        const empty = document.getElementById('wishEmptyMsg');
        if (empty) empty.remove();
        if (document.getElementById('wish-item-' + courseId)) return;
        const feeText = (parseFloat(fee) === 0) ? 'Miễn phí' : Number(fee).toLocaleString('vi-VN') + ' \u20ab';
        const div = document.createElement('div');
        div.className = 'wishlist-dd-item';
        div.id = 'wish-item-' + courseId;
        div.innerHTML =
            '<div class="wishlist-dd-thumb">\uD83D\uDCDA</div>' +
            '<div class="wishlist-dd-info">' +
                '<div class="wishlist-dd-name">' + courseName + '</div>' +
                '<div class="wishlist-dd-price">' + feeText + '</div>' +
            '</div>' +
            '<button class="wishlist-dd-remove" title="X\u00f3a"><i class="bi bi-x"></i></button>';
        div.querySelector('button').addEventListener('click', function(e) {
            toggleWishlist(e, courseId, courseName, fee);
        });
        list.insertBefore(div, list.firstChild);
    }

    function updateWishCount(delta) {
        const el = document.getElementById('wishCount');
        if (el) el.textContent = Math.max(0, parseInt(el.textContent || '0') + delta);
    }

    function checkWishlistEmpty() {
        const list = document.getElementById('wishlistDDList');
        if (list && list.querySelectorAll('.wishlist-dd-item').length === 0)
            list.innerHTML = '<div class="wishlist-dd-empty" id="wishEmptyMsg"><i class="bi bi-heart"></i>Chưa có khóa học yêu thích</div>';
    }

    /* ===== MODAL ===== */
    function fmt(val) { return Number(val).toLocaleString('vi-VN') + ' ₫'; }

    function openModal(courseId, courseName, fee, balance) {
        const feeNum = parseFloat(fee) || 0, balNum = parseFloat(balance) || 0, after = balNum - feeNum;
        document.getElementById('modalCourseId').value         = courseId;
        document.getElementById('modalCourseName').textContent = courseName;
        document.getElementById('modalFee').textContent        = fmt(feeNum);
        document.getElementById('modalBalance').textContent    = fmt(balNum);
        const afterEl = document.getElementById('modalAfter');
        const warnEl  = document.getElementById('modalWarning');
        const confirmEl = document.getElementById('btnConfirm');
        if (after < 0) {
            afterEl.textContent = 'Không đủ số dư!';
            afterEl.className   = 'modal-info-value danger-val';
            warnEl.style.display  = 'block';
            confirmEl.disabled    = true;
        } else {
            afterEl.textContent = fmt(after);
            afterEl.className   = 'modal-info-value after-val';
            warnEl.style.display  = 'none';
            confirmEl.disabled    = false;
        }
        document.getElementById('enrollModal').classList.add('show');
        document.body.style.overflow = 'hidden';
    }

    function closeModal() {
        document.getElementById('enrollModal').classList.remove('show');
        document.body.style.overflow = '';
    }

    function closeModalOutside(e) {
        if (e.target === document.getElementById('enrollModal')) closeModal();
    }

    document.addEventListener('keydown', e => { if (e.key === 'Escape') closeModal(); });

    /* ===== ENROLL SUBMIT — hiện loading overlay ===== */
    function onEnrollSubmit() {
        // Đóng modal, hiện loading spinner trong khi server xử lý và redirect
        document.getElementById('enrollModal').classList.remove('show');
        document.body.style.overflow = '';
        document.getElementById('enrollLoading').classList.add('show');
        // Form submit bình thường (không preventDefault), server sẽ redirect
        // EnrollServlet cần redirect về: lesson?courseId=X&lessonId=<first_lesson_id>
    }

    /* ===== FILTER ===== */
    const TOPIC_MAP = {
        ai:['ai','machine learning','ml','deep learning','neural','nlp','computer vision','tensorflow','pytorch','chatgpt','llm','generative','prompt'],
        data:['data','python','pandas','sql','analytics','statistics','tableau','power bi','excel','bi','hadoop','spark','etl'],
        web:['web','html','css','javascript','js','react','vue','angular','nodejs','php','laravel','django','flask','frontend','backend','fullstack','typescript','next.js','api','rest','java'],
        design:['design','ui','ux','figma','photoshop','illustrator','graphic','adobe','canva','sketch','prototype','wireframe'],
        mobile:['mobile','android','ios','flutter','react native','swift','kotlin','app'],
        cloud:['cloud','aws','azure','gcp','google cloud','devops','docker','kubernetes','ci/cd','linux','server','network'],
        security:['security','cybersecurity','hacking','ethical','pentest','firewall','encryption','blockchain','crypto'],
        language:['english','tiếng anh','giao tiếp','ielts','toeic','toefl','japanese','tiếng nhật','korean','tiếng hàn','chinese','tiếng trung','french','tiếng pháp','german','language','ngôn ngữ','communication','speaking','writing','grammar'],
        programming:['java','c++','c#','golang','go lang','rust','ruby','scala','kotlin','swift','algorithm','data structure','cấu trúc dữ liệu','lập trình','programming','oop','design pattern','clean code'],
        business:['business','marketing','management','finance','accounting','hr','leadership','project management','scrum','agile','pmp','mba'],
    };

    function getTopicGroup(t) {
        t = (t || '').toLowerCase();
        for (const [g, kws] of Object.entries(TOPIC_MAP)) {
            if (kws.some(kw => t.includes(kw))) return g;
        }
        return t;
    }

    document.querySelectorAll('.course-card-full').forEach(c => {
        c.dataset.group = getTopicGroup(c.dataset.topic || '');
    });

    let currentGroup = '';
    function filterByTopic(el, group) {
        document.querySelectorAll('.filter-chip').forEach(c => c.classList.remove('active'));
        el.classList.add('active');
        currentGroup = group;
        applyFilters();
    }

    function filterCourses() { applyFilters(); }

    function applyFilters() {
        const search = (document.getElementById('searchInput')?.value || '').toLowerCase();
        let visible = 0;
        document.querySelectorAll('.course-card-full').forEach(card => {
            const ok = (!search || ((card.dataset.name || '').toLowerCase().includes(search) || (card.dataset.topic || '').toLowerCase().includes(search)))
                    && (!currentGroup || card.dataset.group === currentGroup);
            card.style.display = ok ? '' : 'none';
            if (ok) visible++;
        });
        const b = document.getElementById('courseCount');
        if (b) b.textContent = visible + ' khóa học';
    }
</script>
</body>
</html>
