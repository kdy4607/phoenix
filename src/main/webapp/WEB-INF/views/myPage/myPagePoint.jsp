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
    <title>MyPage : My Point & Membership - Phoenix Cinema</title>
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
        <div> My Point & Membership </div>
        <div class="cay-myPage-total">
            <div>My Total Point & Membership Class</div>
            <div>
                <table class="cay-myPage-total-table">
                    <th> Total Point</th>
                    <th> Membership Class</th>
                    <tr>
                        <td>${(totalAdults * 500) + (totalYouths * 500) + (totalChildren * 300)} </td>
                        <td>
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
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <div class="cay-myPage-point">
            <div>Point History</div>
            <div>
                <table class="cay-myPage-point-table">
                    <th> Point</th>
                    <th> Adult</th>
                    <th> Youth</th>
                    <th> Child</th>
                    <th> Point Accrual Date</th>
                    <c:forEach items="${reservations}" var="reservation">
                        <tr>
                            <td>${reservation.adult * 500 + reservation.youth * 500 + reservation.child * 300} </td>
                            <td>${reservation.adult}</td>
                            <td>${reservation.youth}</td>
                            <td> ${reservation.child}</td>
                            <td><fmt:formatDate value="${reservation.reservation_date}" pattern="yyyy-MM-dd"/></td>
                        </tr>
                    </c:forEach>
                </table>
            </div>
        </div>
        <div class="cay-myPage-membership">
            <div>Membership Class Guide</div>
            <div>
                <table class="cay-myPage-membership-table">
                    <th> Class</th>
                    <th> Benefit</th>
                    <th> Requirements</th>
                    <tr>
                        <td> A</td>
                        <td> One movie ticket (adult) is provided.</td>
                        <td> 5000 points or more required.</td>
                    </tr>
                    <tr>
                        <td> B</td>
                        <td> 50% discount coupon is provided.</td>
                        <td> 3000 points or more required.</td>
                    </tr>
                    <tr>
                        <td> C</td>
                        <td> 30% discount coupon is provided.</td>
                        <td> 1000 points or more required.</td>
                    </tr>
                    <tr>
                        <td> D</td>
                        <td> No Benefits</td>
                        <td> No Requirements</td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</div>

</body>
</html>
