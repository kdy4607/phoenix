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

// 상영시간 선택
function selectShowtime(element) {
    document.querySelectorAll('.showtime-btn').forEach(btn => {
        btn.classList.remove('selected');
    });
    element.classList.add('selected');

    selectedShowtime = {
        runtimeId: parseInt(element.dataset.runtimeId), // 정수로 변환
        movieTitle: element.dataset.movieTitle,
        startTime: element.dataset.startTime,
        roomName: element.dataset.roomName,
        availableSeats: parseInt(element.dataset.availableSeats) // 정수로 변환
    };

    showSelectedInfo();
}

// 선택된 상영시간 정보 표시
function showSelectedInfo() {
    if (selectedShowtime) {
        const infoDiv = document.getElementById('selectedShowtimeInfo');
        const detailsP = document.getElementById('selectedDetails');

        detailsP.innerHTML = '<strong>' + selectedShowtime.movieTitle + '</strong><br>' +
            selectedShowtime.startTime + ' | ' + selectedShowtime.roomName + ' | 잔여좌석: ' + selectedShowtime.availableSeats + '석';

        infoDiv.style.display = 'block';
    }
}

// 좌석 선택 화면 로드
function loadSeatSelection() {
    if (!selectedShowtime) {
        alert('상영시간을 먼저 선택해주세요.');
        return;
    }

    // 단계 표시 업데이트
    updateSteps(2);

    // runtimeId를 정수로 변환
    const runtimeId = parseInt(selectedShowtime.runtimeId);

    // 좌석 정보 로드
    fetch('/seat/runtime/' + runtimeId)
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                allSeats = data.seats;
                seatPrice = data.runtime.price || 12000;

                // 좌석 선택 화면 표시
                showSeatSelection(data.runtime, data.seats);
            } else {
                alert(data.message || '좌석 정보를 불러올 수 없습니다.');
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('좌석 정보를 불러오는 중 오류가 발생했습니다.');
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
function confirmSeats() {
    if (selectedSeats.length === 0) {
        alert('좌석을 선택해주세요.');
        return;
    }

    // 확인 메시지
    const seatLabels = selectedSeats.map(seat => seat.seat_row + seat.seat_number).join(', ');
    const totalAmount = selectedSeats.length * seatPrice;

    const confirmMessage = '다음 내용으로 예약하시겠습니까?\n\n' +
        '영화: ' + selectedShowtime.movieTitle + '\n' +
        '상영시간: ' + selectedShowtime.startTime + '\n' +
        '상영관: ' + selectedShowtime.roomName + '\n' +
        '좌석: ' + seatLabels + '\n' +
        '총 금액: ' + totalAmount.toLocaleString() + '원';

    if (!confirm(confirmMessage)) {
        return;
    }

    // 좌석 ID를 정수로 변환
    const selectedSeatIds = selectedSeats.map(seat => parseInt(seat.seat_id));
    const runtimeId = parseInt(selectedShowtime.runtimeId);

    // 예약 생성 요청
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
                // 예약 완료 메시지 표시
                showReservationComplete(data.reservation);
                updateSteps(4);
            } else {
                alert(data.message || '예약 중 오류가 발생했습니다.');
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert('예약 중 오류가 발생했습니다.');
        });
}

// 예약 완료 화면 표시
function showReservationComplete(reservation) {
    const message = '🎉 예약이 완료되었습니다!\n\n' +
        '예약번호: ' + reservation.reservation_id + '\n' +
        '영화: ' + reservation.movie_title + '\n' +
        '상영시간: ' + reservation.start_time + '\n' +
        '상영관: ' + reservation.room_name + '\n' +
        '좌석: ' + reservation.selected_seats + '\n' +
        '총 금액: ' + reservation.total_amount.toLocaleString() + '원\n\n' +
        '예약 내역은 마이페이지에서 확인할 수 있습니다.';

    alert(message);

    // 예약 내역 페이지로 이동할지 메인 페이지로 이동할지 선택
    if (confirm('예약 내역을 확인하시겠습니까?')) {
        window.location.href = '/reservation/list';
    } else {
        window.location.href = '/';
    }
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