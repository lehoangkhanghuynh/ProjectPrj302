<%-- 
    Document   : instructors
    Created on : Mar 1, 2026, 10:03:37 PM
    Author     : HOANG KHANG PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Giảng viên - DUK Academy</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,600;0,700;1,600&family=DM+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
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
                --gold-light:  #F5D98A;
                --text:        #1A1A2E;
                --muted:       #6B6B8A;
                --border:      #E2D9F3;
                --bg:          #F4F0FC;
            }
            *, *::before, *::after {
                box-sizing: border-box;
                margin: 0;
                padding: 0;
            }
            body {
                font-family: 'DM Sans', sans-serif;
                color: var(--text);
                background: var(--bg);
            }

            /* ── NAVBAR ── */
            .navbar-main {
                background: var(--purple-deep);
                padding: 0 72px;
                height: 68px;
                display: flex;
                align-items: center;
                justify-content: space-between;
                position: sticky;
                top: 0;
                z-index: 100;
                box-shadow: 0 2px 24px rgba(0,0,0,0.28);
            }
            .brand {
                font-family: 'Playfair Display', serif;
                font-size: 1.55rem;
                font-weight: 700;
                color: #fff;
                text-decoration: none;
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
                color: rgba(255,255,255,0.72);
                text-decoration: none;
                padding: 7px 14px;
                border-radius: 6px;
                transition: all 0.15s;
            }
            .nav-links a:hover, .nav-links a.active {
                background: rgba(255,255,255,0.1);
                color: #fff;
            }
            .nav-right {
                display: flex;
                align-items: center;
                gap: 12px;
            }
            .nav-cta {
                display: flex;
                align-items: center;
                gap: 7px;
                background: var(--purple);
                color: #fff;
                text-decoration: none;
                font-size: 0.85rem;
                font-weight: 700;
                padding: 8px 18px;
                border-radius: 8px;
                transition: all 0.15s;
            }
            .nav-cta:hover {
                background: var(--purple-dark);
                color: #fff;
                transform: translateY(-1px);
            }

            /* ── HERO ── */
            .hero {
                background: linear-gradient(135deg, var(--purple-deep) 0%, #2E1275 50%, #5B2DC5 100%);
                padding: 88px 72px 96px;
                position: relative;
                overflow: hidden;
            }
            .hero::before {
                content: '';
                position: absolute;
                width: 600px;
                height: 600px;
                border-radius: 50%;
                background: radial-gradient(circle, rgba(212,168,67,0.08) 0%, transparent 70%);
                top: -200px;
                right: -100px;
            }
            .hero::after  {
                content: '';
                position: absolute;
                width: 300px;
                height: 300px;
                border-radius: 50%;
                background: rgba(155,114,232,0.12);
                bottom: -80px;
                left: 300px;
            }
            .hero-dot {
                position: absolute;
                border-radius: 50%;
                background: rgba(255,255,255,0.06);
                animation: floatDot 6s ease-in-out infinite;
            }
            @keyframes floatDot {
                0%,100% {
                    transform: translateY(0);
                }
                50% {
                    transform: translateY(-18px);
                }
            }
            .hero-inner {
                position: relative;
                z-index: 2;
                max-width: 660px;
            }
            .hero-eyebrow {
                font-size: 0.72rem;
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: 2.5px;
                color: var(--gold);
                margin-bottom: 14px;
                display: flex;
                align-items: center;
                gap: 8px;
            }
            .hero-eyebrow::before {
                content: '';
                display: inline-block;
                width: 22px;
                height: 2px;
                background: var(--gold);
                border-radius: 1px;
            }
            .hero-title {
                font-family: 'Playfair Display', serif;
                font-size: 3rem;
                font-weight: 700;
                color: #fff;
                line-height: 1.2;
                margin-bottom: 18px;
            }
            .hero-title em {
                font-style: italic;
                color: var(--gold-light);
            }
            .hero-sub {
                font-size: 1.05rem;
                color: rgba(255,255,255,0.62);
                line-height: 1.7;
                margin-bottom: 36px;
                max-width: 520px;
            }
            .hero-stats {
                display: flex;
                gap: 40px;
            }
            .hero-stat-num {
                font-size: 1.75rem;
                font-weight: 700;
                color: var(--gold);
            }
            .hero-stat-lbl {
                font-size: 0.78rem;
                color: rgba(255,255,255,0.5);
                margin-top: 2px;
            }

            /* ── SEARCH ── */
            .search-section {
                background: #fff;
                border-bottom: 1px solid var(--border);
                padding: 18px 72px;
                display: flex;
                align-items: center;
                gap: 14px;
            }
            .search-wrap {
                flex: 1;
                max-width: 480px;
                position: relative;
            }
            .search-wrap input {
                width: 100%;
                padding: 11px 18px 11px 44px;
                border: 1.5px solid var(--border);
                border-radius: 10px;
                font-size: 0.88rem;
                font-family: 'DM Sans', sans-serif;
                color: var(--text);
                outline: none;
                transition: border-color 0.15s;
                background: var(--bg);
            }
            .search-wrap input:focus {
                border-color: var(--purple);
                background: #fff;
            }
            .search-wrap i {
                position: absolute;
                left: 15px;
                top: 50%;
                transform: translateY(-50%);
                color: var(--muted);
                font-size: 0.9rem;
            }
            .filter-chips {
                display: flex;
                align-items: center;
                gap: 8px;
                flex-wrap: wrap;
            }
            .chip {
                padding: 6px 16px;
                border-radius: 20px;
                font-size: 0.8rem;
                font-weight: 600;
                border: 1.5px solid var(--border);
                background: #fff;
                color: var(--muted);
                cursor: pointer;
                transition: all 0.15s;
            }
            .chip:hover {
                border-color: var(--purple);
                color: var(--purple);
            }
            .chip.active {
                background: var(--purple);
                border-color: var(--purple);
                color: #fff;
            }

            /* ── FEATURED ── */
            .featured-section {
                padding: 60px 72px 0;
            }
            .section-label {
                font-size: 0.72rem;
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: 2.5px;
                color: var(--gold);
                margin-bottom: 10px;
                display: flex;
                align-items: center;
                gap: 8px;
            }
            .section-label::before {
                content: '';
                width: 18px;
                height: 2px;
                background: var(--gold);
                border-radius: 1px;
            }
            .section-heading {
                font-family: 'Playfair Display', serif;
                font-size: 1.7rem;
                font-weight: 700;
                color: var(--text);
                margin-bottom: 28px;
            }
            .featured-card {
                background: linear-gradient(135deg, var(--purple-deep) 0%, #3A1A7A 60%, #5B2DC5 100%);
                border-radius: 24px;
                padding: 48px;
                display: grid;
                grid-template-columns: 280px 1fr;
                gap: 48px;
                align-items: center;
                position: relative;
                overflow: hidden;
                box-shadow: 0 20px 60px rgba(108,63,197,0.25);
            }
            .featured-card::before {
                content: '';
                position: absolute;
                width: 350px;
                height: 350px;
                border-radius: 50%;
                background: rgba(212,168,67,0.07);
                top: -100px;
                right: -60px;
            }
            .featured-avatar-wrap {
                position: relative;
                z-index: 1;
            }
            .featured-avatar {
                width: 220px;
                height: 220px;
                border-radius: 50%;
                background: linear-gradient(135deg, var(--purple-mid), var(--gold));
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 5rem;
                font-weight: 700;
                color: #fff;
                border: 5px solid rgba(255,255,255,0.18);
                box-shadow: 0 12px 40px rgba(0,0,0,0.35), 0 0 0 10px rgba(255,255,255,0.05);
                overflow: hidden;
                margin: 0 auto;
                position: relative;
            }
            .featured-avatar img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                position: absolute;
                inset: 0;
                transition: transform 0.4s;
            }
            .featured-avatar:hover img {
                transform: scale(1.06);
            }
            .featured-initials {
                position: absolute;
                inset: 0;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 5rem;
                font-weight: 700;
                color: #fff;
            }
            .featured-crown {
                position: absolute;
                top: -6px;
                right: 20px;
                background: var(--gold);
                color: #2D1B00;
                font-size: 0.65rem;
                font-weight: 700;
                padding: 4px 12px;
                border-radius: 20px;
                display: flex;
                align-items: center;
                gap: 4px;
                z-index: 2;
            }
            .featured-info {
                position: relative;
                z-index: 1;
            }
            .featured-tag {
                font-size: 0.7rem;
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: 2px;
                color: var(--gold);
                margin-bottom: 10px;
            }
            .featured-name {
                font-family: 'Playfair Display', serif;
                font-size: 2.2rem;
                font-weight: 700;
                color: #fff;
                margin-bottom: 6px;
            }
            .featured-title-text {
                font-size: 1rem;
                color: rgba(255,255,255,0.6);
                margin-bottom: 18px;
            }
            .featured-bio {
                font-size: 0.9rem;
                color: rgba(255,255,255,0.55);
                line-height: 1.75;
                margin-bottom: 24px;
                max-width: 540px;
            }
            .featured-badges {
                display: flex;
                flex-wrap: wrap;
                gap: 8px;
                margin-bottom: 24px;
            }
            .feat-badge {
                background: rgba(255,255,255,0.1);
                border: 1px solid rgba(255,255,255,0.15);
                color: rgba(255,255,255,0.8);
                font-size: 0.75rem;
                font-weight: 600;
                padding: 5px 14px;
                border-radius: 20px;
            }
            .featured-row {
                display: flex;
                gap: 32px;
                flex-wrap: wrap;
            }
            .feat-stat-num {
                font-size: 1.4rem;
                font-weight: 700;
                color: var(--gold);
            }
            .feat-stat-lbl {
                font-size: 0.72rem;
                color: rgba(255,255,255,0.45);
                margin-top: 1px;
            }

            /* ── GRID ── */
            .all-section {
                padding: 52px 72px 80px;
            }
            .all-header {
                display: flex;
                align-items: center;
                justify-content: space-between;
                margin-bottom: 28px;
            }
            .all-title {
                font-family: 'Playfair Display', serif;
                font-size: 1.6rem;
                font-weight: 700;
                color: var(--text);
            }
            .count-badge {
                background: var(--purple-light);
                color: var(--purple);
                font-size: 0.78rem;
                font-weight: 700;
                padding: 4px 14px;
                border-radius: 20px;
            }
            .instructor-grid {
                display: grid;
                grid-template-columns: repeat(4, 1fr);
                gap: 22px;
            }
            .instructor-card {
                background: #fff;
                border: 1px solid var(--border);
                border-radius: 18px;
                overflow: visible;
                transition: transform 0.22s, box-shadow 0.22s;
                cursor: pointer;
                animation: cardIn 0.4s ease both;
            }
            @keyframes cardIn {
                from {
                    opacity: 0;
                    transform: translateY(22px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }
            .instructor-card:nth-child(1){
                animation-delay:.05s
            }
            .instructor-card:nth-child(2){
                animation-delay:.10s
            }
            .instructor-card:nth-child(3){
                animation-delay:.15s
            }
            .instructor-card:nth-child(4){
                animation-delay:.20s
            }
            .instructor-card:nth-child(5){
                animation-delay:.25s
            }
            .instructor-card:nth-child(6){
                animation-delay:.30s
            }
            .instructor-card:nth-child(7){
                animation-delay:.35s
            }
            .instructor-card:nth-child(8){
                animation-delay:.40s
            }
            .instructor-card:hover {
                transform: translateY(-6px);
                box-shadow: 0 18px 48px rgba(108,63,197,0.16);
            }

            /* Card header strip */
            .icard-inner {
                border-radius: 18px;
                overflow: hidden;
            }
            .icard-header {
                height: 100px;
                position: relative;
            }
            .icard-bg {
                width: 100%;
                height: 100%;
                display: block;
            }

            /* ── PHOTO AVATAR on card ── */
            .icard-avatar {
                width: 88px;
                height: 88px;
                border-radius: 50%;
                border: 4px solid #fff;
                position: absolute;
                bottom: -40px;
                left: 50%;
                transform: translateX(-50%);
                overflow: hidden;
                box-shadow: 0 6px 22px rgba(108,63,197,0.3);
                transition: transform 0.25s, box-shadow 0.25s;
                /* gradient shown when no img */
                background: linear-gradient(135deg, var(--purple-mid), var(--gold));
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 1.9rem;
                font-weight: 700;
                color: #fff;
            }
            .instructor-card:hover .icard-avatar {
                transform: translateX(-50%) scale(1.09);
                box-shadow: 0 10px 30px rgba(108,63,197,0.4);
            }
            .icard-avatar img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                position: absolute;
                inset: 0;
            }
            .icard-avatar img.err {
                display: none;
            }

            /* Card body */
            .icard-body {
                padding: 52px 18px 16px;
                text-align: center;
            }
            .icard-name {
                font-size: 0.95rem;
                font-weight: 700;
                color: var(--text);
                margin-bottom: 4px;
            }
            .icard-role {
                font-size: 0.75rem;
                color: var(--muted);
                font-weight: 500;
                margin-bottom: 14px;
            }
            .icard-tags {
                display: flex;
                flex-wrap: wrap;
                gap: 5px;
                justify-content: center;
                margin-bottom: 14px;
            }
            .icard-tag {
                background: var(--purple-light);
                color: var(--purple);
                font-size: 0.65rem;
                font-weight: 700;
                padding: 3px 9px;
                border-radius: 4px;
            }
            .icard-divider {
                height: 1px;
                background: var(--border);
                margin: 12px 0;
            }
            .icard-stats {
                display: flex;
                justify-content: space-around;
            }
            .icard-stat-num {
                font-size: 0.88rem;
                font-weight: 700;
                color: var(--purple);
            }
            .icard-stat-lbl {
                font-size: 0.64rem;
                color: var(--muted);
                margin-top: 1px;
            }
            .icard-stars {
                color: var(--gold);
                font-size: 0.72rem;
                margin-bottom: 2px;
            }
            .icard-footer {
                padding: 0 18px 18px;
            }
            .btn-view-profile {
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 7px;
                width: 100%;
                background: var(--purple-light);
                color: var(--purple);
                border: 1.5px solid var(--border);
                border-radius: 10px;
                padding: 9px;
                font-size: 0.8rem;
                font-weight: 700;
                font-family: 'DM Sans', sans-serif;
                transition: all 0.18s;
                cursor: pointer;
            }
            .btn-view-profile:hover {
                background: var(--purple);
                color: #fff;
                border-color: var(--purple);
                box-shadow: 0 5px 16px rgba(108,63,197,0.3);
            }

            /* ── CTA ── */
            .cta-section {
                padding: 0 72px 80px;
            }
            .cta-box {
                background: linear-gradient(135deg, var(--purple-deep), #3A1A7A);
                border-radius: 24px;
                padding: 64px 72px;
                text-align: center;
                position: relative;
                overflow: hidden;
            }
            .cta-box::before {
                content: '';
                position: absolute;
                width: 400px;
                height: 400px;
                border-radius: 50%;
                background: rgba(212,168,67,0.07);
                top: -150px;
                right: -80px;
            }
            .cta-inner {
                position: relative;
                z-index: 1;
            }
            .cta-eyebrow {
                font-size: 0.72rem;
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: 2px;
                color: var(--gold);
                margin-bottom: 14px;
            }
            .cta-title {
                font-family: 'Playfair Display', serif;
                font-size: 2rem;
                font-weight: 700;
                color: #fff;
                margin-bottom: 14px;
            }
            .cta-sub {
                font-size: 0.95rem;
                color: rgba(255,255,255,0.55);
                margin-bottom: 32px;
                max-width: 480px;
                margin-left: auto;
                margin-right: auto;
            }
            .cta-actions {
                display: flex;
                gap: 14px;
                justify-content: center;
                flex-wrap: wrap;
            }
            .btn-cta-primary {
                display: inline-flex;
                align-items: center;
                gap: 8px;
                background: linear-gradient(135deg, var(--gold), #B8892D);
                color: #1A1A2E;
                font-size: 0.9rem;
                font-weight: 700;
                padding: 13px 30px;
                border-radius: 12px;
                text-decoration: none;
                transition: all 0.18s;
                box-shadow: 0 5px 18px rgba(212,168,67,0.35);
            }
            .btn-cta-primary:hover {
                transform: translateY(-2px);
                box-shadow: 0 9px 28px rgba(212,168,67,0.5);
                color: #1A1A2E;
            }
            .btn-cta-secondary {
                display: inline-flex;
                align-items: center;
                gap: 8px;
                background: rgba(255,255,255,0.1);
                color: #fff;
                font-size: 0.9rem;
                font-weight: 700;
                padding: 13px 30px;
                border-radius: 12px;
                text-decoration: none;
                border: 1.5px solid rgba(255,255,255,0.2);
                transition: all 0.18s;
            }
            .btn-cta-secondary:hover {
                background: rgba(255,255,255,0.15);
                color: #fff;
            }

            /* ── FOOTER ── */
            footer {
                background: var(--purple-deep);
                padding: 32px 72px;
            }
            .footer-inner {
                display: flex;
                justify-content: space-between;
                align-items: center;
                border-top: 1px solid rgba(255,255,255,0.08);
                padding-top: 20px;
            }

            /* ── MODAL ── */
            .modal-overlay {
                display: none;
                position: fixed;
                inset: 0;
                background: rgba(10,5,30,0.72);
                backdrop-filter: blur(6px);
                z-index: 500;
                align-items: center;
                justify-content: center;
            }
            .modal-overlay.show {
                display: flex;
            }
            .modal-box {
                background: #fff;
                border-radius: 22px;
                width: 560px;
                max-width: 95vw;
                max-height: 90vh;
                overflow-y: auto;
                box-shadow: 0 28px 72px rgba(108,63,197,0.28);
                animation: modalPop 0.25s cubic-bezier(0.34,1.56,0.64,1);
            }
            @keyframes modalPop {
                from {
                    transform: scale(0.85) translateY(30px);
                    opacity: 0;
                }
                to {
                    transform: scale(1) translateY(0);
                    opacity: 1;
                }
            }
            .modal-strip {
                height: 155px;
                position: relative;
                border-radius: 22px 22px 0 0;
                overflow: visible;
            }
            .modal-close {
                position: absolute;
                top: 14px;
                right: 16px;
                background: rgba(255,255,255,0.22);
                border: none;
                border-radius: 50%;
                width: 32px;
                height: 32px;
                font-size: 1rem;
                color: #fff;
                cursor: pointer;
                display: flex;
                align-items: center;
                justify-content: center;
                transition: background 0.15s;
                z-index: 2;
            }
            .modal-close:hover {
                background: rgba(255,255,255,0.38);
            }
            /* Modal photo */
            .modal-photo {
                width: 114px;
                height: 114px;
                border-radius: 50%;
                border: 5px solid #fff;
                position: absolute;
                bottom: -50px;
                left: 50%;
                transform: translateX(-50%);
                overflow: hidden;
                box-shadow: 0 8px 28px rgba(108,63,197,0.3);
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 2.6rem;
                font-weight: 700;
                color: #fff;
                background: linear-gradient(135deg, var(--purple-mid), var(--gold));
            }
            .modal-photo img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                position: absolute;
                inset: 0;
            }
            .modal-photo img.err {
                display: none;
            }
            .modal-photo-initials {
                font-size: 2.6rem;
                font-weight: 700;
                color: #fff;
            }

            .modal-body {
                padding: 66px 36px 36px;
                text-align: center;
            }
            .modal-name {
                font-family: 'Playfair Display', serif;
                font-size: 1.6rem;
                font-weight: 700;
                color: var(--text);
                margin-bottom: 4px;
            }
            .modal-role {
                font-size: 0.88rem;
                color: var(--muted);
                margin-bottom: 16px;
            }
            .modal-tags {
                display: flex;
                flex-wrap: wrap;
                gap: 7px;
                justify-content: center;
                margin-bottom: 20px;
            }
            .modal-tag {
                background: var(--purple-light);
                color: var(--purple);
                font-size: 0.72rem;
                font-weight: 700;
                padding: 4px 12px;
                border-radius: 6px;
            }
            .modal-bio {
                font-size: 0.88rem;
                color: var(--muted);
                line-height: 1.8;
                text-align: left;
                margin-bottom: 24px;
            }
            .modal-stats-row {
                display: flex;
                gap: 16px;
                margin-bottom: 24px;
            }
            .modal-stat {
                flex: 1;
                background: var(--bg);
                border-radius: 12px;
                padding: 14px;
                text-align: center;
            }
            .modal-stat-num {
                font-size: 1.2rem;
                font-weight: 700;
                color: var(--purple);
            }
            .modal-stat-lbl {
                font-size: 0.68rem;
                color: var(--muted);
                margin-top: 2px;
            }
            .btn-modal-courses {
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 8px;
                width: 100%;
                background: linear-gradient(135deg, var(--purple), var(--purple-dark));
                color: #fff;
                border: none;
                border-radius: 12px;
                padding: 13px;
                font-size: 0.9rem;
                font-weight: 700;
                cursor: pointer;
                font-family: 'DM Sans', sans-serif;
                transition: all 0.18s;
                text-decoration: none;
                box-shadow: 0 5px 16px rgba(108,63,197,0.3);
            }
            .btn-modal-courses:hover {
                transform: translateY(-2px);
                box-shadow: 0 8px 24px rgba(108,63,197,0.45);
                color: #fff;
            }

            @media (max-width: 1100px) {
                .instructor-grid {
                    grid-template-columns: repeat(3, 1fr);
                }
            }
            @media (max-width: 800px) {
                .instructor-grid {
                    grid-template-columns: repeat(2, 1fr);
                }
                .featured-card {
                    grid-template-columns: 1fr;
                    text-align: center;
                }
                .featured-avatar {
                    margin: 0 auto;
                }
                .featured-row {
                    justify-content: center;
                }
                .hero {
                    padding: 60px 24px 72px;
                }
                .featured-section, .all-section, .cta-section {
                    padding-left: 24px;
                    padding-right: 24px;
                }
                .search-section {
                    padding: 14px 24px;
                }
                .navbar-main {
                    padding: 0 24px;
                }
                .nav-links {
                    display: none;
                }
            }
            @media (max-width: 560px) {
                .instructor-grid {
                    grid-template-columns: 1fr;
                }
            }
        </style>
    </head>
    <body>

        <!-- NAVBAR -->
        <nav class="navbar-main">
            <a href="homePage.jsp" class="brand">DUK<span>Academy</span></a>
            <ul class="nav-links">
                <li><a href="homePage.jsp">Trang chủ</a></li>
                <li><a href="courseController?action=ExploreCourse">Khóa học</a></li>
                <li><a href="instructors.jsp" class="active">Giảng viên</a></li>
                <li><a href="#">Về chúng tôi</a></li>
            </ul>
            <div class="nav-right">
                <a href="courseController?action=ExploreCourse" class="nav-cta">
                    <i class="bi bi-compass-fill"></i> Khám phá khóa học
                </a>
            </div>
        </nav>

        <!-- HERO -->
        <div class="hero">
            <div class="hero-dot" style="width:180px;height:180px;top:30px;right:320px;animation-delay:0s;"></div>
            <div class="hero-dot" style="width:90px;height:90px;top:140px;right:180px;animation-delay:1.5s;"></div>
            <div class="hero-dot" style="width:50px;height:50px;bottom:60px;right:500px;animation-delay:3s;"></div>
            <div class="hero-inner">
                <div class="hero-eyebrow">Đội ngũ giảng viên</div>
                <h1 class="hero-title">Học từ những<br><em>chuyên gia thực chiến</em></h1>
                <p class="hero-sub">Đội ngũ giảng viên của DUK Academy là những chuyên gia có nhiều năm kinh nghiệm trong ngành, cam kết mang đến kiến thức thực tiễn và cập nhật nhất.</p>
                <div class="hero-stats">
                    <div><div class="hero-stat-num">40+</div><div class="hero-stat-lbl">Giảng viên</div></div>
                    <div><div class="hero-stat-num">120+</div><div class="hero-stat-lbl">Khóa học</div></div>
                    <div><div class="hero-stat-num">50K+</div><div class="hero-stat-lbl">Học viên</div></div>
                    <div><div class="hero-stat-num">4.9 ★</div><div class="hero-stat-lbl">Đánh giá TB</div></div>
                </div>
            </div>
        </div>

        <!-- SEARCH + FILTER -->
        <div class="search-section">
            <div class="search-wrap">
                <i class="bi bi-search"></i>
                <input type="text" placeholder="Tìm kiếm giảng viên..." id="searchInput" oninput="filterInstructors()">
            </div>
            <div class="filter-chips">
                <span class="chip active" onclick="filterByField(this, '')">Tất cả</span>
                <span class="chip" onclick="filterByField(this, 'ai')">🤖 AI & ML</span>
                <span class="chip" onclick="filterByField(this, 'web')">💻 Web Dev</span>
                <span class="chip" onclick="filterByField(this, 'data')">📊 Data</span>
                <span class="chip" onclick="filterByField(this, 'design')">🎨 Design</span>
                <span class="chip" onclick="filterByField(this, 'mobile')">📱 Mobile</span>
                <span class="chip" onclick="filterByField(this, 'cloud')">☁️ Cloud</span>
            </div>
        </div>

        <!-- FEATURED INSTRUCTOR -->
        <%-- Đặt ảnh tại: /img/instructors/featured.jpg --%>
        <div class="featured-section">
            <div class="section-label">Giảng viên nổi bật</div>
            <div class="section-heading">Gương mặt tiêu biểu tháng này</div>
            <div class="featured-card">
                <div class="featured-avatar-wrap">
                    <div class="featured-avatar" id="featuredAvatar">
                        <span class="featured-initials" id="featuredInitials">K</span>
                        <img id="featuredImg"
                             src="img/instructors/gv1.jpg"
                             alt="Lê Hoàng Khang"
                             onload="this.style.zIndex = '2'; document.getElementById('featuredInitials').style.display = 'none';"
                             onerror="this.style.display='none'; document.getElementById('featuredInitials').style.display='flex';"
                             style="z-index:1;">
                    </div>
                    <div class="featured-crown"><i class="bi bi-trophy-fill"></i> Top Instructor</div>
                </div>
                <div class="featured-info">
                    <div class="featured-tag">✦ Giảng viên của tháng</div>
                    <div class="featured-name">Lê Hoàng Khang</div>
                    <div class="featured-title-text">Machine AI · Google Vietnam</div>
                    <p class="featured-bio">Hơn 12 năm kinh nghiệm trong lĩnh vực Trí tuệ nhân tạo và Machine Learning. Từng làm việc tại Google, Grab và VinAI. Chuyên gia về Deep Learning, NLP và Computer Vision. Tác giả của hơn 20 bài báo khoa học quốc tế.</p>
                    <div class="featured-badges">
                        <span class="feat-badge">🤖 Deep Learning</span>
                        <span class="feat-badge">🧠 NLP</span>
                        <span class="feat-badge">👁️ Computer Vision</span>
                        <span class="feat-badge">🐍 Python</span>
                        <span class="feat-badge">📊 TensorFlow</span>
                    </div>
                    <div class="featured-row">
                        <div><div class="feat-stat-num">18</div><div class="feat-stat-lbl">Khóa học</div></div>
                        <div><div class="feat-stat-num">511</div><div class="feat-stat-lbl">Học viên</div></div>
                        <div><div class="feat-stat-num">4.9 ★</div><div class="feat-stat-lbl">Đánh giá</div></div>
                        <div><div class="feat-stat-num">98%</div><div class="feat-stat-lbl">Hài lòng</div></div>
                    </div>
                </div>
            </div>
        </div>

        <!-- ALL INSTRUCTORS -->
        <%--
        ╔══════════════════════════════════════════════════════════╗
        ║  ĐẶT ẢNH TẠI:  /img/instructors/instructor1.jpg  ...8  ║
        ║  Nếu ảnh không tồn tại → tự động hiện chữ cái màu sắc  ║
        ╚══════════════════════════════════════════════════════════╝
        --%>
        <div class="all-section">
            <div class="all-header">
                <div class="all-title">Tất cả giảng viên</div>
                <span class="count-badge" id="instructorCount">8 giảng viên</span>
            </div>

            <div class="instructor-grid" id="instructorGrid">

                <!-- ── MACRO: 1 instructor card ──
                     data-img  = đường dẫn ảnh (relative từ root project)
                     data-init = chữ cái fallback
                     data-c1/c2 = màu gradient fallback
                -->

                <!-- Card 1 -->
                <div class="instructor-card" data-field="ai" data-name="Lê Hoàng Khang"
                     data-img="img/instructors/gv1.jpg" data-init="K" data-c1="#1E0A4A" data-c2="#6C3FC5"
                     onclick="openModal(this)">
                    <div class="icard-inner">
                        <div class="icard-header">
                            <svg class="icard-bg" viewBox="0 0 300 100" preserveAspectRatio="xMidYMid slice"><defs><linearGradient id="g1" x1="0" y1="0" x2="1" y2="1"><stop offset="0%" stop-color="#1E0A4A"/><stop offset="100%" stop-color="#6C3FC5"/></linearGradient></defs><rect width="300" height="100" fill="url(#g1)"/></svg>
                            <div class="icard-avatar" style="background:linear-gradient(135deg,#6C3FC5,#1E0A4A)">
                                <span>K</span>
                                <img src="img/instructors/gv1.jpg" alt="Lê Hoàng Khang"
                                     onload="this.style.zIndex = '2';this.previousElementSibling.style.display = 'none';"
                                     onerror="this.classList.add('err')" style="z-index:1;">
                            </div>
                        </div>
                        <div class="icard-body">
                            <div class="icard-name">Lê Hoàng Khang</div>
                            <div class="icard-role">Machine AI · Google</div>
                            <div class="icard-tags"><span class="icard-tag">AI</span><span class="icard-tag">ML</span><span class="icard-tag">Python</span></div>
                            <div class="icard-stars">★★★★★</div>
                            <div class="icard-divider"></div>
                            <div class="icard-stats">
                                <div><div class="icard-stat-num">18</div><div class="icard-stat-lbl">Khóa học</div></div>
                                <div><div class="icard-stat-num">511</div><div class="icard-stat-lbl">Học viên</div></div>
                            </div>
                        </div>
                        <div class="icard-footer"><button class="btn-view-profile"><i class="bi bi-person-circle"></i> Xem hồ sơ</button></div>
                    </div>
                </div>

                <!-- Card 2 -->
                <div class="instructor-card" data-field="web" data-name="Trần Lê Phương Uyên"
                     data-img="img/instructors/gv2.jpg" data-init="T" data-c1="#3A1A7A" data-c2="#9B72E8"
                     data-bio="Chuyên gia React và Node.js với 9 năm kinh nghiệm. Lead developer tại Shopee Việt Nam."
                     data-role="Full-Stack Lead · Shopee" data-courses="12" data-students="323" data-rating="4.8"
                     data-tags="React,Node.js,TypeScript,MongoDB"
                     onclick="openModal(this)">
                    <div class="icard-inner">
                        <div class="icard-header">
                            <svg class="icard-bg" viewBox="0 0 300 100" preserveAspectRatio="xMidYMid slice"><defs><linearGradient id="g2" x1="0" y1="0" x2="1" y2="1"><stop offset="0%" stop-color="#3A1A7A"/><stop offset="100%" stop-color="#9B72E8"/></linearGradient></defs><rect width="300" height="100" fill="url(#g2)"/></svg>
                            <div class="icard-avatar" style="background:linear-gradient(135deg,#9B72E8,#3A1A7A)">
                                <span>T</span>
                                <img src="img/instructors/gv2.jpg" alt="Trần Lê Phương Uyên"
                                     onload="this.style.zIndex = '2';this.previousElementSibling.style.display = 'none';"
                                     onerror="this.classList.add('err')" style="z-index:1;">
                            </div>
                        </div>
                        <div class="icard-body">
                            <div class="icard-name">Trần Lê Phương Uyên</div>
                            <div class="icard-role">Full-Stack Lead · Shopee</div>
                            <div class="icard-tags"><span class="icard-tag">React</span><span class="icard-tag">Node.js</span><span class="icard-tag">TS</span></div>
                            <div class="icard-stars">★★★★★</div>
                            <div class="icard-divider"></div>
                            <div class="icard-stats">
                                <div><div class="icard-stat-num">12</div><div class="icard-stat-lbl">Khóa học</div></div>
                                <div><div class="icard-stat-num">323</div><div class="icard-stat-lbl">Học viên</div></div>
                            </div>
                        </div>
                        <div class="icard-footer"><button class="btn-view-profile"><i class="bi bi-person-circle"></i> Xem hồ sơ</button></div>
                    </div>
                </div>

                <!-- Card 3 -->
                <div class="instructor-card" data-field="data" data-name="Nguyễn Ngọc Huyền Diệu"
                     data-img="img/instructors/instructor3.jpg" data-init="Đ" data-c1="#4E2C96" data-c2="#D4A843"
                     data-bio="Tiến sĩ Toán học ứng dụng. 8 năm kinh nghiệm phân tích dữ liệu lớn và xây dựng mô hình dự đoán."
                     data-role="Data Scientist · VinAI" data-courses="10" data-students="158" data-rating="4.9"
                     data-tags="Python,SQL,Tableau,Power BI"
                     onclick="openModal(this)">
                    <div class="icard-inner">
                        <div class="icard-header">
                            <svg class="icard-bg" viewBox="0 0 300 100" preserveAspectRatio="xMidYMid slice"><defs><linearGradient id="g3" x1="0" y1="0" x2="1" y2="1"><stop offset="0%" stop-color="#4E2C96"/><stop offset="100%" stop-color="#D4A843"/></linearGradient></defs><rect width="300" height="100" fill="url(#g3)"/></svg>
                            <div class="icard-avatar" style="background:linear-gradient(135deg,#D4A843,#4E2C96)">
                                <span>Đ</span>
                                <img src="img/instructors/gv3.jpg" alt="Nguyễn Ngọc Huyền Diệu"
                                     onload="this.style.zIndex = '2';this.previousElementSibling.style.display = 'none';"
                                     onerror="this.classList.add('err')" style="z-index:1;">
                            </div>
                        </div>
                        <div class="icard-body">
                            <div class="icard-name">Nguyễn Ngọc Huyền Diệu</div>
                            <div class="icard-role">Data Scientist · VinAI</div>
                            <div class="icard-tags"><span class="icard-tag">Data</span><span class="icard-tag">SQL</span><span class="icard-tag">Python</span></div>
                            <div class="icard-stars">★★★★★</div>
                            <div class="icard-divider"></div>
                            <div class="icard-stats">
                                <div><div class="icard-stat-num">10</div><div class="icard-stat-lbl">Khóa học</div></div>
                                <div><div class="icard-stat-num">158</div><div class="icard-stat-lbl">Học viên</div></div>
                            </div>
                        </div>
                        <div class="icard-footer"><button class="btn-view-profile"><i class="bi bi-person-circle"></i> Xem hồ sơ</button></div>
                    </div>
                </div>

                <!-- Card 4 -->
                <div class="instructor-card" data-field="design" data-name="Nguyễn Ánh Hồng"
                     data-img="img/instructors/gv4.jpg" data-init="P" data-c1="#0D47A1" data-c2="#42A5F5"
                     data-bio="Hơn 10 năm thiết kế sản phẩm số. Từng hợp tác với các thương hiệu lớn tại Đông Nam Á."
                     data-role="UX Lead Designer · Tiki" data-courses="8" data-students="112" data-rating="4.8"
                     data-tags="Figma,UI/UX,Sketch,Prototyping"
                     onclick="openModal(this)">
                    <div class="icard-inner">
                        <div class="icard-header">
                            <svg class="icard-bg" viewBox="0 0 300 100" preserveAspectRatio="xMidYMid slice"><defs><linearGradient id="g4" x1="0" y1="0" x2="1" y2="1"><stop offset="0%" stop-color="#0D47A1"/><stop offset="100%" stop-color="#42A5F5"/></linearGradient></defs><rect width="300" height="100" fill="url(#g4)"/></svg>
                            <div class="icard-avatar" style="background:linear-gradient(135deg,#42A5F5,#0D47A1)">
                                <span>P</span>
                                <img src="img/instructors/gv4.jpg" alt="Nguyễn Ánh Hồng"
                                     onload="this.style.zIndex = '2';this.previousElementSibling.style.display = 'none';"
                                     onerror="this.classList.add('err')" style="z-index:1;">
                            </div>
                        </div>
                        <div class="icard-body">
                            <div class="icard-name">Nguyễn Ánh Hồng</div>
                            <div class="icard-role">UX Lead Designer · Tiki</div>
                            <div class="icard-tags"><span class="icard-tag">Figma</span><span class="icard-tag">UI/UX</span><span class="icard-tag">Design</span></div>
                            <div class="icard-stars">★★★★★</div>
                            <div class="icard-divider"></div>
                            <div class="icard-stats">
                                <div><div class="icard-stat-num">8</div><div class="icard-stat-lbl">Khóa học</div></div>
                                <div><div class="icard-stat-num">112</div><div class="icard-stat-lbl">Học viên</div></div>
                            </div>
                        </div>
                        <div class="icard-footer"><button class="btn-view-profile"><i class="bi bi-person-circle"></i> Xem hồ sơ</button></div>
                    </div>
                </div>

                <!-- Card 5 -->
                <div class="instructor-card" data-field="cloud" data-name="Phạm Nhật Vượng"
                     data-img="img/instructors/gv5.webp" data-init="H" data-c1="#1B5E20" data-c2="#388E3C"
                     data-bio="AWS Certified Solutions Architect với 11 năm kinh nghiệm triển khai hệ thống cloud quy mô lớn."
                     data-role="Cloud Architect · AWS Vietnam" data-courses="14" data-students="403" data-rating="4.9"
                     data-tags="AWS,Docker,Kubernetes,DevOps"
                     onclick="openModal(this)">
                    <div class="icard-inner">
                        <div class="icard-header">
                            <svg class="icard-bg" viewBox="0 0 300 100" preserveAspectRatio="xMidYMid slice"><defs><linearGradient id="g5" x1="0" y1="0" x2="1" y2="1"><stop offset="0%" stop-color="#1B5E20"/><stop offset="100%" stop-color="#388E3C"/></linearGradient></defs><rect width="300" height="100" fill="url(#g5)"/></svg>
                            <div class="icard-avatar" style="background:linear-gradient(135deg,#388E3C,#1B5E20)">
                                <span>H</span>
                                <img src="img/instructors/gv5.webp" alt="Phạm Nhật Vượng"
                                     onload="this.style.zIndex = '2';this.previousElementSibling.style.display = 'none';"
                                     onerror="this.classList.add('err')" style="z-index:1;">
                            </div>
                        </div>
                        <div class="icard-body">
                            <div class="icard-name">Phạm Nhật Vượng</div>
                            <div class="icard-role">Cloud Architect · AWS</div>
                            <div class="icard-tags"><span class="icard-tag">AWS</span><span class="icard-tag">DevOps</span><span class="icard-tag">K8s</span></div>
                            <div class="icard-stars">★★★★★</div>
                            <div class="icard-divider"></div>
                            <div class="icard-stats">
                                <div><div class="icard-stat-num">14</div><div class="icard-stat-lbl">Khóa học</div></div>
                                <div><div class="icard-stat-num">403</div><div class="icard-stat-lbl">Học viên</div></div>
                            </div>
                        </div>
                        <div class="icard-footer"><button class="btn-view-profile"><i class="bi bi-person-circle"></i> Xem hồ sơ</button></div>
                    </div>
                </div>

                <!-- Card 6 -->
                <div class="instructor-card" data-field="mobile" data-name="Vũ Thị Hoa"
                     data-img="img/instructors/instructor6.jpg" data-init="V" data-c1="#B71C1C" data-c2="#E53935"
                     data-bio="Chuyên gia Flutter và React Native. Lead developer tại ví điện tử MoMo với hơn 7 năm kinh nghiệm."
                     data-role="Mobile Lead · MoMo" data-courses="9" data-students="13500" data-rating="4.7"
                     data-tags="Flutter,React Native,Swift,Kotlin"
                     onclick="openModal(this)">
                    <div class="icard-inner">
                        <div class="icard-header">
                            <svg class="icard-bg" viewBox="0 0 300 100" preserveAspectRatio="xMidYMid slice"><defs><linearGradient id="g6" x1="0" y1="0" x2="1" y2="1"><stop offset="0%" stop-color="#B71C1C"/><stop offset="100%" stop-color="#E53935"/></linearGradient></defs><rect width="300" height="100" fill="url(#g6)"/></svg>
                            <div class="icard-avatar" style="background:linear-gradient(135deg,#E53935,#B71C1C)">
                                <span>V</span>
                                <img src="img/instructors/instructor6.jpg" alt="Vũ Thị Hoa"
                                     onload="this.style.zIndex = '2';
                                         this.previousElementSibling.style.display = 'none';"
                                     onerror="this.classList.add('err')" style="z-index:1;">
                            </div>
                        </div>
                        <div class="icard-body">
                            <div class="icard-name">Vũ Thị Hoa</div>
                            <div class="icard-role">Mobile Lead · MoMo</div>
                            <div class="icard-tags"><span class="icard-tag">Flutter</span><span class="icard-tag">Swift</span><span class="icard-tag">Mobile</span></div>
                            <div class="icard-stars">★★★★½</div>
                            <div class="icard-divider"></div>
                            <div class="icard-stats">
                                <div><div class="icard-stat-num">9</div><div class="icard-stat-lbl">Khóa học</div></div>
                                <div><div class="icard-stat-num">13.5K</div><div class="icard-stat-lbl">Học viên</div></div>
                            </div>
                        </div>
                        <div class="icard-footer"><button class="btn-view-profile"><i class="bi bi-person-circle"></i> Xem hồ sơ</button></div>
                    </div>
                </div>

                <!-- Card 7 -->
                <div class="instructor-card" data-field="web" data-name="Đỗ Thanh Tùng"
                     data-img="img/instructors/instructor7.jpg" data-init="Đ" data-c1="#4A148C" data-c2="#7B1FA2"
                     data-bio="Kiến trúc sư hệ thống backend với chuyên môn Java Spring Boot và microservices. 10 năm tại Zalo."
                     data-role="Backend Engineer · Zalo" data-courses="11" data-students="17300" data-rating="4.8"
                     data-tags="Java,Spring,Microservices,Redis"
                     onclick="openModal(this)">
                    <div class="icard-inner">
                        <div class="icard-header">
                            <svg class="icard-bg" viewBox="0 0 300 100" preserveAspectRatio="xMidYMid slice"><defs><linearGradient id="g7" x1="0" y1="0" x2="1" y2="1"><stop offset="0%" stop-color="#4A148C"/><stop offset="100%" stop-color="#7B1FA2"/></linearGradient></defs><rect width="300" height="100" fill="url(#g7)"/></svg>
                            <div class="icard-avatar" style="background:linear-gradient(135deg,#7B1FA2,#4A148C)">
                                <span>Đ</span>
                                <img src="img/instructors/instructor7.jpg" alt="Đỗ Thanh Tùng"
                                     onload="this.style.zIndex = '2';this.previousElementSibling.style.display = 'none';"
                                     onerror="this.classList.add('err')" style="z-index:1;">
                            </div>
                        </div>
                        <div class="icard-body">
                            <div class="icard-name">Đỗ Thanh Tùng</div>
                            <div class="icard-role">Backend Engineer · Zalo</div>
                            <div class="icard-tags"><span class="icard-tag">Java</span><span class="icard-tag">Spring</span><span class="icard-tag">Backend</span></div>
                            <div class="icard-stars">★★★★★</div>
                            <div class="icard-divider"></div>
                            <div class="icard-stats">
                                <div><div class="icard-stat-num">11</div><div class="icard-stat-lbl">Khóa học</div></div>
                                <div><div class="icard-stat-num">17.3K</div><div class="icard-stat-lbl">Học viên</div></div>
                            </div>
                        </div>
                        <div class="icard-footer"><button class="btn-view-profile"><i class="bi bi-person-circle"></i> Xem hồ sơ</button></div>
                    </div>
                </div>

                <!-- Card 8 -->
                <div class="instructor-card" data-field="data" data-name="Ngô Thị Mỹ Linh"
                     data-img="img/instructors/instructor8.jpg" data-init="M" data-c1="#004D40" data-c2="#00897B"
                     data-bio="Chuyên gia bảo mật thông tin với chứng chỉ CISSP và CEH. 13 năm kinh nghiệm tại các tập đoàn lớn."
                     data-role="Cybersecurity Expert · VNPT" data-courses="7" data-students="9800" data-rating="4.9"
                     data-tags="Security,Penetration Testing,Blockchain,Cryptography"
                     onclick="openModal(this)">
                    <div class="icard-inner">
                        <div class="icard-header">
                            <svg class="icard-bg" viewBox="0 0 300 100" preserveAspectRatio="xMidYMid slice"><defs><linearGradient id="g8" x1="0" y1="0" x2="1" y2="1"><stop offset="0%" stop-color="#004D40"/><stop offset="100%" stop-color="#00897B"/></linearGradient></defs><rect width="300" height="100" fill="url(#g8)"/></svg>
                            <div class="icard-avatar" style="background:linear-gradient(135deg,#00897B,#004D40)">
                                <span>M</span>
                                <img src="img/instructors/instructor8.jpg" alt="Ngô Thị Mỹ Linh"
                                     onload="this.style.zIndex = '2';this.previousElementSibling.style.display = 'none';"
                                     onerror="this.classList.add('err')" style="z-index:1;">
                            </div>
                        </div>
                        <div class="icard-body">
                            <div class="icard-name">Ngô Thị Mỹ Linh</div>
                            <div class="icard-role">Cybersecurity Expert · VNPT</div>
                            <div class="icard-tags"><span class="icard-tag">Security</span><span class="icard-tag">CISSP</span><span class="icard-tag">CEH</span></div>
                            <div class="icard-stars">★★★★★</div>
                            <div class="icard-divider"></div>
                            <div class="icard-stats">
                                <div><div class="icard-stat-num">7</div><div class="icard-stat-lbl">Khóa học</div></div>
                                <div><div class="icard-stat-num">9.8K</div><div class="icard-stat-lbl">Học viên</div></div>
                            </div>
                        </div>
                        <div class="icard-footer"><button class="btn-view-profile"><i class="bi bi-person-circle"></i> Xem hồ sơ</button></div>
                    </div>
                </div>

            </div><!-- /instructor-grid -->
        </div>

        <!-- JOIN CTA -->
        <div class="cta-section">
            <div class="cta-box">
                <div class="cta-inner">
                    <div class="cta-eyebrow">✦ Trở thành giảng viên</div>
                    <div class="cta-title">Chia sẻ kiến thức, truyền cảm hứng</div>
                    <p class="cta-sub">Bạn là chuyên gia trong lĩnh vực của mình? Hãy cùng DUK Academy xây dựng thế hệ nhân tài tương lai và tạo thu nhập từ đam mê giảng dạy.</p>
                    <div class="cta-actions">
                        <a href="#" class="btn-cta-primary"><i class="bi bi-mortarboard-fill"></i> Đăng ký giảng dạy</a>
                        <a href="#" class="btn-cta-secondary"><i class="bi bi-info-circle"></i> Tìm hiểu thêm</a>
                    </div>
                </div>
            </div>
        </div>

        <!-- FOOTER -->
        <footer>
            <div class="footer-inner">
                <span style="font-family:'Playfair Display',serif;font-size:1.2rem;font-weight:700;color:#fff;">DUK<span style="color:var(--gold);">Academy</span></span>
                <span style="font-size:0.78rem;color:rgba(255,255,255,0.35);">© 2026 DUK Academy. All rights reserved.</span>
            </div>
        </footer>

        <!-- INSTRUCTOR MODAL -->
        <div class="modal-overlay" id="instructorModal" onclick="closeModalOutside(event)">
            <div class="modal-box">
                <div class="modal-strip" id="modalStrip">
                    <button class="modal-close" onclick="closeModal()"><i class="bi bi-x-lg"></i></button>
                    <div class="modal-photo" id="modalPhoto">
                        <span class="modal-photo-initials" id="modalInitials"></span>
                        <img id="modalPhotoImg" src="" alt=""
                             onload="this.style.zIndex = '2'; document.getElementById('modalInitials').style.display = 'none';"
                             onerror="this.classList.add('err'); document.getElementById('modalInitials').style.display='flex';"
                             style="z-index:1;">
                    </div>
                </div>
                <div class="modal-body">
                    <div class="modal-name" id="modalName"></div>
                    <div class="modal-role" id="modalRole"></div>
                    <div class="modal-tags" id="modalTags"></div>
                    <p class="modal-bio"   id="modalBio"></p>
                    <div class="modal-stats-row">
                        <div class="modal-stat"><div class="modal-stat-num" id="mCourses"></div><div class="modal-stat-lbl">Khóa học</div></div>
                        <div class="modal-stat"><div class="modal-stat-num" id="mStudents"></div><div class="modal-stat-lbl">Học viên</div></div>
                        <div class="modal-stat"><div class="modal-stat-num" id="mRating"></div><div class="modal-stat-lbl">Đánh giá</div></div>
                    </div>
                    <a href="courseController?action=ExploreCourse" class="btn-modal-courses">
                        <i class="bi bi-collection-play-fill"></i> Xem khóa học của giảng viên
                    </a>
                </div>
            </div>
        </div>

        <script>
            /* ── FILTER ── */
            let currentField = '';
            function filterByField(el, field) {
                document.querySelectorAll('.chip').forEach(c => c.classList.remove('active'));
                el.classList.add('active');
                currentField = field;
                applyFilter();
            }
            function filterInstructors() {
                applyFilter();
            }
            function applyFilter() {
                const q = (document.getElementById('searchInput').value || '').toLowerCase();
                let count = 0;
                document.querySelectorAll('.instructor-card').forEach(card => {
                    const nm = (card.dataset.name || '').toLowerCase().includes(q);
                    const fm = !currentField || card.dataset.field === currentField;
                    const ok = (nm || !q) && fm;
                    card.style.display = ok ? '' : 'none';
                    if (ok)
                        count++;
                });
                document.getElementById('instructorCount').textContent = count + ' giảng viên';
            }

            /* ── MODAL: reads data-* from the clicked card ── */
            function fmt(n) {
                return Number(n) >= 1000 ? (Number(n) / 1000).toFixed(1) + 'K' : String(n);
            }

            function openModal(card) {
                const d = card.dataset;
                const c1 = d.c1 || '#1E0A4A', c2 = d.c2 || '#6C3FC5';

                // strip background
                document.getElementById('modalStrip').style.background =
                        'linear-gradient(135deg,' + c1 + ',' + c2 + ')';

                // photo
                const photoEl = document.getElementById('modalPhoto');
                const imgEl = document.getElementById('modalPhotoImg');
                const initEl = document.getElementById('modalInitials');
                photoEl.style.background = 'linear-gradient(135deg,' + c2 + ',' + c1 + ')';
                initEl.textContent = d.init || '?';
                initEl.style.display = 'flex';
                imgEl.classList.remove('err');
                imgEl.src = d.img || '';
                imgEl.alt = d.name || '';

                // text
                document.getElementById('modalName').textContent = d.name || '';
                document.getElementById('modalRole').textContent = d.role || '';
                document.getElementById('modalBio').textContent = d.bio || '';
                document.getElementById('mCourses').textContent = d.courses || '—';
                document.getElementById('mStudents').textContent = fmt(d.students || 0);
                document.getElementById('mRating').textContent = (d.rating || '—') + ' ★';

                document.getElementById('modalTags').innerHTML =
                        (d.tags || '').split(',').map(t =>
                    '<span class="modal-tag">' + t.trim() + '</span>'
                ).join('');

                document.getElementById('instructorModal').classList.add('show');
                document.body.style.overflow = 'hidden';
            }

            function closeModal() {
                document.getElementById('instructorModal').classList.remove('show');
                document.body.style.overflow = '';
            }
            function closeModalOutside(e) {
                if (e.target === document.getElementById('instructorModal'))
                    closeModal();
            }
            document.addEventListener('keydown', e => {
                if (e.key === 'Escape')
                    closeModal();
            });
        </script>
    </body>
</html>
