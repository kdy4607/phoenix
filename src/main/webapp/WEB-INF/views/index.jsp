<%@ page language = "java" contentType = "text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Document</title>
    <link rel="stylesheet" href="resources/css/index.css">
</head>
<body>
<div class="container">
    <div class="logo">🎬 Phoenix Cinema</div>
    <div class="description">
        영화의 모든 순간을 함께하는 프리미엄 시네마
    </div>

    <div class="menu-grid">
        <a href="/movie-all" class="menu-item">
            <span class="icon">🎭</span>
            영화 목록
        </a>

        <a href="/schedule" class="menu-item">
            <span class="icon">🎫</span>
            상영시간표 & 예매
        </a>


        <a href="/reservation/list" class="menu-item">
            <span class="icon">📋</span>
            예약 내역
        </a>

        <a href="#" class="menu-item" onclick="alert('준비 중입니다!')">
            <span class="icon">🎉</span>
            이벤트
        </a>

        <a href="#" class="menu-item" onclick="alert('준비 중입니다!')">
            <span class="icon">🛍️</span>
            스토어
        </a>

        <a href="#" class="menu-item" onclick="alert('준비 중입니다!')">
            <span class="icon">👤</span>
            마이페이지
        </a>

        <a href="/credits" class="menu-item">
            <span class="icon">🏢</span>
            개발팀 소개
        </a>

    </div>

    <div style="margin-top: 40px; text-align: center; color: #999; font-size: 14px;">
        © 2025 Phoenix Cinema. All rights reserved.
    </div>
</div>
</body>
</html>