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
    <title>MyPage : User Information Update - Phoenix Cinema</title>
</head>
<body>

<div class="cay-myPage-content">
<div class="cay-myPage-errorMessage"> ${errorMessage} </div>
    <div class="cay-myPage-wrap">
        <div> Update Account Information </div>
        <form action="/mypage/general-info/update/submit" method="post" onsubmit="return call();">
            <div>
                <h1> Your user ID</h1>
                <input type="text" readonly name="u_id" value="${user.u_id}">
            </div>
            <div>
                <h1> Your user Password</h1>
                <input type="password"name="u_pw">
            </div>
            <div>
                <h1> Your Name</h1>
                <input type="text" name="u_name" value="${user.u_name}">
            </div>
            <div>
                <h1> Your Birth Date</h1>
                <input type="text" readonly name="u_birth_before"
                       value="<fmt:formatDate value='${user.u_birth}' pattern='yyyy-MM-dd'/>">
                <div>▼</div> <input type="date" name="u_birth">
            </div>
            <div>
                <h1> Your Address</h1>
                <input type="text" name="u_address" value="${user.u_address}">
            </div>
            <div>
                <h2> Are you sure you want  to <br> change your account information? </h2>
                <button type="submit"> Submit </button>
                <button type="button" onclick="history.back()"> Cancel </button>
            </div>
        </form>
    </div>
</div>

</body>
</html>
