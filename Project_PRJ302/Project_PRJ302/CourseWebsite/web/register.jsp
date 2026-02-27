<%-- 
    Document   : register
    Created on : Feb 3, 2026, 11:09:56 PM
    Author     : ASUS
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Sign up</title>
    </head>
    <body>

        <h2>Sign up</h2>

        <form action="MainController" method="post">
            <!-- báo cho MainController đây là register -->
            <input type="hidden" name="action" value="register"/>

            Email * <br>
            <input type="text" name="email" required /><br><br>

            First name * <br>
            <input type="text" name="firstName" required /><br><br>

            Last name * <br>
            <input type="text" name="lastName" required /><br><br>

            Password * <br>
            <input type="password" name="password" required /><br><br>

            Confirm password * <br>
            <input type="password" name="confirm" required /><br><br>

            <input type="submit" value="Sign up"/>
        </form>

        <br>
        <a href="index.jsp">Already have an account? Log in</a>

    </body>
</html>
