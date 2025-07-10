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
    <div class="cay-myPage-profile">
        <div> Check Your Account</div>
        <form action="/mypage/general-info" method="post">
            <div> Enter Your Password to identify your Account</div>
            <input type="hidden" name="u_id" value="${u_id}" />
            <div> Nickname : <input readonly value="${user.u_id}"> </div>
            <div> Password : <input type="text" name="u_pw"> </div>
            <button> Verify </button>
        </form>
    </div>
</div>

</body>
</html>
