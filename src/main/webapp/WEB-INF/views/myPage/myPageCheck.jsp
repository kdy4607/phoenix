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
    <title>MyPage : User Information Update Check - Phoenix Cinema</title>
</head>
<body>

<div class="cay-myPage-content">
    <div class="cay-myPage-wrap">
        <div> Your Account Information  is <br> Successfully Updated ! </div>
        <form action="/mypage">
            <div>
                <h1> Your user ID</h1>
                <input type="text" readonly name="u_id" value="${sessionScope.user.u_id}">
            </div>
            <div>
                <h1> Your Password </h1>
                <input type="text" readonly name="u_pw" value="${sessionScope.user.u_pw}">
            </div>
            <div>
                <h1> Your Name</h1>
                <input type="text" readonly name="u_name" value="${sessionScope.user.u_name}">
            </div>
            <div>
                <h1> Your Birth Date</h1>
                <input type="text" readonly name="u_birth"
                       value="<fmt:formatDate value='${sessionScope.user.u_birth}' pattern='yyyy-MM-dd'/>">
            </div>
            <div>
                <h1> Your Address</h1>
                <input type="text" readonly name="u_address" value="${sessionScope.user.u_address}">
            </div>
            <div>
                <button> Go To My Page Home </button>
            </div>
        </form>
    </div>
</div>

</body>
</html>
