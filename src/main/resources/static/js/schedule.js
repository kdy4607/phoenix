// ========================================
// 전역 변수
// ========================================
let selectedMovieId = null;
let selectedDate = null;
let selectedShowtime = null;
let selectedSeats = [];
let seatPrice = 12000; // 기본 좌석 가격

// ========================================
// 로그인 상태 확인
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
// 로그인 필요 알림
// ========================================
function requireLogin() {
    if (confirm('예약을 위해 로그인이 필요합니다.\n로그인 페이지로 이동하시겠습니까?')) {
        const currentUrl = encodeURIComponent(window.location.pathname + window.location.search);
        window.location.href = '/login?returnUrl=' + currentUrl;
    }
}

// ========================================
// 페이지 초기화
// ========================================
document.addEventListener('DOMContentLoaded', function() {
    console.log('영화 예매 페이지 초기화 시작');

    // 오늘 날짜 설정
    const today = new Date();
    const dateString = today.toISOString().split('T')[0];
    document.getElementById('dateSelector').value = dateString;
    selectedDate = dateString;

    // 초기 데이터 로드
    loadMovies();
    loadSchedule();

    // 이벤트 리스너 등록
    document.getElementById('movieSelector').addEventListener('change', function() {
        selectedMovieId = this.value;
        loadSchedule();
    });

    document.getElementById('dateSelector').addEventListener('change', function() {
        selectedDate = this.value;
        loadSchedule();
    });

    console.log('영화 예매 페이지 초기화 완료');
});

// ========================================
// 영화 목록 로드
// ========================================
function loadMovies() {
    console.log('영화 목록 로드 시작');

    fetch('/api/movies')
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                const movieSelector = document.getElementById('movieSelector');
                movieSelector.innerHTML = '<option value="">전체 영화</option>';

                data.movies.forEach(movie => {
                    const option = document.createElement('option');
                    option.value = movie.movie_id;
                    option.textContent = movie.title;
                    movieSelector.appendChild(option);
                });

                console.log('영화 목록 로드 완료:', data.movies.length + '편');
            } else {
                console.error('영화 목록 로드 실패:', data.message);
            }
        })
        .catch(error => {
            console.error('영화 목록 로드 오류:', error);
        });
}

// ========================================
// 상영 시간표 로드
// ========================================
function loadSchedule() {
    console.log('상영 시간표 로드 시작');

    const params = new URLSearchParams();
    if (selectedMovieId) params.append('movieId', selectedMovieId);
    if (selectedDate) params.append('date', selectedDate);

    fetch('/api/schedule?' + params.toString())
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                displaySchedule(data.schedule);
                console.log('상영 시간표 로드 완료:', data.schedule.length + '건');
            } else {
                console.error('상영 시간표 로드 실패:', data.message);
                document.getElementById('scheduleList').innerHTML =
                    '<div class="no-schedule">상영 시간표가 없습니다.</div>';
            }
        })
        .catch(error => {
            console.error('상영 시간표 로드 오류:', error);
            document.getElementById('scheduleList').innerHTML =
                '<div class="error-message">상영 시간표를 불러오는 중 오류가 발생했습니다.</div>';
        });
}

// ========================================
// 상영 시간표 표시
// ========================================
function displaySchedule(schedule) {
    const scheduleList = document.getElementById('scheduleList');

    if (!schedule || schedule.length === 0) {
        scheduleList.innerHTML = '<div class="no-schedule">선택한 조건에 맞는 상영 시간표가 없습니다.</div>';
        return;
    }

    // 영화별로 그룹화
    const movieGroups = {};
    schedule.forEach(item => {
        if (!movieGroups[item.movie_title]) {
            movieGroups[item.movie_title] = [];
        }
        movieGroups[item.movie_title].push(item);
    });

    let html = '';
    Object.keys(movieGroups).forEach(movieTitle => {
        html += `<div class="movie-group">
            <h3 class="movie-title">${movieTitle}</h3>
            <div class="showtime-list">`;

        movieGroups[movieTitle].forEach(showtime => {
            const availableSeats = showtime.available_seats || 0;
            const totalSeats = showtime.total_seats || 0;
            const isAvailable = availableSeats > 0;

            html += `
                <div class="showtime-item ${isAvailable ? 'available' : 'full'}" 
                     onclick="${isAvailable ? `selectShowtime(${showtime.runtime_id}, '${movieTitle}', '${showtime.start_time}', '${showtime.room_name}', ${showtime.price || 12000})` : 'alert(\'매진된 상영입니다.\')'}">
                    <div class="showtime-info">
                        <span class="time">${showtime.start_time}</span>
                        <span class="room">${showtime.room_name}</span>
                        <span class="seats">${availableSeats}/${totalSeats}</span>
                    </div>
                    <div class="showtime-status">
                        ${isAvailable ? '예매가능' : '매진'}
                    </div>
                </div>
            `;
        });

        html += '</div></div>';
    });

    scheduleList.innerHTML = html;
}

// ========================================
// 상영시간 선택
// ========================================
function selectShowtime(runtimeId, movieTitle, startTime, roomName, price) {
    console.log('상영시간 선택:', movieTitle, startTime, roomName);

    selectedShowtime = {
        runtimeId: runtimeId,
        movieTitle: movieTitle,
        startTime: startTime,
        roomName: roomName,
        price: price
    };

    seatPrice = price || 12000;

    // 단계 업데이트
    updateSteps(2);

    // 좌석 정보 로드
    loadSeats(runtimeId);
}

// ========================================
// 단계 표시 업데이트
// ========================================
function updateSteps(currentStep) {
    const steps = document.querySelectorAll('.step');
    steps.forEach((step, index) => {
        step.classList.remove('active', 'completed');
        if (index + 1 < currentStep) {
            step.classList.add('completed');
        } else if (index + 1 === currentStep) {
            step.classList.add('active');
        }
    });
}

// ========================================
// 좌석 정보 로드
// ========================================
function loadSeats(runtimeId) {
    console.log('좌석 정보 로드 시작 - Runtime ID:', runtimeId);

    fetch(`/seat/${runtimeId}/seats`)
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                showSeatSelection(data.runtime, data.seats);
                console.log('좌석 정보 로드 완료:', data.seats.length + '석');
            } else {
                alert('좌석 정보를 불러오는 중 오류가 발생했습니다: ' + data.message);
            }
        })
        .catch(error => {
            console.error('좌석 정보 로드 오류:', error);
            alert('좌석 정보를 불러오는 중 오류가 발생했습니다.');
        });
}

// ========================================
// 좌석 선택 화면 표시
// ========================================
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

// ========================================
// 좌석 맵 생성
// ========================================
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

// ========================================
// 좌석 선택/해제
// ========================================
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

// ========================================
// 선택된 좌석 정보 업데이트
// ========================================
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

// ========================================
// 좌석 선택 취소
// ========================================
function cancelSeatSelection() {
    selectedSeats = [];
    updateSteps(1);
    document.getElementById('seatSelection').classList.remove('active');
    document.getElementById('scheduleSection').style.display = 'block';
}

// ========================================
// 좌석 선택 확인 - 결제 단계로 이동
// ========================================
function confirmSeats() {
    if (selectedSeats.length === 0) {
        alert('좌석을 선택해주세요.');
        return;
    }

    // 로그인 상태 확인
    checkLoginStatus().then(isLoggedIn => {
        if (!isLoggedIn) {
            requireLogin();
            return;
        }

        // 로그인된 경우 결제 단계로 이동
        const totalAmount = selectedSeats.length * seatPrice;
        const seatLabels = selectedSeats.map(seat => seat.seat_row + seat.seat_number).join(', ');

        showPaymentSection(totalAmount, seatLabels);
    });
}

// ========================================
// 결제 섹션 표시
// ========================================
function showPaymentSection(amount, seatLabels) {
    // 결제 요약 정보 채우기
    document.getElementById('paymentSummary').innerHTML = `
        <div class="payment-summary-box">
            <h3>최종 예매 내역 확인</h3>
            <p><strong>영화:</strong> ${selectedShowtime.movieTitle}</p>
            <p><strong>상영시간:</strong> ${selectedShowtime.startTime}</p>
            <p><strong>상영관:</strong> ${selectedShowtime.roomName}</p>
            <p><strong>좌석:</strong> ${seatLabels}</p>
            <p><strong>최종 결제 금액:</strong> ${amount.toLocaleString()}원</p>
        </div>
    `;

    // 진행 단계 업데이트
    updateSteps(3);

    // 화면 전환
    document.getElementById('seatSelection').classList.remove('active');
    document.getElementById('paymentSection').style.display = 'block';

    // 결제 버튼 활성화
    const paymentButton = document.getElementById('payment-button');
    paymentButton.disabled = false;
    paymentButton.onclick = processPaymentAndReserve;
}

// ========================================
// 결제 처리 및 예약 생성
// ========================================
function processPaymentAndReserve() {
    console.log('🎫 예약 생성 시작');

    // 중복 클릭 방지
    document.getElementById('payment-button').disabled = true;

    const runtimeId = parseInt(selectedShowtime.runtimeId);
    const selectedSeatIds = selectedSeats.map(seat => parseInt(seat.seat_id));

    // 서버에 예약 생성 요청
    fetch('/seat/reserve', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({
            runtimeId: runtimeId,
            selectedSeatIds: selectedSeatIds
        })
    })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                console.log('✅ 예약 생성 성공:', data.reservation);

                // 예약 완료 화면 표시
                updateSteps(4);
                document.getElementById('paymentSection').style.display = 'none';
                showReservationComplete(data.reservation);

            } else if (data.requireLogin) {
                console.log('🔐 로그인 필요');
                requireLogin();

            } else {
                console.error('❌ 예약 생성 실패:', data.message);
                alert('예약 중 오류가 발생했습니다: ' + data.message);
                document.getElementById('payment-button').disabled = false;
            }
        })
        .catch(error => {
            console.error('❌ 예약 생성 오류:', error);
            alert('예약 처리 중 오류가 발생했습니다.');
            document.getElementById('payment-button').disabled = false;
        });
}

// ========================================
// 예약 완료 화면 표시
// ========================================
function showReservationComplete(reservation) {
    const completionInfo = document.getElementById('completionInfo');

    completionInfo.innerHTML = `
        <div class="completion-card">
            <div class="completion-icon">✅</div>
            <h3>예약이 완료되었습니다!</h3>
            
            <div class="completion-details">
                <p><strong>예약번호:</strong> ${reservation.reservation_id}</p>
                <p><strong>영화:</strong> ${reservation.movie_title || selectedShowtime.movieTitle}</p>
                <p><strong>상영시간:</strong> ${reservation.start_time || selectedShowtime.startTime}</p>
                <p><strong>상영관:</strong> ${reservation.room_name || selectedShowtime.roomName}</p>
                <p><strong>좌석:</strong> ${reservation.selected_seats || selectedSeats.map(s => s.seat_row + s.seat_number).join(', ')}</p>
                <p><strong>총 금액:</strong> ${reservation.total_amount ? reservation.total_amount.toLocaleString() : (selectedSeats.length * seatPrice).toLocaleString()}원</p>
            </div>
            
            <div class="completion-actions">
                <button onclick="goToReservationList()" class="btn btn-primary">예약 내역 확인</button>
                <button onclick="goToHome()" class="btn btn-secondary">메인으로</button>
            </div>
        </div>
    `;

    document.getElementById('completionSection').style.display = 'block';
}

// ========================================
// 네비게이션 함수들
// ========================================
function goToReservationList() {
    window.location.href = '/reservation/list';
}

function goToHome() {
    window.location.href = '/';
}

// ========================================
// 좌석 상태 새로고침
// ========================================
function refreshSeatStatus() {
    if (selectedShowtime) {
        console.log('🔄 좌석 상태 새로고침');

        fetch(`/seat/${selectedShowtime.runtimeId}/refresh`)
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    updateSeatStatus(data.reservedSeats);
                    console.log('✅ 좌석 상태 새로고침 완료');
                } else {
                    console.error('❌ 좌석 상태 새로고침 실패:', data.message);
                }
            })
            .catch(error => {
                console.error('❌ 좌석 상태 새로고침 오류:', error);
            });
    }
}

// ========================================
// 좌석 상태 업데이트
// ========================================
function updateSeatStatus(reservedSeatIds) {
    const seatElements = document.querySelectorAll('.seat');

    seatElements.forEach(seatElement => {
        const seatId = parseInt(seatElement.dataset.seatId);

        if (reservedSeatIds.includes(seatId)) {
            // 예약된 좌석으로 변경
            seatElement.classList.remove('available', 'selected');
            seatElement.classList.add('reserved');
            seatElement.onclick = null;

            // 선택된 좌석 목록에서 제거
            selectedSeats = selectedSeats.filter(seat => parseInt(seat.seat_id) !== seatId);
        }
    });

    // 선택된 좌석 정보 업데이트
    updateSelectedSeatsInfo();
}

// ========================================
// 유틸리티 함수들
// ========================================

// 페이지 떠날 때 확인
window.addEventListener('beforeunload', function(e) {
    if (selectedSeats.length > 0) {
        e.preventDefault();
        e.returnValue = '';
    }
});

// 정기적으로 좌석 상태 새로고침 (선택사항)
setInterval(function() {
    if (selectedShowtime && document.getElementById('seatSelection').classList.contains('active')) {
        refreshSeatStatus();
    }
}, 30000); // 30초마다 새로고침