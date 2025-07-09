<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>영화 좌석 선택</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
            text-align: center;
        }

        .container {
            margin: 20px auto;
            width: 350px; /* 컨테이너 너비 조정 */
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .screen {
            background-color: #777; /* 스크린 색상 변경 */
            color: #fff;
            height: 50px; /* 스크린 높이 조정 */
            width: 90%;
            margin: 20px auto;
            border-radius: 5px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.2em;
            font-weight: bold;
        }

        .seat-map {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 5px; /* 좌석 행 간 간격 */
        }

        .seat-row {
            display: flex;
            justify-content: center;
            gap: 5px; /* 좌석 간 간격 */
        }

        .seat {
            width: 40px; /* 좌석 크기 조정 */
            height: 40px;
            background-color: #b0c4de; /* 기본 좌석 색상 */
            border-radius: 5px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.9em;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.2s ease;
            color: #333;
            border: 1px solid #9fb8d1;
        }

        .seat.selected {
            background-color: #6feaf6; /* 선택된 좌석 색상 */
            border-color: #4dd5e4;
        }

        .seat.occupied {
            background-color: #ffcccc; /* 예약된 좌석 색상 */
            cursor: not-allowed;
            color: #777;
            text-decoration: line-through;
            border-color: #ff9999;
        }

        .seat:not(.occupied):hover {
            opacity: 0.8;
        }

        .movie-info, .summary {
            margin-top: 20px;
            font-size: 1.1em;
            text-align: left;
            padding: 0 10px;
        }

        .movie-info p, .summary p {
            margin: 8px 0;
            color: #555;
        }

        .movie-info span, .summary span {
            font-weight: bold;
            color: #333;
        }

        #nextButton {
            background-color: #007bff;
            color: white;
            padding: 12px 25px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1.1em;
            margin-top: 30px;
            transition: background-color 0.3s ease;
            width: 100%;
            max-width: 200px;
            display: block;
            margin-left: auto;
            margin-right: auto;
        }

        #nextButton:hover:not(:disabled) {
            background-color: #0056b3;
        }

        #nextButton:disabled {
            background-color: #cccccc;
            cursor: not-allowed;
        }

        /* 반응형 */
        @media (max-width: 480px) {
            .container {
                width: 95%;
                margin: 10px auto;
                padding: 15px;
            }
            .seat {
                width: 35px;
                height: 35px;
                font-size: 0.8em;
            }
            .movie-info, .summary {
                font-size: 1em;
            }
            #nextButton {
                padding: 10px 20px;
                font-size: 1em;
            }
        }
    </style>
</head>
<body>

<div class="container">
    <h1>영화 예매</h1>

    <jsp:include page="/WEB-INF/views/stepbar.jsp">
        <jsp:param name="currentStep" value="${reservation.currentStep}"/>
    </jsp:include>

    <div class="movie-info">
        <p>선택한 영화: <span id="movieTitleDisplay">${reservation.movieTitle}</span></p>
        <p>선택한 날짜: <span id="reservationDateDisplay">${reservation.reservationDate}</span></p>
        <p>선택한 시간: <span id="startTimeDisplay">${reservation.startTime}</span> (<span id="theaterNameDisplay">${reservation.theaterName}</span>)</p>
    </div>

    <div class="screen">SCREEN</div>

    <h3>좌석 배치도</h3>
    <div class="seat-map" id="seatMap">
        <%-- 백엔드에서 전달된 availableSeats 데이터를 사용하여 좌석을 동적으로 렌더링 --%>
        <c:set var="currentSeats" value="${availableSeats}" />
        <c:set var="lastRowChar" value="" />
        <c:forEach var="seat" items="${currentSeats}">
        <c:set var="rowChar" value="${seat.seatNumber.substring(0,1)}" />
        <c:if test="${rowChar ne lastRowChar}">
        <c:if test="${lastRowChar ne ''}"></div></c:if>
    <div class="seat-row">
        </c:if>
        <div class="seat ${seat.available ? '' : 'occupied'}"
             data-seat-id="${seat.seatId}"
             data-seat-number="${seat.seatNumber}">
                ${seat.seatNumber}
        </div>
        <c:set var="lastRowChar" value="${rowChar}" />
        </c:forEach>
        <c:if test="${lastRowChar ne ''}"></div></c:if>
</div>

<div class="summary">
    <p>선택된 좌석: <span id="selectedSeatsDisplay">선택된 좌석 없음</span></p>
    <p>총 인원: <span id="selectedSeatsCount">0</span>명</p>
</div>

<form id="bookingForm" action="/step5" method="post">
    <input type="hidden" name="scheduleId" id="scheduleIdInput" value="${reservation.scheduleId}">
    <input type="hidden" name="movieId" value="${reservation.movieId}">
    <input type="hidden" name="reservationDate" value="${reservation.reservationDate}">
    <%-- StepBarVO에 있는 다른 정보도 필요하다면 hidden 필드로 전달 --%>
    <input type="hidden" name="selectedSeatIds" id="selectedSeatIdsInput">
    <button type="submit" id="nextButton" disabled>다음 단계</button>
</form>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const seatMapElement = document.getElementById('seatMap');
        const selectedSeatsDisplay = document.getElementById('selectedSeatsDisplay');
        const selectedSeatsCount = document.getElementById('selectedSeatsCount');
        const nextButton = document.getElementById('nextButton');
        const selectedSeatIdsInput = document.getElementById('selectedSeatIdsInput');
        const MAX_SEAT_SELECTION = 8; // 최대 8개까지 선택 가능

        // JSP에서 백엔드 데이터 초기화
        const initialSelectedSeatIds = []; // 초기에는 선택된 좌석이 없음
        <c:forEach var="seatId" items="${reservation.selectedSeatIds}">
        initialSelectedSeatIds.push(${seatId});
        </c:forEach>
        let selectedSeatIds = initialSelectedSeatIds;

        // 경고 메시지 표시 (RedirectAttributes에서 넘어온 경우)
        <c:if test="${not empty errorMessage}">
        alert('${errorMessage}');
        </c:if>
        <c:if test="${not empty successMessage}">
        // 성공 메시지는 step5로 리다이렉트되므로 여기서는 필요 없을 수 있지만,
        // 만약 step4에서 바로 메시지를 보여줘야 한다면 사용합니다.
        // alert('${successMessage}');
        </c:if>


        // 좌석 클릭 이벤트 핸들러
        seatMapElement.addEventListener('click', e => {
            const clickedSeat = e.target.closest('.seat'); // 클릭된 요소 또는 가장 가까운 .seat 요소를 찾음
            if (clickedSeat && !clickedSeat.classList.contains('occupied')) {
                const seatId = parseInt(clickedSeat.dataset.seatId); // seatId를 숫자로 변환

                if (clickedSeat.classList.contains('selected')) {
                    // 이미 선택된 좌석이면 선택 해제
                    clickedSeat.classList.remove('selected');
                    selectedSeatIds = selectedSeatIds.filter(id => id !== seatId);
                } else {
                    // 새로운 좌석 선택
                    if (selectedSeatIds.length < MAX_SEAT_SELECTION) {
                        clickedSeat.classList.add('selected');
                        selectedSeatIds.push(seatId);
                    } else {
                        alert('최대 ' + MAX_SEAT_SELECTION + '개까지 좌석을 선택할 수 있습니다.');
                    }
                }
                updateSelectedInfo();
            }
        });

        function updateSelectedInfo() {
            // 현재 선택된 좌석 번호들을 수집
            const currentSelectedSeatNumbers = [];
            document.querySelectorAll('.seat.selected').forEach(seatDiv => {
                currentSelectedSeatNumbers.push(seatDiv.dataset.seatNumber);
            });

            selectedSeatsDisplay.innerText = currentSelectedSeatNumbers.length > 0 ? currentSelectedSeatNumbers.join(', ') : '선택된 좌석 없음';
            selectedSeatsCount.innerText = currentSelectedSeatNumbers.length;

            // 숨겨진 입력 필드에 선택된 좌석 ID들을 쉼표로 구분하여 저장
            selectedSeatIdsInput.value = selectedSeatIds.join(',');

            // 선택된 좌석이 없으면 '다음 단계' 버튼 비활성화
            nextButton.disabled = selectedSeatIds.length === 0;
        }

        // 초기 로드 시 선택된 좌석이 있다면 UI에 반영
        initialSelectedSeatIds.forEach(id => {
            const seatDiv = document.querySelector(`.seat[data-seat-id="${id}"]`);
            if (seatDiv) {
                seatDiv.classList.add('selected');
            }
        });

        // 페이지 로드 시 정보 업데이트
        updateSelectedInfo();
    });
</script>
</body>
</html>