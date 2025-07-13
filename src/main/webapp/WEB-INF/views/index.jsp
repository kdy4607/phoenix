<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Phoenix Cinema</title>
  <link rel="stylesheet" href="/resources/css/index.css">
</head>

<body>
<!-- 공통 헤더 포함 -->
<jsp:include page="/WEB-INF/views/header.jsp" />

<div class="container">
  <div class="main-logo">
    <img src="/resources/images/logo.png" alt="Phoenix Cinema Logo" class="main-logo-image">
    <span class="main-logo-text">Phoenix Cinema</span>
  </div>
  <div class="description">Premium Cinema System made by Soldesk</div>

  <div class="menu-grid">
    <a href="/movie-all" class="menu-item">
      <span class="icon">🎭</span>
      Movie List
    </a>

    <a href="/schedule" class="menu-item">
      <span class="icon">🎫</span>
      Schedule & Book
    </a>

    <a href="/reservation/list" class="menu-item">
      <span class="icon">📋</span>
      Booking history
    </a>

    <a href="/mypage" class="menu-item">
      <span class="icon">👤</span>
      My Page
    </a>

    <a href="/credits" class="menu-item">
      <span class="icon">🏢</span>
      Credits
    </a>

    <a href="#" class="menu-item" onclick="alert('준비 중입니다!')">
      <span class="icon">🎉</span>
      Events
    </a>
  </div>

  <div class="footer">
    © 2025 Phoenix Cinema. All rights reserved.
  </div>
</div>
</body>

</html>