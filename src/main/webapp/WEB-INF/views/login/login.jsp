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


<div class="cay-main-wrap">
    <header class="cay-header">
        <h1>header</h1>
        <a href="/main"> Main </a>
        <a href="/mypage" onclick="login()"> MyPage </a>
        <a href="/login"> login </a>
    </header>
    <nav class="cay-nav"><h1>Nav</h1></nav>
    <main class="cay-login-container">
        <div class="cay-login-content">
            <form class="cay-login-wrap" action="/mypage" method="post">
                <h1>Sign in or Creat Account </h1>
                <div class="cay-login-section">
                    <div class="cay-login-col1">
                        <input type="text" placeholder="Nickname" name="u_nickname">
                    </div>
                    <div class="cay-login-col1">
                        <input type="text" placeholder="Password" name="u_pw">
                    </div></div>
                <div class="cay-login-col2">
                    <button> sign in </button>
                    <button type="button" onclick="location.href='/join/step1'"> Creat Account</button>
                </div>
                <a href=""> Need help? </a>
            </form>
        </div>
    </main>
    <footer class="cay-footer"><h1>footer</h1></footer>
</div>

</body>
</html>