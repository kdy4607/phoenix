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
    <title>MyPage : Home - Phoenix Cinema</title>
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
                <div onclick="location.href='/mypage/reward/point?u_id=${user.u_id}'">
                    <div>POINT</div>
                    <span id="point-ctn"> ${(totalAdults * 500) + (totalYouths * 500) + (totalChildren * 300)} </span>
                </div>
                <div onclick="location.href='/mypage/reward/point?u_id=${user.u_id}'">
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
                <h1>My History
                    <div class="cay-maPage-bottom-solid"></div>
                </h1>
                <div>
                    <a href="/mypage/history?u_id=${user.u_id}">
                        <span> ${stats.youth != null ? stats.youth : 0} </span>
                        <div> Watch</div>
                    </a>
                    <a href="/mypage/history?u_id=${user.u_id}">
                        <span> ${reviewsCtn != null ? reviewsCtn : 0} </span>
                        <div> Review</div>
                    </a>
                    <a href="/mypage/history?u_id=${user.u_id}">
                        <span> ${BookmarksCtn != null ? BookmarksCtn : 0 }</span>
                        <div> Wishlist</div>
                    </a>
                </div>
            </div>
            <div class="cay-myPage-genre">
                <h1>Favorite Genre
                    <div class="cay-maPage-bottom-solid"></div>
                </h1>
                <div>
                    <c:forEach var="tag" items="${tagLists}">
                        <c:if test="${tag.tag_type eq 'Genre'}">
                            <a class="" href="/movie-all?status=showing&tags=${tag.tag_id}">
                                <div class="tag tag-genre">${tag.tag_name}</div>
                            </a>
                        </c:if>
                    </c:forEach>
                </div>
            </div>
            <div class="cay-myPage-order">
                <h1>My Order History
                    <div class="cay-maPage-bottom-solid"></div>
                </h1>
                <div>
                    <div>
                        <c:forEach items="${reservations}" var="reservation" begin="0" end="2">
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
                <div>
                    <div> ※ It only reflects reservations of the most recent reservation details.</div>
                    <div> ※ Check <a href="/reservation/list">here</a> for more coupon
                        details.
                    </div>
                </div>
            </div>
            <div class="cay-myPage-event">
                <h1>My Event History
                    <div class="cay-maPage-bottom-solid"></div>
                </h1>
                <div>
                    <span> No events participated.  </span>
                </div>
            </div>
            <div class="cay-myPage-reward">
                <h1>My reward
                    <div class="cay-maPage-bottom-solid"></div>
                </h1>
                <div class="cay-myPage-ticket">
                    <div>Reward Ticket</div>
                    <table class="cay-myPage-ticket-table">
                        <th> Ticket</th>
                        <th> Price</th>
                        <th> Date of issuance</th>
                        <c:if test="${userBirthMonthDay.isBefore(todayMonthDay)}">
                            <tr>
                                <td>Birthday Cinema Ticket</td>
                                <td> 12,000 ₩</td>
                                <td> ${userBirth} </td>
                            </tr>
                        </c:if>
                        <tr>
                            <td>Welcome Cinema Ticket</td>
                            <td> 12,000 ₩</td>
                            <td> Membership Date</td>
                        </tr>
                    </table>
                </div>
                <div class="cay-myPage-coupon">
                    <div style="color: black">Reward Coupon</div>
                        <c:if test="${not empty reservations}">
                    <table class="cay-myPage-coupon-table">
                        <th> Coupon</th>
                        <th> Benefit</th>
                        <th> Date of issuance</th>
                        <c:forEach items="${reservations}" var="reservation" begin="${reservations.size() - 1}"
                                   end="${reservations.size() - 1}">
                            <%-- 성인 수만큼 반복하여 쿠폰 출력 --%>
                            <c:forEach begin="1" end="${reservation.adult}" varStatus="loop">
                                <tr>
                                    <td>Adult Cinema Discount Coupon</td>
                                    <td> 50%</td>
                                    <td><fmt:formatDate value="${reservation.run_date}" pattern="yyyy-MM-dd (E)"/></td>
                                </tr>
                            </c:forEach>
                            <%-- 청소년 수만큼 반복하여 쿠폰 출력 --%>
                            <c:forEach begin="1" end="${reservation.youth}" varStatus="loop">
                                <tr>
                                    <td>Youth Cinema Discount Coupon</td>
                                    <td> 30%</td>
                                    <td><fmt:formatDate value="${reservation.run_date}" pattern="yyyy-MM-dd (E)"/></td>
                                </tr>
                            </c:forEach>
                            <%-- 아동 수만큼 반복하여 쿠폰 출력 --%>
                            <c:forEach begin="1" end="${reservation.child}" varStatus="loop">
                                <tr>
                                    <td>Child Cinema Discount Coupon</td>
                                    <td> 10%</td>
                                    <td><fmt:formatDate value="${reservation.run_date}" pattern="yyyy-MM-dd (E)"/></td>
                                </tr>
                            </c:forEach>
                        </c:forEach>
                    </table>
                    <div>
                        <div> ※ It only reflects the coupon payment status of the most recent reservation details.</div>
                        <div> ※ Check <a href="/mypage/reward/coupon?u_id=${user.u_id}">here</a> for more coupon
                            details.
                        </div>
                    </div>
                    </c:if>
                    <c:if test="${empty reservations}">
                        Your recent coupon details do not exist.
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
