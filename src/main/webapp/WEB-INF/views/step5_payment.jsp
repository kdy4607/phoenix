<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
    <title>결제 페이지</title>
    <link rel="stylesheet" href="/resources/css/stepbar.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            text-align: center;
        }
        .container {
            margin: 20px auto;
            width: 600px;
            background: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .info-list {
            list-style: none;
            padding: 0;
            text-align: left;
        }
        .info-list li {
            margin: 10px 0;
        }
        .payment-box {
            margin-top: 30px;
            text-align: center;
        }
        .btn-pay {
            padding: 10px 20px;
            font-size: 18px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .btn-pay:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>결제 정보 확인</h1>

    <jsp:include page="/WEB-INF/views/stepbar.jsp">
        <jsp:param name="currentStep" value="5"/>
    </jsp:include>

    <h2>선택하신 정보:</h2>
    <ul>
        <li><strong>영화:</strong> ${reservation.title}</li>
        <li><strong>상영관:</strong> ${reservation.theaterName}</li>
        <li><strong>날짜:</strong> ${reservation.reservationDate}</li>
        <li><strong>시간:</strong> ${reservation.start_time}</li>

        <li><strong>좌석:</strong>
            <c:forEach var="seat" items="${selectedSeats}">
                ${seat.seat_label}
                <c:if test="${!fn:contains(selectedSeats[selectedSeats.size()-1].seat_label, seat.seat_label)}">, </c:if>
            </c:forEach>
        </li>

        <li><strong>가격:</strong> ${totalPrice}원</li>
    </ul>

    <form action="/completeReservation" method="post">
        <input type="hidden" name="movie_id" value="${reservation.movie_id}"/>
        <input type="hidden" name="schedule_id" value="${reservation.scheduleId}"/>
        <input type="hidden" name="reservationDate" value="${reservation.reservationDate}"/>
        <input type="hidden" name="selectedSeats" value="${selectedSeats}"/>

        <div class="payment-box">
            <h3>결제 수단 선택</h3>
            <select name="paymentMethod" required>
                <option value="">-- 결제 수단 선택 --</option>
                <option value="credit">신용카드</option>
                <option value="kakaopay">카카오페이</option>
                <option value="naverpay">네이버페이</option>
            </select>
            <br><br>
            <button type="submit" class="btn-pay">결제하기</button>
        </div>
    </form>
</div>
</body>
</html>
