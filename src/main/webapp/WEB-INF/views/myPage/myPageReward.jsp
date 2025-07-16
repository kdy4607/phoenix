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

<div class="cay-myPage-content">
    <div class="cay-myPage-wrap">
        <div> My Reward</div>
        <div class="cay-myPage-reward">
            <div>
                <div>Point&Membership</div>
                <div>
                    <div onclick="location.href='/mypage/reward/point?u_id=${user.u_id}'">
                        <span> ${(stats.adult*500) + (stats.youth*500) + (stats.child*300)} </span>
                        <div>Total Point</div>
                    </div>
                    <div onclick="location.href='/mypage/reward/point?u_id=${user.u_id}'">
                        <span>
                        <c:choose>
                            <c:when test="${(stats.adult*500) + (stats.youth*500) + (stats.child*300) ge 5000}">
                                A
                            </c:when>
                            <c:when test="${(stats.adult*500) + (stats.youth*500) + (stats.child*300) ge 3000}">
                                B
                            </c:when>
                            <c:when test="${(stats.adult*500) + (stats.youth*500) + (stats.child*300) ge 1000}">
                                C
                            </c:when>
                            <c:when test="${(stats.adult*500) + (stats.youth*500) + (stats.child*300) ge 0}">
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
                        <span> ${stats.adult != null || stats.youth != null || stats.child != null ? stats.adult + stats.youth + stats.child : 0} </span>
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
