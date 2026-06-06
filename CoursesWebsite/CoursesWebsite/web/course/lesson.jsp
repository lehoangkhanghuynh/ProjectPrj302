<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>${course.courseName} - DUK Academy</title>
        <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&family=DM+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
        <link rel="icon" type="favicon" href="img/page/favicon.jpg">

        <style>
            :root {
                --purple:      #7C4DFF;
                --purple-dark: #5E35B1;
                --purple-deep: #1A0A3A;
                --purple-light:#EDE7FF;
                --purple-mid:  #B39DDB;
                --gold:        #FFB300;
                --gold-light:  #FFD54F;
                --text:        #1A1A2E;
                --muted:       #6B6B8A;
                --border:      #E2D9F3;
                --bg:          #F5F0FF;
                --sidebar-w:   340px;
                --surface-main:    #F7F4FF;
                --surface-card:    #FFFFFF;
                --surface-sidebar: #FDFBFF;
                --topbar-bg:       #2D1B6B;
                --lesson-info-bg:  #FFFFFF;
            }
            *, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
            body { font-family: 'DM Sans', sans-serif; color: var(--text); background: var(--surface-main); height: 100vh; display: flex; flex-direction: column; overflow: hidden; }

            /* TOPBAR */
            .topbar { background: var(--topbar-bg); height: 58px; display: flex; align-items: center; padding: 0 24px; gap: 16px; border-bottom: 1px solid rgba(255,255,255,0.08); flex-shrink: 0; z-index: 50; box-shadow: 0 2px 16px rgba(45,27,107,0.35); }
            .topbar-brand { font-family: 'Playfair Display', serif; font-size: 1.2rem; font-weight: 700; color: #fff; text-decoration: none; white-space: nowrap; }
            .topbar-brand span { color: var(--gold); }
            .topbar-divider { width: 1px; height: 24px; background: rgba(255,255,255,0.18); }
            .topbar-course { font-size: 0.85rem; font-weight: 600; color: rgba(255,255,255,0.85); white-space: nowrap; overflow: hidden; text-overflow: ellipsis; flex: 1; }
            .topbar-back { display: flex; align-items: center; gap: 6px; color: rgba(255,255,255,0.75); text-decoration: none; font-size: 0.82rem; font-weight: 600; padding: 6px 14px; border-radius: 8px; border: 1px solid rgba(255,255,255,0.2); transition: all 0.15s; white-space: nowrap; background: rgba(255,255,255,0.07); }
            .topbar-back:hover { background: rgba(255,255,255,0.15); color: #fff; }
            .topbar-progress { display: flex; align-items: center; gap: 10px; }
            .progress-text { font-size: 0.75rem; color: rgba(255,255,255,0.6); white-space: nowrap; font-weight: 600; }
            .progress-bar-wrap { width: 130px; height: 6px; background: rgba(255,255,255,0.12); border-radius: 3px; overflow: hidden; }
            .progress-bar-fill { height: 100%; background: linear-gradient(90deg, #B39DDB, var(--gold)); border-radius: 3px; transition: width 0.4s ease; }

            /* MAIN LAYOUT */
            .main-layout { display: flex; flex: 1; overflow: hidden; }

            /* VIDEO AREA */
            .video-area { flex: 1; display: flex; flex-direction: column; overflow-y: auto; background: var(--surface-main); }
            .video-area::-webkit-scrollbar { width: 5px; }
            .video-area::-webkit-scrollbar-thumb { background: #D1C4E9; border-radius: 3px; }
            .video-wrap { width: 100%; background: #000; position: relative; box-shadow: 0 4px 24px rgba(0,0,0,0.25); }
            .video-wrap iframe, .video-wrap video { width: 100%; aspect-ratio: 16/9; display: block; border: none; }
            .no-video { width: 100%; aspect-ratio: 16/9; background: linear-gradient(135deg, #1E0A4A, #3A1A7A); display: flex; flex-direction: column; align-items: center; justify-content: center; gap: 12px; }
            .no-video i { font-size: 3rem; color: rgba(255,255,255,0.2); }
            .no-video span { font-size: 0.9rem; color: rgba(255,255,255,0.3); }

            /* LESSON INFO */
            .lesson-info { padding: 28px 36px; background: var(--lesson-info-bg); border-bottom: 1px solid #EDE7FF; box-shadow: 0 2px 12px rgba(124,77,255,0.06); }
            .lesson-number { font-size: 0.7rem; font-weight: 700; text-transform: uppercase; letter-spacing: 2.5px; color: var(--purple); margin-bottom: 8px; display: flex; align-items: center; gap: 6px; }
            .lesson-number::before { content: ''; display: inline-block; width: 18px; height: 2px; background: var(--purple); border-radius: 1px; }
            .lesson-title { font-family: 'Playfair Display', serif; font-size: 1.65rem; font-weight: 700; color: #1A0A3A; margin-bottom: 14px; line-height: 1.3; }
            .lesson-meta { display: flex; align-items: center; gap: 18px; flex-wrap: wrap; }
            .lesson-meta-item { display: flex; align-items: center; gap: 6px; font-size: 0.8rem; color: var(--muted); font-weight: 500; }
            .lesson-meta-item i { color: var(--purple); }

            /* CONTENT AREA */
            .content-area { padding: 28px 36px 0; background: var(--surface-main); }
            .content-label { font-size: 0.7rem; font-weight: 700; text-transform: uppercase; letter-spacing: 2.5px; color: var(--purple-dark); margin-bottom: 14px; display: flex; align-items: center; gap: 8px; }
            .content-box { background: #fff; border: 1px solid #EDE7FF; border-radius: 14px; padding: 24px; font-size: 0.9rem; line-height: 1.85; color: #3D2B6B; box-shadow: 0 2px 12px rgba(124,77,255,0.05); }
            .content-empty { color: #B0A0D0; font-style: italic; font-size: 0.875rem; }

            /* UPLOAD PANEL */
            .upload-panel { margin: 24px 36px 0; background: #FFFBEF; border: 1px dashed #FFB300; border-radius: 14px; padding: 20px 24px; }
            .upload-label { font-size: 0.7rem; font-weight: 700; text-transform: uppercase; letter-spacing: 2.5px; color: #B8860B; margin-bottom: 14px; display: flex; align-items: center; gap: 8px; }
            .upload-form { display: flex; align-items: center; gap: 12px; flex-wrap: wrap; }
            .upload-file-wrap { position: relative; flex: 1; min-width: 200px; }
            .upload-file-wrap input[type="file"] { position: absolute; inset: 0; opacity: 0; cursor: pointer; width: 100%; }
            .upload-file-btn { display: flex; align-items: center; gap: 8px; background: rgba(255,179,0,0.08); border: 1px solid rgba(255,179,0,0.3); border-radius: 8px; padding: 9px 16px; font-size: 0.82rem; color: #7A6000; cursor: pointer; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; width: 100%; }
            .upload-submit { display: flex; align-items: center; gap: 6px; background: linear-gradient(135deg, var(--gold), #E6A200); color: #2D1B00; border: none; border-radius: 8px; padding: 9px 22px; font-size: 0.82rem; font-weight: 700; cursor: pointer; font-family: 'DM Sans', sans-serif; transition: all 0.15s; white-space: nowrap; box-shadow: 0 3px 10px rgba(255,179,0,0.3); }
            .upload-submit:hover { transform: translateY(-1px); box-shadow: 0 5px 16px rgba(255,179,0,0.45); }

            /* ALERT */
            .alert { margin: 16px 36px 0; padding: 12px 18px; border-radius: 10px; font-size: 0.83rem; font-weight: 600; display: flex; align-items: center; gap: 10px; }
            .alert-success { background: #F0FFF4; border: 1px solid #6EE7B7; color: #065F46; }
            .alert-error   { background: #FFF5F5; border: 1px solid #FCA5A5; color: #991B1B; }

            /* NAV BUTTONS */
            .lesson-nav { display: flex; gap: 14px; padding: 24px 36px 32px; background: var(--surface-main); align-items: center; flex-wrap: wrap; }
            .btn-nav { display: flex; align-items: center; gap: 8px; padding: 12px 24px; border-radius: 12px; font-size: 0.88rem; font-weight: 700; text-decoration: none; transition: all 0.18s; font-family: 'DM Sans', sans-serif; border: none; cursor: pointer; position: relative; overflow: hidden; }
            .btn-prev { background: #fff; color: var(--purple-dark); border: 2px solid #D1C4E9; box-shadow: 0 2px 8px rgba(124,77,255,0.08); }
            .btn-prev:hover { background: #EDE7FF; border-color: var(--purple); color: var(--purple); box-shadow: 0 4px 16px rgba(124,77,255,0.15); transform: translateY(-1px); }
            .btn-next { background: linear-gradient(135deg, var(--purple) 0%, var(--purple-dark) 100%); color: #fff; box-shadow: 0 4px 20px rgba(124,77,255,0.4); padding: 13px 28px; font-size: 0.92rem; }
            .btn-next:hover { transform: translateY(-2px); box-shadow: 0 8px 28px rgba(124,77,255,0.55); }
            .btn-complete { display: flex; align-items: center; gap: 10px; padding: 13px 28px; border-radius: 12px; font-size: 0.92rem; font-weight: 700; font-family: 'DM Sans', sans-serif; border: none; cursor: pointer; background: linear-gradient(135deg, #FFB300 0%, #FF6F00 100%); color: #fff; box-shadow: 0 5px 22px rgba(255,111,0,0.45); animation: pulseGlow 2.4s ease-in-out infinite; }
            @keyframes pulseGlow { 0%,100%{box-shadow:0 5px 22px rgba(255,111,0,0.45)} 50%{box-shadow:0 8px 32px rgba(255,111,0,0.7),0 0 0 4px rgba(255,179,0,0.18)} }
            .btn-complete:hover { transform: translateY(-3px); color: #fff; }
            .btn-complete .complete-star { font-size: 1.1rem; animation: spin 3s linear infinite; }
            @keyframes spin { 0%{transform:rotate(0deg) scale(1)} 50%{transform:rotate(180deg) scale(1.2)} 100%{transform:rotate(360deg) scale(1)} }
            .btn-cert-nav { display: flex; align-items: center; gap: 10px; padding: 13px 28px; border-radius: 12px; font-size: 0.92rem; font-weight: 700; text-decoration: none; transition: all 0.2s; background: linear-gradient(135deg, #F59E0B, #D97706); color: #fff; box-shadow: 0 5px 22px rgba(245,158,11,0.45); }
            .btn-cert-nav:hover { transform: translateY(-2px); box-shadow: 0 8px 30px rgba(245,158,11,0.6); color: #fff; }
            .btn-nav.disabled { opacity: 0.35; pointer-events: none; }
            .nav-spacer { flex: 1; }

            /* Certificate banner */
            .certificate-banner { display: flex; align-items: center; gap: 20px; background: linear-gradient(135deg, #FFFDE7, #FFF9C4); border: 2px solid #FFD54F; border-radius: 16px; padding: 20px 24px; margin: 0 36px 28px; box-shadow: 0 4px 20px rgba(255,179,0,0.2); }
            .cert-icon { font-size: 2.5rem; color: #F59E0B; flex-shrink: 0; }
            .cert-text { flex: 1; display: flex; flex-direction: column; gap: 4px; }
            .cert-text strong { font-size: 1rem; color: #78350F; }
            .cert-text span { font-size: 0.82rem; color: #92400E; }
            .btn-cert { display: flex; align-items: center; gap: 8px; background: linear-gradient(135deg, #F59E0B, #D97706); color: #fff; padding: 11px 22px; border-radius: 10px; font-size: 0.88rem; font-weight: 700; text-decoration: none; white-space: nowrap; box-shadow: 0 4px 14px rgba(245,158,11,0.45); transition: all 0.18s; }
            .btn-cert:hover { transform: translateY(-2px); box-shadow: 0 8px 22px rgba(245,158,11,0.6); color: #fff; }

            /* ===== REVIEW SECTION ===== */
            .review-section { padding: 0 36px 32px; }
            .review-section-title { font-size: 0.7rem; font-weight: 700; text-transform: uppercase; letter-spacing: 2.5px; color: var(--purple-dark); margin-bottom: 18px; display: flex; align-items: center; gap: 8px; }
            .review-summary { display: flex; gap: 28px; background: #fff; border: 1px solid #EDE7FF; border-radius: 14px; padding: 20px 24px; margin-bottom: 20px; align-items: center; flex-wrap: wrap; box-shadow: 0 2px 10px rgba(124,77,255,0.05); }
            .review-avg-block { text-align: center; min-width: 80px; }
            .review-avg-num { font-size: 2.8rem; font-weight: 700; color: var(--purple); line-height: 1; }
            .review-avg-stars { color: var(--gold); font-size: 1rem; margin: 4px 0; }
            .review-avg-count { font-size: 0.72rem; color: var(--muted); }
            .review-dist { flex: 1; min-width: 160px; }
            .dist-row { display: flex; align-items: center; gap: 8px; margin-bottom: 5px; }
            .dist-label { font-size: 0.72rem; color: var(--muted); width: 28px; text-align: right; flex-shrink: 0; }
            .dist-bar-wrap { flex: 1; background: #EDE7FF; border-radius: 4px; height: 7px; overflow: hidden; }
            .dist-bar-fill { height: 100%; background: linear-gradient(90deg, var(--purple), var(--purple-mid)); border-radius: 4px; }
            .dist-cnt { font-size: 0.68rem; color: var(--muted); width: 20px; flex-shrink: 0; }
            .rv-alert { padding: 11px 16px; border-radius: 10px; font-size: 0.83rem; font-weight: 600; margin-bottom: 16px; display: flex; align-items: center; gap: 8px; }
            .rv-alert-success { background: #F0FFF4; border: 1px solid #6EE7B7; color: #065F46; }
            .rv-alert-error   { background: #FFF5F5; border: 1px solid #FCA5A5; color: #991B1B; }
            .review-form-box { background: #fff; border: 1px solid #EDE7FF; border-radius: 14px; padding: 20px 24px; margin-bottom: 20px; box-shadow: 0 2px 10px rgba(124,77,255,0.05); }
            .review-form-heading { font-size: 0.88rem; font-weight: 700; color: #1A0A3A; margin-bottom: 14px; display: flex; align-items: center; gap: 8px; }
            .star-picker { display: flex; flex-direction: row-reverse; gap: 4px; margin-bottom: 12px; width: fit-content; }
            .star-picker input[type="radio"] { display: none; }
            .star-picker label { font-size: 1.8rem; color: #D1C4E9; cursor: pointer; transition: color 0.12s; line-height: 1; }
            .star-picker input[type="radio"]:checked ~ label,
            .star-picker label:hover,
            .star-picker label:hover ~ label { color: var(--gold); }
            .review-textarea { width: 100%; border: 1.5px solid #D1C4E9; border-radius: 10px; padding: 11px 14px; font-size: 0.88rem; font-family: 'DM Sans', sans-serif; color: #1A0A3A; resize: vertical; min-height: 90px; outline: none; transition: border-color 0.15s; background: #F7F4FF; }
            .review-textarea:focus { border-color: var(--purple); background: #fff; }
            .review-form-actions { display: flex; gap: 10px; margin-top: 12px; }
            .btn-rv-submit { background: linear-gradient(135deg, var(--purple), var(--purple-dark)); color: #fff; border: none; padding: 9px 20px; border-radius: 9px; font-size: 0.82rem; font-weight: 700; font-family: 'DM Sans', sans-serif; cursor: pointer; transition: all 0.15s; box-shadow: 0 3px 10px rgba(124,77,255,0.3); }
            .btn-rv-submit:hover { transform: translateY(-1px); box-shadow: 0 5px 16px rgba(124,77,255,0.45); }
            .btn-rv-cancel { background: #fff; color: var(--muted); border: 1.5px solid #D1C4E9; padding: 9px 16px; border-radius: 9px; font-size: 0.82rem; font-weight: 600; font-family: 'DM Sans', sans-serif; cursor: pointer; transition: all 0.15s; }
            .btn-rv-cancel:hover { border-color: var(--purple); color: var(--purple); }
            .my-review-card { background: #F3F0FF; border: 1.5px solid #B39DDB; border-radius: 12px; padding: 16px 20px; margin-bottom: 20px; }
            .my-review-label { font-size: 0.68rem; font-weight: 700; text-transform: uppercase; letter-spacing: 1.5px; color: var(--purple); margin-bottom: 8px; }
            .my-review-stars { color: var(--gold); font-size: 1rem; margin-bottom: 6px; }
            .my-review-comment { font-size: 0.875rem; color: #3D2B6B; line-height: 1.6; }
            .my-review-actions { display: flex; gap: 8px; margin-top: 12px; }
            .btn-rv-edit { background: var(--purple-light); color: var(--purple-dark); border: none; padding: 6px 14px; border-radius: 7px; font-size: 0.78rem; font-weight: 700; cursor: pointer; font-family: 'DM Sans', sans-serif; transition: all 0.15s; }
            .btn-rv-edit:hover { background: var(--purple); color: #fff; }
            .btn-rv-delete { background: #FFF5F5; color: #991B1B; border: 1px solid #FCA5A5; padding: 6px 14px; border-radius: 7px; font-size: 0.78rem; font-weight: 700; cursor: pointer; font-family: 'DM Sans', sans-serif; transition: all 0.15s; }
            .btn-rv-delete:hover { background: #991B1B; color: #fff; }
            .review-list { display: flex; flex-direction: column; gap: 12px; }
            .review-card { background: #fff; border: 1px solid #EDE7FF; border-radius: 12px; padding: 16px 20px; transition: box-shadow 0.15s; box-shadow: 0 1px 6px rgba(124,77,255,0.04); }
            .review-card:hover { box-shadow: 0 4px 16px rgba(124,77,255,0.1); }
            .rv-card-top { display: flex; align-items: center; gap: 10px; margin-bottom: 8px; }
            .rv-avatar { width: 36px; height: 36px; border-radius: 50%; background: linear-gradient(135deg, var(--purple), var(--purple-mid)); display: flex; align-items: center; justify-content: center; font-size: 0.82rem; font-weight: 700; color: #fff; flex-shrink: 0; }
            .rv-name { font-size: 0.82rem; font-weight: 700; color: #2D1B6B; }
            .rv-time { font-size: 0.7rem; color: #B0A0D0; margin-left: auto; }
            .rv-stars { color: var(--gold); font-size: 0.88rem; margin-bottom: 6px; }
            .rv-comment { font-size: 0.875rem; color: #3D2B6B; line-height: 1.65; }
            .btn-rv-admin-delete { background: none; border: none; cursor: pointer; color: #C5B8F0; font-size: 0.75rem; padding: 3px 8px; border-radius: 6px; transition: all 0.15s; font-family: 'DM Sans', sans-serif; float: right; }
            .btn-rv-admin-delete:hover { color: #E53935; background: #FFF5F5; }
            .no-reviews { text-align: center; padding: 32px 20px; }
            .no-reviews i { font-size: 2rem; color: #D1C4E9; display: block; margin-bottom: 8px; }
            .no-reviews p { font-size: 0.83rem; color: #B0A0D0; }

            /* COMMENTS */
            .comments-section { padding: 0 36px 48px; background: var(--surface-main); }
            .comments-header { display: flex; align-items: center; justify-content: space-between; margin-bottom: 20px; padding-top: 8px; }
            .comments-title { font-size: 0.7rem; font-weight: 700; text-transform: uppercase; letter-spacing: 2.5px; color: var(--purple-dark); display: flex; align-items: center; gap: 8px; }
            .comments-count { font-size: 0.78rem; color: var(--muted); background: #EDE7FF; padding: 3px 12px; border-radius: 20px; font-weight: 600; }
            .comment-form-wrap { background: #fff; border: 1px solid #EDE7FF; border-radius: 14px; padding: 20px; margin-bottom: 20px; box-shadow: 0 2px 10px rgba(124,77,255,0.05); }
            .comment-form-row { display: flex; gap: 12px; align-items: flex-start; }
            .comment-avatar { width: 38px; height: 38px; border-radius: 50%; background: linear-gradient(135deg, var(--purple), var(--purple-mid)); display: flex; align-items: center; justify-content: center; font-size: 0.85rem; font-weight: 700; color: #fff; flex-shrink: 0; box-shadow: 0 2px 8px rgba(124,77,255,0.3); }
            .comment-input-wrap { flex: 1; }
            .comment-textarea { width: 100%; background: #F7F4FF; border: 1.5px solid #D1C4E9; border-radius: 10px; padding: 12px 16px; font-size: 0.88rem; color: #1A0A3A; font-family: 'DM Sans', sans-serif; resize: vertical; min-height: 80px; outline: none; transition: border-color 0.15s; }
            .comment-textarea:focus { border-color: var(--purple); background: #fff; }
            .comment-textarea::placeholder { color: #B0A0D0; }
            .comment-form-actions { display: flex; justify-content: flex-end; margin-top: 10px; }
            .btn-comment-submit { display: flex; align-items: center; gap: 6px; background: linear-gradient(135deg, var(--purple), var(--purple-dark)); color: #fff; border: none; border-radius: 8px; padding: 9px 20px; font-size: 0.82rem; font-weight: 700; cursor: pointer; font-family: 'DM Sans', sans-serif; transition: all 0.15s; box-shadow: 0 3px 10px rgba(124,77,255,0.3); }
            .btn-comment-submit:hover { transform: translateY(-1px); box-shadow: 0 5px 16px rgba(124,77,255,0.45); }

            /* COMMENT LIST */
            .comment-list { display: flex; flex-direction: column; gap: 10px; }
            .comment-card { display: flex; gap: 12px; background: #fff; border: 1px solid #EDE7FF; border-radius: 12px; padding: 16px; transition: all 0.15s; box-shadow: 0 1px 6px rgba(124,77,255,0.04); }
            .comment-card:hover { border-color: #C5B8F0; box-shadow: 0 3px 14px rgba(124,77,255,0.08); }
            .comment-body { flex: 1; min-width: 0; }
            .comment-meta { display: flex; align-items: center; gap: 10px; margin-bottom: 8px; flex-wrap: wrap; }
            .comment-name { font-size: 0.82rem; font-weight: 700; color: #2D1B6B; }
            .comment-time { font-size: 0.72rem; color: #B0A0D0; }

            /* COMMENT ACTIONS — nút edit + delete gom vào đây */
            .comment-actions { display: flex; align-items: center; gap: 6px; margin-left: auto; flex-shrink: 0; }
            .btn-cm-edit {
                display: flex; align-items: center; gap: 4px;
                background: #EDE7FF; color: var(--purple-dark);
                border: none; border-radius: 7px;
                padding: 5px 12px; font-size: 0.76rem; font-weight: 700;
                cursor: pointer; font-family: 'DM Sans', sans-serif;
                transition: all 0.15s;
            }
            .btn-cm-edit:hover { background: var(--purple); color: #fff; }
            .btn-cm-delete {
                display: flex; align-items: center; gap: 4px;
                background: none; border: none; cursor: pointer;
                color: #C5B8F0; font-size: 0.76rem; font-weight: 600;
                padding: 5px 10px; border-radius: 7px;
                transition: all 0.15s; font-family: 'DM Sans', sans-serif;
            }
            .btn-cm-delete:hover { color: #E53935; background: #FFF5F5; }

            /* INLINE EDIT FORM */
            .comment-edit-form { display: none; margin-top: 10px; }
            .comment-edit-textarea {
                width: 100%; background: #F7F4FF; border: 1.5px solid #B39DDB;
                border-radius: 9px; padding: 10px 14px;
                font-size: 0.88rem; color: #1A0A3A;
                font-family: 'DM Sans', sans-serif;
                resize: vertical; min-height: 64px; outline: none;
                transition: border-color 0.15s;
            }
            .comment-edit-textarea:focus { border-color: var(--purple); background: #fff; }
            .comment-edit-actions { display: flex; gap: 8px; justify-content: flex-end; margin-top: 8px; }
            .btn-cm-save {
                display: flex; align-items: center; gap: 5px;
                background: linear-gradient(135deg, var(--purple), var(--purple-dark));
                color: #fff; border: none; border-radius: 8px;
                padding: 7px 16px; font-size: 0.8rem; font-weight: 700;
                cursor: pointer; font-family: 'DM Sans', sans-serif;
                transition: all 0.15s; box-shadow: 0 3px 10px rgba(124,77,255,0.3);
            }
            .btn-cm-save:hover { transform: translateY(-1px); box-shadow: 0 5px 14px rgba(124,77,255,0.45); }
            .btn-cm-cancel-edit {
                background: #fff; color: var(--muted);
                border: 1.5px solid #D1C4E9; border-radius: 8px;
                padding: 7px 14px; font-size: 0.8rem; font-weight: 600;
                cursor: pointer; font-family: 'DM Sans', sans-serif;
                transition: all 0.15s;
            }
            .btn-cm-cancel-edit:hover { border-color: var(--purple); color: var(--purple); }

            .comment-text { font-size: 0.875rem; line-height: 1.7; color: #3D2B6B; word-break: break-word; }
            .no-comments { text-align: center; padding: 40px 20px; }
            .no-comments i { font-size: 2.2rem; color: #D1C4E9; display: block; margin-bottom: 10px; }
            .no-comments p { font-size: 0.83rem; color: #B0A0D0; }

            /* SIDEBAR */
            .sidebar { width: var(--sidebar-w); flex-shrink: 0; background: var(--surface-sidebar); border-left: 1px solid #EDE7FF; display: flex; flex-direction: column; overflow: hidden; box-shadow: -4px 0 20px rgba(124,77,255,0.06); }
            .sidebar-header { padding: 18px 20px; border-bottom: 1px solid #EDE7FF; flex-shrink: 0; background: #fff; }
            .sidebar-title { font-size: 0.7rem; font-weight: 700; text-transform: uppercase; letter-spacing: 2.5px; color: var(--purple); margin-bottom: 4px; }
            .sidebar-count { font-size: 0.88rem; font-weight: 600; color: #2D1B6B; }
            .lesson-list { overflow-y: auto; flex: 1; padding: 10px; }
            .lesson-list::-webkit-scrollbar { width: 4px; }
            .lesson-list::-webkit-scrollbar-thumb { background: #D1C4E9; border-radius: 2px; }
            .lesson-item { display: flex; align-items: flex-start; gap: 12px; padding: 12px 14px; border-radius: 10px; text-decoration: none; color: #5E4B8B; transition: all 0.15s; margin-bottom: 4px; border: 1px solid transparent; }
            .lesson-item:hover { background: #EDE7FF; color: #2D1B6B; }
            .lesson-item.active { background: linear-gradient(135deg, #EDE7FF, #E8E0FF); border-color: #B39DDB; color: #2D1B6B; box-shadow: 0 2px 10px rgba(124,77,255,0.1); }
            .lesson-num { width: 28px; height: 28px; border-radius: 50%; background: #EDE7FF; display: flex; align-items: center; justify-content: center; font-size: 0.72rem; font-weight: 700; flex-shrink: 0; color: var(--purple); }
            .lesson-item.active .lesson-num { background: var(--purple); color: #fff; }
            .lesson-item-info { flex: 1; min-width: 0; }
            .lesson-item-title { font-size: 0.82rem; font-weight: 600; line-height: 1.4; margin-bottom: 4px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
            .lesson-item-dur { font-size: 0.7rem; color: #B0A0D0; display: flex; align-items: center; gap: 4px; }
            .lesson-item.active .lesson-item-dur { color: #7C4DFF; }
            .lesson-play-icon { color: var(--purple); font-size: 0.8rem; flex-shrink: 0; margin-top: 6px; opacity: 0; transition: opacity 0.15s; }
            .lesson-item:hover .lesson-play-icon, .lesson-item.active .lesson-play-icon { opacity: 1; }
            .no-lesson { text-align: center; padding: 48px 20px; }
            .no-lesson i { font-size: 2.5rem; color: #D1C4E9; margin-bottom: 12px; display: block; }
            .no-lesson p { font-size: 0.85rem; color: #B0A0D0; }

            @media (max-width: 768px) {
                .main-layout { flex-direction: column; }
                .sidebar { width: 100%; height: 280px; border-left: none; border-top: 1px solid #EDE7FF; }
                .lesson-info, .content-area, .lesson-nav, .comments-section, .review-section, .upload-panel, .alert, .certificate-banner { padding-left: 20px; padding-right: 20px; }
                .topbar-progress { display: none; }
                .upload-form { flex-direction: column; align-items: stretch; }
                .certificate-banner { flex-direction: column; text-align: center; }
            }
        </style>
    </head>
    <body>

        <!-- TOPBAR -->
        <div class="topbar">
            <a href="courseController?action=ExploreCourse" class="topbar-brand">DUK<span>Academy</span></a>
            <div class="topbar-divider"></div>
            <span class="topbar-course">${course.courseName}</span>
            <c:if test="${not empty lessons}">
                <div class="topbar-progress">
                    <span class="progress-text">Bài ${currentIndex} / ${fn:length(lessons)}</span>
                    <div class="progress-bar-wrap">
                        <div class="progress-bar-fill"
                             style="width: ${currentIndex * 100 / fn:length(lessons)}%"></div>
                    </div>
                </div>
            </c:if>
            <a href="courseController?action=ExploreCourse" class="topbar-back">
                <i class="bi bi-arrow-left"></i> Thoát
            </a>
        </div>

        <!-- MAIN -->
        <div class="main-layout">
            <div class="video-area">

                <!-- VIDEO -->
                <div class="video-wrap">
                    <c:choose>
                        <c:when test="${not empty currentLesson and not empty currentLesson.video}">
                            <c:choose>
                                <c:when test="${not empty ytVideoId}">
                                    <iframe
                                        src="https://www.youtube.com/embed/${ytVideoId}?rel=0&modestbranding=1&autoplay=1"
                                        style="width:100%;aspect-ratio:16/9;border:none;display:block;"
                                        allowfullscreen
                                        allow="autoplay; encrypted-media">
                                    </iframe>
                                </c:when>
                                <c:otherwise>
                                    <video id="lessonVideo" controls
                                           style="width:100%;aspect-ratio:16/9;background:#000;display:block;">
                                        <source src="${pageContext.request.contextPath}/${currentLesson.video}">
                                        Trình duyệt không hỗ trợ video.
                                    </video>
                                </c:otherwise>
                            </c:choose>
                        </c:when>
                        <c:otherwise>
                            <div class="no-video">
                                <i class="bi bi-camera-video-off"></i>
                                <span>Bài học này chưa có video</span>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <c:if test="${not empty currentLesson}">

                    <!-- LESSON INFO -->
                    <div class="lesson-info">
                        <div class="lesson-number">Bài ${currentIndex} / ${fn:length(lessons)}</div>
                        <div class="lesson-title">${currentLesson.title}</div>
                        <div class="lesson-meta">
                            <c:if test="${currentLesson.duration > 0}">
                                <span class="lesson-meta-item"><i class="bi bi-clock"></i>${currentLesson.duration} phút</span>
                            </c:if>
                            <span class="lesson-meta-item"><i class="bi bi-play-circle"></i> Video bài giảng</span>
                            <span class="lesson-meta-item"><i class="bi bi-book"></i>${course.topic}</span>
                            <c:choose>
                                <c:when test="${status == 2}">
                                    <span class="lesson-meta-item" style="color:#B8860B; background:#FFF9C4; padding:3px 10px; border-radius:20px; border:1px solid #FFD54F;">
                                        <i class="bi bi-trophy-fill" style="color:#F59E0B;"></i> Đã hoàn thành
                                    </span>
                                </c:when>
                                <c:when test="${status == 1}">
                                    <span class="lesson-meta-item" style="color:#2E7D32; background:#E8F5E9; padding:3px 10px; border-radius:20px; border:1px solid #C8E6C9;">
                                        <i class="bi bi-check-circle-fill" style="color:#2E7D32;"></i> Đang học
                                    </span>
                                </c:when>
                            </c:choose>
                        </div>
                    </div>

                    <!-- ALERTS upload -->
                    <c:if test="${not empty sessionScope.uploadSuccess}">
                        <div class="alert alert-success"><i class="bi bi-check-circle-fill"></i>${sessionScope.uploadSuccess}</div>
                        <c:remove var="uploadSuccess" scope="session"/>
                    </c:if>
                    <c:if test="${not empty sessionScope.uploadError}">
                        <div class="alert alert-error"><i class="bi bi-exclamation-circle-fill"></i>${sessionScope.uploadError}</div>
                        <c:remove var="uploadError" scope="session"/>
                    </c:if>

                    <!-- UPLOAD (admin/instructor) -->
                    <c:if test="${sessionScope.user.role == 1 || sessionScope.user.role == 2}">
                        <div class="upload-panel">
                            <div class="upload-label"><i class="bi bi-cloud-upload-fill"></i> Upload Video cho bài này</div>
                            <form method="POST" action="courseController" enctype="multipart/form-data">
                                <input type="hidden" name="action" value="uploadVideo">
                                <input type="hidden" name="courseId" value="${courseId}">
                                <input type="hidden" name="lessonId" value="${currentLesson.lessonId}">
                                <div class="upload-form">
                                    <div class="upload-file-wrap">
                                        <input type="file" name="videoFile" id="videoFile"
                                               accept="video/*,.mp4,.webm,.ogg,.mov,.mkv"
                                               onchange="onFileChange(this)">
                                        <div class="upload-file-btn">
                                            <i class="bi bi-file-earmark-play"></i>
                                            <span id="fileLabelText">Chọn file video (mp4, webm, mkv...)</span>
                                        </div>
                                    </div>
                                    <button type="submit" class="upload-submit">
                                        <i class="bi bi-upload"></i> Upload
                                    </button>
                                </div>
                            </form>
                        </div>
                    </c:if>

                    <!-- NỘI DUNG -->
                    <div class="content-area">
                        <div class="content-label"><i class="bi bi-file-text-fill"></i> Nội dung bài học</div>
                        <div class="content-box">
                            <c:choose>
                                <c:when test="${not empty currentLesson.content}">${currentLesson.content}</c:when>
                                <c:otherwise><span class="content-empty">Bài học này chưa có nội dung mô tả.</span></c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <!-- NAV -->
                    <div class="lesson-nav">
                        <c:set var="prevLesson" value="${null}"/>
                        <c:set var="nextLesson" value="${null}"/>
                        <c:set var="found"      value="false"/>
                        <c:forEach var="l" items="${lessons}">
                            <c:choose>
                                <c:when test="${found == 'true' and empty nextLesson}"><c:set var="nextLesson" value="${l}"/></c:when>
                                <c:when test="${l.lessonId == currentLesson.lessonId}"><c:set var="found" value="true"/></c:when>
                                <c:otherwise><c:if test="${found == 'false'}"><c:set var="prevLesson" value="${l}"/></c:if></c:otherwise>
                            </c:choose>
                        </c:forEach>

                        <c:choose>
                            <c:when test="${not empty prevLesson}">
                                <a href="courseController?action=lesson&courseId=${courseId}&lessonId=${prevLesson.lessonId}" class="btn-nav btn-prev">
                                    <i class="bi bi-arrow-left"></i> Bài trước
                                </a>
                            </c:when>
                            <c:otherwise>
                                <span class="btn-nav btn-prev disabled"><i class="bi bi-arrow-left"></i> Bài trước</span>
                            </c:otherwise>
                        </c:choose>

                        <div class="nav-spacer"></div>

                        <c:choose>
                            <c:when test="${not empty nextLesson}">
                                <a href="courseController?action=lesson&courseId=${courseId}&lessonId=${nextLesson.lessonId}" class="btn-nav btn-next">
                                    Bài tiếp theo <i class="bi bi-arrow-right"></i>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <c:choose>
                                    <c:when test="${status == 2}">
                                        <a href="certificate?courseId=${courseId}" class="btn-cert-nav">
                                            <i class="bi bi-award-fill"></i> Xem chứng chỉ
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <form method="POST" action="courseController" style="margin:0;">
                                            <input type="hidden" name="action" value="finishCourse">
                                            <input type="hidden" name="courseId" value="${courseId}">
                                            <button type="submit" class="btn-complete">
                                                <span class="complete-star"><i class="bi bi-star-fill"></i></span>
                                                Hoàn thành khóa học! <i class="bi bi-trophy-fill"></i>
                                            </button>
                                        </form>
                                    </c:otherwise>
                                </c:choose>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <%-- Banner chứng chỉ --%>
                    <c:if test="${status == 2}">
                        <div class="certificate-banner">
                            <div class="cert-icon"><i class="bi bi-trophy-fill"></i></div>
                            <div class="cert-text">
                                <strong>Chúc mừng! Bạn đã hoàn thành toàn bộ khóa học.</strong>
                                <span>Nhận chứng chỉ hoàn thành của bạn ngay bây giờ</span>
                            </div>
                            <a href="certificate?courseId=${courseId}" class="btn-cert">
                                <i class="bi bi-award-fill"></i> Nhận chứng chỉ
                            </a>
                        </div>
                    </c:if>

                    <%-- ===== REVIEW SECTION ===== --%>
                    <c:if test="${status == 2}">
                        <div class="review-section" id="reviews">
                            <div class="review-section-title">
                                <i class="bi bi-star-fill" style="color:var(--gold)"></i>
                                Đánh giá khóa học
                                <span style="background:#EDE7FF;color:var(--purple);padding:2px 10px;border-radius:20px;font-size:0.72rem;">${REVIEW_COUNT} đánh giá</span>
                            </div>

                            <c:if test="${not empty sessionScope.reviewSuccess}">
                                <div class="rv-alert rv-alert-success"><i class="bi bi-check-circle-fill"></i>${sessionScope.reviewSuccess}</div>
                                <c:remove var="reviewSuccess" scope="session"/>
                            </c:if>
                            <c:if test="${not empty sessionScope.reviewError}">
                                <div class="rv-alert rv-alert-error"><i class="bi bi-exclamation-circle-fill"></i>${sessionScope.reviewError}</div>
                                <c:remove var="reviewError" scope="session"/>
                            </c:if>

                            <div class="review-summary">
                                <div class="review-avg-block">
                                    <div class="review-avg-num"><fmt:formatNumber value="${AVG_RATING}" maxFractionDigits="1"/></div>
                                    <div class="review-avg-stars">
                                        <c:forEach begin="1" end="5" var="i">
                                            <c:choose>
                                                <c:when test="${AVG_RATING >= i}"><i class="bi bi-star-fill"></i></c:when>
                                                <c:when test="${AVG_RATING + 0.5 >= i}"><i class="bi bi-star-half"></i></c:when>
                                                <c:otherwise><i class="bi bi-star"></i></c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                    </div>
                                    <div class="review-avg-count">${REVIEW_COUNT} đánh giá</div>
                                </div>
                                <div class="review-dist">
                                    <c:forEach var="star" items="5,4,3,2,1">
                                        <c:set var="cnt" value="${DIST[star] != null ? DIST[star] : 0}"/>
                                        <c:set var="pct" value="${REVIEW_COUNT > 0 ? (cnt * 100 / REVIEW_COUNT) : 0}"/>
                                        <div class="dist-row">
                                            <span class="dist-label">${star}★</span>
                                            <div class="dist-bar-wrap">
                                                <div class="dist-bar-fill" style="width:${pct}%"></div>
                                            </div>
                                            <span class="dist-cnt">${cnt}</span>
                                        </div>
                                    </c:forEach>
                                </div>
                            </div>

                            <c:choose>
                                <c:when test="${not empty MY_REVIEW}">
                                    <div class="my-review-card" id="myReviewBlock">
                                        <div class="my-review-label"><i class="bi bi-person-check-fill"></i> Đánh giá của bạn</div>
                                        <div class="my-review-stars">${MY_REVIEW.starString}</div>
                                        <div class="my-review-comment">${MY_REVIEW.comment}</div>
                                        <div class="my-review-actions">
                                            <button class="btn-rv-edit" onclick="showEditForm()"><i class="bi bi-pencil-fill"></i> Sửa</button>
                                            <form method="POST" action="reviewController" style="margin:0;"
                                                  onsubmit="return confirm('Xóa đánh giá này?')">
                                                <input type="hidden" name="action"   value="delete">
                                                <input type="hidden" name="reviewId" value="${MY_REVIEW.reviewId}">
                                                <input type="hidden" name="courseId" value="${courseId}">
                                                <button type="submit" class="btn-rv-delete"><i class="bi bi-trash3-fill"></i> Xóa</button>
                                            </form>
                                        </div>
                                    </div>
                                    <div class="review-form-box" id="editReviewForm" style="display:none;">
                                        <div class="review-form-heading"><i class="bi bi-pencil-fill" style="color:var(--purple)"></i> Sửa đánh giá</div>
                                        <form method="POST" action="reviewController">
                                            <input type="hidden" name="action"   value="edit">
                                            <input type="hidden" name="reviewId" value="${MY_REVIEW.reviewId}">
                                            <input type="hidden" name="courseId" value="${courseId}">
                                            <div class="star-picker">
                                                <c:forEach begin="1" end="5" var="s">
                                                    <input type="radio" name="rating" id="edit_star${s}" value="${s}"
                                                           ${MY_REVIEW.rating == s ? 'checked' : ''}/>
                                                    <label for="edit_star${s}">★</label>
                                                </c:forEach>
                                            </div>
                                            <textarea name="comment" class="review-textarea"
                                                      placeholder="Chia sẻ cảm nhận của bạn..." maxlength="1000">${MY_REVIEW.comment}</textarea>
                                            <div class="review-form-actions">
                                                <button type="submit" class="btn-rv-submit"><i class="bi bi-check-lg"></i> Lưu</button>
                                                <button type="button" class="btn-rv-cancel" onclick="hideEditForm()">Hủy</button>
                                            </div>
                                        </form>
                                    </div>
                                </c:when>
                                <c:when test="${IS_COMPLETED}">
                                    <div class="review-form-box">
                                        <div class="review-form-heading"><i class="bi bi-star-fill" style="color:var(--gold)"></i> Viết đánh giá của bạn</div>
                                        <form method="POST" action="reviewController">
                                            <input type="hidden" name="action"   value="add">
                                            <input type="hidden" name="courseId" value="${courseId}">
                                            <div class="star-picker">
                                                <c:forEach begin="1" end="5" var="s">
                                                    <input type="radio" name="rating" id="star${s}" value="${s}" required/>
                                                    <label for="star${s}">★</label>
                                                </c:forEach>
                                            </div>
                                            <textarea name="comment" class="review-textarea"
                                                      placeholder="Chia sẻ cảm nhận của bạn về khóa học này..." maxlength="1000"></textarea>
                                            <div class="review-form-actions">
                                                <button type="submit" class="btn-rv-submit"><i class="bi bi-send-fill"></i> Gửi đánh giá</button>
                                            </div>
                                        </form>
                                    </div>
                                </c:when>
                            </c:choose>

                            <div class="review-list">
                                <c:choose>
                                    <c:when test="${not empty REVIEWS}">
                                        <c:forEach var="rv" items="${REVIEWS}">
                                            <c:if test="${rv.userId != sessionScope.user.userId}">
                                                <div class="review-card">
                                                    <c:if test="${sessionScope.user.role == 1}">
                                                        <form method="POST" action="reviewController" style="float:right;margin:0;"
                                                              onsubmit="return confirm('Xóa đánh giá này?')">
                                                            <input type="hidden" name="action"   value="delete">
                                                            <input type="hidden" name="reviewId" value="${rv.reviewId}">
                                                            <input type="hidden" name="courseId" value="${courseId}">
                                                            <button type="submit" class="btn-rv-admin-delete"><i class="bi bi-trash3"></i></button>
                                                        </form>
                                                    </c:if>
                                                    <div class="rv-card-top">
                                                        <div class="rv-avatar">${fn:substring(rv.fullname, 0, 1)}</div>
                                                        <span class="rv-name">${rv.fullname}</span>
                                                        <span class="rv-time"><fmt:formatDate value="${rv.createdAt}" pattern="dd/MM/yyyy"/></span>
                                                    </div>
                                                    <div class="rv-stars">${rv.starString}</div>
                                                    <c:if test="${not empty rv.comment}">
                                                        <div class="rv-comment">${rv.comment}</div>
                                                    </c:if>
                                                </div>
                                            </c:if>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="no-reviews">
                                            <i class="bi bi-star"></i>
                                            <p>Chưa có đánh giá nào. Hãy là người đầu tiên!</p>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </c:if>

                    <!-- ===== COMMENTS ===== -->
                    <div class="comments-section" id="comments">
                        <div class="comments-header">
                            <div class="comments-title"><i class="bi bi-chat-dots-fill"></i> Bình luận</div>
                            <span class="comments-count">${fn:length(comments)} bình luận</span>
                        </div>

                        <%-- Form gửi comment mới --%>
                        <div class="comment-form-wrap">
                            <div class="comment-form-row">
                                <div class="comment-avatar">${fn:substring(sessionScope.user.fullname, 0, 1)}</div>
                                <div class="comment-input-wrap">
                                    <form method="POST" action="courseController">
                                        <input type="hidden" name="action"   value="addComment">
                                        <input type="hidden" name="courseId" value="${courseId}">
                                        <input type="hidden" name="lessonId" value="${currentLesson.lessonId}">
                                        <textarea name="commentContent" class="comment-textarea"
                                                  placeholder="Chia sẻ câu hỏi hoặc nhận xét của bạn về bài học này..."
                                                  maxlength="1000" rows="3"></textarea>
                                        <div class="comment-form-actions">
                                            <button type="submit" class="btn-comment-submit">
                                                <i class="bi bi-send-fill"></i> Gửi bình luận
                                            </button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>

                        <%-- Danh sách comment --%>
                        <div class="comment-list">
                            <c:choose>
                                <c:when test="${not empty comments}">
                                    <c:forEach var="cm" items="${comments}">
                                        <div class="comment-card">
                                            <div class="comment-avatar">${fn:substring(cm.username, 0, 1)}</div>
                                            <div class="comment-body">

                                                <%-- Meta: tên + giờ + nút edit/delete (chỉ chủ comment) --%>
                                                <div class="comment-meta">
                                                    <span class="comment-name">${cm.username}</span>
                                                    <span class="comment-time">
                                                        <fmt:formatDate value="${cm.createdAt}" pattern="HH:mm dd/MM/yyyy"/>
                                                    </span>

                                                    <c:if test="${cm.userId == sessionScope.user.userId}">
                                                        <div class="comment-actions">
                                                            <%-- NÚT SỬA --%>
                                                            <button class="btn-cm-edit"
                                                                    onclick="showCmEdit(${cm.commentId})">
                                                                <i class="bi bi-pencil-fill"></i> Sửa
                                                            </button>

                                                            <%-- NÚT XÓA --%>
                                                            <form method="POST" action="courseController" style="margin:0;"
                                                                  onsubmit="return confirm('Xóa bình luận này?')">
                                                                <input type="hidden" name="action"    value="deleteComment">
                                                                <input type="hidden" name="commentId" value="${cm.commentId}">
                                                                <input type="hidden" name="lessonId"  value="${currentLesson.lessonId}">
                                                                <input type="hidden" name="courseId"  value="${courseId}">
                                                                <button type="submit" class="btn-cm-delete">
                                                                    <i class="bi bi-trash3"></i>
                                                                </button>
                                                            </form>
                                                        </div>
                                                    </c:if>
                                                </div>

                                                <%-- Nội dung bình luận --%>
                                                <div class="comment-text" id="cmText_${cm.commentId}">${cm.content}</div>

                                                <%-- Form sửa inline (ẩn mặc định) — chỉ render nếu là chủ comment --%>
                                                <c:if test="${cm.userId == sessionScope.user.userId}">
                                                    <div class="comment-edit-form" id="cmEditForm_${cm.commentId}">
                                                        <form method="POST" action="courseController">
                                                            <input type="hidden" name="action"    value="updateComment">
                                                            <input type="hidden" name="commentId" value="${cm.commentId}">
                                                            <input type="hidden" name="lessonId"  value="${currentLesson.lessonId}">
                                                            <input type="hidden" name="courseId"  value="${courseId}">
                                                            <textarea name="commentContent"
                                                                      class="comment-edit-textarea"
                                                                      maxlength="1000"
                                                                      id="cmEditTA_${cm.commentId}">${cm.content}</textarea>
                                                            <div class="comment-edit-actions">
                                                                <button type="submit" class="btn-cm-save">
                                                                    <i class="bi bi-check-lg"></i> Lưu
                                                                </button>
                                                                <button type="button" class="btn-cm-cancel-edit"
                                                                        onclick="hideCmEdit(${cm.commentId})">
                                                                    Hủy
                                                                </button>
                                                            </div>
                                                        </form>
                                                    </div>
                                                </c:if>

                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <div class="no-comments">
                                        <i class="bi bi-chat-square-dots"></i>
                                        <p>Chưa có bình luận nào. Hãy là người đầu tiên!</p>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                </c:if><%-- end currentLesson not empty --%>

                <c:if test="${empty currentLesson}">
                    <div class="no-lesson" style="padding:60px 36px;">
                        <i class="bi bi-collection-play" style="font-size:3rem; color:#D1C4E9; display:block; margin-bottom:16px;"></i>
                        <p style="color:#B0A0D0;">Khóa học này chưa có bài học nào.</p>
                    </div>
                </c:if>
            </div>

            <!-- SIDEBAR -->
            <div class="sidebar">
                <div class="sidebar-header">
                    <div class="sidebar-title">Nội dung khóa học</div>
                    <div class="sidebar-count">${fn:length(lessons)} bài học</div>
                </div>
                <div class="lesson-list">
                    <c:choose>
                        <c:when test="${not empty lessons}">
                            <c:forEach var="l" items="${lessons}" varStatus="st">
                                <a href="courseController?action=lesson&courseId=${courseId}&lessonId=${l.lessonId}"
                                   class="lesson-item ${currentLesson.lessonId == l.lessonId ? 'active' : ''}"
                                   data-lesson-id="${l.lessonId}">
                                    <div class="lesson-num">${st.index + 1}</div>
                                    <div class="lesson-item-info">
                                        <div class="lesson-item-title">${l.title}</div>
                                        <div class="lesson-item-dur">
                                            <i class="bi bi-clock"></i>
                                            <c:choose>
                                                <c:when test="${l.duration > 0}">${l.duration} phút</c:when>
                                                <c:otherwise>—</c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                    <i class="bi bi-play-circle-fill lesson-play-icon"></i>
                                </a>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="no-lesson"><i class="bi bi-collection-play"></i><p>Chưa có bài học nào</p></div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
        <script src="${pageContext.request.contextPath}/assets/js/lesson.js"></script>
    </body>
</html>
