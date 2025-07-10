<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2025-07-03
  Time: 오후 7:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Title</title>
</head>
<body>

<div class="cay-myPage-content">
    <div class="cay-myPage-profile">

        <h1> Are you sure want to DELETE YOUR ACCOUNT ? </h1>
            <p> This action cannot be undone. Please check your password to verify your account. </p>

        <form action="/mypage/deleteAccount" method="post">
            ID : <input type="text" name="u_id" value="${user.u_id}">
            PASSWORD : <input name="u_pw" type="text">
            <button> DELETE </button>
        </form>

    </div>

</body>
</html>
