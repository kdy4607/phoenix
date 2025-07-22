<!-- src/main/webapp/WEB-INF/views/main.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <title>메인</title>
  <link rel="icon" href="/resources/images/logo.png" type="image/png">
</head>
<body>
<h1>메인 페이지</h1>

<c:choose>
  <c:when test="${not empty sessionScope.userId}">
    <p style="color: green;">✅ 로그인 성공: ${sessionScope.userId}</p>
    <form action="/logoutx21" method="post">
      <button type="submit">로그아웃</button>
    </form>
    <form action="/countinuex21">
      <button>계속하기</button>
    </form>
  </c:when>
  <c:otherwise>
    <p style="color: red;">❌ 로그인하지 않았습니다.</p>
    <a href="/loginx21">로그인하러 가기</a>
  </c:otherwise>
</c:choose>

</body>
</html>
