<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <title>영화 선택</title>
  <link rel="stylesheet" href="/resources/css/sample.css">
    </style>
</head>
<body>
<div class="container">
  <h1>영화 예매</h1>

  <jsp:include page="/WEB-INF/views/stepbar.jsp">
    <jsp:param name="currentStep" value="${reservation.currentStep}"/>
  </jsp:include>

  <h2>1. 영화 선택</h2>

  <div class="movie-grid">
    <c:forEach var="movie" items="${movies}">
      <div class="movie-card">
        <!-- 포스터 이미지 경로: 영화제목 기반 -->
        <img src="/resources/posters/${movie.title}.jpg" alt="${movie.title}">
        <p>${movie.title}</p>
        <form action="/step2" method="post">
          <input type="hidden" name="title" value="${movie.title}" />
          <button type="submit">예매하기</button>
        </form>
      </div>
    </c:forEach>
  </div>

</div>
</body>
</html>