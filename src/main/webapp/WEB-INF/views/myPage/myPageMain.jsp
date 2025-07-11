<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>마이페이지 - Phoenix Cinema</title>
    <link rel="stylesheet" href="/resources/css/user.css">
    <!-- header.js 사용 (login.js 대신) -->
    <script src="/resources/js/header.js"></script>
</head>
<body>

<div class="cay-main-wrap">
    <!-- 공통 헤더 사용 -->
    <jsp:include page="/WEB-INF/views/header.jsp" />

    <nav class="cay-nav"><h1>Nav</h1></nav>
    <main class="cay-myPage-container">
        <div class="cay-myPage-aside">
            <h1>aside</h1>
            <a href="/mypage"> My Page </a>
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

<!-- 디버깅용 사용자 정보 표시 -->
<div style="margin-top: 20px; padding: 15px; background-color: #f8f9fa; border-radius: 5px;">
    <h3>사용자 정보 (디버깅용)</h3>
    <p>ID: ${user.u_id}</p>
    <p>Name: ${user.u_name}</p>
    <p>Birth: ${user.u_birth}</p>
    <p>Address: ${user.u_address}</p>
</div>

</body>
</html>