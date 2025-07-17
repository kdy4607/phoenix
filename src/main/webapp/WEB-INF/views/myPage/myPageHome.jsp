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
    <title>Title</title>
</head>
<body>

<div style="display: none">
    <%-- 인원수 총합계를 저장할 변수 초기화 --%>
    <c:set var="totalAdults" value="0"/>
    <c:set var="totalYouths" value="0"/>
    <c:set var="totalChildren" value="0"/>

    <c:forEach items="${reservations}" var="reservation">
        <c:set var="totalAdults" value="${totalAdults + reservation.adult}"/>
        <c:set var="totalYouths" value="${totalYouths + reservation.youth}"/>
        <c:set var="totalChildren" value="${totalChildren + reservation.child}"/>
        ${reservation.adult}
    </c:forEach>

    <%-- 계산된 총 인원수를 바탕으로 금액 계산 --%>
    <c:set var="calculatedTotalAmount" value="${(totalAdults * 500) + (totalYouths * 500) + (totalChildren * 300)}"/>

    <p>
        총 성인 수: ${totalAdults}명 <br>
        총 청소년 수: ${totalYouths}명 <br>
        총 아동 수: ${totalChildren}명 <br>
        <br>
        계산된 총 인원수 기반 금액: <fmt:formatNumber value="${calculatedTotalAmount}" type="number"/> ₩
    </p>
</div>

<div class="cay-myPage-content">
    <div class="cay-myPage-home">
        <div class="cay-myPage-top">
            <div> W</div>
            <div>
                <div><h1>Hello, ${homeName}</h1></div>
                <div>
                    <a href="/mypage/profile?u_id=${user.u_id}">Update My Information</a>
                </div>
            </div>
            <div>
                <div>
                    <div>POINT</div>
                    <span id="point-ctn"> ${(totalAdults * 500) + (totalYouths * 500) + (totalChildren * 300)} </span>
                </div>
                <div>
                    <div>MEMBERSHIP</div>
                    <span id="membership-ctn">
                        <c:choose>
                            <c:when test="${(totalAdults * 500) + (totalYouths * 500) + (totalChildren * 300) ge 5000}">
                                A
                            </c:when>
                            <c:when test="${(totalAdults * 500) + (totalYouths * 500) + (totalChildren * 300) ge 3000}">
                                B
                            </c:when>
                            <c:when test="${(totalAdults * 500) + (totalYouths * 500) + (totalChildren * 300) ge 1000}">
                                C
                            </c:when>
                            <c:when test="${(totalAdults * 500) + (totalYouths * 500) + (totalChildren * 300) ge 0}">
                                E
                            </c:when>
                        </c:choose>
                    </span>
                </div>
            </div>
        </div>
        <div class="cay-myPage-bottom">
            <div class="cay-myPage-history">
                <h1>My History</h1>
                <div>
                    <a href="/mypage/history?u_id=${user.u_id}">
                        <span> ${stats.youth != null ? stats.youth : 0} </span>
                        <div> Watch</div>
                    </a>
                    <a href="/mypage/history?u_id=${user.u_id}">
                        <span> 0 </span>
                        <div> Review</div>
                    </a>
                    <a href="/mypage/history?u_id=${user.u_id}">
                        <span> 0 </span>
                        <div> Wishlist</div>
                    </a>
                </div>
            </div>
            <div class="cay-myPage-genre">
                <h1>Favorite Genre</h1>
                <div>
                    <a href="/movie-all">
                        <c:forEach var="tag" items="${tagList}">
                            <c:choose>
                                <c:when test="${tag.tag_type eq 'Genre'}">
                                    <div class="tag tag-genre">${tag.tag_name}</div>
                                </c:when>
                            </c:choose>
                        </c:forEach>
                    </a>
                </div>
            </div>
            <div class="cay-myPage-order">
                <h1>My Order History</h1>
                <div>
                    <div>
                        <c:forEach items="${reservations}" var="reservation">
                            <div>
                                <div class="cay-myPage-order-img">
                                    <img src="${reservation.poster_url}" alt="">
                                </div>
                                <div class="cay-myPage-order-info">
                                    <div class="cay-myPage-order-top">
                                        Booking Date - <fmt:formatDate value='${reservation.reservation_date}'
                                                                       pattern='yyyy-MM-dd (E)'/>
                                        <button class="cay-myPage-order-button"
                                                onclick="location.href='/reservation/list'"> ⤴
                                        </button>
                                    </div>
                                    <div class="cay-myPage-order-bottom">
                                        <div>
                                                ${reservation.movie_title}
                                        </div>
                                        <div>
                                                ${reservation.room_name}
                                        </div>
                                        <div>
                                            <div>
                                                <fmt:formatDate value='${reservation.run_date}'
                                                                pattern='yyyy-MM-dd (E)'/>
                                                    ${reservation.start_time}
                                            </div>
                                            <div>
                                                Seat ${reservation.selected_seats}
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                    <c:if test="${empty reservations}">
                        <span> Your recent reservation details do not exist.  </span>
                    </c:if>
                </div>
            </div>
            <div class="cay-myPage-event">
                <h1>My Event History</h1>
                <div>
                    <span> No events participated.  </span>
                </div>
            </div>
            <div class="cay-myPage-reward">
                <h1>My reward</h1>
                <div>
                    <div><h4>Ticket</h4></div>
                    <div>
                        <table class="cay-myPage-reward-table">
                            <tr>
                                <td>Birthday Cinema Ticket</td>
                                <td> 12,000 ₩</td>
                            </tr>
                            <tr>
                                <td>Welcome Cinema Ticket</td>
                                <td> 12,000 ₩</td>
                            </tr>
                        </table>
                    </div>
                </div>
                <div>
                    <div><h4>Coupon</h4></div>
                    <div>
                        <table class="cay-myPage-reward-table">
                            <tr>
                                <td>Welcome Discount Coupon</td>
                                <td> 50 %</td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
