<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>시간 및 극장 선택</title>
    <link rel="stylesheet" href="/resources/css/sample.css">
</head>
<body>
<div class="container">
    <h1>영화 예매</h1>
    <jsp:include page="/WEB-INF/views/stepbar.jsp">
        <jsp:param name="currentStep" value="${reservation.currentStep}"/>
    </jsp:include>

    <h2>3. 시간 및 극장 선택</h2>
    <form action="/step4" method="post">
        <p>선택한 영화: <span>${reservation.movieTitle}</span></p>
        <p>선택한 날짜: <span>${reservation.reservationDate}</span></p>

        <input type="hidden" name="movieId" value="${reservation.movieId}">
        <input type="hidden" name="movieTitle" value="${reservation.movieTitle}">
        <input type="hidden" name="reservationDate" value="${reservation.reservationDate}">

        <label for="schedule">상영 시간 선택:</label>
        <select name="scheduleId" id="schedule" required>
            <option value="">상영 시간을 선택하세요</option>
            <c:forEach var="schedule" items="${schedules}">
                <option value="${schedule.scheduleId}">
                        ${schedule.startTime} - ${schedule.theaterName} (${schedule.availableSeats}석)
                </option>
            </c:forEach>
        </select>

        <button type="submit">다음</button>
    </form>
</div>
</body>
</html>