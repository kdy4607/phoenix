<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2025-07-03
  Time: 오후 7:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
    <title>MyPage : My History - Phoenix Cinema</title>
</head>
<body>


<div class="cay-myPage-content">
    <div class="cay-myPage-wrap">
        <div> Movie History</div>
        <div class="cay-myPage-tabs">
            <input type="radio" id="watch" name="radio" checked>
            <input type="radio" id="review" name="radio"/>
            <input type="radio" id="wishlist" name="radio"/>
            <label class="tab_items" for="watch">
                <div>Watch</div>
            </label>
            <label class="tab_items" for="review">
                <div>Review</div>
            </label>
            <label class="tab_items" for="wishlist">
                <div>Wishlist</div>
            </label>
            <div class="cay-myPage-tabs-content" id="watch_content">
                <div class="cay-myPage-order">
                    <h1>Watched Movie</h1>
                    <div>
                        <div>
                            <c:if test="${not empty reservations}">
                                <c:forEach items="${reservations}" var="reservation">
                                    <div>
                                        <div class="cay-myPage-order-img">
                                            <img src="${reservation.poster_url}" alt="">
                                        </div>
                                        <div class="cay-myPage-order-info">
                                            <div class="cay-myPage-order-top">
                                                    ${reservation.movie_title}
                                            </div>
                                            <div class="cay-myPage-order-bottom">
                                                <div>
                                                        ${reservation.room_name}
                                                </div>
                                                <div>
                                                    <div>
                                                        <fmt:formatDate value='${reservation.run_date}'
                                                                        pattern='yyyy-MM-dd (E)'/>
                                                            ${reservation.start_time}
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:if>
                        </div>
                        <c:if test="${empty reservations}">
                            <span> Your recent reservation details do not exist.  </span>
                        </c:if>
                    </div>
                </div>
            </div>
            <div class="cay-myPage-tabs-content" id="review_content">
                <div class="cay-myPage-order">
                    <h1>My Review</h1>
                    <div>
                        <div>
                            <c:if test="${not empty reviewList}">
                                <c:forEach items="${reviewList}" var="review">
                                    <div>
                                        <div class="cay-myPage-order-img">
                                            <img src="${review.movie.poster_url}" alt="">
                                        </div>
                                        <div class="cay-myPage-order-info">
                                            <div class="cay-myPage-order-top">
                                                    ${review.movie.title}
                                            </div>
                                            <div class="cay-myPage-order-bottom">
                                                <div>
                                                    <div>
                                                        <c:if test="${not empty review}">
                                                            <span style="font-size: 1.5rem">
                                                                " ${review.r_text} "
                                                            </span>
                                                        </c:if>
                                                        <c:if test="${empty review}">
                                                            <span>
                                                                The review has not been created yet.
                                                            </span>
                                                        </c:if>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:if>
                        </div>
                        <c:if test="${empty reservations}">
                            <span> Your recent reservation details do not exist.  </span>
                        </c:if>
                    </div>
                </div>
            </div>
            <div class="cay-myPage-tabs-content" id="wishlist_content">
                <div class="cay-myPage-order">
                    <h1>My Wishlist</h1>
                    <div>
                        <div>
                            <%--북마크 추가에 따른 수정 필요<--%>
                            <c:if test="${not empty bookmarks}">
                                <c:forEach items="${bookmarks}" var="bookmark">
                                    <div>
                                        <div class="cay-myPage-order-img">
                                            <img src="${bookmark.poster_url}" alt="">
                                        </div>
                                        <div class="cay-myPage-order-info">
                                            <div class="cay-myPage-order-top">
                                                    ${bookmark.title}
                                            </div>
                                            <div class="cay-myPage-order-bottom">
                                                <div>
                                                    <div> ㅤ</div>
                                                    Click the button to view movie details.
                                                    <button class="cay-myPage-history-button"
                                                            onclick="location.href='/oneMovieDetail?movie_id=${bookmark.movie_id}'">
                                                        ⤴
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </c:if>
                            <c:if test="${empty bookmarks}">
                                <div>
                                    <span> Your wishlist do not exist.  </span>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
