<%-- 
    Document   : payment
    Created on : Feb 6, 2026, 12:13:14 PM
    Author     : USER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form action="MainController" method="post">
            <input type="hidden" name="action" value="payment">
            <input type="hidden" name="courseId" value="${c.courseId}" />
            <input type="hidden" name="Amount" value="${c.fee}">
            <select name="paymentMethod">
                <option value ="MOMO">Momo</option>
                <option value ="VNPAY">VNPay </option>
                <option value = "Bank">Bank</option>
            </select>
            <input type="submit" name="Thanh toán"/>
        </form>
    </body>
</html>
