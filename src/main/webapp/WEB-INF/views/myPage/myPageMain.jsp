<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>마이페이지 - Phoenix Cinema</title>
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
                    <li><a href="/mypage/theatres?u_id=${user.u_id}">Favorite Theatres</a></li>
                </ul>
            </li>
            <li><a href="/reservation/list">My Tickets</a>
                <ul>
                    <li><a href="/reservation/list">My Reservation</a></li>
                    <li><a href="/mypage/history?u_id=${user.u_id}">My History</a></li>
                </ul>
            </li>
            <li><a href="/mypage/reward?u_id=${user.u_id}">My Rewards</a>
                <ul>
                    <li><a href="/mypage/reward/point?u_id=${user.u_id}">Point</a></li>
                    <li><a href="/mypage/reward/coupon?u_id=${user.u_id}">Coupon</a></li>
                </ul>
            </li>
            <li><a href="" onclick="alert('준비 중입니다!')">Event</a>
                <ul>
                    <li><a href="" onclick="alert('준비 중입니다!')">My Events History</a></li>
                </ul>
            </li>
            <li><a href="" onclick="alert('준비 중입니다!')">Wallet</a>
                <ul>
                    <li><a href="" onclick="alert('준비 중입니다!')">Credit/Debit Cards</a></li>
                    <li><a href="" onclick="alert('준비 중입니다!')">Gift Cards</a></li>
                </ul>
            </li>
            <li><a href="/mypage/reminder?u_id=${user.u_id}">Movie Reminder</a>
                <ul>
                    <li><a href="/mypage/reminder?u_id=${user.u_id}">My Movie Reminders</a></li>
                    <li><a href="/mypage/wishlist?u_id=${user.u_id}">Wishlist</a></li>
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