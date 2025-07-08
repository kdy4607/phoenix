<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="/resources/css/test.css">
</head>
<body>
<body>
<div class="movie-container">
    <c:forEach var="movie" items="${Allmovie}">
        <div class="movie-card">
            <div class="movie-title">${movie.TITLE}</div>
            <img class="movie-img" src="movieFile/${movie.POSTER_URL}" alt="${movie.TITLE}">
            <div class="movie-meta">
                <div>${movie.GENRE}</div>
<%--                <div>${movie.m_country}</div>--%>
                <div>코멘트</div>
                <div>표 가격</div>
                <div>
                    <button onclick="location.href='oneMovieDetail?MOVIE_ID=${movie.MOVIE_ID}'">상세페이지</button>
                </div>
            </div>
        </div>
    </c:forEach>
</div>


</body>
</html>

