// 현재 사용자 정보
const currentUser = {
    isLoggedIn: /${not empty user},
`<c:if test="\${not empty user}">
    id: '${user.u_id}',
    name: '${user.u_name}',
    loginId: '${user.u_id}'
</c:if>`
};

console.log('예약 내역 페이지 로드 - 사용자:', currentUser);

// 예약 상세 보기
function viewReservationDetail(reservationId) {
    console.log('🔍 예약 상세 조회 - ID:', reservationId);

    fetch('/reservation/' + reservationId)
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                showReservationModal(data.reservation);
            } else {
                alert('❌ ' + (data.message || '예약 정보를 불러올 수 없습니다.'));
            }
        })
        .catch(error => {
            console.error('예약 정보 조회 오류:', error);
            alert('❌ 예약 정보 조회 중 오류가 발생했습니다.');
        });
}

// 예약 상세 모달 표시
function showReservationModal(reservation) {
    const modal = `
        <div class="modal-overlay" onclick="closeModal()">
            <div class="modal-content" onclick="event.stopPropagation()">
                <div class="modal-header">
                    <h3>예약 상세 정보</h3>
                    <button onclick="closeModal()" class="modal-close">×</button>
                </div>
                <div class="modal-body">
                    <p><strong>예약번호:</strong> ${reservation.reservation_id}</p>
                    <p><strong>영화:</strong> ${reservation.movie_title}</p>
                    <p><strong>상영관:</strong> ${reservation.room_name}</p>
                    <p><strong>상영일:</strong> ${reservation.run_date}</p>
                    <p><strong>상영시간:</strong> ${reservation.start_time}</p>
                    <p><strong>좌석:</strong> ${reservation.selected_seats || '정보 없음'}</p>
                    <p><strong>관람인원:</strong> 성인 ${reservation.adult}명, 청소년 ${reservation.youth}명, 어린이 ${reservation.child}명</p>
                    <p><strong>총 금액:</strong> ${reservation.total_amount.toLocaleString()}원</p>
                    <p><strong>예약상태:</strong> ${reservation.reservation_status}</p>
                </div>
            </div>
        </div>
    `;

    document.body.insertAdjacentHTML('beforeend', modal);
}

// 모달 닫기
function closeModal() {
    const modal = document.querySelector('.modal-overlay');
    if (modal) {
        modal.remove();
    }
}

// 예약 취소
function cancelReservation(reservationId) {
    console.log('🗑️ 예약 취소 시도 - ID:', reservationId);

    if (!confirm('정말로 예약을 취소하시겠습니까?\n\n취소된 예약은 복구할 수 없습니다.')) {
        return;
    }

    fetch('/reservation/' + reservationId + '/cancel', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        }
    })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                alert('✅ 예약이 취소되었습니다.');
                location.reload();
            } else {
                alert('❌ ' + (data.message || '예약 취소 중 오류가 발생했습니다.'));
            }
        })
        .catch(error => {
            console.error('예약 취소 오류:', error);
            alert('❌ 예약 취소 중 오류가 발생했습니다.');
        });
}

// 예약 필터링
function filterReservations() {
    const filter = document.getElementById('statusFilter').value;
    const cards = document.querySelectorAll('.reservation-card');

    cards.forEach(card => {
        const status = card.getAttribute('data-status');
        if (filter === 'all' || status === filter) {
            card.style.display = 'block';
        } else {
            card.style.display = 'none';
        }
    });
}

// 예약 정렬
function sortReservations() {
    const sortOrder = document.getElementById('sortOrder').value;
    const container = document.getElementById('reservationList');
    const cards = Array.from(container.children);

    cards.sort((a, b) => {
        switch(sortOrder) {
            case 'recent':
                return parseInt(b.getAttribute('data-reservation-id')) - parseInt(a.getAttribute('data-reservation-id'));
            case 'old':
                return parseInt(a.getAttribute('data-reservation-id')) - parseInt(b.getAttribute('data-reservation-id'));
            case 'amount':
                return parseInt(b.getAttribute('data-amount')) - parseInt(a.getAttribute('data-amount'));
            default:
                return 0;
        }
    });

    cards.forEach(card => container.appendChild(card));
}

// 예약 목록 새로고침
function refreshReservations() {
    console.log('🔄 예약 목록 새로고침');
    location.reload();
}

// 페이지 로드 시 초기화
document.addEventListener('DOMContentLoaded', function() {
    console.log('예약 내역 페이지 초기화 완료');

    // 초기 정렬 (최신순)
    if (document.getElementById('sortOrder')) {
        sortReservations();
    }
});