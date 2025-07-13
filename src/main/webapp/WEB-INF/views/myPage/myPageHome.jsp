<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2025-07-03
  Time: 오후 7:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>

<div class="cay-myPage-content">
  <h1>content</h1>
  <div class="cay-myPage-Home">
    <div class="cay-myPage-profile">
      <img src="" alt="">
      <p> Dummy data </p>
    </div>
    <div class="cay-myPage-coupon">
      <h1>My coupon</h1>
      <div> Discount Coupon</div>
      <div> My Movie Ticket</div>
    </div>
    <div class="cay-myPage-point">
      <h1>My Point</h1>
      <div> 0,000 p</div>
    </div>
    <div class="cay-myPage-theatre">
      <h1>My Favorite theatre</h1>
      <%-- JSTL 로 반복문 사용 --%>
      <span> A </span>
    </div>
  </div>
  <div class="cay-myPage-myInfo">
    <div class="cay-myPage-history">
        <h1>My History</h1>
      <a href="">
        <span> Num </span>
        <div> Watched Movie </div>
      </a>
      <a href="">
        <span> Num </span>
        <div> Review </div>
      </a>
      <a href="">
        <span> Num </span>
        <div> Wishlist </div>
      </a>
    </div>
    <div class="cay-myPage-favorite">
        <h1>Favorite Genre</h1>
      <a href="">
        <%-- JSTL 로 반복문 사용 --%>
        <span> genre tag </span>
          <span> dummy </span>
          <span> dummy </span>
          <span> dummy </span>
          <span> dummy </span>
          <span> dummy </span>
      </a>
    </div>
    <div class="cay-myPage-order">
      <h1>My Order History</h1>
      <%-- JSTL 로 반복문 사용 --%>
      <span> Your recent reservation details do not exist.  </span>
    </div>
    <div class="cay-myPage-event">
      <h1>My Event History</h1>
      <%-- JSTL 로 반복문 사용 --%>
      <span> No events participated.  </span>
    </div>
  </div>

</body>
</html>
