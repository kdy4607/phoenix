<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Movie Schedule</title>
    <script src="https://js.tosspayments.com/v2/standard"></script>
    <link rel="stylesheet" href="/resources/css/schedule.css">
</head>
<body>
<!-- 공통 헤더 포함 -->
<jsp:include page="/WEB-INF/views/header.jsp" />

<div class="container">
    <!-- Booking Steps -->
    <div class="booking-steps">
        <div class="steps">
            <div class="step" id="step1">
                <div class="step-number">1</div>
                <span>상영시간</span>
            </div>
            <div class="step inactive" id="step2">
                <div class="step-number">2</div>
                <span>인원/좌석</span>
            </div>
            <div class="step inactive" id="step3">
                <div class="step-number">3</div>
                <span>결제</span>
            </div>
            <div class="step inactive" id="step4">
                <div class="step-number">4</div>
                <span>완료</span>
            </div>
        </div>
    </div>

    <!-- Error Message -->
    <c:if test="${not empty error}">
        <div class="error-message"
             style="background-color: #ffebee; color: #c62828; padding: 10px; margin: 10px 0; border-radius: 4px;">
                ${error}
        </div>
    </c:if>

    <!-- Current Theater -->
    <div class="section">
        <div class="section-header">Phoenix 종각점</div>
        <div class="section-content">
            <p style="color: #666; font-size: 14px;">서울특별시 종로구 종로12길 15</p>
        </div>
    </div>

    <!-- Movie Schedule Section -->
    <div class="section" id="scheduleSection">
        <div class="section-header">날짜 및 상영시간 선택</div>
        <div class="section-content">
            <!-- Date Selection -->
            <div class="date-selection">
                <c:forEach var="date" items="${dates}" varStatus="status">
                    <div class="date-item ${status.index == 0 ? 'active' : ''}"
                         data-date="${date.dateString}"
                         onclick="selectDate('${date.dateString}', this)">
                        <div class="date-day">${date.dayName}</div>
                        <div class="date-number">${date.dayNumber}</div>
                    </div>
                </c:forEach>
            </div>

            <!-- Movie Selection -->
            <div class="movie-grid" id="movieGrid">
                <c:choose>
                    <c:when test="${not empty movieRuntimes}">
                        <c:forEach var="movieEntry" items="${movieRuntimes}">
                            <c:set var="movieTitle" value="${movieEntry.key}"/>
                            <c:set var="runtimes" value="${movieEntry.value}"/>
                            <c:set var="firstRuntime" value="${runtimes[0]}"/>

                            <div class="movie-card">
                                <div class="movie-poster">
                                    <c:choose>
                                        <c:when test="${not empty firstRuntime.poster_url}">
                                            <img src="${firstRuntime.poster_url}" alt="${movieTitle}"
                                                 style="width: 100%; height: 100%; object-fit: cover;"/>
                                        </c:when>
                                        <c:otherwise>
                                            <div style="display: flex; align-items: center; justify-content: center; height: 100%; background: #f0f0f0; color: #666;">
                                                    ${movieTitle}
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="movie-info">
                                    <div class="movie-title">${movieTitle}</div>
                                    <div class="movie-genre">${firstRuntime.movie_genre}</div>
                                    <div class="movie-rating">${firstRuntime.movie_rating}</div>
                                    <div class="showtimes-grid">
                                        <c:forEach var="runtime" items="${runtimes}">
                                            <c:set var="isSoldOut" value="${soldOutStatus[runtime.runtime_id]}"/>
                                            <div class="showtime-btn ${isSoldOut ? 'full' : ''}"
                                                 data-runtime-id="${runtime.runtime_id}"
                                                 data-movie-title="${movieTitle}"
                                                 data-start-time="${runtime.start_time}"
                                                 data-room-name="${runtime.room_name}"
                                                 data-available-seats="${runtime.available_seats}"
                                                 onclick="${isSoldOut ? '' : 'selectShowtime(this)'}">
                                                    ${runtime.start_time}
                                                <br><small>${runtime.room_name}</small>
                                                <br><small>${runtime.available_seats}석</small>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div style="text-align: center; padding: 40px; color: #666;">
                            선택하신 날짜에 상영 중인 영화가 없습니다.
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- 선택된 상영시간 정보 -->
            <div id="selectedShowtimeInfo"
                 style="display: none; background: #f8f9fa; padding: 15px; margin-top: 20px; border-radius: 8px;">
                <h4>선택된 상영시간</h4>
                <p id="selectedDetails"></p>
                <button type="button" class="btn-primary" onclick="loadSeatSelection()">좌석 선택하기</button>
            </div>
        </div>
    </div>

    <!-- Seat Selection Section -->
    <div class="section seat-selection" id="seatSelection">
        <div class="section-header">좌석 선택</div>
        <div class="section-content">
            <!-- Runtime Info -->
            <div class="seat-info">
                <div id="seatRuntimeInfo"></div>
            </div>

            <!-- Seat Legend -->
            <div class="seat-legend">
                <div class="legend-item">
                    <div class="legend-seat legend-available"></div>
                    <span>선택가능</span>
                </div>
                <div class="legend-item">
                    <div class="legend-seat legend-selected"></div>
                    <span>선택됨</span>
                </div>
                <div class="legend-item">
                    <div class="legend-seat legend-reserved"></div>
                    <span>예약됨</span>
                </div>
            </div>

            <!-- Cinema Screen -->
            <div class="cinema-screen">SCREEN</div>

            <!-- Seat Map -->
            <div class="seat-map" id="seatMap">
                <!-- 좌석 배치는 JavaScript로 동적 생성 -->
            </div>

            <!-- Selected Seats Info -->
            <div class="selected-seats" id="selectedSeatsInfo">
                <h4>선택된 좌석</h4>
                <div id="selectedSeatsList"></div>
                <div id="totalPrice"></div>
            </div>

            <!-- Seat Buttons -->
            <div class="seat-buttons">
                <button type="button" class="btn-secondary" onclick="cancelSeatSelection()">이전 단계</button>
                <button type="button" class="btn-primary" id="confirmSeatsBtn" onclick="confirmSeats()" disabled>다음 단계
                </button>
            </div>
        </div>
    </div>

    <!-- ▼ 결제 섹션 시작 ▼ -->
    <div class="section payment-section" id="paymentSection" style="display:none;">
        <!-- 헤더 -->
        <div class="section-header">결제</div>
        <!-- 본문 -->
        <div class="section-content">
            <!-- 결제 요약 -->
            <div id="paymentSummary" style="margin-bottom: 30px;"></div>

            <!-- 할인 쿠폰 -->
            <div>
                <input type="checkbox" id="coupon-box" />
                <label for="coupon-box"> 5,000원 쿠폰 적용 </label>
            </div>
            <!-- 결제 UI -->
            <div id="payment-method"></div>
            <!-- 이용약관 UI -->
            <div id="agreement"></div>



            <!-- 결제하기 버튼 -->
            <button type="button" id="payment-button" class="btn-primary" disabled>
                결제하기
            </button>
        </div>
    </div>
    <!-- ▲ 결제 섹션 끝 ▲ -->

    <!-- 완료 섹션 -->
    <div id="completeSection" style="display:none;">
        <div id="completeMessage"></div>
        <button class="payButton" onclick="location.href='/reservation/list'">예매 내역 보기</button>

    </div>



</div>

<script>
    let selectedShowtime = null;
    let selectedSeats = [];
    let allSeats = [];
    let seatPrice = 12000; // 기본 가격

    // 날짜 선택 기능
    function selectDate(dateString, element) {
        document.querySelectorAll('.date-item').forEach(item => {
            item.classList.remove('active');
        });
        element.classList.add('active');

        fetch('/schedule/date/' + dateString)
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    updateMovieGrid(data.movieRuntimes, data.soldOutStatus);
                    hideAllSections();
                } else {
                    alert(data.message || '데이터를 불러올 수 없습니다.');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('오류가 발생했습니다. 다시 시도해 주세요.');
            });
    }

    // 상영시간 선택 (DOM 엘리먼트 방식)
    function selectShowtime(element) {
        console.log('🎬 상영시간 선택 시작');

        // 이전 선택 해제
        document.querySelectorAll('.showtime-btn').forEach(btn => {
            btn.classList.remove('selected');
        });

        // 현재 선택 표시
        element.classList.add('selected');

        // 데이터 추출 및 검증
        const runtimeId = element.dataset.runtimeId;
        const movieTitle = element.dataset.movieTitle;
        const startTime = element.dataset.startTime;
        const roomName = element.dataset.roomName;
        const availableSeats = element.dataset.availableSeats;

        console.log('📋 추출된 데이터:', {
            runtimeId: runtimeId,
            movieTitle: movieTitle,
            startTime: startTime,
            roomName: roomName,
            availableSeats: availableSeats
        });

        // Runtime ID 검증
        if (!runtimeId || runtimeId === 'undefined' || runtimeId === 'null') {
            console.error('❌ Runtime ID가 유효하지 않습니다:', runtimeId);
            alert('상영시간 정보에 오류가 있습니다. 페이지를 새로고침해주세요.');
            return;
        }

        // selectedShowtime 객체 생성
        selectedShowtime = {
            runtimeId: parseInt(runtimeId), // 정수로 변환
            movieTitle: movieTitle,
            startTime: startTime,
            roomName: roomName,
            availableSeats: parseInt(availableSeats) // 정수로 변환
        };

        console.log('✅ selectedShowtime 설정 완료:', selectedShowtime);

        // 선택된 상영시간 정보 표시
        showSelectedInfo();
    }


    // 선택된 상영시간 정보 표시
    function showSelectedInfo() {
        if (selectedShowtime) {
            const infoDiv = document.getElementById('selectedShowtimeInfo');
            const detailsP = document.getElementById('selectedDetails');

            if (infoDiv && detailsP) {
                detailsP.innerHTML = '<strong>' + selectedShowtime.movieTitle + '</strong><br>' +
                    selectedShowtime.startTime + ' | ' + selectedShowtime.roomName + ' | 잔여좌석: ' + selectedShowtime.availableSeats + '석';

                infoDiv.style.display = 'block';
                console.log('✅ 선택된 상영시간 정보 표시 완료');
            }
        }
    }

    // JSP 파일 내부의 loadSeatSelection 함수를 이것으로 교체하세요
    function loadSeatSelection() {
        if (!selectedShowtime) {
            alert('상영시간을 먼저 선택해주세요.');
            return;
        }

        // 단계 표시 업데이트
        updateSteps(2);

        // runtimeId를 정수로 변환
        const runtimeId = parseInt(selectedShowtime.runtimeId);

        // 디버깅 로그
        console.log('🔍 좌석 선택 화면 로드 - Runtime ID:', runtimeId);
        console.log('📋 selectedShowtime:', selectedShowtime);

        // ✅ 올바른 엔드포인트 사용
        fetch(`/seat/\${runtimeId}/seats`)
            .then(response => {
                console.log('📡 응답 상태:', response.status);
                return response.json();
            })
            .then(data => {
                console.log('📦 받은 데이터:', data);

                if (data.success) {
                    allSeats = data.seats;
                    seatPrice = data.runtime.price || 12000;

                    // 좌석 선택 화면 표시
                    showSeatSelection(data.runtime, data.seats);
                    console.log('✅ 좌석 정보 로드 성공:', data.seats.length + '석');
                } else {
                    alert(data.message || '좌석 정보를 불러올 수 없습니다.');
                }
            })
            .catch(error => {
                console.error('❌ 좌석 정보 로드 오류:', error);
                alert('좌석 정보를 불러오는 중 오류가 발생했습니다: ' + error.message);
            });
    }

    // 좌석 선택 화면 표시
    function showSeatSelection(runtime, seats) {
        // 상영시간 정보 표시
        document.getElementById('seatRuntimeInfo').innerHTML =
            '<strong>' + runtime.movie_title + '</strong> | ' +
            runtime.start_time + ' | ' +
            runtime.room_name + ' | ' +
            runtime.price.toLocaleString() + '원';

        // 좌석 맵 생성
        createSeatMap(seats);

        // 화면 전환
        document.getElementById('scheduleSection').style.display = 'none';
        document.getElementById('seatSelection').classList.add('active');
    }

    // 좌석 맵 생성
    function createSeatMap(seats) {
        const seatMap = document.getElementById('seatMap');
        seatMap.innerHTML = '';

        // 좌석을 행별로 그룹화
        const seatsByRow = {};
        seats.forEach(seat => {
            if (!seatsByRow[seat.seat_row]) {
                seatsByRow[seat.seat_row] = [];
            }
            seatsByRow[seat.seat_row].push(seat);
        });

        // 각 행별로 좌석 생성
        Object.keys(seatsByRow).sort().forEach(row => {
            const rowDiv = document.createElement('div');
            rowDiv.className = 'seat-row';

            // 행 라벨
            const rowLabel = document.createElement('div');
            rowLabel.className = 'seat-row-label';
            rowLabel.textContent = row;
            rowDiv.appendChild(rowLabel);

            // 좌석들
            seatsByRow[row].sort((a, b) => a.seat_number - b.seat_number).forEach(seat => {
                const seatDiv = document.createElement('div');
                seatDiv.className = 'seat';
                seatDiv.dataset.seatId = seat.seat_id;
                seatDiv.dataset.seatRow = seat.seat_row;
                seatDiv.dataset.seatNumber = seat.seat_number;
                seatDiv.textContent = seat.seat_number;

                if (seat.status === '예약됨') {
                    seatDiv.classList.add('reserved');
                } else {
                    seatDiv.classList.add('available');
                    seatDiv.onclick = () => toggleSeat(seatDiv, seat);
                }

                rowDiv.appendChild(seatDiv);
            });

            seatMap.appendChild(rowDiv);
        });
    }

    // 좌석 선택/해제
    function toggleSeat(seatDiv, seat) {
        const seatId = parseInt(seatDiv.dataset.seatId);

        if (seatDiv.classList.contains('selected')) {
            // 선택 해제
            seatDiv.classList.remove('selected');
            seatDiv.classList.add('available');
            selectedSeats = selectedSeats.filter(s => parseInt(s.seat_id) !== seatId);
        } else {
            // 선택
            seatDiv.classList.remove('available');
            seatDiv.classList.add('selected');
            // seat 객체의 seat_id를 정수로 변환하여 저장
            seat.seat_id = parseInt(seat.seat_id);
            selectedSeats.push(seat);
        }

        updateSelectedSeatsInfo();
    }

    // 선택된 좌석 정보 업데이트
    function updateSelectedSeatsInfo() {
        const selectedSeatsInfo = document.getElementById('selectedSeatsInfo');
        const selectedSeatsList = document.getElementById('selectedSeatsList');
        const totalPrice = document.getElementById('totalPrice');
        const confirmBtn = document.getElementById('confirmSeatsBtn');

        if (selectedSeats.length > 0) {
            selectedSeatsInfo.classList.add('active');

            const seatLabels = selectedSeats.map(seat =>
                seat.seat_row + seat.seat_number
            ).join(', ');

            selectedSeatsList.innerHTML =
                '<strong>선택된 좌석:</strong> ' + seatLabels + '<br>' +
                '<strong>좌석 수:</strong> ' + selectedSeats.length + '석';

            totalPrice.innerHTML =
                '<strong>총 금액:</strong> ' + (selectedSeats.length * seatPrice).toLocaleString() + '원';

            confirmBtn.disabled = false;
        } else {
            selectedSeatsInfo.classList.remove('active');
            confirmBtn.disabled = true;
        }
    }

    // 좌석 선택 취소
    function cancelSeatSelection() {
        selectedSeats = [];
        updateSteps(1);
        document.getElementById('seatSelection').classList.remove('active');
        document.getElementById('scheduleSection').style.display = 'block';
    }

    // 좌석 선택 확인 - 실제 예약 생성
    /**
     * 좌석 선택을 마치고 결제 단계로 넘어가는 함수
     */
    function confirmSeats() {
        if (selectedSeats.length === 0) {
            alert('좌석을 선택해주세요.');
            return;
        }

        // 결제 단계로 넘어갈 준비
        const totalAmount = selectedSeats.length * seatPrice;
        const seatLabels = selectedSeats.map(seat => seat.seat_row + seat.seat_number).join(', ');

        // 결제 섹션을 표시하는 함수 호출
        showPaymentSection(totalAmount, seatLabels);

        console.log('[confirmSeats] selectedShowtime', selectedShowtime);
    }

    /**
     * 결제 섹션을 설정하고 화면에 표시하는 함수
     */
    function showPaymentSection(amount, seatLabels) {
        // 1. 결제 요약 정보 채우기
        document.getElementById('paymentSummary').innerHTML = `
            <div class="payment-summary-box">
               <h3>최종 예매 내역 확인</h3>
            <p><strong>영화:</strong> \${selectedShowtime.movieTitle}</p>
            <p><strong>상영시간:</strong> \${selectedShowtime.startTime}</p>
            <p><strong>상영관:</strong> \${selectedShowtime.roomName}</p>
            <p><strong>좌석:</strong> \${seatLabels}</p>
            <p><strong>최종 결제 금액:</strong> \${amount.toLocaleString()}원</p>
            </div>
        `;

        // 2. 진행 단계(step)를 3단계 '결제'로 업데이트
        updateSteps(3);

        // 3. 이전 섹션 숨기고 결제 섹션 표시
        document.getElementById('seatSelection').classList.remove('active');
        document.getElementById('paymentSection').style.display = 'block';

        // 4. '결제하기' 버튼 활성화 및 클릭 이벤트 연결
        const paymentButton = document.getElementById('payment-button');
        paymentButton.disabled = false; // 버튼 활성화
        paymentButton.onclick = processPaymentAndReserve; // 실제 예약 처리 함수 연결
    }




    /**
     * '결제하기' 버튼 클릭 시 최종 예약을 처리하는 함수
     */
    function processPaymentAndReserve() {
        // 중복 클릭 방지를 위해 버튼 비활성화
        document.getElementById('payment-button').disabled = true;

        const runtimeId = parseInt(selectedShowtime.runtimeId);
        const selectedSeatIds = selectedSeats.map(seat => parseInt(seat.seat_id));

        // 서버에 예약 생성 요청 (기존 confirmSeats에 있던 로직)
        fetch('/seat/reserve', {
            method: 'POST',
            headers: {'Content-Type': 'application/json'},
            body: JSON.stringify({
                runtimeId: runtimeId,
                selectedSeatIds: selectedSeatIds
            })
        })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    // 예약 성공 시 완료 화면 표시
                    updateSteps(4);
                    document.getElementById('paymentSection').style.display = 'none'; // 결제 섹션 숨기기
                    showReservationComplete(data.reservation);
                } else {
                    // 예약 실패 시
                    alert(data.message || '예약 중 오류가 발생했습니다.');
                    document.getElementById('payment-button').disabled = false; // 다시 시도할 수 있도록 버튼 활성화
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('예약 처리 중 오류가 발생했습니다.');
                document.getElementById('payment-button').disabled = false; // 버튼 활성화
            });
    }


    // 예약 완료 화면 표시
    function showReservationComplete(reservation) {
        const completeSection = document.getElementById('completeSection');
        const completeMessage = document.getElementById('completeMessage');

        completeMessage.innerHTML = `
            <h2>예약이 완료되었습니다!</h2>
            <p><strong>예약번호:</strong> \${reservation.reservation_id}</p>
            <p><strong>영화:</strong> \${reservation.movie_title}</p>
            <p><strong>상영시간:</strong> \${reservation.start_time}</p>
            <p><strong>상영관:</strong> \${reservation.room_name}</p>
            <p><strong>좌석:</strong> \${reservation.selected_seats}</p>
            <p><strong>총 금액:</strong> \${reservation.total_amount.toLocaleString()}원</p>
        `;

        completeSection.style.display = 'block';
    }

    // 단계 업데이트
    function updateSteps(activeStep) {
        document.querySelectorAll('.step').forEach((step, index) => {
            if (index + 1 <= activeStep) {
                step.classList.remove('inactive');
            } else {
                step.classList.add('inactive');
            }
        });
    }

    // 모든 섹션 숨기기
    function hideAllSections() {
        document.getElementById('selectedShowtimeInfo').style.display = 'none';
        document.getElementById('seatSelection').classList.remove('active');
        document.getElementById('scheduleSection').style.display = 'block';
        selectedShowtime = null;
        selectedSeats = [];
        updateSteps(1);
    }

    // 영화 그리드 업데이트 (기존 함수)
    function updateMovieGrid(movieRuntimes, soldOutStatus) {
        const movieGrid = document.getElementById('movieGrid');

        if (!movieRuntimes || Object.keys(movieRuntimes).length === 0) {
            movieGrid.innerHTML = '<div style="text-align: center; padding: 40px; color: #666;">선택하신 날짜에 상영 중인 영화가 없습니다.</div>';
            return;
        }

        let html = '';
        for (const [movieTitle, runtimes] of Object.entries(movieRuntimes)) {
            const firstRuntime = runtimes[0];
            html += '<div class="movie-card">';
            html += '<div class="movie-poster">';

            if (firstRuntime.poster_url) {
                html += '<img src="' + firstRuntime.poster_url + '" alt="' + movieTitle + '" style="width: 100%; height: 100%; object-fit: cover;" />';
            } else {
                html += '<div style="display: flex; align-items: center; justify-content: center; height: 100%; background: #f0f0f0; color: #666;">' + movieTitle + '</div>';
            }

            html += '</div>';
            html += '<div class="movie-info">';
            html += '<div class="movie-title">' + movieTitle + '</div>';
            html += '<div class="movie-genre">' + firstRuntime.movie_genre + '</div>';
            html += '<div class="movie-rating">' + firstRuntime.movie_rating + '</div>';
            html += '<div class="showtimes-grid">';

            runtimes.forEach(runtime => {
                const isSoldOut = soldOutStatus[runtime.runtime_id];
                html += '<div class="showtime-btn ' + (isSoldOut ? 'full' : '') + '"';
                html += ' data-runtime-id="' + runtime.runtime_id + '"';
                html += ' data-movie-title="' + movieTitle + '"';
                html += ' data-start-time="' + runtime.start_time + '"';
                html += ' data-room-name="' + runtime.room_name + '"';
                html += ' data-available-seats="' + runtime.available_seats + '"';
                if (!isSoldOut) {
                    html += ' onclick="selectShowtime(this)"';
                }
                html += '>';
                html += runtime.start_time;
                html += '<br><small>' + runtime.room_name + '</small>';
                html += '<br><small>' + runtime.available_seats + '석</small>';
                html += '</div>';
            });

            html += '</div>';
            html += '</div>';
            html += '</div>';
        }

        movieGrid.innerHTML = html;
    }


    // 토스페이
    main();

    async function main() {
        const button = document.getElementById("payment-button");
        const coupon = document.getElementById("coupon-box");
        // ------  결제위젯 초기화 ------
        const clientKey = "test_gck_docs_Ovk5rk1EwkEbP0W43n07xlzm";
        const tossPayments = TossPayments(clientKey);
        // 회원 결제
        const customerKey = "qMATQmTPqT9RMvmO0EpQQ";
        const widgets = tossPayments.widgets({
            customerKey,
        });
        // 비회원 결제
        // const widgets = tossPayments.widgets({ customerKey: TossPayments.ANONYMOUS });

        // ------ 주문의 결제 금액 설정 ------
        await widgets.setAmount({
            currency: "KRW",
            value: 50000,
        });

        await Promise.all([
            // ------  결제 UI 렌더링 ------
            widgets.renderPaymentMethods({
                selector: "#payment-method",
                variantKey: "DEFAULT",
            }),
            // ------  이용약관 UI 렌더링 ------
            widgets.renderAgreement({ selector: "#agreement", variantKey: "AGREEMENT" }),
        ]);

        // ------  주문서의 결제 금액이 변경되었을 경우 결제 금액 업데이트 ------
        coupon.addEventListener("change", async function () {
            if (coupon.checked) {
                await widgets.setAmount({
                    currency: "KRW",
                    value: 50000 - 5000,
                });

                return;
            }

            await widgets.setAmount({
                currency: "KRW",
                value: 50000,
            });
        });

        // ------ '결제하기' 버튼 누르면 결제창 띄우기 ------
        // button.addEventListener("click", async function () {
        //     await widgets.requestPayment({
        //         orderId: "ualqx-0Mvh-wmo9smOcnr",
        //         orderName: "토스 티셔츠 외 2건",
        //         successUrl: window.location.origin + "/success.html",
        //         failUrl: window.location.origin + "/fail.html",
        //         customerEmail: "customer123@gmail.com",
        //         customerName: "김토스",
        //         customerMobilePhone: "01012341234",
        //     });
        // });
    }


</script>
</body>
<script src="/resources/js/schedule.js"></script>
</html>