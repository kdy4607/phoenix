<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Join : Step 2 - Phoenix Cinema</title>
</head>
<body>

<h1> Join Us </h1>

<div class="cay-join-process">
    <div class="cay-join-process-step">
        <div> Step 1</div>
        <div> Step <span style="color: ${fontColor}">2</span></div>
        <div> Step 3</div>
    </div>
    <div class="cay-join-process-bar">
        <%-- 공백 문자 있음, 지우지 말 것 --%>
        <div> ㅤ</div>
        <div> ㅤ</div>
        <div style="background-color: ${color}"> ㅤ</div>
        <div> ㅤ</div>
        <div> ㅤ</div>
    </div>
    <div class="cay-join-process-txt">
        <div> Enter User ID And Password</div>
        <div> Enter User Information</div>
        <div> Join Us !</div>
    </div>
</div>

<form class="cay-join-wrap" action="/join/step3" method="post" onsubmit="return call();">
    <div> ${errorMessage} </div>
    <div> Create Account</div>
    <div>
        <input type="hidden" name="u_id" value="${loginVO.u_id}">
        <input type="hidden" name="u_pw" value="${loginVO.u_pw}">
    </div>
    <div>
        <div> Your Name</div>
        <input type="text" name="u_name">
        <div> ※ Name must be <span>2-50</span> characters long. </div>
        <div> ※ Usable English letter or Korean letter. </div>
    </div>
    <div>
        <div> Your Birth Date</div>
        <input type="date" name="u_birth">
        <div> ※ It's not a requirement. </div>
    </div>
    <div>
        <div> Your Address</div>
        <input type="text" name="u_address">
        <div> ※ It's not a requirement. </div>
        <div> ※ Address can't be more than 500 characters. </div>
    </div>
    <div>
        <button type="submit"> Next !</button>
    </div>
</form>
</div>


</div>
<script src="/resources/js/login.js"></script>
</body>
</html>