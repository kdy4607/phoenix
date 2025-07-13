<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>마이페이지 - Phoenix Cinema</title>
    <link rel="stylesheet" href="/resources/css/user.css">
    <!-- header.js 사용 (login.js 대신) -->
    <script src="/resources/js/header.js"></script>
</head>
<body>

<jsp:include page="/WEB-INF/views/header.jsp" />

<button onclick="logout()"></button>

    <main class="cay-myPage-container">
        <div class="cay-myPage-aside">
            <div><a href="/mypage"> My Page </a></div>
            <ul>
                <li><a href="/mypage/profile?u_id=${user.u_id}"> Profile </a>
                    <ul>
                        <li><a href="/mypage/profile?u_id=${user.u_id}">General Info</a></li>
                        <li> Favorite Theatres</li>
                        <li> Communications</li>
                    </ul>
                </li>
                <li>My Tickets
                    <ul>
                        <li> My Reservation </li>
                        <li> My History </li>
                    </ul>
                </li>
                <li> Point & Rewards
                    <ul>
                        <li> Point</li>
                        <li> Reward Coupon</li>
                    </ul>
                </li>
                <li> Event</li>
                <li> Wallet</li>
                <li> Movie Reminder (찜)</li>
            </ul>
        </div>
        <jsp:include page="${content}"></jsp:include>
    </main>
    <footer class="cay-footer"><h1>footer</h1></footer>
</div>
<button onclick="logout()"> logout </button>
<script src="/resources/js/login.js"></script>
</body>
</html>