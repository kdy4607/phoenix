<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Document</title>
    <link rel="stylesheet" href="/resources/css/user.css">
    <script src="/resources/js/login.js"></script>
</head>
<body>
<jsp:include page="/WEB-INF/views/header.jsp" />

<div class="cay-main-wrap">
    <main class="cay-login-container">
        <div class="cay-login-content">
            <!-- action을 /login으로 변경 -->
            <form class="cay-login-wrap" action="/login" method="post">
                <h1>Sign in or Create Account</h1>

                <!-- 오류 메시지 표시 -->
                <% if(request.getAttribute("errorMessage") != null) { %>
                <div class="error-message" style="color: red; margin-bottom: 10px;">
                    <%= request.getAttribute("errorMessage") %>
                </div>
                <% } %>

                <!-- returnUrl을 hidden 필드로 전달 -->
                <% if(request.getAttribute("returnUrl") != null) { %>
                <input type="hidden" name="returnUrl" value="<%= request.getAttribute("returnUrl") %>">
                <% } %>

                <div class="cay-login-section">
                    <div class="cay-login-col1">
                        <input type="text" placeholder="ID" name="u_id" required>
                    </div>
                    <div class="cay-login-col1">
                        <!-- password 타입으로 변경 -->
                        <input type="password" placeholder="Password" name="u_pw" required>
                    </div>
                </div>
                <div class="cay-login-col2">
                    <button type="submit">Sign in</button>
                    <button type="button" onclick="location.href='/join/step1'">Create Account</button>
                </div>
                <a href="">Need help?</a>
            </form>
        </div>
    </main>
    <footer class="cay-footer"><h1>footer</h1></footer>
</div>

</body>
</html>