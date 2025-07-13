<%@ page language="java" contentType="text/html; charset=utf-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Phoenix Cinema - Login</title>
  <link rel="stylesheet" href="/resources/css/user.css" />
  <script src="/resources/js/login.js"></script>
</head>
<body>
<jsp:include page="/WEB-INF/views/header.jsp" />

<div class="cay-main-wrap">
  <main class="cay-login-container">
    <div class="cay-login-content">
      <!-- action을 /login으로 수정 -->
      <form class="cay-login-wrap" action="/login" method="post">
        <!-- returnUrl이 있으면 hidden input으로 전달 -->
        <c:if test="${not empty returnUrl}">
          <input type="hidden" name="returnUrl" value="${returnUrl}" />
        </c:if>

        <!-- 에러 메시지 표시 -->
        <c:if test="${not empty errorMessage}">
          <div class="error-message">${errorMessage}</div>
        </c:if>

        <h2>
          Sign in
          <div>or</div>
          Create Account !
        </h2>

        <div class="cay-login-section">
          <div class="cay-login-col1">
            <input type="text" placeholder="ID" name="u_id" required />
          </div>
          <div class="cay-login-col1">
            <input
                    type="password"
                    placeholder="Password"
                    name="u_pw"
                    required
            />
          </div>
        </div>

        <div class="cay-login-col2">
          <button type="submit">Sign in</button>
          <button type="button" onclick="location.href='/join/step1'">
            Create Account
          </button>
        </div>

        <a href="">Need help?</a>
      </form>
    </div>
  </main>
  <footer class="cay-footer">
    © 2025 Phoenix Cinema. All rights reserved.
  </footer>
</div>
</body>
</html>