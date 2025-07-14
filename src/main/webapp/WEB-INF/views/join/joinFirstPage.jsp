<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Document</title>
</head>
<body>

<div class="cay-join-process">
    <div class="cay-join-process-step">
        <div> Step <span style="color: ${fontColor}">1</span></div>
        <div> Step 2</div>
        <div> Step 3</div>
    </div>
    <div class="cay-join-process-bar">
        <div style="background-color: ${color}"> ㅤ</div> <%-- 공백 문자 있음, 지우지 말 것 --%>
        <div> ㅤ</div>
        <div> ㅤ</div>
        <div> ㅤ</div>
        <div> ㅤ</div>
    </div>
    <div class="cay-join-process-txt">
        <div> Enter User ID And Password</div>
        <div> Enter User Information</div>
        <div> Join Us !</div>
    </div>
</div>

<form class="cay-join-wrap" action="/join/step2" method="post" onsubmit="return call();">
    <div>error${errorMessage}</div>
    <div> Create Account</div>
    <div> Enter Your New User ID</div>
    <input type="text" name="u_id" placeholder="Enter User ID">
    <div> User ID must be 6-20 characters long, containing only lowercase letters and numbers</div>
    <div> Enter Your New Password</div>
    <input type="password" name="u_pw" placeholder="Enter Password">
    <div> Password must be at least <span> 0 </span> characters</div>
    <div> Re-enter Your Password</div>
    <input type="password" name="u_ReEntered_pw" placeholder="Re-enter Password">
    <div>
        <button type="submit"> Next !</button>
    </div>
</form>

</body>
</html>