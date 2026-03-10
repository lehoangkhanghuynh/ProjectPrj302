<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>DUK Academy Certificate</title>

        <link href="https://fonts.googleapis.com/css2?family=Cinzel:wght@700&family=Great+Vibes&family=Montserrat:wght@400;600&display=swap" rel="stylesheet">

        <style>
            /* ===== GIỮ NGUYÊN CSS CỦA BẠN ===== */
            body {
                margin: 0;
                padding: 0;
                background: #2c3e50;
                display: flex;
                justify-content: center;
                align-items: flex-start;
                padding-top: 40px;
                min-height: 100vh;
                font-family: 'Montserrat', sans-serif;
            }

            .certificate {
                width: 900px;
                height: 600px;
                padding: 50px 60px 40px 60px;
                background: #f5f0e0;
                position: relative;
                box-sizing: border-box;
                box-shadow: 0 20px 50px rgba(0,0,0,0.5);
                border: 18px solid #1a237e;
                outline: 3px solid #c5a059;
                outline-offset: -26px;
                text-align: center;
                overflow: hidden;
            }

            .certificate::before {
                content: '';
                position: absolute;
                top: 22px;
                left: 22px;
                right: 22px;
                bottom: 22px;
                border: 1.5px solid #c5a059;
                pointer-events: none;
                z-index: 0;
            }

            .watermark {
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                font-family: 'Cinzel', serif;
                font-size: 200px;
                color: rgba(197, 160, 89, 0.07);
                z-index: 0;
            }

            .verified-stamp {
                position: absolute;
                bottom: 55px;
                right: 50px;
                font-size: 46px;
                font-weight: 900;
                color: rgba(197, 160, 89, 0.15);
                letter-spacing: 4px;
                transform: rotate(-15deg);
                font-family: 'Cinzel', serif;
            }

            .laurel-wrap {
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 12px;
            }

            .laurel {
                font-size: 20px;
                color: #8a7a50;
                opacity: 0.65;
            }

            .content {
                position: relative;
                z-index: 1;
            }

            .logo {
                width: 120px;
                margin: -30px auto 10px auto;
                background: transparent;
            }

            .academy-name {
                font-family: 'Cinzel', serif;
                font-size: 38px;
                color: #1a1a2e;
                letter-spacing: 4px;
            }

            .cert-title {
                font-size: 30px;
                font-weight: 700;
                color: #2c3e50;
                margin: 8px 0 4px 0;
                font-family: 'Cinzel', serif;
            }

            .subtitle {
                font-size: 13px;
                letter-spacing: 2px;
                margin: 10px 0 4px 0;
                color: #555;
            }

            .name {
                font-family: 'Great Vibes', cursive;
                font-size: 58px;
                color: #c5a059;
            }

            .name-line {
                width: 55%;
                margin: 2px auto 0 auto;
                border-top: 1.5px solid #c5a059;
            }

            .desc {
                margin-top: 14px;
                font-size: 14px;
                font-style: italic;
                color: #444;
            }

            .course {
                font-size: 16px;
                font-weight: 600;
                color: #333;
            }

            .info {
                font-size: 13px;
                color: #555;
                margin-top: 8px;
            }

            .bottom {
                position: absolute;
                bottom: 42px;
                left: 55px;
                right: 70px;
                display: flex;
                justify-content: space-between;
                align-items: flex-end;
            }

            .signature {
                text-align: center;
                width: 160px;
                height: 120px;
            }

            .sig-line {
                border-top: 1.5px solid #333;
            }

            .sig-label-bold {
                font-size: 12px;
                font-weight: bold;
            }

            .sig-label-small {
                font-size: 10px;
                color: #666;
            }

            .verified-badge {
                width: 150px;
                text-align: center;
                transform: translateY(10px);
            }

            .verified-badge img {
                width: 95px;
                margin-top: 20px;
                filter: drop-shadow(0px 4px 6px rgba(0,0,0,0.35));
            }

            .verified-text {
                font-size: 10px;
                margin-top: 3px;
                font-weight: bold;
                color: #1a237e;
            }
        </style>
    </head>

    <body>

        <div class="certificate">

            <div class="watermark">DUK</div>
            <div class="verified-stamp">VERIFIED</div>

            <div class="content">

                <img src="${pageContext.request.contextPath}/img/logo/DUK.png" class="logo">

                <div class="academy-name">DUK ACADEMY</div>

                <div class="laurel-wrap">
                    <span class="laurel">❧</span>
                    <div class="cert-title">Certificate of Completion</div>
                    <span class="laurel">❧</span>
                </div>

                <div class="subtitle">This certifies that</div>

                <div class="name">

                    <c:choose>
                        <c:when test="${not empty sessionScope.user.fullname}">
                            ${sessionScope.user.fullname}
                        </c:when>
                        <c:otherwise>
                            Your Full Name
                        </c:otherwise>
                    </c:choose>

                </div>

                <div class="name-line"></div>

                <div class="desc">has successfully completed the course</div>

                <div class="course">

                    <c:choose>
                        <c:when test="${not empty course.courseName}">
                            ${course.courseName}
                        </c:when>
                        <c:otherwise>
                            Course Title
                        </c:otherwise>
                    </c:choose>

                </div>

                <div class="info">
                    Certificate Code: <strong>${certificate.code}</strong>
                    &nbsp;|&nbsp;
                    Date:
                    <strong>
                        <fmt:formatDate value="${certificate.issueDate}" pattern="dd/MM/yyyy"/>
                    </strong>
                </div>

            </div>

            <div class="bottom">

                <div class="signature">
                    <img src="${pageContext.request.contextPath}/img/logo/signature.png" style="width:130px;margin-bottom:-10px;">
                    <div class="sig-line"></div>
                    <div class="sig-label-bold">Instructor Signature</div>
                    <div class="sig-label-small">Authorized Signature, DUK Academic Board</div>
                </div>

                <div class="verified-badge">
                    <img src="${pageContext.request.contextPath}/img/logo/duk_badge.png">
                    <div class="verified-text">Verified International Standard</div>
                </div>

            </div>

        </div>

    </body>
</html>