<!-- src/main/webapp/WEB-INF/views/login.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <title>로그인</title>
</head>
<body>
<h2>로그인 페이지</h2>

<form action="/login" method="post">
  <label for="username">아이디:</label>
  <input type="text" id="username" name="username" required>
  <br><br>
  <button type="submit">로그인</button>
</form>

<c:if test="${not empty param.error}">
  <p style="color: red;">로그인 실패. 다시 시도해주세요.</p>
</c:if>

</body>
</html>
