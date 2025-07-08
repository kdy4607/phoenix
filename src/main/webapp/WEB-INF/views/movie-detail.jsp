<%--
  Created by IntelliJ IDEA.
  User: 2zino
  Date: 2025-07-07
  Time: 오후 1:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>(사진, 타이틀, 총 별점, 감독,주연,관객별점, 전문가 평점, 북마크)
        값을 사용하는 기준으로 같이 묶음.) </title>
    <link rel="stylesheet" href="/resources/css/movie-detail.css">
</head>
<body>
<div class="M-detail">
    <div class="detail-img-res"> <%-- 이미지파일과 예매버튼 나중에 수정--%>
        <div id="img"><img
                class="movie-img" src="movieFile/${movieDetail2.POSTER_URL}" alt="">
        </div>
        <div id="check">
            <button style="width: 200px; height: 30px"
                    onclick="예매사이트">예매</button>
        </div>
    </div>
    <%--   밑에는 이외의 정보들이 들었습니다.  --%>
    <div class="detail-info">
        <div class="info-title">
            <div>${movieDetail2.TITLE}</div>
            <div>북마크 이미지</div>
        </div>
        <div class="info-plusStar">총 별점</div>
        <div class="info-ather">
            <div>영화감독:</div>
            <div>주연:</div>
            <div>평론가 평점:</div>
            <div>관객 평점:</div>
        </div>
    </div>
</div>
<div class="side-bar">side bar</div>
</body>
</html>
