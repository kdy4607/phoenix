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
    <title>MyPage : Withdraw Membership - Phoenix Cinema</title>
</head>
<body>

<div class="cay-myPage-content">
    <div class="cay-myPage-wrap">
        <div>Are you sure want to <br> DELETE YOUR ACCOUNT ?</div>
        <form action="/mypage/deleteAccount" method="post">
            <div class="cay-myPage-errorMessage">${errorMessage}</div>
            <div>
                <h3>Your User ID</h3>
                <input readonly type="text" placeholder="ID" name="u_id" value="${user.u_id}">
                <h3>Please Enter Your Password</h3>
                <input type="password" placeholder="password" name="u_pw">
            </div>
            <div>
                <p>
                    This action cannot be undone. <br>
                    Please check your password to verify your account.
                </p>
                <div>
                    <input name="agree" type="checkbox" class="chk-btn"/> I Agree to Delete Account
                </div>
                <button> DELETE</button>
            </div>
        </form>
    </div>
</div>

</body>
</html>
