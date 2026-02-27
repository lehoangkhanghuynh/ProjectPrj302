<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thanh toán thất bại</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f5f5f5;
            padding: 50px;
        }
        .error-box {
            max-width: 600px;
            margin: 0 auto;
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            text-align: center;
        }
        .error-icon {
            font-size: 80px;
            color: #e74c3c;
        }
        h1 {
            color: #e74c3c;
        }
        .btn {
            display: inline-block;
            padding: 12px 30px;
            margin: 10px;
            text-decoration: none;
            border-radius: 5px;
            color: white;
        }
        .btn-primary {
            background: #e74c3c;
        }
        .btn-secondary {
            background: #95a5a6;
        }
    </style>
</head>
<body>
    <div class="error-box">
        <div class="error-icon"></div>
        <h1>Thanh toán thất bại</h1>
        <p>${error != null ? error : "Đã có lỗi xảy ra trong quá trình thanh toán"}</p>
        
        <div style="margin-top: 30px;">
            <a href="javascript:history.back()" class="btn btn-primary">Thử lại</a>
            <a href="courses.jsp" class="btn btn-secondary">Quay lại</a>
        </div>
    </div>
</body>
</html>