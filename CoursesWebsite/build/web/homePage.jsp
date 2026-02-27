<%-- 
    Document   : welcome
    Created on : Feb 23, 2026, 10:11:54 PM
    Author     : HOANG KHANG PC
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>KKKedu - Home</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&family=DM+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">

        
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
                --white:       #FFFFFF;
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

            /* ===== NAVBAR ===== */
            .navbar-main {
                background: var(--purple-deep);
                padding: 0 48px;
                height: 68px;
                display: flex;
                align-items: center;
                justify-content: space-between;
                position: sticky;
                top: 0;
                z-index: 100;
                box-shadow: 0 2px 20px rgba(0,0,0,0.25);
            }

            .brand {
                font-family: 'Playfair Display', serif;
                font-size: 1.55rem;
                font-weight: 700;
                color: #fff;
                text-decoration: none;
                letter-spacing: 0.3px;
            }
            .brand span {
                color: var(--gold);
            }

            .nav-links {
                display: flex;
                align-items: center;
                gap: 4px;
                list-style: none;
            }

            .nav-links a {
                font-size: 0.9rem;
                font-weight: 500;
                color: rgba(255,255,255,0.75);
                text-decoration: none;
                padding: 7px 14px;
                border-radius: 6px;
                transition: background 0.15s, color 0.15s;
            }
            .nav-links a:hover {
                background: rgba(255,255,255,0.08);
                color: #fff;
            }

            .nav-right {
                display: flex;
                align-items: center;
                gap: 12px;
            }

            .search-bar {
                display: flex;
                align-items: center;
                background: rgba(255,255,255,0.1);
                border: 1px solid rgba(255,255,255,0.15);
                border-radius: 8px;
                padding: 7px 14px;
                gap: 8px;
                transition: background 0.15s;
            }
            .search-bar:hover {
                background: rgba(255,255,255,0.15);
            }
            .search-bar input {
                background: none;
                border: none;
                outline: none;
                color: #fff;
                font-size: 0.875rem;
                font-family: 'DM Sans', sans-serif;
                width: 180px;
            }
            .search-bar input::placeholder {
                color: rgba(255,255,255,0.5);
            }
            .search-bar i {
                color: rgba(255,255,255,0.6);
                font-size: 0.9rem;
            }

            /* User Menu */
            .user-menu {
                display: flex;
                align-items: center;
                gap: 10px;
                cursor: pointer;
                padding: 6px 12px;
                border-radius: 8px;
                transition: background 0.15s;
                border: 1px solid rgba(255,255,255,0.15);
            }
            .user-menu:hover {
                background: rgba(255,255,255,0.08);
            }

            .user-avatar {
                width: 34px;
                height: 34px;
                border-radius: 50%;
                background: linear-gradient(135deg, var(--purple-mid), var(--gold));
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 0.9rem;
                font-weight: 700;
                color: #fff;
                flex-shrink: 0;
            }

            .user-name {
                font-size: 0.875rem;
                font-weight: 600;
                color: #fff;
                max-width: 120px;
                overflow: hidden;
                text-overflow: ellipsis;
                white-space: nowrap;
            }

            .dropdown-menu-custom {
                position: absolute;
                top: 76px;
                right: 48px;
                background: #fff;
                border: 1px solid var(--border);
                border-radius: 10px;
                padding: 8px;
                min-width: 200px;
                box-shadow: 0 8px 32px rgba(0,0,0,0.15);
                display: none;
                z-index: 200;
            }
            .dropdown-menu-custom.show {
                display: block;
            }

            .dropdown-menu-custom a {
                display: flex;
                align-items: center;
                gap: 10px;
                padding: 10px 14px;
                border-radius: 7px;
                font-size: 0.875rem;
                color: var(--text);
                text-decoration: none;
                font-weight: 500;
                transition: background 0.12s;
            }
            .dropdown-menu-custom a:hover {
                background: var(--purple-light);
                color: var(--purple);
            }
            .dropdown-menu-custom .divider-drop {
                height: 1px;
                background: var(--border);
                margin: 6px 0;
            }
            .dropdown-menu-custom .logout-link {
                color: #CC0000;
            }
            .dropdown-menu-custom .logout-link:hover {
                background: #FFF3F3;
                color: #CC0000;
            }

            /* ===== HERO ===== */
            .hero {
                background: linear-gradient(145deg, var(--purple-deep) 0%, #3A1A7A 50%, #5B2DC5 100%);
                padding: 88px 80px 0;
                display: flex;
                align-items: flex-end;
                gap: 64px;
                overflow: hidden;
                min-height: 500px;
                position: relative;
            }

            .hero::before {
                content: '';
                position: absolute;
                width: 600px;
                height: 600px;
                border-radius: 50%;
                background: rgba(212,168,67,0.05);
                top: -200px;
                right: -100px;
            }

            .hero-content {
                flex: 1;
                padding-bottom: 72px;
                position: relative;
                z-index: 1;
            }

            .hero-eyebrow {
                display: inline-flex;
                align-items: center;
                gap: 8px;
                background: rgba(212,168,67,0.15);
                border: 1px solid rgba(212,168,67,0.3);
                color: var(--gold);
                font-size: 0.78rem;
                font-weight: 700;
                padding: 6px 14px;
                border-radius: 20px;
                margin-bottom: 22px;
                letter-spacing: 1px;
                text-transform: uppercase;
            }

            .hero h1 {
                font-family: 'Playfair Display', serif;
                font-size: 3.4rem;
                font-weight: 700;
                color: #fff;
                line-height: 1.15;
                margin-bottom: 20px;
            }

            .hero h1 em {
                font-style: normal;
                color: var(--gold);
            }

            /* Welcome message for logged-in user */
            .welcome-badge {
                display: inline-flex;
                align-items: center;
                gap: 10px;
                background: rgba(255,255,255,0.08);
                border: 1px solid rgba(255,255,255,0.15);
                border-radius: 10px;
                padding: 10px 18px;
                margin-bottom: 22px;
                color: rgba(255,255,255,0.9);
                font-size: 0.9rem;
                font-weight: 500;
            }
            .welcome-badge strong {
                color: var(--gold);
            }

            .hero p {
                font-size: 1.05rem;
                color: rgba(255,255,255,0.78);
                max-width: 500px;
                line-height: 1.7;
                margin-bottom: 36px;
            }

            .hero-actions {
                display: flex;
                gap: 14px;
                flex-wrap: wrap;
            }

            .btn-hero-primary {
                background: var(--gold);
                color: var(--purple-deep);
                font-weight: 700;
                font-size: 0.95rem;
                padding: 13px 32px;
                border-radius: 8px;
                border: none;
                text-decoration: none;
                transition: opacity 0.15s, transform 0.1s;
                box-shadow: 0 4px 16px rgba(212,168,67,0.4);
                display: inline-flex;
                align-items: center;
                gap: 8px;
            }
            .btn-hero-primary:hover {
                opacity: 0.9;
                transform: translateY(-1px);
                color: var(--purple-deep);
            }

            .btn-hero-secondary {
                background: transparent;
                color: #fff;
                font-weight: 600;
                font-size: 0.95rem;
                padding: 13px 28px;
                border-radius: 8px;
                border: 1.5px solid rgba(255,255,255,0.35);
                text-decoration: none;
                transition: border-color 0.15s, background 0.15s;
                display: inline-flex;
                align-items: center;
                gap: 8px;
            }
            .btn-hero-secondary:hover {
                border-color: #fff;
                background: rgba(255,255,255,0.06);
                color: #fff;
            }

            /* Hero right — floating course cards */
            .hero-right {
                flex: 0 0 360px;
                padding-bottom: 0;
                position: relative;
                z-index: 1;
            }

            .floating-cards {
                background: rgba(255,255,255,0.06);
                border: 1px solid rgba(255,255,255,0.12);
                border-radius: 14px 14px 0 0;
                padding: 20px;
                backdrop-filter: blur(12px);
            }

            .mini-card {
                background: #fff;
                border-radius: 10px;
                padding: 14px 16px;
                margin-bottom: 10px;
                box-shadow: 0 4px 16px rgba(0,0,0,0.12);
                display: flex;
                align-items: center;
                gap: 14px;
            }
            .mini-card:last-child {
                margin-bottom: 0;
            }

            .mini-icon {
                width: 40px;
                height: 40px;
                border-radius: 8px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1.2rem;
                flex-shrink: 0;
            }
            .bg-pur {
                background: linear-gradient(135deg, #6C3FC5, #9B72E8);
            }
            .bg-gld {
                background: linear-gradient(135deg, #D4A843, #F5CC6A);
            }
            .bg-grn {
                background: linear-gradient(135deg, #1B5E20, #388E3C);
            }

            .mini-info h4 {
                font-size: 0.82rem;
                font-weight: 700;
                color: var(--text);
                margin-bottom: 3px;
            }
            .mini-info p  {
                font-size: 0.72rem;
                color: var(--muted);
            }
            .mini-stars   {
                color: var(--gold);
                font-size: 0.72rem;
            }

            /* ===== PARTNERS ===== */
            .partners {
                background: #F8F5FF;
                padding: 36px 80px;
                text-align: center;
                border-bottom: 1px solid var(--border);
            }

            .partners-label {
                font-size: 0.75rem;
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: 1.5px;
                color: var(--muted);
                margin-bottom: 20px;
            }

            .partner-logos {
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 48px;
                flex-wrap: wrap;
            }

            .partner-logo {
                font-size: 1rem;
                font-weight: 700;
                color: #B0A8C8;
                letter-spacing: -0.3px;
                transition: color 0.2s;
                cursor: default;
            }
            .partner-logo:hover {
                color: var(--purple);
            }

            /* ===== SECTIONS ===== */
            section {
                padding: 72px 80px;
            }

            .section-eyebrow {
                font-size: 0.75rem;
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: 2px;
                color: var(--purple);
                margin-bottom: 8px;
            }

            .section-title {
                font-family: 'Playfair Display', serif;
                font-size: 2rem;
                font-weight: 700;
                color: var(--text);
                margin-bottom: 8px;
            }

            .section-sub {
                font-size: 0.95rem;
                color: var(--muted);
                margin-bottom: 40px;
                max-width: 520px;
            }

            /* ===== CATEGORIES ===== */
            .categories {
                background: #fff;
            }

            .cat-grid {
                display: grid;
                grid-template-columns: repeat(4, 1fr);
                gap: 16px;
            }

            .cat-card {
                border: 1.5px solid var(--border);
                border-radius: 12px;
                padding: 24px 20px;
                text-decoration: none;
                color: var(--text);
                transition: border-color 0.2s, box-shadow 0.2s, transform 0.2s;
                position: relative;
                overflow: hidden;
                display: block;
                background: #fff;
            }

            .cat-card::after {
                content: '';
                position: absolute;
                inset: 0;
                background: linear-gradient(135deg, var(--purple-light), transparent);
                opacity: 0;
                transition: opacity 0.2s;
            }

            .cat-card:hover {
                border-color: var(--purple);
                box-shadow: 0 6px 24px rgba(108,63,197,0.12);
                transform: translateY(-3px);
                color: var(--text);
            }
            .cat-card:hover::after {
                opacity: 1;
            }

            .cat-icon {
                font-size: 2rem;
                margin-bottom: 12px;
                position: relative;
                z-index: 1;
            }

            .cat-card h3 {
                font-size: 0.95rem;
                font-weight: 700;
                margin-bottom: 4px;
                position: relative;
                z-index: 1;
            }

            .cat-card p {
                font-size: 0.8rem;
                color: var(--muted);
                position: relative;
                z-index: 1;
            }

            .cat-arrow {
                position: absolute;
                right: 16px;
                top: 16px;
                color: var(--purple);
                opacity: 0;
                transition: opacity 0.2s;
                z-index: 1;
            }
            .cat-card:hover .cat-arrow {
                opacity: 1;
            }

            /* ===== COURSES ===== */
            .courses {
                background: #F8F5FF;
            }

            .course-grid {
                display: grid;
                grid-template-columns: repeat(4, 1fr);
                gap: 20px;
            }

            .course-card {
                background: #fff;
                border: 1px solid var(--border);
                border-radius: 12px;
                overflow: hidden;
                text-decoration: none;
                color: var(--text);
                transition: box-shadow 0.2s, transform 0.2s;
                display: block;
            }
            .course-card:hover {
                box-shadow: 0 10px 32px rgba(108,63,197,0.14);
                transform: translateY(-4px);
                color: var(--text);
            }

            .course-thumb {
                height: 148px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 3rem;
            }
            .th1 {
                background: linear-gradient(135deg, #1E0A4A, #6C3FC5);
            }
            .th2 {
                background: linear-gradient(135deg, #3A1A7A, #9B72E8);
            }
            .th3 {
                background: linear-gradient(135deg, #4E2C96, #D4A843);
            }
            .th4 {
                background: linear-gradient(135deg, #1A0D35, #5B2DC5);
            }

            .course-body {
                padding: 16px 18px 18px;
            }

            .course-org {
                font-size: 0.72rem;
                font-weight: 700;
                color: var(--purple);
                text-transform: uppercase;
                letter-spacing: 0.5px;
                margin-bottom: 6px;
            }

            .course-body h3 {
                font-size: 0.9rem;
                font-weight: 700;
                line-height: 1.45;
                margin-bottom: 10px;
                color: var(--text);
            }

            .course-meta {
                display: flex;
                align-items: center;
                gap: 6px;
                font-size: 0.78rem;
            }

            .course-stars {
                color: var(--gold);
            }
            .course-score {
                font-weight: 700;
                color: var(--text);
            }
            .course-count {
                color: var(--muted);
            }

            .course-tag {
                display: inline-block;
                background: var(--purple-light);
                color: var(--purple);
                font-size: 0.68rem;
                font-weight: 700;
                padding: 3px 9px;
                border-radius: 4px;
                margin-top: 10px;
            }

            /* ===== STATS ===== */
            .stats-section {
                background: linear-gradient(135deg, var(--purple-deep) 0%, #3A1A7A 100%);
                padding: 72px 80px;
            }

            .stats-grid {
                display: grid;
                grid-template-columns: repeat(4, 1fr);
                gap: 32px;
                text-align: center;
            }

            .stat-item .number {
                font-family: 'Playfair Display', serif;
                font-size: 2.8rem;
                font-weight: 700;
                color: var(--gold);
                display: block;
                line-height: 1;
                margin-bottom: 8px;
            }

            .stat-item .label {
                font-size: 0.875rem;
                color: rgba(255,255,255,0.7);
            }

            .stats-divider {
                width: 1px;
                background: rgba(255,255,255,0.1);
            }

            /* ===== WHY ===== */
            .why {
                background: #fff;
            }

            .why-grid {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 72px;
                align-items: center;
            }

            .why-features {
                display: flex;
                flex-direction: column;
                gap: 28px;
            }

            .why-item {
                display: flex;
                gap: 18px;
                align-items: flex-start;
            }

            .why-icon {
                width: 50px;
                height: 50px;
                background: var(--purple-light);
                border-radius: 12px;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1.3rem;
                color: var(--purple);
                flex-shrink: 0;
                border: 1px solid var(--border);
            }

            .why-item h4 {
                font-size: 1rem;
                font-weight: 700;
                margin-bottom: 6px;
                color: var(--text);
            }

            .why-item p {
                font-size: 0.875rem;
                color: var(--muted);
                line-height: 1.65;
            }

            .why-visual {
                background: linear-gradient(160deg, var(--purple-light) 0%, #fff 100%);
                border: 1.5px solid var(--border);
                border-radius: 16px;
                padding: 36px;
            }

            .why-visual-title {
                font-family: 'Playfair Display', serif;
                font-size: 1.1rem;
                font-weight: 700;
                color: var(--text);
                margin-bottom: 20px;
            }

            .testimonial {
                background: #fff;
                border: 1px solid var(--border);
                border-radius: 10px;
                padding: 20px;
                margin-bottom: 14px;
                box-shadow: 0 2px 8px rgba(108,63,197,0.06);
            }
            .testimonial:last-child {
                margin-bottom: 0;
            }

            .testimonial-text {
                font-size: 0.875rem;
                color: var(--muted);
                line-height: 1.6;
                margin-bottom: 12px;
                font-style: italic;
            }

            .testimonial-author {
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .t-avatar {
                width: 32px;
                height: 32px;
                border-radius: 50%;
                background: linear-gradient(135deg, var(--purple), var(--gold));
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 0.8rem;
                font-weight: 700;
                color: #fff;
            }

            .t-name {
                font-size: 0.8rem;
                font-weight: 700;
                color: var(--text);
            }
            .t-role {
                font-size: 0.72rem;
                color: var(--muted);
            }
            .t-stars {
                color: var(--gold);
                font-size: 0.75rem;
                margin-left: auto;
            }

            /* ===== CTA ===== */
            .cta-section {
                background: linear-gradient(135deg, #1E0A4A 0%, var(--purple) 100%);
                padding: 80px;
                text-align: center;
                position: relative;
                overflow: hidden;
            }

            .cta-section::before {
                content: '';
                position: absolute;
                width: 400px;
                height: 400px;
                border-radius: 50%;
                background: rgba(212,168,67,0.06);
                top: -150px;
                right: -100px;
            }

            .cta-section h2 {
                font-family: 'Playfair Display', serif;
                font-size: 2.6rem;
                font-weight: 700;
                color: #fff;
                margin-bottom: 14px;
                position: relative;
            }

            .cta-section p {
                font-size: 1rem;
                color: rgba(255,255,255,0.75);
                margin-bottom: 40px;
                max-width: 480px;
                margin-left: auto;
                margin-right: auto;
                position: relative;
            }

            .cta-btns {
                display: flex;
                gap: 14px;
                justify-content: center;
                position: relative;
            }

            .btn-cta-gold {
                background: var(--gold);
                color: var(--purple-deep);
                font-weight: 700;
                padding: 14px 36px;
                border-radius: 8px;
                border: none;
                font-size: 0.95rem;
                text-decoration: none;
                transition: opacity 0.15s, transform 0.1s;
                box-shadow: 0 4px 20px rgba(212,168,67,0.4);
            }
            .btn-cta-gold:hover {
                opacity: 0.9;
                transform: translateY(-1px);
                color: var(--purple-deep);
            }

            .btn-cta-outline {
                background: transparent;
                color: #fff;
                font-weight: 600;
                padding: 14px 32px;
                border-radius: 8px;
                border: 1.5px solid rgba(255,255,255,0.4);
                font-size: 0.95rem;
                text-decoration: none;
                transition: border-color 0.15s;
            }
            .btn-cta-outline:hover {
                border-color: #fff;
                color: #fff;
            }

            /* ===== FOOTER ===== */
            footer {
                background: var(--purple-deep);
                padding: 56px 80px 24px;
            }

            .footer-grid {
                display: grid;
                grid-template-columns: 2fr 1fr 1fr 1fr;
                gap: 48px;
                margin-bottom: 40px;
            }

            .footer-brand-text {
                font-family: 'Playfair Display', serif;
                font-size: 1.5rem;
                font-weight: 700;
                color: #fff;
                display: block;
                margin-bottom: 10px;
            }
            .footer-brand-text span {
                color: var(--gold);
            }

            .footer-desc {
                font-size: 0.875rem;
                color: rgba(255,255,255,0.5);
                line-height: 1.7;
                margin-bottom: 20px;
            }

            .footer-social {
                display: flex;
                gap: 10px;
            }
            .footer-social a {
                width: 34px;
                height: 34px;
                border-radius: 8px;
                background: rgba(255,255,255,0.07);
                border: 1px solid rgba(255,255,255,0.1);
                display: flex;
                align-items: center;
                justify-content: center;
                color: rgba(255,255,255,0.6);
                font-size: 0.9rem;
                text-decoration: none;
                transition: background 0.15s, color 0.15s;
            }
            .footer-social a:hover {
                background: var(--purple);
                color: #fff;
                border-color: var(--purple);
            }

            .footer-col h4 {
                font-size: 0.8rem;
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: 1px;
                color: rgba(255,255,255,0.5);
                margin-bottom: 16px;
            }

            .footer-col a {
                display: block;
                font-size: 0.875rem;
                color: rgba(255,255,255,0.65);
                text-decoration: none;
                margin-bottom: 10px;
                transition: color 0.15s;
            }
            .footer-col a:hover {
                color: var(--gold);
            }

            .footer-bottom {
                border-top: 1px solid rgba(255,255,255,0.08);
                padding-top: 20px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                font-size: 0.78rem;
                color: rgba(255,255,255,0.35);
            }

            /* ===== ANIMATIONS ===== */
            @keyframes fadeUp {
                from {
                    opacity: 0;
                    transform: translateY(28px);
                }
                to   {
                    opacity: 1;
                    transform: translateY(0);
                }
            }
            .hero-content {
                animation: fadeUp 0.6s ease both;
            }
            .hero-right    {
                animation: fadeUp 0.6s 0.2s ease both;
            }

            /* ===== RESPONSIVE ===== */
            @media (max-width: 1100px) {
                .cat-grid, .course-grid {
                    grid-template-columns: repeat(2, 1fr);
                }
                .stats-grid {
                    grid-template-columns: repeat(2, 1fr);
                }
            }
            @media (max-width: 900px) {
                .hero {
                    flex-direction: column;
                    padding: 48px 24px 0;
                }
                .hero-right {
                    flex: none;
                    width: 100%;
                }
                section, .stats-section, .cta-section, footer {
                    padding: 48px 24px;
                }
                .why-grid, .footer-grid {
                    grid-template-columns: 1fr;
                    gap: 32px;
                }
                .navbar-main {
                    padding: 0 20px;
                }
                .search-bar {
                    display: none;
                }
            }
        </style>
    </head>
    <body>

        <!-- NAVBAR -->
        <nav class="navbar-main" style="position:relative;">
            <a href="welcome.jsp" class="brand">Learn<span>Verse</span></a>

            <ul class="nav-links">
                <li><a href="search.jsp"><i class="bi bi-compass me-1"></i>Khám phá</a></li>
                <li><a href="#">Khóa học</a></li>
                <li><a href="#">Giảng viên</a></li>
                <li><a href="#">Về chúng tôi</a></li>
            </ul>

            <div class="nav-right">
                <!-- Search -->
                <form action="search.jsp" method="GET">
                    <div class="search-bar">
                        <i class="bi bi-search"></i>
                        <input type="text" name="q" placeholder="Tìm khóa học..." />
                    </div>
                </form>

                <!-- User dropdown -->
                <c:choose>
                    <c:when test="${not empty user}">
                        <div class="user-menu" onclick="toggleDropdown()">
                            <div class="user-avatar">
                                ${fn:substring(user.userName, 0, 1)}
                            </div>
                            <span class="user-name">${user.userName}</span>
                            <i class="bi bi-chevron-down" style="color:rgba(255,255,255,0.6); font-size:0.75rem;"></i>
                        </div>
                        <div class="dropdown-menu-custom" id="userDropdown">
                            <a href="#"><i class="bi bi-person"></i> Hồ sơ của tôi</a>
                            <a href="mainController?action=ViewCourse"> 
                                <i class="bi bi-book"></i> Khóa học của tôi
                            </a>
                            <a href="#"><i class="bi bi-award"></i> Chứng chỉ</a>
                            <a href="#"><i class="bi bi-gear"></i> Cài đặt</a>
                            <div class="divider-drop"></div>
                            <a href="mainController?action=logout" class="logout-link">
                                <i class="bi bi-box-arrow-right"></i> Đăng xuất
                            </a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <a href="login.jsp" style="color:rgba(255,255,255,0.75); text-decoration:none; font-size:0.875rem; font-weight:500;">Đăng nhập</a>
                        <a href="register.jsp" style="background:var(--gold); color:var(--purple-deep); font-weight:700; padding:8px 20px; border-radius:8px; text-decoration:none; font-size:0.875rem; transition:opacity 0.15s;">Đăng ký</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </nav>

        <!-- HERO -->
        <div class="hero">
            <div class="hero-content">
                <!-- Welcome message if logged in -->
                <c:if test="${not empty user}">
                    <div class="welcome-badge">
                        <i class="bi bi-hand-wave" style="color:var(--gold);"></i>
                        Chào mừng trở lại, <strong>${user.userName}</strong>!
                    </div>
                </c:if>

                <div class="hero-eyebrow">✦ Nền tảng học trực tuyến hàng đầu</div>
                <h1>Chinh phục<br>tri thức, <em>định hình</em><br>tương lai</h1>
                <p>Hàng nghìn khóa học từ các chuyên gia hàng đầu đang chờ bạn. Học bất cứ lúc nào, bất cứ nơi đâu.</p>

                <div class="hero-actions">
                    <a href="search.jsp" class="btn-hero-primary">
                        <i class="bi bi-play-fill"></i> Khám phá khóa học
                    </a>
                    <a href="register.jsp" class="btn-hero-secondary">
                        <i class="bi bi-person-plus"></i> Tham gia miễn phí
                    </a>
                </div>
            </div>

            <div class="hero-right">
                <div class="floating-cards">
                    <div class="mini-card">
                        <div class="mini-icon bg-pur">🤖</div>
                        <div class="mini-info">
                            <h4>Machine Learning A-Z</h4>
                            <p><span class="mini-stars">★★★★★</span> 4.9 · 125K học viên</p>
                        </div>
                    </div>
                    <div class="mini-card">
                        <div class="mini-icon bg-gld">🎨</div>
                        <div class="mini-info">
                            <h4>UI/UX Design Masterclass</h4>
                            <p><span class="mini-stars">★★★★★</span> 4.8 · 89K học viên</p>
                        </div>
                    </div>
                    <div class="mini-card">
                        <div class="mini-icon bg-grn">📊</div>
                        <div class="mini-info">
                            <h4>Python for Data Science</h4>
                            <p><span class="mini-stars">★★★★½</span> 4.7 · 240K học viên</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- PARTNERS -->
        <div class="partners">
            <div class="partners-label">Đối tác và đơn vị chứng nhận</div>
            <div class="partner-logos">
                <span class="partner-logo">Google</span>
                <span class="partner-logo">Microsoft</span>
                <span class="partner-logo">IBM</span>
                <span class="partner-logo">Meta</span>
                <span class="partner-logo">AWS</span>
                <span class="partner-logo">Adobe</span>
                <span class="partner-logo">Oracle</span>
            </div>
        </div>

        <!-- CATEGORIES -->
        <section class="categories">
            <div class="section-eyebrow">Danh mục</div>
            <div class="section-title">Khám phá theo lĩnh vực</div>
            <p class="section-sub">Chọn chủ đề phù hợp với mục tiêu sự nghiệp của bạn</p>

            <div class="cat-grid">
                <a href="search.jsp?cat=tech" class="cat-card">
                    <i class="bi bi-arrow-right cat-arrow"></i>
                    <div class="cat-icon">💻</div>
                    <h3>Lập trình & Công nghệ</h3>
                    <p>668 khóa học</p>
                </a>
                <a href="search.jsp?cat=data" class="cat-card">
                    <i class="bi bi-arrow-right cat-arrow"></i>
                    <div class="cat-icon">📊</div>
                    <h3>Khoa học dữ liệu & AI</h3>
                    <p>425 khóa học</p>
                </a>
                <a href="search.jsp?cat=business" class="cat-card">
                    <i class="bi bi-arrow-right cat-arrow"></i>
                    <div class="cat-icon">💼</div>
                    <h3>Kinh doanh & Quản lý</h3>
                    <p>1,095 khóa học</p>
                </a>
                <a href="search.jsp?cat=design" class="cat-card">
                    <i class="bi bi-arrow-right cat-arrow"></i>
                    <div class="cat-icon">🎨</div>
                    <h3>Thiết kế sáng tạo</h3>
                    <p>312 khóa học</p>
                </a>
                <a href="search.jsp?cat=marketing" class="cat-card">
                    <i class="bi bi-arrow-right cat-arrow"></i>
                    <div class="cat-icon">📣</div>
                    <h3>Marketing & Truyền thông</h3>
                    <p>278 khóa học</p>
                </a>
                <a href="search.jsp?cat=lang" class="cat-card">
                    <i class="bi bi-arrow-right cat-arrow"></i>
                    <div class="cat-icon">🌐</div>
                    <h3>Ngoại ngữ</h3>
                    <p>186 khóa học</p>
                </a>
                <a href="search.jsp?cat=health" class="cat-card">
                    <i class="bi bi-arrow-right cat-arrow"></i>
                    <div class="cat-icon">⚕️</div>
                    <h3>Sức khỏe & Thể chất</h3>
                    <p>234 khóa học</p>
                </a>
                <a href="search.jsp?cat=finance" class="cat-card">
                    <i class="bi bi-arrow-right cat-arrow"></i>
                    <div class="cat-icon">💰</div>
                    <h3>Tài chính & Đầu tư</h3>
                    <p>197 khóa học</p>
                </a>
            </div>
        </section>

        <!-- POPULAR COURSES -->
        <section class="courses">
            <div class="section-eyebrow">Nổi bật</div>
            <div class="section-title">Khóa học được yêu thích nhất</div>
            <p class="section-sub">Hàng triệu học viên đang theo học các khóa học này</p>

            <div class="course-grid">
                <a href="#" class="course-card">
                    <div class="course-thumb th1">🤖</div>
                    <div class="course-body">
                        <div class="course-org">DeepLearning.AI</div>
                        <h3>Machine Learning Specialization</h3>
                        <div class="course-meta">
                            <span class="course-stars">★★★★★</span>
                            <span class="course-score">4.9</span>
                            <span class="course-count">(125K)</span>
                        </div>
                        <span class="course-tag">Dành cho người mới</span>
                    </div>
                </a>
                <a href="#" class="course-card">
                    <div class="course-thumb th2">🐍</div>
                    <div class="course-body">
                        <div class="course-org">Đại học Bách Khoa</div>
                        <h3>Python cho Khoa học Dữ liệu</h3>
                        <div class="course-meta">
                            <span class="course-stars">★★★★★</span>
                            <span class="course-score">4.8</span>
                            <span class="course-count">(240K)</span>
                        </div>
                        <span class="course-tag">Nhiều người học nhất</span>
                    </div>
                </a>
                <a href="#" class="course-card">
                    <div class="course-thumb th3">🎨</div>
                    <div class="course-body">
                        <div class="course-org">Google · UX Design</div>
                        <h3>Google UX Design Professional</h3>
                        <div class="course-meta">
                            <span class="course-stars">★★★★½</span>
                            <span class="course-score">4.7</span>
                            <span class="course-count">(89K)</span>
                        </div>
                        <span class="course-tag">Chứng chỉ chuyên nghiệp</span>
                    </div>
                </a>
                <a href="#" class="course-card">
                    <div class="course-thumb th4">📈</div>
                    <div class="course-body">
                        <div class="course-org">IBM · Data Science</div>
                        <h3>IBM Data Science Professional</h3>
                        <div class="course-meta">
                            <span class="course-stars">★★★★★</span>
                            <span class="course-score">4.6</span>
                            <span class="course-count">(67K)</span>
                        </div>
                        <span class="course-tag">Cầu nghề cao</span>
                    </div>
                </a>
            </div>
        </section>

        <!-- STATS -->
        <div class="stats-section">
            <div class="stats-grid">
                <div class="stat-item">
                    <span class="number">500K+</span>
                    <span class="label">Học viên đang học</span>
                </div>
                <div class="stat-item">
                    <span class="number">7,000+</span>
                    <span class="label">Khóa học chất lượng</span>
                </div>
                <div class="stat-item">
                    <span class="number">98%</span>
                    <span class="label">Học viên hài lòng</span>
                </div>
                <div class="stat-item">
                    <span class="number">325+</span>
                    <span class="label">Đối tác & Giảng viên</span>
                </div>
            </div>
        </div>

        <!-- WHY US -->
        <section class="why">
            <div class="why-grid">
                <div>
                    <div class="section-eyebrow">Tại sao chọn chúng tôi</div>
                    <div class="section-title" style="margin-bottom: 32px;">Học thật, giá trị thật</div>
                    <div class="why-features">
                        <div class="why-item">
                            <div class="why-icon"><i class="bi bi-patch-check-fill"></i></div>
                            <div>
                                <h4>Chứng chỉ được công nhận</h4>
                                <p>Chứng chỉ của chúng tôi được hàng nghìn doanh nghiệp lớn tin tưởng và công nhận trên toàn quốc.</p>
                            </div>
                        </div>
                        <div class="why-item">
                            <div class="why-icon"><i class="bi bi-play-circle-fill"></i></div>
                            <div>
                                <h4>Học mọi lúc, mọi nơi</h4>
                                <p>Truy cập nội dung học từ điện thoại, máy tính bảng hoặc máy tính — theo tốc độ của riêng bạn.</p>
                            </div>
                        </div>
                        <div class="why-item">
                            <div class="why-icon"><i class="bi bi-person-video3"></i></div>
                            <div>
                                <h4>Giảng viên hàng đầu</h4>
                                <p>Học từ những chuyên gia thực chiến với nhiều năm kinh nghiệm trong ngành.</p>
                            </div>
                        </div>
                        <div class="why-item">
                            <div class="why-icon"><i class="bi bi-graph-up-arrow"></i></div>
                            <div>
                                <h4>Kết quả nghề nghiệp thực tế</h4>
                                <p>85% học viên báo cáo thăng tiến công việc hoặc tăng thu nhập sau khi hoàn thành khóa học.</p>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="why-visual">
                    <div class="why-visual-title">💬 Học viên nói gì về chúng tôi</div>
                    <div class="testimonial">
                        <div class="testimonial-text">"Khóa học Python ở đây cực kỳ chất lượng. Sau 3 tháng tôi đã xin được việc tại công ty công nghệ lớn!"</div>
                        <div class="testimonial-author">
                            <div class="t-avatar">M</div>
                            <div>
                                <div class="t-name">Minh Hoàng</div>
                                <div class="t-role">Software Developer · HCM</div>
                            </div>
                            <div class="t-stars">★★★★★</div>
                        </div>
                    </div>
                    <div class="testimonial">
                        <div class="testimonial-text">"Giao diện đẹp, nội dung chuyên sâu. Đây là nơi học online tốt nhất mà tôi từng thử."</div>
                        <div class="testimonial-author">
                            <div class="t-avatar">L</div>
                            <div>
                                <div class="t-name">Lan Anh</div>
                                <div class="t-role">UX Designer · Hà Nội</div>
                            </div>
                            <div class="t-stars">★★★★★</div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- CTA -->
        <div class="cta-section">
            <h2>Bắt đầu hành trình<br>học tập ngay hôm nay</h2>
            <p>Tham gia cùng hơn 500,000 học viên và mở khóa tiềm năng của bạn.</p>
            <div class="cta-btns">
                <a href="register.jsp" class="btn-cta-gold">
                    <i class="bi bi-rocket-takeoff me-2"></i>Tạo tài khoản miễn phí
                </a>
                <a href="search.jsp" class="btn-cta-outline">
                    <i class="bi bi-grid me-2"></i>Xem khóa học
                </a>
            </div>
        </div>

        <!-- FOOTER -->
        <footer>
            <div class="footer-grid">
                <div>
                    <span class="footer-brand-text">Learn<span>Verse</span></span>
                    <p class="footer-desc">Nền tảng học trực tuyến hàng đầu, kết nối học viên với kiến thức và cơ hội nghề nghiệp tốt nhất.</p>
                    <div class="footer-social">
                        <a href="#"><i class="bi bi-facebook"></i></a>
                        <a href="#"><i class="bi bi-youtube"></i></a>
                        <a href="#"><i class="bi bi-linkedin"></i></a>
                        <a href="#"><i class="bi bi-instagram"></i></a>
                    </div>
                </div>
                <div class="footer-col">
                    <h4>Công ty</h4>
                    <a href="#">Về chúng tôi</a>
                    <a href="#">Blog</a>
                    <a href="#">Tuyển dụng</a>
                    <a href="#">Báo chí</a>
                </div>
                <div class="footer-col">
                    <h4>Cộng đồng</h4>
                    <a href="#">Học viên</a>
                    <a href="#">Giảng viên</a>
                    <a href="#">Đối tác</a>
                    <a href="#">Diễn đàn</a>
                </div>
                <div class="footer-col">
                    <h4>Hỗ trợ</h4>
                    <a href="#">Trung tâm trợ giúp</a>
                    <a href="#">Liên hệ</a>
                    <a href="#">Điều khoản</a>
                    <a href="#">Chính sách</a>
                </div>
            </div>
            <div class="footer-bottom">
                <span>© 2026 LearnVerse. All rights reserved.</span>
                <span>Được làm với ❤️ tại Việt Nam</span>
            </div>
        </footer>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                            function toggleDropdown() {
                                const dd = document.getElementById('userDropdown');
                                dd.classList.toggle('show');
                            }
                            document.addEventListener('click', function (e) {
                                const menu = document.querySelector('.user-menu');
                                const dd = document.getElementById('userDropdown');
                                if (dd && menu && !menu.contains(e.target) && !dd.contains(e.target)) {
                                    dd.classList.remove('show');
                                }
                            });
        </script>
    </body>
</html>
