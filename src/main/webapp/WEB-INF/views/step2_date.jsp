<%-- /WEB-INF/views/step2_date_select.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>날짜 선택</title>
    <link rel="stylesheet" href="/resources/css/stepbar.css">
</head>
<body>
<div class="container">

    <div class="top-section">
        <h1>영화 예매</h1>
        <jsp:include page="/WEB-INF/views/stepbar.jsp">
            <jsp:param name="currentStep" value="${reservation.currentStep}"/>
        </jsp:include>
    </div>


    <div>
        <h2>2. 날짜 선택</h2>
        <form action="/step3" method="post">
                <input type="hidden" name="movie_id" value="${reservation.movie_id}"> <!-- ✅ 여기에 값 들어오는지 확인 -->
                <input type="hidden" name="title" value="${reservation.title}">

            <label for="reservationDate">날짜 선택</label>
            <input type="date" id="reservationDate" name="reservationDate" required>
            <div>
                <button type="submit">다음</button>
            </div>
        </form>
    </div>
</div>

</body>
</html>