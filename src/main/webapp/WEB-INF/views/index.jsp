<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Phoenix Cinema</title>
  <link rel="stylesheet" href="/resources/css/index.css">
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Winky+Rough:ital,wght@0,300..900;1,300..900&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
  <link rel="icon" href="/resources/images/logo.png" type="image/png">
</head>

<body>
<!-- 공통 헤더 포함 -->
<jsp:include page="/WEB-INF/views/header.jsp" />

<div class="container">
  <div class="main-logo">
    <img src="/resources/images/logo.png" alt="Phoenix Cinema Logo" class="main-logo-image">
<%--    <span class="main-logo-text">PHOENIX</span>--%>
    <span class="main-logo-text">Phoenix</span>
  </div>
  <div class="description">Premium Cinema System made by Soldesk</div>

  <div class="menu-grid">
    <!-- 메뉴 아이템 수정 -->
    <a href="/movie-all" class="menu-item">
      <span class="icon"><i class="fas fa-film"></i></span>
      Movie List
    </a>

    <a href="/schedule" class="menu-item">
      <span class="icon"><i class="fas fa-ticket-alt"></i></span>
      Schedule & Book
    </a>

    <a href="/reservation/list" class="menu-item">
      <span class="icon"><i class="fas fa-list"></i></span>
      My Bookings
    </a>

    <a href="/mypage" class="menu-item">
      <span class="icon"><i class="fas fa-user"></i></span>
      My Page
    </a>

    <a href="/credits" class="menu-item">
      <span class="icon"><i class="fas fa-building"></i></span>
      Credits
    </a>

    <a href="/events" class="menu-item">
      <span class="icon"><i class="fa-solid fa-calendar-week"></i></span>
      Events
    </a>
  </div>

  <div class="footer">
    © 2025 Phoenix Cinema. All rights reserved.
  </div>
</div>
</body>

</html>