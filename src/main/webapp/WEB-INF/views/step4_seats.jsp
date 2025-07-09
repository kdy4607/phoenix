<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>좌석 선택</title>
    <link rel="stylesheet" href="/resources/css/stepbar.css">
</head>
<body>

<div class="container">
    <h1>좌석 선택</h1>

    <jsp:include page="/WEB-INF/views/stepbar.jsp">
        <jsp:param name="currentStep" value="${reservation.currentStep}"/>
    </jsp:include>

    <h2>선택하신 정보:</h2>
    <ul>
        <li>영화: ${reservation.title}</li>
        <li>날짜: ${reservation.reservationDate}</li>
        <li>시간: ${reservation.start_time}</li>
        <li>가격: ${reservation.price}</li>
        <%-- 예약 객체에서 필요한 다른 상세 정보 추가 --%>
    </ul>

    <p>여기에 좌석 선택 로직과 UI를 구현합니다.</p>

    <form action="/step5" method="post">
        <input type="hidden" name="movie_id" value="${reservation.movie_id}"/>
        <input type="hidden" name="schedule_id" value="${reservation.schedule_id}"/>
        <input type="hidden" name="reservationDate" value="${reservation.reservationDate}"/>
        <%-- 여기에 선택된 좌석에 대한 input 추가 --%>

        <button type="submit">다음</button>
    </form>
</div>

</body>
</html>