<%-- 
    Document   : payment
    Created on : Feb 27, 2026, 11:38:16 PM
    Author     : HOANG KHANG PC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Thanh Toán</title>
    </head>
    <body>
        <h2>Thanh toán đơn hàng</h2>
        Tổng tiền: <b>${totalAmount} VND</b>
        <br><br>

        <!-- ✅ Gọi thẳng /payment servlet, không qua mainController -->
        <form action="payment" method="post">
            <input type="hidden" name="action" value="create">
            <input type="hidden" name="amount" value="${totalAmount}">
            <button type="submit">💜 Thanh toán MoMo</button>
        </form>

        <br>

        <button onclick="pay()">📱 Thanh toán QR</button>
        <br><br>
        <img id="qr" width="300" style="display:none; border-radius:12px;">

        <script>
            function pay() {
                let bank = "970415"; // Vietinbank
                let account = "106879806456";
                let name = "LE HOANG KHANG";
                let amount = parseInt("${totalAmount}") || 0;
                let info = "Thanh toan user ${user.userId}";


                let url = "https://img.vietqr.io/image/"
                        + bank + "-" + account
                        + "-qr_only.png?amount=" + amount
                        + "&addInfo=" + encodeURIComponent(info)
                        + "&accountName=" + encodeURIComponent(name);

                let img = document.getElementById("qr");
                img.src = url;
                img.style.display = "block";
            }
        </script>
    </body>
</html>
