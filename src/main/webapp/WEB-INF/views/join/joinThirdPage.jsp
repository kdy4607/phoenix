<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Join : Step 3 - Phoenix Cinema</title>
</head>
<body>

<h1> Join Us </h1>

<div class="cay-join-process">
    <div class="cay-join-process-step">
        <div> Step <span>1</span></div>
        <div> Step 2</div>
        <div> Step <span style="color: ${fontColor}">3</span></div>
    </div>
    <div class="cay-join-process-bar">
        <%-- 공백 문자 있음, 지우지 말 것 --%>
        <div> ㅤ</div>
        <div> ㅤ</div>
        <div> ㅤ</div>
        <div> ㅤ</div>
        <div style="background-color: ${color}"> ㅤ</div>
    </div>
    <div class="cay-join-process-txt">
        <div> Enter User ID And Password</div>
        <div> Enter User Information</div>
        <div> Join Us !</div>
    </div>
</div>

<form class="cay-join-wrap" action="/join/complete" method="post" onsubmit="return call();">
    <div> ${errorMessage} </div>
    <div> Join Us !</div>
    <div>
        <div> Your User ID</div>
        <input type="text" readonly name="u_id" value="${loginVO.u_id}">
    </div>
    <div>
        <div> Your password </div>
        <input type="text" name="u_pw" readonly value="${loginVO.u_pw}">
    </div>
    <div>
        <div> Your Name</div>
        <input type="text" readonly name="u_name" value="${loginVO.u_name}">
    </div>
    <div>
        <div> Your Birth Date</div>
        <input type="text" readonly name="u_birth"
               value="<fmt:formatDate value='${loginVO.u_birth}' pattern='yyyy-MM-dd'/>">
    </div>
    <div>
        <div> Your Address</div>
        <input type="text" readonly name="u_address" value="${loginVO.u_address}">
    </div>
    <div>
        <button type="submit"> Next !</button>
    </div>
</form>
</div>


</div>

</body>
</html>