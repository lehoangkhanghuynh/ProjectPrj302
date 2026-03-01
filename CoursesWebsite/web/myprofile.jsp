<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Hồ sơ của tôi</title>
    </head>
    <body>
        <c:if test="${empty sessionScope.user}">
            <c:redirect url="login.jsp" />
        </c:if>
        <c:if test="${not empty sessionScope.user}">
            <h2>Thông tin của bạn</h2>
            <h3>Tài Khoản: ${sessionScope.user.userId}</h3>

            <!-- Form cập nhật thông tin -->
            <form action="mainController" method="POST">
                <input type="hidden" name="action" value="updateUser" />
                <!-- Sửa: truyền userId lên server -->
                <input type="hidden" name="userId" value="${sessionScope.user.userId}" />

                <label>Tên</label><br/>
                <input type="text" name="fullname" placeholder="${sessionScope.user.fullname}"/><br/>

                <label>Email</label><br/>
                <input type="text" name="email" placeholder="${sessionScope.user.email}" /><br/>

                <input type="submit" value="Đổi thông tin" onclick="return confirm('Bạn có chắc muốn cập nhật thông tin không?')" />
            </form>
            <c:if test="${not empty MSG}">
                <span style="color: green">${MSG}</span>
            </c:if>
            <c:if test="${not empty ERROR}">
                <span style="color: red">${ERROR}</span>
            </c:if>
            <hr/>
            <script>
                function confirmPassword() {
                    let oldPass = document.querySelector("input[name='oldPassword']").value;
                    let pass = document.querySelector("input[name='password']").value;
                    let confirmPass = document.querySelector("input[name='confirmPassword']").value;

                    if (oldPass.trim() === "") {
                        alert("Vui lòng nhập mật khẩu cũ!");
                        return false;
                    }
                    if (pass !== confirmPass) {
                        alert("Mật khẩu xác nhận không khớp!");
                        return false;
                    }
                    if (pass.length < 6) {
                        alert("Mật khẩu mới phải có ít nhất 6 ký tự!");
                        return false;
                    }
                    return confirm("Bạn có chắc muốn đổi mật khẩu không?");
                }
            </script>

            <!-- Form đổi mật khẩu -->
            <form action="mainController" method="POST">
                <input type="hidden" name="action" value="updatePassword" />
                <input type="hidden" name="userId" value="${sessionScope.user.userId}" />

                Mật khẩu cũ<br/>
                <input type="password" name="oldPassword" required place /><br/>

                <label>Mật khẩu mới</label><br/>
                <input type="password" name="password" required /><br/>

                <label>Xác nhận mật khẩu</label><br/>
                <input type="password" name="confirmPassword" required /><br/>

                <input type="submit" value="Đổi mật khẩu" onclick="return confirmPassword()" />
            </form>

            <!-- Thêm hiển thị thông báo đổi mật khẩu -->
            <c:if test="${not empty MSGpass}">
                <span style="color: green">${MSGpass}</span>
            </c:if>
            <c:if test="${not empty ERRORpass}">
                <span style="color: red">${ERRORpass}</span>
            </c:if>
        </c:if>
    </body>
</html>