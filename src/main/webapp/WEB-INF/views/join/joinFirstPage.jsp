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
        <div> Step <span>1</span></div>
        <div> Step 2</div>
        <div> Step 3</div>
    </div>
    <div class="cay-join-process-bar">
        <div> 1 </div>
        <div> - </div>
        <div> 1 </div>
        <div> - </div>
        <div> 1 </div>
    </div>
    <div class="cay-join-process-txt">
        <div> Enter User ID And Password</div>
        <div> Enter User Information</div>
        <div> Join Us !</div>
    </div>
</div>

<form  class="cay-join-wrap" action="/join/step2" method="post">
    <div> Create Account </div>
    <div> Enter Your New User Nickname </div>
    <div> It will be used when you sign in</div>
    <input type="text" name="u_id">
    <div> Enter Your New Password </div>
    <input type="text" name="u_pw">
    <div> Password must be at least <span> 0 </span> characters </div>
    <div> Re-enter Your Password </div>
    <input type="text">
    <div>
        <button> Next !</button>
    </div>
</form>

</div>


</div>

</body>
</html>