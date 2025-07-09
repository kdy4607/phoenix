<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
  <title>상영 시간표</title>
</head>
<body>
<c:if test="${empty runtimes}">
  <p>선택하신 날짜와 영화관에는 상영 시간이 없습니다.</p>
</c:if>
<c:if test="${not empty runtimes}">
  <table>
    <thead>
    <tr>
      <th>영화 제목</th>
      <th>시작 시간</th>
      <th>가격</th>
      <th>잔여 좌석</th>
      <th>선택</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="rt" items="${runtimes}">
      <tr>
        <td>${rt.movie_title}</td>
        <td>${rt.start_time}</td>
        <td>${rt.price}</td>
        <td>${rt.available_seats} / ${rt.total_seats}</td>
        <td>
          <input type="radio" name="schedule_id" value="${rt.runtime_id}" required />
        </td>
      </tr>
    </c:forEach>
    </tbody>
  </table>
</c:if>
</body>
</html>