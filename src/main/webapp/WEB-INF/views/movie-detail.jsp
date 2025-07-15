<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>(사진, 타이틀, 총 별점, 감독,주연,관객별점, 전문가 평점, 북마크)
        값을 사용하는 기준으로 같이 묶음.) </title>
    <link rel="stylesheet" href="/resources/css/movie-detail.css">
    <link rel="stylesheet" href="/resources/css/bookmark.css">
<%--    <script src="/resources/js/detailBookMark.js" defer></script>--%>
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
            <form action="${pageContext.request.contextPath}/bookmark"
                  method="post"
                  onsubmit="return checkLogin(this);">
                <input type="hidden" name="movie_id" value="${movieDetail2.movie_id}">
                <input type="hidden" name="u_id" value="${sessionScope.userId}">

                <button type="submit" class="bookmark-btn">
                    <span class="star-icon">☆</span> 북마크
                </button>
            </form>
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
<p>세션 user: ${sessionScope.user}</p>
<p>세션 userId: ${sessionScope.userId}</p>
<p>${movieDetail2.movie_id}</p>///movieDetail2.movie_id
<div class="side-bar">side</div>

<script>
    function checkLogin(form) {
        const userId = form.querySelector('input[name="u_id"]').value;
        if (!userId) {
            alert("로그인 후 이용해주세요.");
            return false;
        }
        return true;
    }
</script>

</body>
</html>
