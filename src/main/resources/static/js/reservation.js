// ========================================
// 예약 상세 정보 조회 (개선된 버전)
// ========================================
function showReservationDetail(reservationId) {
    console.log('🔍 예약 상세 정보 조회 시작 - ID:', reservationId);

    fetch('/reservation/' + reservationId)
        .then(response => {
            console.log('📡 응답 상태:', response.status);
            if (!response.ok) {
                throw new Error(`HTTP ${response.status}: ${response.statusText}`);
            }
            return response.json();
        })
        .then(data => {
            console.log('📊 응답 데이터:', data);

            if (data.success) {
                const reservation = data.reservation;
                console.log('✅ 예약 정보 수신 성공:', reservation);

                // 데이터 유효성 검사
                if (!reservation) {
                    alert('❌ 예약 정보가 비어있습니다.');
                    return;
                }

                // 날짜 포맷팅 함수
                function formatDate(dateStr) {
                    if (!dateStr) return '정보 없음';
                    try {
                        const date = new Date(dateStr);
                        return date.toLocaleDateString('ko-KR', {
                            year: 'numeric',
                            month: '2-digit',
                            day: '2-digit',
                            weekday: 'short'
                        });
                    } catch (e) {
                        console.warn('날짜 포맷팅 오류:', e);
                        return dateStr;
                    }
                }

                // 좌석 정보 처리
                let seatInfo = '정보 없음';
                if (reservation.selected_seats && reservation.selected_seats.trim() !== '') {
                    seatInfo = reservation.selected_seats;
                } else if (reservation.selectedSeats && reservation.selectedSeats.trim() !== '') {
                    seatInfo = reservation.selectedSeats;
                }

                // 관람인원 정보 구성
                let audienceInfo = '';
                const adult = reservation.adult || 0;
                const youth = reservation.youth || 0;
                const child = reservation.child || 0;

                if (adult > 0) audienceInfo += `성인 ${adult}명`;
                if (youth > 0) audienceInfo += (audienceInfo ? ', ' : '') + `청소년 ${youth}명`;
                if (child > 0) audienceInfo += (audienceInfo ? ', ' : '') + `어린이 ${child}명`;
                if (!audienceInfo) audienceInfo = '정보 없음';

                // 금액 포맷팅
                const totalAmount = reservation.total_amount || 0;
                const formattedAmount = totalAmount.toLocaleString() + '원';

                // 상세 정보 메시지 구성
                let message = `📋 예약 상세 정보\n\n`;
                message += `🎫 예약번호: ${reservation.reservation_id || '정보 없음'}\n`;
                message += `🎬 영화: ${reservation.movie_title || '정보 없음'}\n`;
                message += `🏢 상영관: ${reservation.room_name || '정보 없음'}\n`;
                message += `📅 상영일: ${formatDate(reservation.run_date)}\n`;
                message += `⏰ 상영시간: ${reservation.start_time || '정보 없음'}\n`;
                message += `🪑 좌석: ${seatInfo}\n`;
                message += `👥 관람인원: ${audienceInfo}\n`;
                message += `💰 결제금액: ${formattedAmount}\n`;
                message += `📋 예약상태: ${reservation.reservation_status || '정보 없음'}\n`;

                // 예약일시 처리
                if (reservation.reserved_at) {
                    try {
                        const reservedDate = new Date(reservation.reserved_at);
                        const formattedReservedDate = reservedDate.toLocaleString('ko-KR', {
                            year: 'numeric',
                            month: '2-digit',
                            day: '2-digit',
                            hour: '2-digit',
                            minute: '2-digit'
                        });
                        message += `📝 예약일시: ${formattedReservedDate}`;
                    } catch (e) {
                        console.warn('예약일시 포맷팅 오류:', e);
                        message += `📝 예약일시: ${reservation.reserved_at}`;
                    }
                } else {
                    message += `📝 예약일시: 정보 없음`;
                }

                console.log('📝 표시할 메시지:', message);
                alert(message);

            } else {
                console.error('❌ 응답 실패:', data.message);
                alert('❌ ' + (data.message || '예약 정보를 불러올 수 없습니다.'));
            }
        })
        .catch(error => {
            console.error('❌ 네트워크 오류:', error);
            alert(`❌ 예약 정보를 불러오는 중 오류가 발생했습니다.\n\n오류 내용: ${error.message}\n\n페이지를 새로고침 후 다시 시도해주세요.`);
        });
}

// ========================================
// 디버깅용 상세 정보 조회 함수
// ========================================
function showReservationDetailDebug(reservationId) {
    console.log('🐛 디버그 모드로 예약 상세 정보 조회 - ID:', reservationId);

    fetch('/reservation/debug/' + reservationId)
        .then(response => response.json())
        .then(data => {
            console.log('🐛 디버그 데이터:', data);

            if (data.success) {
                let debugMessage = `🐛 디버그 정보 (예약 ID: ${reservationId})\n\n`;
                debugMessage += `기본 예약 정보: ${data.basicReservation ? 'OK' : 'NULL'}\n`;
                debugMessage += `좌석 정보 개수: ${data.seatCount}\n`;
                debugMessage += `완전한 예약 정보: ${data.fullReservation ? 'OK' : 'NULL'}\n\n`;

                if (data.basicReservation) {
                    const basic = data.basicReservation;
                    debugMessage += `=== 기본 정보 ===\n`;
                    debugMessage += `영화: ${basic.movie_title || 'NULL'}\n`;
                    debugMessage += `상영관: ${basic.room_name || 'NULL'}\n`;
                    debugMessage += `상영일: ${basic.run_date || 'NULL'}\n`;
                    debugMessage += `상영시간: ${basic.start_time || 'NULL'}\n`;
                    debugMessage += `금액: ${basic.total_amount || 'NULL'}\n`;
                    debugMessage += `상태: ${basic.reservation_status || 'NULL'}\n\n`;
                }

                if (data.seats && data.seats.length > 0) {
                    debugMessage += `=== 좌석 정보 ===\n`;
                    data.seats.forEach((seat, index) => {
                        debugMessage += `${index + 1}. ${seat.seat_row}${seat.seat_number} (ID: ${seat.seat_id})\n`;
                    });
                    debugMessage += `\n`;
                }

                if (data.fullReservation) {
                    const full = data.fullReservation;
                    debugMessage += `=== 완전한 정보 ===\n`;
                    debugMessage += `좌석 문자열: "${full.selected_seats || 'NULL'}"\n`;
                }

                console.log(debugMessage);
                alert(debugMessage);
            } else {
                console.error('디버그 실패:', data.error);
                alert('❌ 디버그 정보 조회 실패: ' + data.error);
            }
        })
        .catch(error => {
            console.error('디버그 오류:', error);
            alert('❌ 디버그 조회 중 오류: ' + error.message);
        });
}

// ========================================
// 예약 취소 함수
// ========================================
function cancelReservation(reservationId) {
    console.log('🗑️ 예약 취소 시도 - ID:', reservationId);

    if (!confirm('정말로 예약을 취소하시겠습니까?\n\n취소된 예약은 복구할 수 없습니다.')) {
        console.log('사용자가 취소를 중단했습니다.');
        return;
    }

    fetch('/reservation/' + reservationId + '/cancel', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        }
    })
        .then(response => {
            console.log('취소 응답 상태:', response.status);
            return response.json();
        })
        .then(data => {
            console.log('취소 응답 데이터:', data);
            if (data.success) {
                alert('✅ 예약이 취소되었습니다.');
                location.reload();
            } else {
                alert('❌ ' + (data.message || '예약 취소 중 오류가 발생했습니다.'));
            }
        })
        .catch(error => {
            console.error('취소 오류:', error);
            alert('❌ 예약 취소 중 오류가 발생했습니다.\n\n오류: ' + error.message);
        });
}

// ========================================
// 디버깅 함수들
// ========================================
function testReservationData() {
    console.log('🧪 예약 데이터 테스트 시작...');

    const reservationCards = document.querySelectorAll('.reservation-card');
    console.log(`총 ${reservationCards.length}개의 예약 카드 발견`);

    reservationCards.forEach((card, index) => {
        const reservationId = card.dataset.reservationId || '알 수 없음';
        const movieTitle = card.querySelector('.movie-details h3')?.textContent || '제목 없음';
        const seatNumbers = card.querySelector('.seat-numbers')?.textContent || '좌석 정보 없음';

        console.log(`예약 ${index + 1}: ID=${reservationId}, 영화="${movieTitle}", 좌석="${seatNumbers}"`);
    });

    alert(`💡 콘솔에서 디버깅 정보를 확인하세요.\n총 ${reservationCards.length}개의 예약이 발견되었습니다.`);
}

function testAllReservations() {
    console.log('🧪 모든 예약 API 테스트 시작...');

    const reservationCards = document.querySelectorAll('.reservation-card');
    let testPromises = [];

    reservationCards.forEach((card, index) => {
        const reservationId = card.dataset.reservationId;
        if (reservationId) {
            const promise = fetch(`/reservation/${reservationId}`)
                .then(r => r.json())
                .then(data => {
                    console.log(`테스트 ${index + 1} (ID: ${reservationId}):`, data.success ? '성공' : '실패');
                    return { id: reservationId, success: data.success, data: data };
                })
                .catch(error => {
                    console.error(`테스트 ${index + 1} (ID: ${reservationId}) 오류:`, error);
                    return { id: reservationId, success: false, error: error.message };
                });
            testPromises.push(promise);
        }
    });

    Promise.all(testPromises).then(results => {
        const successCount = results.filter(r => r.success).length;
        const failCount = results.length - successCount;

        console.log(`🧪 전체 테스트 완료: 성공 ${successCount}개, 실패 ${failCount}개`);
        alert(`🧪 전체 테스트 완료!\n\n성공: ${successCount}개\n실패: ${failCount}개\n\n자세한 내용은 콘솔을 확인하세요.`);
    });
}

// ========================================
// 페이지 초기화
// ========================================
document.addEventListener('DOMContentLoaded', function() {
    const urlParams = new URLSearchParams(window.location.search);
    const isDebugMode = urlParams.get('debug') === 'true';

    if (isDebugMode) {
        console.log('🔍 디버깅 모드 활성화');
        console.log('💡 팁1: Shift + 상세정보 클릭으로 디버그 정보 확인 가능');
        console.log('💡 팁2: 브라우저 콘솔에서 testReservationData() 실행 가능');
        console.log('💡 팁3: fetch("/reservation/1").then(r=>r.json()).then(console.log) 으로 직접 API 테스트 가능');

        // Shift + 클릭으로 디버그 모드 활성화
        const detailButtons = document.querySelectorAll('.detail-btn');
        detailButtons.forEach(btn => {
            btn.addEventListener('click', function(e) {
                if (e.shiftKey) {
                    e.preventDefault();
                    const reservationId = btn.getAttribute('onclick').match(/\d+/)[0];
                    showReservationDetailDebug(reservationId);
                }
            });
        });
    }

    // 예약 카드 개수 로깅
    const reservationCards = document.querySelectorAll('.reservation-card');
    console.log(`📊 현재 페이지에 ${reservationCards.length}개의 예약이 표시됨`);

    // 각 예약 카드에 마우스 오버 이벤트 추가 (디버깅용)
    if (isDebugMode) {
        reservationCards.forEach(card => {
            card.addEventListener('mouseenter', function() {
                const reservationId = card.dataset.reservationId;
                console.log(`🖱️ 마우스 오버 - 예약 ID: ${reservationId}`);
            });
        });
    }
});

// 전역 오류 처리
window.addEventListener('error', function(e) {
    console.error('🚨 전역 오류 발생:', e.error);
});

window.addEventListener('unhandledrejection', function(e) {
    console.error('🚨 처리되지 않은 Promise 거부:', e.reason);
});