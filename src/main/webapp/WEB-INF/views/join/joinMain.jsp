<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Join : Main - Phoenix Cinema</title>
    <link rel="stylesheet" href="/resources/css/user.css">
</head>
<body>

<div class="cay-main-wrap">

    <jsp:include page="/WEB-INF/views/header.jsp" />

    <main class="cay-join-container">
        <div class="cay-join-content">
                <jsp:include page="${content}"></jsp:include>
        </div>
    </main>

    <footer class="cay-footer">
    © 2025 Phoenix Cinema. All rights reserved.
</footer>
</div>


</div>
<script src="/resources/js/login.js"></script>
</body>
</html>