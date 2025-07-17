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
        <div> My Ticket & Coupon</div>

        <div class="cay-myPage-total">
            <div>Total Reward Ticket & Discount Coupon</div>
            <div>
                <table class="cay-myPage-total-table">
                    <th> Total Reward Ticket</th>
                    <th> Total Discount Coupon</th>
                    <tr>
                        <td> ${userBirth.isBefore(today) ? 2 : 1} </td>
                        <td>
                            ${totalAdults != null || totalYouths != null || totalChildren != null ? totalAdults + totalYouths + totalChildren : 0}
                        </td>
                    </tr>
                </table>
            </div>
        </div>

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
            <div>Reward Coupon</div>
            <table class="cay-myPage-coupon-table">
                <th> Coupon</th>
                <th> Benefit</th>
                <th> Date of issuance</th>
                <c:forEach items="${reservations}" var="reservation">
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
        </div>

    </div>
</div>

</body>
</html>
