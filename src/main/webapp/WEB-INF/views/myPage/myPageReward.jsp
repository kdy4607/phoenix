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
    <div class="cay-myPage-wrap">
        <div> My Reward</div>
        <div class="cay-myPage-reward">
            <div>
                <div>Point&Membership</div>
                <div>
                    <div onclick="location.href='/mypage/reward/point?u_id=${user.u_id}'">
                        <span>${(totalAdults * 500) + (totalYouths * 500) + (totalChildren * 300)}</span>
                        <div>Total Point</div>
                    </div>
                    <div onclick="location.href='/mypage/reward/point?u_id=${user.u_id}'">
                        <span>
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
                        <div>Membership Class</div>
                    </div>
                </div>
            </div>
            <div>
                <div>Ticket&Coupon</div>
                <div>
                    <div onclick="location.href='/mypage/reward/coupon?u_id=${user.u_id}'">
                        <span> ${userBirth.isBefore(today) ? 2 : 1} </span>
                        <div>Total Reward Ticket</div>
                    </div>
                    <div onclick="location.href='/mypage/reward/coupon?u_id=${user.u_id}'">
                        <span> ${totalAdults != null || totalYouths != null || totalChildren != null ? totalAdults + totalYouths + totalChildren : 0} </span>
                        <div>Total Reward Coupon</div>
                    </div>
                </div>
            </div>
        </div>
        </form>
    </div>
</div>

</body>
</html>
