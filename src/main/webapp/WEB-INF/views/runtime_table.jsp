<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:choose>
  <c:when test="${not empty runtimes}">
    <table>
      <tr>
        <th>영화 제목</th>
        <th>시작 시간</th>
        <th>가격</th>
        <th>잔여 좌석</th>
        <th>선택</th>
      </tr>
      <c:forEach var="rt" items="${runtimes}">
        <tr>
          <td>${rt.movie_title}</td>
          <td>${rt.start_time}</td>
          <td>${rt.price}</td>
          <td>${rt.available_seats} / ${rt.total_seats}</td>
          <td><input type="radio" name="schedule_id" value="${rt.runtime_id}" required/></td>
        </tr>
      </c:forEach>
    </table>
  </c:when>
  <c:otherwise>
    <p>해당 상영관에는 선택한 날짜의 상영 시간이 없습니다.</p>
  </c:otherwise>
</c:choose>