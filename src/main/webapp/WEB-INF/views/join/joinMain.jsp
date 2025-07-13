<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Document</title>
    <link rel="stylesheet" href="/resources/css/user.css">
</head>
<body>

<div class="cay-main-wrap">
    <header class="cay-header">
        <h1>header</h1>
        <a href="/mypage"> MyPage </a>
        <a href="/login"> login </a>
    </header>
    <nav class="cay-nav"><h1>Nav</h1></nav>

    <main class="cay-join-container">
        <div class="cay-join-content">
                <h1> Join Us </h1>
                <jsp:include page="${content}"></jsp:include>
        </div>
    </main>

    <footer class="cay-footer"><h1>footer</h1></footer>
</div>


</div>

</body>
</html>