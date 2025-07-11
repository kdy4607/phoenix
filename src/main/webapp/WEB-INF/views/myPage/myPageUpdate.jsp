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
        <div> Update Account Information </div>
        <form action="/mypage/general-info/update/submit" method="post">
            <div>
                <input type="hidden" name="u_id" value="${user.u_id}">
                <div> Your user Nickname</div>
                <input type="text" readonly name="u_id" value="${user.u_id}">
            </div>
            <div>
                <div> Your user Password</div>
                <input type="text"name="u_pw" value="${user.u_pw}">
            </div>
            <div>
                <div> Your Name</div>
                <input type="text" name="u_name" value="${user.u_name}">
            </div>
            <div>
                <div> Your Birth Date</div>
                <input type="text" readonly name="u_birth_before"
                       value="<fmt:formatDate value='${user.u_birth}' pattern='yyyy-MM-dd'/>">
                ▶ <input type="date" name="u_birth">
            </div>
            <div>
                <div> Your Address</div>
                <input type="text" name="u_address" value="${user.u_address}">
            </div>
            <div>
                <div> Are you sure you want to change your account information? </div>
                <button> Submit </button>
                <button type="button" onclick="history.back()"> Cancel </button>
            </div>
        </form>
    </div>
</div>

</body>
</html>
