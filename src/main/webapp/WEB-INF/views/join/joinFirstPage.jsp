<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Join : Step 1 - Phoenix Cinema</title>
</head>
<body>

<h1> Join Us </h1>

<div class="cay-join-process">
    <div class="cay-join-process-step">
        <div> Step <span style="color: ${fontColor}">1</span></div>
        <div> Step 2</div>
        <div> Step 3</div>
    </div>
    <div class="cay-join-process-bar">
        <div style="background-color: ${color}"> ㅤ</div>
        <%-- 공백 문자 있음, 지우지 말 것 --%>
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
    <div>${errorMessage}</div>
    <div> Create Account</div>
    <div>
        <div> Enter Your New User ID</div>
        <input type="text" name="u_id" placeholder="Enter User ID">
        <div> ※ User ID must be between <span>6</span> and <span>20</span> characters.</div>
        <div> ※ Must contain uppercase letters and lowercase letters. </div>
        <div> ※ Usable letters uppercase and lowercase, numbers, and special symbols. <br> (@_.)</div>
    </div>
    <div>
        <div> Enter Your New Password</div>
        <input type="password" name="u_pw" placeholder="Enter Password">
        <div> ※ Password must be <span>8-100</span> characters long.</div>
        <div> ※ Must contain letters uppercase and lowercase, numbers, and special symbols. <br>(!@#$%^&*-_+=)</div>
    </div>
    <div>
        <div> Re-enter Your Password</div>
        <input type="password" name="u_ReEntered_pw" placeholder="Re-enter Password">
        <div> ※ Enter your password one more time. </div>
    </div>
    <div>
        <button type="submit"> Next !</button>
    </div>
</form>

</body>
</html>