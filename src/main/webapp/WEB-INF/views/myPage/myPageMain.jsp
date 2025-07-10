<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2025-07-03
  Time: 오후 6:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="/resources/css/user.css">
    <script src="/resources/js/login.js"></script>
</head>
<body>

<div class="cay-main-wrap">
    <header class="cay-header">
        <h1>header</h1>
        <a href="/main"> Main </a>
        <a href="/mypage"> MyPage </a>
        <a onclick="logout()"> logout </a>
    </header>
    <nav class="cay-nav"><h1>Nav</h1></nav>
    <main class="cay-myPage-container">
        <div class="cay-myPage-aside">
            <h1>aside</h1>
            <a href="/mypage"> My Page </a>
            <ul>
                <li>  <a href="/mypage/profile?u_id=${user.u_id}"> Profile </a>
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
                <%-- 필요한가? --%>
                <li> Event</li>
                <%-- 결제 시스템을 구현할 것인가? --%>
                <li> Wallet</li>
                <%-- 회원 정보에 포함 시킬 것인가? --%>
                <li> Movie Reminder (찜)</li>
            </ul>
        </div>
        <jsp:include page="${content}"></jsp:include>
    </main>
    <footer class="cay-footer"><h1>footer</h1></footer>
</div>
<h1> id : ${user.u_id} </h1>
<h1> pw : ${user.u_pw} </h1>
<h1> u_name : ${user.u_name} </h1>
<h1> u_birth : ${user.u_birth} </h1>
<h1> u_address : ${user.u_address} </h1>

</body>
</html>
