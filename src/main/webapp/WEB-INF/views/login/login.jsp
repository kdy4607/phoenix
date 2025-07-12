<%@ page language="java" contentType="text/html; charset=utf-8"
pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Document</title>
    <link rel="stylesheet" href="/resources/css/user.css" />
    <script src="/resources/js/login.js"></script>
  </head>
  <body>
    <jsp:include page="/WEB-INF/views/header.jsp" />

    <div class="cay-main-wrap">
      <main class="cay-login-container">
        <div class="cay-login-content">
          <form class="cay-login-wrap" action="/mypage" method="post">
            <div class="error-message">${errorMessage}</div>
            <h2>
              Sign in
              <div>or</div>
              Creat Account !
            </h2>
            <div class="cay-login-section">
              <div class="cay-login-col1">
                <input type="text" placeholder="ID" name="u_id" required />
              </div>
              <div class="cay-login-col1">
                <!-- password 타입으로 변경 -->
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
