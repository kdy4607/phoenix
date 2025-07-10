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
        <div> Your Account Information </div>
        <form action="/mypage/general-info/update" method="post">
            <input type="hidden" value="${user.u_id}" name="u_id">
            <div>
                <div> Your user Nickname</div>
                <input type="text" name="u_id" readonly value="${user.u_id}">
            </div>
            <div>
                <div> Your user Password</div>
                <input type="text" name="u_pw" readonly value="${sessionScope.user.u_pw}">
            </div>
            <div>
                <div> Your Name</div>
                <input type="text" readonly name="u_name" value="${sessionScope.user.u_name}">
            </div>
            <div>
                <div> Your Birth Date</div>
                <input type="text" readonly name="u_birth"
                       value="<fmt:formatDate value='${sessionScope.user.u_birth}' pattern='yyyy-MM-dd'/>">
            </div>
            <div>
                <div> Your Address</div>
                <input type="text" readonly name="u_address" value="${sessionScope.user.u_address}">
            </div>
            <div>
                <button> Update Account Information </button>
            </div>
        </form>
        <form action="/mypage/DeleteAccount">
            <input type="text" name="u_id" value="${sessionScope.user.u_id}"/>
            <button> Delete account </button>
        </form>
    </div>
</div>

</body>
</html>
