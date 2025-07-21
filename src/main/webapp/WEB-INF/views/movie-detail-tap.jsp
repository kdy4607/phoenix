<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>Movie Detail</title>
    <link rel="stylesheet" href="/resources/css/clickTap.css">
</head>
<body>

<div class="tap-outBox">
    <div class="tab active" data-tab="genre" onclick="showTab(this)">Similar Genre Movies</div>
    <div class="tab" data-tab="review" onclick="showTab(this)">User Reviews</div>
</div>

<div class="tap-inBox">

    <%--    <!-- 동일장르 -->--%>
    <%--    <div class="content active" data-tab-content="genre">--%>
    <%--        <div class="related-movie-wrap">--%>
    <%--            <c:choose>--%>
    <%--                <c:when test="${empty relatedMovies}">--%>
    <%--                    관련 영화가 없습니다.--%>
    <%--                </c:when>--%>
    <%--                <c:otherwise>--%>

    <%--                    <c:forEach var="rel" items="${relatedMovies}" varStatus="loop">--%>

    <%--                        <c:if test="${loop.index < 5}">--%>
    <%--                            <a href="/oneMovieDetail?movie_id=${rel.movie_id}"--%>
    <%--                               style="text-decoration: none; color: inherit;">--%>
    <%--                                <!-- 동일장르 -->--%>
    <%--                                <div class="related-movie">--%>
    <%--                                    <img src="${rel.poster_url}" alt="${rel.title}" style="width:150px">--%>
    <%--                                    <div>${rel.title}</div>--%>
    <%--                                </div>--%>
    <%--                            </a>--%>
    <%--                        </c:if>--%>

    <%--                    </c:forEach>--%>

    <%--                </c:otherwise>--%>
    <%--            </c:choose>--%>
    <%--        </div>--%>
    <%--    </div>--%>
    <!-- 동일장르 -->
        <div class="content active" data-tab-content="genre">
            <c:choose>
                <c:when test="${empty relatedMovies}">
                    관련 영화가 없습니다.
                </c:when>
                <c:otherwise>
                    <div class="slider-container">
                        <button class="slider-btn prev" onclick="slideMovies(-1)">&#10094;</button>

                        <div class="related-movie-wrap" id="slider-track"  style="width: calc((250px + 20px) * ${fn:length(relatedMovies)});">
                            <c:forEach var="rel" items="${relatedMovies}">
                                <a href="/oneMovieDetail?movie_id=${rel.movie_id}" class="related-movie-link">
                                    <div class="related-movie">
                                        <img src="${rel.poster_url}" alt="${rel.title}" style="width:150px">
                                        <div>${rel.title}</div>
                                    </div>
                                </a>
                            </c:forEach>
                        </div>
                        <button class="slider-btn next" onclick="slideMovies(1)">&#10095;</button>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    <!-- 관객평 -->
    <div class="content" data-tab-content="review">
        <!-- 리뷰 작성 폼 -->
        <form action="/reviews" method="post" class="review-form">
            <input type="hidden" name="movie_id" value="${movieDetail2.movie_id}"/>
            <input type="hidden" name="u_id" value="${sessionScope.user.u_id}"/>

            <div class="review-top">
                <span class="review-user">${sessionScope.user.u_id}</span>
                <div class="review-star">
                    <input type="radio" id="star5" name="r_rating" value="5" required><label for="star5">★</label>
                    <input type="radio" id="star4" name="r_rating" value="4"><label for="star4">★</label>
                    <input type="radio" id="star3" name="r_rating" value="3"><label for="star3">★</label>
                    <input type="radio" id="star2" name="r_rating" value="2"><label for="star2">★</label>
                    <input type="radio" id="star1" name="r_rating" value="1"><label for="star1">★</label>
                </div>
            </div>
            <textarea name="r_text" rows="4" cols="50" placeholder="Please enter your review." required
                      oninvalid="this.setCustomValidity('Please enter your review.')"
                      oninput="this.setCustomValidity('')"></textarea>
            <button type="submit" class="submit-btn">Submit</button>
        </form>


        <!-- 리뷰 목록 -->
        <div class="review-list">
            <c:forEach var="review" items="${reviewList}">
                <div class="review-item">
                    <div class="review-header">
                        <span class="review-uid">${review.u_id}</span>
                        <span class="review-stars">
                            <c:forEach begin="1" end="${review.r_rating}" var="i">⭐</c:forEach>
                        </span>
                    </div>

                    <div class="review-text">${review.r_text}</div>

                    <div class="review-date">
                        <fmt:formatDate value="${review.r_date}" pattern="yyyy.MM.dd HH:mm:ss"/>
                    </div>

                    <!-- 본인만 삭제 버튼 노출 -->
                    <c:if test="${review.u_id == sessionScope.user.u_id}">
                        <form action="/reviews/delete" method="post" style="margin-top: 5px;">
                            <input type="hidden" name="r_id" value="${review.r_id}"/>
                            <input type="hidden" name="movie_id" value="${movieDetail2.movie_id}"/>
                            <button type="submit" class="submit-btn"
                                    onclick="return confirm('Do you really want to delete this?')">Delete
                            </button>
                        </form>
                    </c:if>
                </div>
            </c:forEach>
        </div>
        <div class="content">줄거리:${movieDetail2.description}</div>
        <div class="content">감상평</div>
    </div>
</div>

<script>
    function showTab(tabElement) {
        const tabName = tabElement.dataset.tab;
        document.querySelectorAll('.tab').forEach(tab => {
            tab.classList.toggle('active', tab.dataset.tab === tabName);
        });
        document.querySelectorAll('.content').forEach(content => {
            content.classList.toggle('active', content.dataset.tabContent === tabName);
        });
    }

 // 이건 사이드바 조절용~
    let currentIndex = 0;
    const visibleCount = 4; // 한 번에 보일 영화 개수
    const itemWidth = 270; // 영화 박스 하나의 대략적인 width + margin
    const track = document.getElementById('slider-track');

    function slideMovies(direction) {
        const totalItems = track.children.length;
        console.log("totalItems : "+totalItems);

        const maxIndex = totalItems - visibleCount;
        console.log("maxIndex : "+maxIndex);

        console.log("currentIndex : " + currentIndex);

        currentIndex += direction;

        if (currentIndex < 0) currentIndex = 0;
        if (currentIndex > maxIndex) currentIndex = maxIndex;

        console.log("currentIndex : " + currentIndex);
        const moveX = -currentIndex * itemWidth;
        track.style.transform = `translateX(\${moveX}px)`;
    }

</script>

</body>
</html>
