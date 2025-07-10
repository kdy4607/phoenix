<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>좌석 선택</title>
    <link rel="stylesheet" href="/resources/css/stepbar.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            text-align: center;
        }

        .container {
            margin: 20px auto;
            width: 80%; /* 필요에 따라 너비 조정 */
            max-width: 600px; /* 너무 넓어지지 않도록 최대 너비 설정 */
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.1);
        }

        .screen {
            background-color: #4CAF50; /* 스크린 색상 변경 */
            color: white;
            height: 70px;
            width: 90%; /* 스크린 너비 조정 */
            margin: 15px auto; /* 중앙 정렬 */
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            border-radius: 5px;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
        }
        .row {
            display: flex;
            justify-content: center;
            margin-bottom: 5px; /* 좌석 줄 간격 */
        }
        .seat {
            background-color: #444451;
            color: #fff; /* 좌석 번호가 보이지 않아서 추가 */
            font-size: 12px; /* 좌석 번호 폰트 크기 조정 */
            display: flex; /* 좌석 번호 중앙 정렬을 위해 */
            align-items: center; /* 좌석 번호 수직 중앙 정렬 */
            justify-content: center; /* 좌석 번호 수평 중앙 정렬 */
            height: 30px;
            width: 30px;
            margin: 3px; /* 좌석 간격 줄임 */
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.2s ease; /* 부드러운 색상 변화 */
        }
        .seat.selected {
            background-color: #6feaf6;
            color: #333; /* 선택된 좌석 글자색 */
        }
        .seat.occupied {
            background-color: #ccc; /* 점유된 좌석 색상 변경 */
            color: #888; /* 점유된 좌석 글자색 */
            cursor: not-allowed;
        }
        .text {
            margin-top: 15px;
            font-size: 16px;
        }
        .info-summary {
            background-color: #e9e9e9;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        button[type="submit"] {
            margin-top: 20px;
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
        }
        button[type="submit"]:hover {
            background-color: #0056b3;
        }
        button[type="submit"]:disabled {
            background-color: #cccccc;
            cursor: not-allowed;
        }
    </style>
</head>
<body>

<div class="container">

    <h1>좌석 선택</h1>

    <jsp:include page="/WEB-INF/views/stepbar.jsp">
        <jsp:param name="currentStep" value="${reservation.currentStep}"/>
    </jsp:include>

    <div class="info-summary">
        <h2>선택하신 정보:</h2>
        <ul style="text-align: left;">
            <li>영화: ${reservation.title}</li>
            <li>날짜: ${reservation.reservationDate}</li>
            <li>상영관: ${reservation.theaterName}</li>
            <li>시간: ${reservation.start_time}</li>
            <li>잔여 좌석: ${reservation.available_seats}석</li>
            <li>가격: ${reservation.price}원</li>
        </ul>
    </div>

    <div class="screen">스크린</div>

    <c:set var="prevSeatRow" value=""/>
    <c:forEach var="seat" items="${seatList}" varStatus="status">
        <%-- 새로운 행이 시작될 때 이전 행을 닫고 새로운 행을 엽니다. --%>
    <c:if test="${seat.seat_row != prevSeatRow}">
    <c:if test="${not status.first}">
</div> <%-- 이전 div.row 닫기 --%>
</c:if>
<div class="row"> <%-- 새로운 div.row 열기 --%>
    <c:set var="prevSeatRow" value="${seat.seat_row}"/>
    </c:if>

    <div class="seat ${seat.status == '사용불가' ? 'occupied' : ''} ${seat.status == '예매완료' ? 'occupied' : ''}"
         data-seat-id="${seat.seat_id}"
         data-row="${seat.seat_row}"
         data-number="${seat.seat_number}">
            ${seat.seat_number}
    </div>

        <%-- 루프의 마지막 요소이거나 다음 좌석의 행이 다를 경우 현재 행을 닫습니다. --%>
    <c:if test="${status.last}">
</div> <%-- 마지막 div.row 닫기 --%>
</c:if>
</c:forEach>
<p class="text">
    선택된 좌석 수: <span id="count">0</span>
</p>

<form action="/step5" method="post" id="seatForm">
    <input type="hidden" name="movie_id" value="${reservation.movie_id}"/>
    <input type="hidden" name="schedule_id" value="${reservation.scheduleId}"/>
    <input type="hidden" name="reservationDate" value="${reservation.reservationDate}"/>
    <input type="hidden" name="selectedSeats" id="selectedSeats" value=""/>
    <button type="submit" id="submitButton" disabled>다음</button>
</form>

</div>

<script>
    const seatContainer = document.querySelector('.container');
    const selectedSeatsInput = document.getElementById('selectedSeats');
    const countDisplay = document.getElementById('count');
    const submitButton = document.getElementById('submitButton');

    let selectedSeatIds = [];

    function updateSelectedCount() {
        const selectedSeatsElements = seatContainer.querySelectorAll('.seat.selected');
        countDisplay.innerText = selectedSeatsElements.length;

        selectedSeatIds = Array.from(selectedSeatsElements).map(seat => seat.dataset.seatId);
        selectedSeatsInput.value = selectedSeatIds.join(',');

        submitButton.disabled = selectedSeatIds.length === 0;
    }

    seatContainer.addEventListener('click', e => {
        if (e.target.classList.contains('seat') && !e.target.classList.contains('occupied')) {
            e.target.classList.toggle('selected');
            updateSelectedCount();
        }
    });

    updateSelectedCount();
</script>

</body>
</html>