<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Movie Schedule</title>
    <!-- 토스페이먼츠 SDK 추가 -->
    <script src="https://js.tosspayments.com/v2/standard"></script>
    <link rel="icon" href="https://static.toss.im/icons/png/4x/icon-toss-logo.png" />
    <link rel="stylesheet" href="/resources/css/schedule.css">
    <link rel="stylesheet" type="text/css" href="/resources/css/payment.css" />

</head>
<body>
<!-- 공통 헤더 포함 -->
<jsp:include page="/WEB-INF/views/header.jsp"/>

<div class="container">
    <!-- Booking Steps -->
    <div class="booking-steps">
        <div class="steps">
            <div class="step" id="step1">
                <div class="step-number">1</div>
                <span>Date & Time</span>
            </div>
            <div class="step inactive" id="step2">
                <div class="step-number">2</div>
                <span>Seats</span>
            </div>
            <div class="step inactive" id="step3">
                <div class="step-number">3</div>
                <span>Payment</span>
            </div>
            <div class="step inactive" id="step4">
                <div class="step-number">4</div>
                <span>Confirmation</span>
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
<%--    <div class="section">--%>
<%--        <div class="section-header">Phoenix 종각점</div>--%>
<%--        <div class="section-content">--%>
<%--            <p style="color: #666; font-size: 14px;">서울특별시 종로구 종로12길 15</p>--%>
<%--        </div>--%>
<%--    </div>--%>

    <!-- Movie Schedule Section -->
    <div class="section" id="scheduleSection">
        <div class="section-header">Select Date & Time</div>
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
                                                 data-poster-url="${runtime.poster_url}"
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
                <h4>Selected Date & Time</h4>
                <p id="selectedDetails"></p>
                <button type="button" class="btn-primary" onclick="loadSeatSelection()">좌석 선택하기</button>
            </div>
        </div>
    </div>


    <!-- Seat Selection Section -->
    <div class="section seat-selection" id="seatSelection">
        <div class="section-header">Select Guests & Seats
            <span class="person-number">You can select up to 8 guests</span>
        </div>
        <div class="section-content">
            <!-- Runtime Info -->
            <div class="seat-info">
                <div id="seatRuntimeInfo"></div>
            </div>

            <%-- 인원선택 --%>
            <div class="section person-selection" id="peopleSelection">
                <div class="section-content">
                    <div class="people-row">
                        <div class="label">Adult</div>
                        <div class="counter">
                            <button type="button" onclick="changeCount('adult', -1)">−</button>
                            <span id="adultCount">0</span>
                            <button type="button" onclick="changeCount('adult', 1)">+</button>
                        </div>
                    </div>
                    <div class="people-row">
                        <div class="label">Youth</div>
                        <div class="counter">
                            <button type="button" onclick="changeCount('youth', -1)">−</button>
                            <span id="youthCount">0</span>
                            <button type="button" onclick="changeCount('youth', 1)">+</button>
                        </div>
                    </div>
                    <div class="people-row">
                        <div class="label">Child</div>
                        <div class="counter">
                            <button type="button" onclick="changeCount('child', -1)">−</button>
                            <span id="childCount">0</span>
                            <button type="button" onclick="changeCount('child', 1)">+</button>
                        </div>
                    </div>
                </div>
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
        <div class="section-header">결제하기</div>
        <!-- 본문 -->
        <div class="section-content">
            <!-- 결제 요약 -->

            <div id="paymentSummary" style="margin-bottom: 30px;"></div>

            <!-- 주문서 영역 -->
            <div class="wrapper">
                <div class="box_section" style="padding: 40px 30px 50px 30px; margin-top: 30px; margin-bottom: 50px">
                    <!-- 결제 UI -->
                    <div id="payment-method"></div>
                    <!-- 이용약관 UI -->
                    <div id="agreement"></div>
                    <!-- 쿠폰 체크박스 -->
                    <div style="padding-left: 25px">
                        <div class="checkable typography--p">
                            <label for="coupon-box" class="checkable__label typography--regular"
                            ><input id="coupon-box" class="checkable__input" type="checkbox" aria-checked="true"/><span
                                    class="checkable__label-text">5,000원 쿠폰 적용</span></label>
                        </div>
                    </div>
                    <!-- 결제하기 버튼 -->
                    <div class="result wrapper">
                        <button class="button" id="payment-button" style="margin-top: 30px">
                            결제하기
                        </button>
                    </div>
                </div>

            </div>
        </div>
        <!-- ▲ 결제 섹션 끝 ▲ -->
    </div>

    <!-- 완료 섹션 -->
    <div id="completeSection" style="display: none;">
        <div id="completeMessage"></div>
        <button class="payButton" onclick="location.href='/reservation/list'">
            예매 내역 보기
        </button>
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
            const posterUrl = element.dataset.posterUrl;

            console.log('📋 추출된 데이터:', {
                runtimeId: runtimeId,
                movieTitle: movieTitle,
                startTime: startTime,
                roomName: roomName,
                availableSeats: availableSeats,
                posterUrl: posterUrl
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
                availableSeats: parseInt(availableSeats), // 정수로 변환
                posterUrl: posterUrl
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

            checkLoginStatus().then(isLoggedIn => {
                if (!isLoggedIn) {
                    console.log('❌ 로그인이 필요합니다');
                    requireLogin();
                    return;
                } else {
                    // ✅ 로그인된 경우 좌석 선택 진행
                    console.log('✅ 로그인 확인 완료 - 좌석 선택 진행');

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


            });


        }

        // 좌석 선택 화면 표시
        function showSeatSelection(runtime, seats) {
            // 1) 가격 계산
            const priceAdult = runtime.price;
            const priceYouth = priceAdult - 2000;
            const priceChild = priceAdult - 4000;
            // 상영시간 정보 표시
            document.getElementById('seatRuntimeInfo').innerHTML = `
      <div id="seatRuntimeInfo">
  <div class="runtime-info">
    <!-- 왼쪽 블록: 영화 제목 + 메타 정보 -->
    <div class="runtime-details">
      <strong class="movie-title">\${runtime.movie_title}</strong>
      <div class="runtime-meta">
        \${runtime.start_time} | \${runtime.room_name} | \${runtime.movie_rating}
      </div>
    </div>
    <!-- 오른쪽 블록: 요금 리스트 -->
    <div class="price-list">
      <span class="price-item adult">
        Adult <strong>\${priceAdult.toLocaleString()}원</strong>
      </span>
      <span class="price-item youth">
        Youth <strong>\${priceYouth.toLocaleString()}원</strong>
      </span>
      <span class="price-item child">
        Child <strong>\${priceChild.toLocaleString()}원</strong>
      </span>
    </div>
  </div>
</div>
    `;

            // document.getElementById('seatRuntimeInfo').innerHTML =
            //     '<strong>' + runtime.movie_title + '</strong> | ' +
            //     runtime.start_time + ' | ' +
            //     runtime.room_name + '<br/>' +
            //     '성인 ' + priceAdult.toLocaleString() + '원' + ' | ' +
            //     '청소년 ' + priceYouth.toLocaleString() + '원' + ' | ' +
            //     '어린이 ' + priceChild.toLocaleString() + '원';

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

        function updateSelectedSeatsInfo() {
            const selectedSeatsInfo = document.getElementById('selectedSeatsInfo');
            const selectedSeatsList = document.getElementById('selectedSeatsList');
            const confirmBtn = document.getElementById('confirmSeatsBtn');

            // 인원별 카운트 읽어오기
            const adultCount = parseInt(document.getElementById('adultCount').textContent, 10);
            const youthCount = parseInt(document.getElementById('youthCount').textContent, 10);
            const childCount = parseInt(document.getElementById('childCount').textContent, 10);

            // 좌석 라벨 항상 갱신
            const seatLabels = selectedSeats
                .map(seat => seat.seat_row + seat.seat_number)
                .join(', ');
            selectedSeatsList.innerHTML = '<strong>Selected Seats:</strong> ' + seatLabels;

            // 선택된 좌석 수와 인원 수가 맞아야 인원·총금액 표시
            const totalPeople = adultCount + youthCount + childCount;
            if (selectedSeats.length === totalPeople && totalPeople > 0) {
                // 요금 계산
                const priceAdult = seatPrice;
                const priceYouth = priceAdult - 2000;
                const priceChild = priceAdult - 4000;
                const totalAmount =
                    adultCount * priceAdult +
                    youthCount * priceYouth +
                    childCount * priceChild;

                // 인원 & 총 금액 노출
                selectedSeatsList.innerHTML +=
                    '<br><strong>Number of Seats:</strong> Adult ' + adultCount + '명, ' +
                    'Youth ' + youthCount + ', Child ' + childCount + '명' +
                    '<br><strong>Total Amount:</strong> ' + totalAmount.toLocaleString() + '원';

                confirmBtn.disabled = false;
            } else {
                // 인원 맞추기 전이면 인원·총금액 제거, 버튼 비활성
                confirmBtn.disabled = true;
            }

            // 정보 박스 보임/숨김
            if (selectedSeats.length > 0) {
                selectedSeatsInfo.classList.add('active');
            } else {
                selectedSeatsInfo.classList.remove('active');
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

            const adultCount = parseInt(document.getElementById('adultCount').textContent, 10);
            const youthCount = parseInt(document.getElementById('youthCount').textContent, 10);
            const childCount = parseInt(document.getElementById('childCount').textContent, 10);

            const seatLabels = selectedSeats.map(seat => seat.seat_row + seat.seat_number).join(', ');
            const seatIds = selectedSeats.map(seat => parseInt(seat.seat_id, 10));

            const totalAmount = adultCount * seatPrice
                + youthCount * (seatPrice - 2000)
                + childCount * (seatPrice - 4000);

            showPaymentSection(totalAmount, seatLabels);

            // 백엔드에 보낼 페이로드 미리 저장
            window._reservationPayload = {
                runtimeId: selectedShowtime.runtimeId,
                adult: adultCount,
                youth: youthCount,
                child: childCount,
                seats: seatIds
            };
        }

        // function confirmSeats() {
        //     if (selectedSeats.length === 0) {
        //         alert('좌석을 선택해주세요.');
        //         return;
        //     }
        //
        //     // 결제 단계로 넘어갈 준비
        //     const totalAmount = selectedSeats.length * seatPrice;
        //     const seatLabels = selectedSeats.map(seat => seat.seat_row + seat.seat_number).join(', ');
        //
        //     // 결제 섹션을 표시하는 함수 호출
        //     showPaymentSection(totalAmount, seatLabels);
        //
        //     console.log('[confirmSeats] selectedShowtime', selectedShowtime);
        // }

        /**
         * 결제 섹션을 설정하고 화면에 표시하는 함수
         */
        function showPaymentSection(amount, seatLabels) {

            // 1. 결제 요약 정보 채우기
            document.getElementById('paymentSummary').innerHTML = `
            <div class="payment-summary-box">
               <h3>최종 예매 내역 확인</h3>
            <div class="poster">
            <img src="\${selectedShowtime.posterUrl}"/>
            </div>
            <div class="details">
            <p><strong>영화:</strong> \${selectedShowtime.movieTitle}</p>
            <p><strong>상영시간:</strong> \${selectedShowtime.startTime}</p>
            <p><strong>상영관:</strong> \${selectedShowtime.roomName}</p>
            <p><strong>좌석:</strong> \${seatLabels}</p>
            <p><strong>최종 결제 금액:</strong> \${amount.toLocaleString()}원</p>
            </div>
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
        }

            // paymentButton.onclick = processPaymentAndReserve; // 실제 예약 처리 함수 연결

        /**
         * '결제하기' 버튼 클릭 시 최종 예약을 처리하는 함수
         */
        async function processPaymentAndReserve() {
            const btn = document.getElementById('payment-button');
            btn.disabled = true;

            // 앞서 window._reservationPayload 에 저장된 데이터를 사용
            fetch('/reservation/create', {
                method: 'POST',
                headers: {'Content-Type': 'application/json'},
                body: JSON.stringify(window._reservationPayload)
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
                        btn.disabled = false;
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('예약 처리 중 오류가 발생했습니다.');
                    btn.disabled = false;
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

        // 인원선택
        const MAX_PEOPLE = 8;

        // 변경된 count에 따라 좌석 제한 상태 갱신
        function changeCount(type, delta) {
            const el = document.getElementById(type + 'Count');
            let count = parseInt(el.textContent);
            const total = getTotalPeople();
            const newCount = count + delta;
            if (newCount < 0) return;
            if (delta > 0 && total >= MAX_PEOPLE) {
                alert(`최대 인원은 8명입니다.`);
                return;
            }
            el.textContent = newCount;
            refreshSeatStates();
        }

        // 현재 총 인원 계산
        function getTotalPeople() {
            return ['adult', 'youth', 'child']
                .reduce((sum, t) => sum + parseInt(document.getElementById(t + 'Count').textContent || 0), 0);
        }

        // 좌석 클릭 시 선택/해제 후 상태 갱신
        function toggleSeat(seatDiv, seat) {
            const seatId = parseInt(seatDiv.dataset.seatId);
            if (seatDiv.classList.contains('selected')) {
                // 선택 해제
                seatDiv.classList.remove('selected');
                seatDiv.classList.add('available');
                selectedSeats = selectedSeats.filter(s => s.seat_id !== seatId);
            } else if (selectedSeats.length < getTotalPeople()) {
                // 선택
                seatDiv.classList.remove('available');
                seatDiv.classList.add('selected');
                selectedSeats.push(seat);
            }
            updateSelectedSeatsInfo();
            refreshSeatStates();
        }

        // 클릭 가능한 잔여 좌석과 예약 불가 좌석 표시
        function refreshSeatStates() {
            const total = getTotalPeople();
            const seats = document.querySelectorAll('#seatMap .seat');
            seats.forEach(div => {
                // 원래 예약된 좌석(original-reserved) 및 현재 선택된 좌석(selected)은 건드리지 않음
                if (div.classList.contains('original-reserved') || div.classList.contains('selected')) return;
                if (selectedSeats.length >= total && total > 0) {
                    // 최대에 도달했으면 나머지는 예약불가
                    div.classList.remove('available');
                    div.classList.add('limited-reserved');
                    div.onclick = null;
                } else {
                    // 인원 미달 상태에서는 예약불가 해제
                    div.classList.remove('limited-reserved');
                    div.classList.add('available');
                    const seatObj = allSeats.find(s => s.seat_id == div.dataset.seatId);
                    div.onclick = () => toggleSeat(div, seatObj);
                }
            });
        }

        // 좌석 로드 후 초기화 시, 원래 예약된 좌석 구분
        function createSeatMap(seats) {
            allSeats = seats;
            const seatMap = document.getElementById('seatMap');
            seatMap.innerHTML = '';
            const seatsByRow = {};
            seats.forEach(seat => (seatsByRow[seat.seat_row] = seatsByRow[seat.seat_row] || []).push(seat));
            Object.keys(seatsByRow).sort().forEach(row => {
                const rowDiv = document.createElement('div');
                rowDiv.className = 'seat-row';
                const label = document.createElement('div');
                label.className = 'seat-row-label';
                label.textContent = row;
                rowDiv.appendChild(label);
                seatsByRow[row].sort((a, b) => a.seat_number - b.seat_number).forEach(seat => {
                    const div = document.createElement('div');
                    div.className = seat.status === '예약됨' ? 'seat reserved original-reserved' : 'seat available';
                    div.dataset.seatId = seat.seat_id;
                    div.textContent = seat.seat_number;
                    if (div.classList.contains('available')) div.onclick = () => toggleSeat(div, seat);
                    rowDiv.appendChild(div);
                });
                seatMap.appendChild(rowDiv);
            });
            refreshSeatStates();
        }


        // 토스페이

        main();

        async function main() {
            const button = document.getElementById("payment-button");
            const coupon = document.getElementById("coupon-box");
            const amount = {
                currency: "KRW",
                value: 50000,
            };
            // ------  결제위젯 초기화 ------
            // TODO: clientKey는 개발자센터의 결제위젯 연동 키 > 클라이언트 키로 바꾸세요.
            // TODO: 구매자의 고유 아이디를 불러와서 customerKey로 설정하세요. 이메일・전화번호와 같이 유추가 가능한 값은 안전하지 않습니다.
            // @docs https://docs.tosspayments.com/sdk/v2/js#토스페이먼츠-초기화
            const clientKey = "test_gck_docs_Ovk5rk1EwkEbP0W43n07xlzm";
            const customerKey = generateRandomString();
            const tossPayments = TossPayments(clientKey);
            // 회원 결제
            const widgets = tossPayments.widgets({
                customerKey,
            });
            // 비회원 결제
            // const widgets = tossPayments.widgets({customerKey: TossPayments.ANONYMOUS});

            // ------  주문서의 결제 금액 설정 ------
            // TODO: 위젯의 결제금액을 결제하려는 금액으로 초기화하세요.
            // TODO: renderPaymentMethods, renderAgreement, requestPayment 보다 반드시 선행되어야 합니다.
            await widgets.setAmount(amount);

            // ------  결제 UI 렌더링 ------
            // @docs https://docs.tosspayments.com/sdk/v2/js#widgetsrenderpaymentmethods
            await widgets.renderPaymentMethods({
                selector: "#payment-method",
                // 렌더링하고 싶은 결제 UI의 variantKey
                // 결제 수단 및 스타일이 다른 멀티 UI를 직접 만들고 싶다면 계약이 필요해요.
                // @docs https://docs.tosspayments.com/guides/v2/payment-widget/admin#새로운-결제-ui-추가하기
                variantKey: "DEFAULT",
            });

            // ------  이용약관 UI 렌더링 ------
            // @docs https://docs.tosspayments.com/reference/widget-sdk#renderagreement선택자-옵션
            await widgets.renderAgreement({selector: "#agreement", variantKey: "AGREEMENT"});

            // ------  주문서의 결제 금액이 변경되었을 경우 결제 금액 업데이트 ------
            // @docs https://docs.tosspayments.com/sdk/v2/js#widgetssetamount
            coupon.addEventListener("change", async function () {
                if (coupon.checked) {
                    await widgets.setAmount({
                        currency: "KRW",
                        value: amount.value - 5000,
                    });

                    return;
                }

                await widgets.setAmount({
                    currency: "KRW",
                    value: amount,
                });
            });

            // ------ '결제하기' 버튼 누르면 결제창 띄우기 ------
            // @docs https://docs.tosspayments.com/sdk/v2/js#widgetsrequestpayment
            button.addEventListener("click", async function () {
                // 결제를 요청하기 전에 orderId, amount를 서버에 저장하세요.
                // 결제 과정에서 악의적으로 결제 금액이 바뀌는 것을 확인하는 용도입니다.
                // 결제 요청
                try {
                    await widgets.requestPayment({
                        orderId: generateRandomString(),
                        orderName: "영화 예매",
                        customerEmail: "customer123@gmail.com",
                        customerName: "김토스",
                        customerMobilePhone: "01012341234",

                    });

                    // 결제 성공 시: 예약 생성 API 호출
                    const resp = await fetch('/reservation/create', {
                        method: 'POST',
                        headers: {'Content-Type': 'application/json'},
                        body: JSON.stringify(window._reservationPayload)
                    });
                    const data = await resp.json();
                    if (data.success) {
                        updateSteps(4);
                        document.getElementById('paymentSection').style.display = 'none';
                        document.getElementById('completeSection').style.display = 'block';
                        // ✅ showReservationComplete 함수 호출 추가
                        showReservationComplete(data.reservation);
                    } else {
                        throw new Error(data.message);
                    }
                } catch (err) {
                    console.error('결제 또는 예약 처리 중 오류:', err);
                    // 결제 실패 또는 예약 실패
                    alert('결제에 실패했습니다. 다시 시도해 주세요.');
                    // 필요시 3단계(결제)로 돌아가기
                    updateSteps(3);
                    document.getElementById('paymentSection').style.display = 'block';
                }
            });

            function generateRandomString() {
                return window.btoa(Math.random()).slice(0, 20);
            }
        }

        // ========================================
        // 로그인 상태 확인 함수
        // ========================================
        function checkLoginStatus() {
            return fetch('/user/check')
                .then(response => response.json())
                .then(data => {
                    return data.isLoggedIn;
                })
                .catch(error => {
                    console.error('로그인 상태 확인 오류:', error);
                    return false;
                });
        }

        // ========================================
        // 로그인 필요 알림 함수
        // ========================================
        function requireLogin() {
            if (confirm('좌석 선택을 위해 로그인이 필요합니다.\n로그인 페이지로 이동하시겠습니까?')) {
                const currentUrl = encodeURIComponent(window.location.pathname + window.location.search);
                window.location.href = '/login?returnUrl=' + currentUrl;
            }
        }



    </script>
</body>
<%--<script src="/resources/js/schedule.js"></script>--%>
</html>