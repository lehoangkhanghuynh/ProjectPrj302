<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thanh toán thành công</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f5f5f5;
            padding: 50px;
        }
        .success-box {
            max-width: 600px;
            margin: 0 auto;
            background: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            text-align: center;
        }
        .success-icon {
            font-size: 80px;
            color: #4CAF50;
        }
        h1 {
            color: #4CAF50;
        }
        .payment-details {
            text-align: left;
            margin: 30px 0;
            padding: 20px;
            background: #f9f9f9;
            border-radius: 5px;
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
            background: #4CAF50;
        }
        .btn-secondary {
            background: #2196F3;
        }
    </style>
</head>
<body>
    <div class="success-box">
        <div class="success-icon">✓</div>
        <h1>Thanh toán thành công!</h1>
        <p>Cảm ơn bạn đã mua khóa học</p>
        
        <div class="payment-details">
            <h3>Thông tin đơn hàng:</h3>
            <p><strong>Mã đơn hàng:</strong> ${payment.paymentId}</p>
            <p><strong>Khóa học ID:</strong> ${payment.courseId}</p>
            <p><strong>Số tiền:</strong> ${payment.amount} VNĐ</p>
            <p><strong>Phương thức:</strong> ${payment.paymentMethod}</p>
            <p><strong>Trạng thái:</strong> ${payment.paymentStatus}</p>
            <p><strong>Thời gian:</strong> ${payment.paymentDate}</p>
        </div>
        
        <div>
            <a href="my-courses.jsp" class="btn btn-primary">Vào học ngay</a>
            <a href="courses.jsp" class="btn btn-secondary">Xem khóa học khác</a>
        </div>
    </div>
</body>
</html>