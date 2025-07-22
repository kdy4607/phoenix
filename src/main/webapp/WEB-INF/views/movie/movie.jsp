<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <title>Movie List</title>
  <link rel="stylesheet" href="/resources/css/movie.css" />
  <link rel="icon" href="/resources/images/logo.png" type="image/png">
  <script src="/resources/js/movie.js" defer></script>
</head>
<body>
<jsp:include page="/WEB-INF/views/header.jsp" />

<div class="container">
  <h1 style="cursor: pointer;" onclick="location.href='/movie-all'">🎬 Movie List</h1>

  <!-- 🎬 상태 탭 -->
  <div class="movie-tab">
    <a href="#" onclick="setStatus('all')" class="tab tab-all">All Movies</a>
    <a href="#" onclick="setStatus('showing')" class="tab tab-showing">Showing Movies</a>
    <a href="#" onclick="setStatus('upcoming')" class="tab tab-upcoming">Upcoming Movies</a>
  </div>

  <!-- 🔍 검색 폼 -->
  <form id="searchForm" class="search-form" onsubmit="return handleSearch(event);">
    <button type="button" class="toggle-button" onclick="toggleTags()">Tag Filter</button>
    <input type="text" name="title" placeholder="Movie Title" class="search-input" />
    <button type="submit" class="search-button">Search</button>
  </form>

  <!-- 🏷️ 태그 필터 (JS로 렌더링) -->
  <div class="tag-container" id="tag-container">
    <!-- JS로 그룹별 태그 삽입 -->
  </div>

  <!-- 🎞️ 영화 목록 (JS로 렌더링) -->
  <div id="movie-container" class="movie-container movie-list-section">
    <div class="loading">🎬 Loading movies...</div>
  </div>

<footer class="cay-footer">
  © 2025 Phoenix Cinema. All rights reserved.
</footer>
</body>
</html>
