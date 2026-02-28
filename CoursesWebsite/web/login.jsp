<%-- 
    Document   : welcome
    Author     : HOANG KHANG PC
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>LearnVerse</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&family=DM+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
        <style>
            :root {
                --purple:      #6C3FC5;
                --purple-dark: #4E2C96;
                --purple-deep: #1E0A4A;
                --purple-light:#F3EEFF;
                --gold:        #D4A843;
                --text:        #1A1A2E;
                --muted:       #6B6B8A;
                --border:      #E2D9F3;
            }
            * {
                box-sizing: border-box;
                margin: 0;
                padding: 0;
            }
            body {
                font-family: 'DM Sans', sans-serif;
                color: var(--text);
                background: #fff;
            }

            /* NAVBAR */
            .navbar-main {
                background: var(--purple-deep);
                padding: 0 48px;
                height: 64px;
                display: flex;
                align-items: center;
                justify-content: space-between;
                position: sticky;
                top: 0;
                z-index: 50;
                box-shadow: 0 2px 16px rgba(0,0,0,0.2);
            }
            .brand {
                font-family: 'Playfair Display', serif;
                font-size: 1.5rem;
                font-weight: 700;
                color: #fff;
                text-decoration: none;
            }
            .brand span {
                color: var(--gold);
            }
            .nav-links {
                display: flex;
                gap: 4px;
                list-style: none;
            }
            .nav-links a {
                font-size: 0.875rem;
                font-weight: 500;
                color: rgba(255,255,255,0.7);
                text-decoration: none;
                padding: 7px 13px;
                border-radius: 6px;
                transition: all 0.15s;
            }
            .nav-links a:hover {
                background: rgba(255,255,255,0.08);
                color: #fff;
            }
            .nav-right {
                display: flex;
                align-items: center;
                gap: 10px;
            }
            .btn-nav-login {
                font-size: 0.875rem;
                font-weight: 600;
                color: rgba(255,255,255,0.85);
                background: none;
                border: none;
                padding: 7px 16px;
                border-radius: 6px;
                cursor: pointer;
                font-family: 'DM Sans', sans-serif;
                transition: color 0.15s;
            }
            .btn-nav-login:hover {
                color: #fff;
            }
            .btn-nav-join {
                font-size: 0.875rem;
                font-weight: 700;
                background: var(--gold);
                color: var(--purple-deep);
                border: none;
                padding: 8px 20px;
                border-radius: 8px;
                cursor: pointer;
                transition: opacity 0.15s;
                font-family: 'DM Sans', sans-serif;
            }
            .btn-nav-join:hover {
                opacity: 0.88;
            }
            .user-chip {
                display: flex;
                align-items: center;
                gap: 9px;
                background: rgba(255,255,255,0.08);
                border: 1px solid rgba(255,255,255,0.15);
                border-radius: 8px;
                padding: 5px 12px;
                cursor: pointer;
                transition: background 0.15s;
                position: relative;
            }
            .user-chip:hover {
                background: rgba(255,255,255,0.14);
            }
            .u-avatar {
                width: 30px;
                height: 30px;
                border-radius: 50%;
                background: linear-gradient(135deg, var(--purple), var(--gold));
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 0.8rem;
                font-weight: 700;
                color: #fff;
            }
            .u-name {
                font-size: 0.85rem;
                font-weight: 600;
                color: #fff;
            }
            .user-dropdown {
                position: absolute;
                top: 48px;
                right: 0;
                background: #fff;
                border: 1px solid var(--border);
                border-radius: 10px;
                padding: 6px;
                min-width: 180px;
                box-shadow: 0 8px 32px rgba(0,0,0,0.15);
                display: none;
                z-index: 200;
            }
            .user-dropdown.show {
                display: block;
            }
            .user-dropdown a {
                display: flex;
                align-items: center;
                gap: 9px;
                padding: 9px 12px;
                border-radius: 7px;
                font-size: 0.85rem;
                color: var(--text);
                text-decoration: none;
                font-weight: 500;
                transition: background 0.12s;
            }
            .user-dropdown a:hover {
                background: var(--purple-light);
                color: var(--purple);
            }
            .dd-sep {
                height: 1px;
                background: var(--border);
                margin: 4px 0;
            }
            .logout-link {
                color: #CC0000 !important;
            }
            .logout-link:hover {
                background: #FFF3F3 !important;
                color: #CC0000 !important;
            }

            /* HERO */
            .hero {
                background: linear-gradient(145deg, var(--purple-deep) 0%, #3A1A7A 55%, #5B2DC5 100%);
                padding: 80px 80px 0;
                display: flex;
                align-items: flex-end;
                gap: 60px;
                min-height: 460px;
                overflow: hidden;
                position: relative;
            }
            .hero::before {
                content: '';
                position: absolute;
                width: 500px;
                height: 500px;
                border-radius: 50%;
                background: rgba(212,168,67,0.05);
                top: -180px;
                right: -100px;
            }
            .hero-content {
                flex: 1;
                padding-bottom: 64px;
                position: relative;
                z-index: 1;
            }
            .hero-eyebrow {
                display: inline-flex;
                align-items: center;
                gap: 7px;
                background: rgba(212,168,67,0.15);
                border: 1px solid rgba(212,168,67,0.3);
                color: var(--gold);
                font-size: 0.72rem;
                font-weight: 700;
                padding: 5px 13px;
                border-radius: 20px;
                margin-bottom: 18px;
                letter-spacing: 1px;
                text-transform: uppercase;
            }
            .hero h1 {
                font-family: 'Playfair Display', serif;
                font-size: 3rem;
                font-weight: 700;
                color: #fff;
                line-height: 1.15;
                margin-bottom: 16px;
            }
            .hero h1 em {
                font-style: normal;
                color: var(--gold);
            }
            .hero p {
                font-size: 1rem;
                color: rgba(255,255,255,0.75);
                max-width: 460px;
                line-height: 1.7;
                margin-bottom: 32px;
            }
            .hero-btns {
                display: flex;
                gap: 12px;
            }
            .btn-gold {
                background: var(--gold);
                color: var(--purple-deep);
                font-weight: 700;
                font-size: 0.9rem;
                padding: 12px 28px;
                border-radius: 8px;
                border: none;
                cursor: pointer;
                transition: opacity 0.15s, transform 0.1s;
                box-shadow: 0 4px 14px rgba(212,168,67,0.4);
                font-family: 'DM Sans', sans-serif;
            }
            .btn-gold:hover {
                opacity: 0.9;
                transform: translateY(-1px);
            }
            .btn-outline-w {
                background: transparent;
                color: #fff;
                font-weight: 600;
                font-size: 0.9rem;
                padding: 12px 24px;
                border-radius: 8px;
                border: 1.5px solid rgba(255,255,255,0.35);
                cursor: pointer;
                transition: border-color 0.15s;
                font-family: 'DM Sans', sans-serif;
            }
            .btn-outline-w:hover {
                border-color: #fff;
            }
            .hero-right {
                flex: 0 0 340px;
                position: relative;
                z-index: 1;
            }
            .hero-cards {
                background: rgba(255,255,255,0.06);
                border: 1px solid rgba(255,255,255,0.12);
                border-radius: 14px 14px 0 0;
                padding: 18px;
                backdrop-filter: blur(10px);
            }
            .mini-card {
                background: #fff;
                border-radius: 10px;
                padding: 12px 14px;
                margin-bottom: 9px;
                display: flex;
                align-items: center;
                gap: 12px;
                box-shadow: 0 4px 14px rgba(0,0,0,0.1);
            }
            .mini-card:last-child {
                margin-bottom: 0;
            }
            .mini-icon {
                width: 36px;
                height: 36px;
                border-radius: 8px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1rem;
                flex-shrink: 0;
            }
            .ic1{
                background:linear-gradient(135deg,#6C3FC5,#9B72E8);
            }
            .ic2{
                background:linear-gradient(135deg,#D4A843,#F5CC6A);
            }
            .ic3{
                background:linear-gradient(135deg,#1B5E20,#388E3C);
            }
            .mini-info h4 {
                font-size: 0.78rem;
                font-weight: 700;
                margin-bottom: 2px;
            }
            .mini-info p {
                font-size: 0.68rem;
                color: var(--muted);
            }
            .mstars {
                color: var(--gold);
                font-size: 0.68rem;
            }

            /* SECTIONS */
            section {
                padding: 64px 80px;
            }
            .sec-label {
                font-size: 0.72rem;
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: 2px;
                color: var(--purple);
                margin-bottom: 6px;
            }
            .sec-title {
                font-family: 'Playfair Display', serif;
                font-size: 1.9rem;
                font-weight: 700;
                margin-bottom: 6px;
            }
            .sec-sub {
                font-size: 0.9rem;
                color: var(--muted);
                margin-bottom: 36px;
            }

            .cat-grid {
                display: grid;
                grid-template-columns: repeat(4,1fr);
                gap: 14px;
            }
            .cat-card {
                border: 1.5px solid var(--border);
                border-radius: 12px;
                padding: 22px 18px;
                text-decoration: none;
                color: var(--text);
                transition: all 0.2s;
                display: block;
                background: #fff;
            }
            .cat-card:hover {
                border-color: var(--purple);
                box-shadow: 0 6px 20px rgba(108,63,197,0.1);
                transform: translateY(-2px);
                color: var(--text);
            }
            .cat-icon {
                font-size: 1.8rem;
                margin-bottom: 10px;
            }
            .cat-card h3 {
                font-size: 0.9rem;
                font-weight: 700;
                margin-bottom: 3px;
            }
            .cat-card p {
                font-size: 0.75rem;
                color: var(--muted);
            }

            .course-grid {
                display: grid;
                grid-template-columns: repeat(4,1fr);
                gap: 18px;
            }
            .course-card {
                background: #fff;
                border: 1px solid var(--border);
                border-radius: 12px;
                overflow: hidden;
                text-decoration: none;
                color: var(--text);
                transition: all 0.2s;
                display: block;
            }
            .course-card:hover {
                box-shadow: 0 8px 28px rgba(108,63,197,0.12);
                transform: translateY(-3px);
                color: var(--text);
            }
            .course-thumb {
                height: 130px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 2.5rem;
            }
            .th1{
                background:linear-gradient(135deg,#1E0A4A,#6C3FC5);
            }
            .th2{
                background:linear-gradient(135deg,#3A1A7A,#9B72E8);
            }
            .th3{
                background:linear-gradient(135deg,#4E2C96,#D4A843);
            }
            .th4{
                background:linear-gradient(135deg,#1A0D35,#5B2DC5);
            }
            .course-body {
                padding: 14px 16px 16px;
            }
            .course-org {
                font-size: 0.68rem;
                font-weight: 700;
                color: var(--purple);
                text-transform: uppercase;
                letter-spacing: 0.5px;
                margin-bottom: 5px;
            }
            .course-body h3 {
                font-size: 0.85rem;
                font-weight: 700;
                line-height: 1.4;
                margin-bottom: 8px;
            }
            .course-meta {
                display: flex;
                align-items: center;
                gap: 5px;
                font-size: 0.75rem;
            }
            .c-stars{
                color:var(--gold);
            }
            .c-score{
                font-weight:700;
            }
            .c-count{
                color:var(--muted);
            }
            .c-tag {
                display: inline-block;
                background: var(--purple-light);
                color: var(--purple);
                font-size: 0.65rem;
                font-weight: 700;
                padding: 2px 8px;
                border-radius: 4px;
                margin-top: 8px;
            }

            .stats-bar {
                background: linear-gradient(135deg, var(--purple-deep), #3A1A7A);
                padding: 48px 80px;
                display: grid;
                grid-template-columns: repeat(4,1fr);
                gap: 24px;
                text-align: center;
            }
            .stat-num {
                font-family: 'Playfair Display', serif;
                font-size: 2.4rem;
                font-weight: 700;
                color: var(--gold);
                display: block;
            }
            .stat-lbl {
                font-size: 0.82rem;
                color: rgba(255,255,255,0.65);
            }

            .cta-sec {
                background: linear-gradient(135deg, #1E0A4A, var(--purple));
                padding: 72px 80px;
                text-align: center;
            }
            .cta-sec h2 {
                font-family: 'Playfair Display', serif;
                font-size: 2.2rem;
                color: #fff;
                margin-bottom: 12px;
            }
            .cta-sec p {
                font-size: 0.95rem;
                color: rgba(255,255,255,0.7);
                margin-bottom: 32px;
            }

            footer {
                background: var(--purple-deep);
                padding: 40px 80px 20px;
            }
            .footer-grid {
                display: grid;
                grid-template-columns: 2fr 1fr 1fr 1fr;
                gap: 40px;
                margin-bottom: 32px;
            }
            .f-brand {
                font-family: 'Playfair Display', serif;
                font-size: 1.4rem;
                font-weight: 700;
                color: #fff;
                display: block;
                margin-bottom: 8px;
            }
            .f-brand span {
                color: var(--gold);
            }
            .f-desc {
                font-size: 0.82rem;
                color: rgba(255,255,255,0.45);
                line-height: 1.7;
            }
            .f-col h4 {
                font-size: 0.75rem;
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: 1px;
                color: rgba(255,255,255,0.45);
                margin-bottom: 14px;
            }
            .f-col a {
                display: block;
                font-size: 0.82rem;
                color: rgba(255,255,255,0.6);
                text-decoration: none;
                margin-bottom: 8px;
                transition: color 0.15s;
            }
            .f-col a:hover {
                color: var(--gold);
            }
            .footer-bottom {
                border-top: 1px solid rgba(255,255,255,0.08);
                padding-top: 16px;
                font-size: 0.75rem;
                color: rgba(255,255,255,0.3);
                display: flex;
                justify-content: space-between;
            }

            /* ===== MODAL ===== */
            .modal-overlay {
                position: fixed;
                inset: 0;
                background: rgba(15,5,40,0.6);
                backdrop-filter: blur(5px);
                z-index: 1000;
                display: flex;
                align-items: center;
                justify-content: center;
                opacity: 0;
                pointer-events: none;
                transition: opacity 0.25s;
            }
            .modal-overlay.show {
                opacity: 1;
                pointer-events: all;
            }

            .auth-modal {
                background: #fff;
                border-radius: 18px;
                width: 400px;
                max-width: 95vw;
                max-height: 90vh;
                overflow-y: auto;
                padding: 32px 32px 24px;
                box-shadow: 0 24px 80px rgba(0,0,0,0.3);
                position: relative;
                transform: translateY(24px) scale(0.96);
                transition: transform 0.28s cubic-bezier(0.34,1.56,0.64,1), opacity 0.25s;
                opacity: 0;
            }
            .modal-overlay.show .auth-modal {
                transform: translateY(0) scale(1);
                opacity: 1;
            }
            .auth-modal::-webkit-scrollbar {
                width: 3px;
            }
            .auth-modal::-webkit-scrollbar-thumb {
                background: var(--border);
                border-radius: 2px;
            }

            .modal-close {
                position: absolute;
                top: 14px;
                right: 14px;
                width: 30px;
                height: 30px;
                border-radius: 50%;
                background: #F0EDF8;
                border: none;
                cursor: pointer;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 0.95rem;
                color: var(--muted);
                transition: background 0.15s;
            }
            .modal-close:hover {
                background: var(--border);
                color: var(--text);
            }

            .modal-title {
                font-family: 'Playfair Display', serif;
                font-size: 1.45rem;
                font-weight: 700;
                color: var(--text);
                margin-bottom: 3px;
            }
            .modal-sub   {
                font-size: 0.82rem;
                color: var(--muted);
                margin-bottom: 20px;
            }

            .tab-switch {
                display: flex;
                background: var(--purple-light);
                border-radius: 10px;
                padding: 4px;
                gap: 4px;
                margin-bottom: 20px;
            }
            .tab-btn {
                flex: 1;
                padding: 9px;
                border-radius: 7px;
                font-size: 0.875rem;
                font-weight: 600;
                border: none;
                background: transparent;
                color: var(--muted);
                cursor: pointer;
                transition: all 0.2s;
                font-family: 'DM Sans', sans-serif;
            }
            .tab-btn.active {
                background: var(--purple);
                color: #fff;
                box-shadow: 0 2px 8px rgba(108,63,197,0.3);
            }

            .form-panel {
                display: none;
            }
            .form-panel.active {
                display: block;
            }

            .f-label {
                font-size: 0.75rem;
                font-weight: 700;
                color: var(--text);
                margin-bottom: 5px;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                display: block;
            }
            .f-input {
                width: 100%;
                border: 1.5px solid var(--border);
                border-radius: 9px;
                padding: 10px 13px;
                font-size: 0.875rem;
                font-family: 'DM Sans', sans-serif;
                color: var(--text);
                background: #FDFCFF;
                transition: border-color 0.15s, box-shadow 0.15s;
                outline: none;
            }
            .f-input::placeholder {
                color: #C4BAD9;
            }
            .f-input:focus {
                border-color: var(--purple);
                box-shadow: 0 0 0 3px rgba(108,63,197,0.1);
                background: #fff;
            }
            .pw-wrap {
                position: relative;
            }
            .pw-wrap .f-input {
                padding-right: 38px;
            }
            .pw-eye {
                position: absolute;
                right: 11px;
                top: 50%;
                transform: translateY(-50%);
                background: none;
                border: none;
                padding: 0;
                color: var(--muted);
                font-size: 0.875rem;
                cursor: pointer;
            }
            .pw-eye:hover {
                color: var(--purple);
            }
            .forgot {
                font-size: 0.75rem;
                font-weight: 600;
                color: var(--purple);
                text-decoration: none;
            }
            .forgot:hover {
                text-decoration: underline;
            }

            .btn-submit {
                width: 100%;
                background: linear-gradient(135deg, var(--purple), var(--purple-dark));
                color: #fff;
                font-weight: 700;
                font-size: 0.875rem;
                padding: 12px;
                border: none;
                border-radius: 9px;
                cursor: pointer;
                transition: opacity 0.15s, transform 0.1s;
                box-shadow: 0 4px 14px rgba(108,63,197,0.35);
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 7px;
                font-family: 'DM Sans', sans-serif;
            }
            .btn-submit:hover {
                opacity: 0.9;
                transform: translateY(-1px);
            }

            .or-div {
                display: flex;
                align-items: center;
                gap: 10px;
                font-size: 0.72rem;
                color: var(--muted);
                margin: 12px 0;
            }
            .or-div::before, .or-div::after {
                content: '';
                flex: 1;
                height: 1px;
                background: var(--border);
            }

            .social-grid {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 8px;
            }
            .btn-soc {
                border: 1.5px solid var(--border);
                background: #fff;
                color: var(--text);
                font-weight: 600;
                font-size: 0.78rem;
                padding: 9px 10px;
                border-radius: 9px;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 7px;
                cursor: pointer;
                transition: all 0.15s;
                font-family: 'DM Sans', sans-serif;
                text-decoration: none;
            }
            .btn-soc:hover {
                border-color: var(--purple);
                background: var(--purple-light);
                color: var(--text);
            }

            .name-grid {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 10px;
            }
            .role-grid {
                display: grid;
                grid-template-columns: repeat(3,1fr);
                gap: 7px;
            }
            .role-opt input {
                display: none;
            }
            .role-opt label {
                border: 1.5px solid var(--border);
                border-radius: 8px;
                padding: 9px 4px;
                text-align: center;
                cursor: pointer;
                font-size: 0.68rem;
                font-weight: 600;
                color: var(--muted);
                display: block;
                transition: all 0.15s;
            }
            .role-opt label .ri {
                font-size: 1.1rem;
                display: block;
                margin-bottom: 2px;
            }
            .role-opt input:checked + label {
                border-color: var(--purple);
                background: var(--purple-light);
                color: var(--purple);
            }

            .str-bar {
                display: flex;
                gap: 3px;
                margin-top: 5px;
            }
            .str-seg {
                flex: 1;
                height: 3px;
                border-radius: 2px;
                background: var(--border);
                transition: background 0.3s;
            }
            .str-lbl {
                font-size: 0.67rem;
                color: var(--muted);
                margin-top: 2px;
            }

            .alert-err {
                background: #FFF3F3;
                border: 1px solid #FFB3B3;
                color: #CC0000;
                border-radius: 8px;
                padding: 9px 12px;
                font-size: 0.78rem;
                margin-bottom: 14px;
                display: flex;
                align-items: center;
                gap: 7px;
            }
            .form-check-input:checked {
                background-color: var(--purple);
                border-color: var(--purple);
            }

            @media(max-width:900px){
                .hero{
                    flex-direction:column;
                    padding:48px 24px 0;
                }
                .hero-right{
                    display:none;
                }
                section,.stats-bar,.cta-sec,footer{
                    padding:48px 24px;
                }
                .cat-grid,.course-grid{
                    grid-template-columns:repeat(2,1fr);
                }
                .stats-bar,.footer-grid{
                    grid-template-columns:repeat(2,1fr);
                }
                .navbar-main{
                    padding:0 20px;
                }
            }
        </style>
    </head>
    <body>

        <!-- NAVBAR -->
        <nav class="navbar-main">
            <a href="welcome.jsp" class="brand">Learn<span>Verse</span></a>
            <ul class="nav-links">
                <li><a href="#">Khám phá</a></li>
                <li><a href="#">Khóa học</a></li>
                <li><a href="#">Giảng viên</a></li>
            </ul>
            <div class="nav-right">
                <c:choose>
                    <c:when test="${not empty user}">
                        <div class="user-chip" onclick="toggleDD()">
                            <div class="u-avatar">${user.userName.charAt(0)}</div>
                            <span class="u-name">${user.userName}</span>
                            <i class="bi bi-chevron-down" style="color:rgba(255,255,255,0.5);font-size:0.7rem;"></i>
                            <div class="user-dropdown" id="userDD">
                                <a href="#"><i class="bi bi-person"></i> Hồ sơ</a>
                                <a href="#"><i class="bi bi-book"></i> Khóa học của tôi</a>
                                <a href="#"><i class="bi bi-award"></i> Chứng chỉ</a>
                                <div class="dd-sep"></div>
                                <a href="mainController?action=logout" class="logout-link"><i class="bi bi-box-arrow-right"></i> Đăng xuất</a>
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
                        👋 Chào mừng trở lại, <strong style="color:var(--gold);margin-left:4px;">${user.userName}</strong>!
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
        <section style="background:#F8F5FF;">
            <div class="sec-label">Nổi bật</div>
            <div class="sec-title">Khóa học được yêu thích</div>
            <p class="sec-sub">Triệu học viên đang theo học</p>
            <div class="course-grid">
                <a href="#" class="course-card"><div class="course-thumb th1">🤖</div><div class="course-body"><div class="course-org">DeepLearning.AI</div><h3>Machine Learning Specialization</h3><div class="course-meta"><span class="c-stars">★★★★★</span><span class="c-score">4.9</span><span class="c-count">(125K)</span></div><span class="c-tag">Người mới</span></div></a>
                <a href="#" class="course-card"><div class="course-thumb th2">🐍</div><div class="course-body"><div class="course-org">ĐH Bách Khoa</div><h3>Python cho Dữ liệu</h3><div class="course-meta"><span class="c-stars">★★★★★</span><span class="c-score">4.8</span><span class="c-count">(240K)</span></div><span class="c-tag">Nhiều người học</span></div></a>
                <a href="#" class="course-card"><div class="course-thumb th3">🎨</div><div class="course-body"><div class="course-org">Google UX</div><h3>UX Design Professional</h3><div class="course-meta"><span class="c-stars">★★★★½</span><span class="c-score">4.7</span><span class="c-count">(89K)</span></div><span class="c-tag">Chứng chỉ</span></div></a>
                <a href="#" class="course-card"><div class="course-thumb th4">📈</div><div class="course-body"><div class="course-org">IBM</div><h3>Data Science Pro</h3><div class="course-meta"><span class="c-stars">★★★★★</span><span class="c-score">4.6</span><span class="c-count">(67K)</span></div><span class="c-tag">Cầu nghề cao</span></div></a>
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
                        <a href="#" class="btn-soc"><svg width="15" height="15" viewBox="0 0 48 48"><path fill="#FFC107" d="M43.6 20.1H42V20H24v8h11.3C33.7 32.7 29.2 36 24 36c-6.6 0-12-5.4-12-12s5.4-12 12-12c3.1 0 5.8 1.1 8 2.9l5.7-5.7C34 6.1 29.3 4 24 4 12.9 4 4 12.9 4 24s8.9 20 20 20 20-8.9 20-20c0-1.3-.1-2.6-.4-3.9z"/><path fill="#FF3D00" d="m6.3 14.7 6.6 4.8C14.7 16 19.1 12 24 12c3.1 0 5.8 1.1 8 2.9l5.7-5.7C34 6.1 29.3 4 24 4c-7.7 0-14.4 4.4-17.7 10.7z"/><path fill="#4CAF50" d="M24 44c5.2 0 9.9-2 13.4-5.2l-6.2-5.2C29.3 35.4 26.8 36 24 36c-5.2 0-9.6-3.3-11.3-8H6.1c3.3 6.5 10.1 11 17.9 11z"/><path fill="#1976D2" d="M43.6 20.1H42V20H24v8h11.3c-.8 2.3-2.3 4.2-4.2 5.6l6.2 5.2c-.4.4 6.7-4.9 6.7-14.8 0-1.3-.1-2.6-.4-3.9z"/></svg>Google</a>
                        <a href="#" class="btn-soc"><svg width="15" height="15" viewBox="0 0 24 24"><path fill="#1877F2" d="M24 12.07C24 5.41 18.63 0 12 0S0 5.4 0 12.07C0 18.1 4.39 23.1 10.13 24v-8.44H7.08v-3.49h3.04V9.41c0-3.02 1.8-4.7 4.54-4.7 1.31 0 2.68.24 2.68.24v2.97h-1.51c-1.49 0-1.95.93-1.95 1.88v2.26h3.32l-.53 3.5h-2.8V24C19.62 23.1 24 18.1 24 12.07z"/></svg>Facebook</a>
                    </div>
                    <div class="or-div">hoặc dùng tài khoản</div>
                    <form action="mainController" method="POST">
                        <input type="hidden" name="action" value="login" />
                        <div style="margin-bottom:13px;">
                            <label class="f-label">Tên đăng nhập</label>
                            <input type="text" class="f-input" name="userName" placeholder="Nhập tên đăng nhập" required />
                        </div>
                        <div style="margin-bottom:10px;">
                            <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:5px;">
                                <label class="f-label" style="margin:0;">Mật khẩu</label>
                                <a href="#" class="forgot">Quên mật khẩu?</a>
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
                        <div class="alert-err"><i class="bi bi-exclamation-circle-fill"></i>${registerMessage}</div>
                        </c:if>
                    <form action="mainController" method="POST" id="regForm">
                        <input type="hidden" name="action" value="register" />
                        <div class="name-grid" style="margin-bottom:11px;">
                            <div><label class="f-label">Họ</label><input type="text" class="f-input" name="firstName" placeholder="Nguyễn" required /></div>
                            <div><label class="f-label">Tên</label><input type="text" class="f-input" name="lastName" placeholder="Văn A" required /></div>
                        </div>
                        <div style="margin-bottom:11px;"><label class="f-label">Tên đăng nhập</label><input type="text" class="f-input" name="userName" placeholder="username" required /></div>
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
                        <div style="margin-bottom:11px;">
                            <label class="f-label">Bạn là</label>
                            <div class="role-grid">
                                <div class="role-opt"><input type="radio" name="role" id="ro1" value="1" checked><label for="ro1"><span class="ri">🎓</span>Học viên</label></div>
                                <div class="role-opt"><input type="radio" name="role" id="ro2" value="2"><label for="ro2"><span class="ri">👨‍🏫</span>Giảng viên</label></div>
                                <div class="role-opt"><input type="radio" name="role" id="ro3" value="3"><label for="ro3"><span class="ri">🏢</span>Doanh nghiệp</label></div>
                            </div>
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

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script>
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
                                        if (e.target === document.getElementById('modalOverlay'))
                                            closeModal();
                                    }
                                    document.addEventListener('keydown', e => {
                                        if (e.key === 'Escape')
                                            closeModal();
                                    });

                                    function switchTab(tab) {
                                        ['login', 'register'].forEach(t => {
                                            document.getElementById('panel' + (t === 'login' ? 'Login' : 'Reg')).classList.toggle('active', t === tab);
                                            document.getElementById('tab' + (t === 'login' ? 'Login' : 'Reg')).classList.toggle('active', t === tab);
                                        });
                                    }

                                    function tpw(iId, eId) {
                                        const i = document.getElementById(iId), e = document.getElementById(eId);
                                        i.type = i.type === 'password' ? 'text' : 'password';
                                        e.className = i.type === 'password' ? 'bi bi-eye' : 'bi bi-eye-slash';
                                    }

                                    function chkStr(v) {
                                        const segs = ['st1', 'st2', 'st3', 'st4'].map(id => document.getElementById(id));
                                        const lbl = document.getElementById('stLbl');
                                        let s = 0;
                                        if (v.length >= 8)
                                            s++;
                                        if (/[A-Z]/.test(v))
                                            s++;
                                        if (/[0-9]/.test(v))
                                            s++;
                                        if (/[^A-Za-z0-9]/.test(v))
                                            s++;
                                        const c = ['#CC0000', '#E65100', '#D4A843', '#2E7D32'], l = ['Yếu', 'Trung bình', 'Khá', 'Mạnh'];
                                        segs.forEach((seg, i) => seg.style.background = i < s ? c[s - 1] : '#E2D9F3');
                                        lbl.textContent = v.length ? (l[s - 1] || 'Yếu') : '';
                                        lbl.style.color = c[s - 1] || '#CC0000';
                                    }

                                    document.getElementById('regForm').addEventListener('submit', function (e) {
                                        if (document.getElementById('rPw').value !== document.getElementById('rCpw').value) {
                                            e.preventDefault();
                                            document.getElementById('rCpw').style.borderColor = '#CC0000';
                                            document.getElementById('cpwErr').textContent = '⚠ Mật khẩu không khớp!';
                                        }
                                    });
                                    document.getElementById('rCpw').addEventListener('input', function () {
                                        this.style.borderColor = '';
                                        document.getElementById('cpwErr').textContent = '';
                                    });

                                    function toggleDD() {
                                        document.getElementById('userDD')?.classList.toggle('show');
                                    }
                                    document.addEventListener('click', e => {
                                        const chip = document.querySelector('.user-chip');
                                        const dd = document.getElementById('userDD');
                                        if (dd && chip && !chip.contains(e.target))
                                            dd.classList.remove('show');
                                    });

                                    // Auto mở modal nếu có lỗi từ server
            <c:if test="${not empty message}">window.onload = () => openModal('login');</c:if>
            <c:if test="${not empty registerMessage}">window.onload = () => openModal('register');</c:if>
        </script>
    </body>
</html>
