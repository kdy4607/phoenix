<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>My Page - Phoenix Cinema</title>
    <link rel="stylesheet" href="/resources/css/user.css">
    <!-- header.js 사용 (login.js 대신) -->
    <script src="/resources/js/header.js"></script>
</head>
<body>

<jsp:include page="/WEB-INF/views/header.jsp"/>

<button onclick="logout()"></button>

<main class="cay-myPage-container">
    <div class="cay-myPage-aside">
        <div><a href="/mypage"> My Page </a></div>
        <ul>
            <li><a href="/mypage/profile?u_id=${user.u_id}"> Profile </a>
                <ul>
                    <li><a href="/mypage/profile?u_id=${user.u_id}">General Info</a></li>
                </ul>
            </li>
            <li><a href="/mypage/history?u_id=${user.u_id}">My History</a>
                <ul>
                    <li><a href="/reservation/list">My Reservation</a></li>
                    <li><a href="/mypage/history?u_id=${user.u_id}">My Movie History</a></li>
                    <li><a href="/mypage/event?u_id=${user.u_id}">My Events History</a></li>
                </ul>
            </li>
            <li><a href="/mypage/reward?u_id=${user.u_id}">My Rewards</a>
                <ul>
                    <li><a href="/mypage/reward/point?u_id=${user.u_id}">Point&Membership</a></li>
                    <li><a href="/mypage/reward/coupon?u_id=${user.u_id}">Ticket&Coupon</a></li>
                </ul>
            </li>
            <li><a href="" onclick="alert('🤞 In ready !')">Wallet</a>
                <ul>
                    <li><a href="" onclick="alert('🤞 In ready !')">Credit/Debit Cards</a></li>
                    <li><a href="" onclick="alert('🤞 In ready !')">Gift Cards</a></li>
                </ul>
            </li>
        </ul>
    </div>
    <jsp:include page="${content}"></jsp:include>
</main>
<footer class="cay-footer">
    © 2025 Phoenix Cinema. All rights reserved.
</footer>
<script src="/resources/js/login.js"></script>
</body>
</html>