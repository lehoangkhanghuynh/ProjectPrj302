<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>

    <h2>Payment History</h2>

    <table border="1">

        <tr>
            <th>ID</th>
            <th>User</th>
            <th>Amount</th>
            <th>Method</th>
            <th>Date</th>
            <th>Status</th>
        </tr>

        <c:forEach var="p" items="${PAYMENT_LIST}">

            <tr>

                <td>${p.paymentId}</td>
                <td>${p.userId}</td>
                <td>${p.amount}</td>
                <td>${p.paymentMethod}</td>
                <td>${p.paymentDate}</td>
                <td>${p.paymentStatus}</td>

            </tr>

        </c:forEach>

    </table>
</html>