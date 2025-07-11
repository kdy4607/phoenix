<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
                class="movie-img"
                src="${movieDetail2.poster_url}"
                alt="${movieDetail2.title}">
        </div>

    </div>
    <%--   밑에는 이외의 정보들이 들었습니다.  --%>
    <div class="detail-info">
        <div class="info-title">

            <div class="info-title-t"><span class="value">${movieDetail2.title}</span></div>
            <div class="bookmark-icon" onclick="toggleBookmark(this)">
                <!-- 여기에 SVG 코드 직접 넣기 -->
                <svg version="1.1" id="Capa_1" xmlns="http://www.w3.org/2000/svg"
                     xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
                     width="30.972px" height="30.972px" viewBox="0 0 431.972 431.972"
                     style="enable-background:new 0 0 431.972 431.972;"
                     xml:space="preserve">
                    <g>
                        <path d="M393.146,14.279c-3.713-5.333-8.713-9.233-14.989-11.707c-3.997-1.711-8.186-2.568-12.565-2.568V0H66.378
		c-4.377,0-8.562,0.857-12.56,2.568c-6.28,2.472-11.278,6.377-14.989,11.707c-3.71,5.33-5.568,11.228-5.568,17.701v368.019
		c0,6.475,1.858,12.371,5.568,17.706c3.711,5.329,8.709,9.233,14.989,11.704c3.994,1.711,8.183,2.566,12.56,2.566
		c8.949,0,16.844-3.142,23.698-9.418l125.91-121.062l125.91,121.065c6.663,6.081,14.562,9.127,23.695,9.127
		c4.76,0,8.948-0.756,12.565-2.279c6.276-2.471,11.276-6.375,14.989-11.711c3.71-5.328,5.564-11.225,5.564-17.699V31.98
		C398.71,25.507,396.852,19.609,393.146,14.279z M362.166,391.139L241.397,275.224l-25.411-24.264l-25.409,24.264L69.809,391.139
		V36.549h292.357V391.139L362.166,391.139z"/>
                    </g>
                </svg>
            </div>
        </div>
        <div class="info-plusStar"><span class="label">총 별점:</span>
            <span class="value">
        <c:forEach begin="1" end="${plusStar}">⭐</c:forEach>
            </span>
        </div>
        <div class="info-ather">
            <div class="row"><span class="label">영화감독:</span>
                <span class="value">${movieDetail2.director}</span>
            </div>
            <div class="row"><span class="label">주연 :</span>
                <span class="value">${movieDetail2.actor}</span>
            </div>
            <div class="row"><span class="label">장르 :</span>
                <span class="value">${movieDetail2.genre}</span>
            </div>
            <div class="row"><span class="label">관람연령:</span>
                <span class="value">${movieDetail2.rating}</span>
            </div>
            <div class="row">
                <span class="label">평론가 평점:</span>
                <span class="value"><c:forEach begin="1" end="${proStar}">
                    ⭐
                </c:forEach></span></div>
            <div class="row">
                <span class="label">관객 평점 :</span>
                <span class="value"><c:forEach begin="1" end="${userStar}">
                    ⭐
                </c:forEach></span></div>
        </div>
        <div id="check">
            <button style="width: 200px; height: 30px"
                    onclick="예매사이트">예매
            </button>
        </div>
    </div>
</div>
<div class="side-bar">side</div>
</body>
</html>
