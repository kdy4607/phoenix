// 현재 로그인 상태 (서버에서 전달받은 정보)
const isLoggedIn = /${not empty sessionScope.user ? 'true' : 'false'};
const currentUser = isLoggedIn ? {
    id: '${sessionScope.user.u_id}',
    name: '${sessionScope.user.u_name}',
    loginId: '${sessionScope.user.u_id}'
} : null;

console.log('현재 로그인 상태:', isLoggedIn);
if (currentUser) {
    console.log('로그인 사용자:', currentUser.name);
}

// 사용자 메뉴 토글
function toggleUserMenu() {
    const dropdown = document.getElementById('userDropdown');
    if (dropdown) {
        dropdown.classList.toggle('show');

        // 외부 클릭 시 메뉴 닫기
        document.addEventListener('click', function(event) {
            if (!event.target.closest('.user-menu')) {
                dropdown.classList.remove('show');
            }
        });
    }
}

// 로그아웃 함수
function logout() {
    if (confirm('로그아웃하시겠습니까?')) {
        console.log('로그아웃 처리 시작');

        // 서버에 로그아웃 요청
        fetch('/logout', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            }
        })
            .then(response => {
                if (response.ok) {
                    console.log('로그아웃 성공');
                    alert('로그아웃 되었습니다.');
                    // 메인 페이지로 이동
                    window.location.href = '/';
                } else {
                    console.error('로그아웃 실패');
                    alert('로그아웃 중 오류가 발생했습니다.');
                }
            })
            .catch(error => {
                console.error('로그아웃 오류:', error);
                // 오류가 발생해도 로그아웃 처리
                alert('로그아웃 되었습니다.');
                window.location.href = '/';
            });
    }
}

// 예약내역 버튼 클릭 시 로그인 체크
function checkLoginForReservation(event) {
    if (!isLoggedIn) {
        event.preventDefault();
        if (confirm('예약내역을 확인하려면 로그인이 필요합니다.\n로그인 페이지로 이동하시겠습니까?')) {
            window.location.href = '/login?returnUrl=' + encodeURIComponent('/reservation/list');
        }
        return false;
    }
    return true;
}

// 페이지 로드 시 초기화
document.addEventListener('DOMContentLoaded', function() {
    console.log('헤더 초기화 완료');

    // 예약내역 링크에 로그인 체크 추가
    const reservationLinks = document.querySelectorAll('a[href="/reservation/list"]');
    reservationLinks.forEach(link => {
        link.addEventListener('click', checkLoginForReservation);
    });

    // 로그인 상태에 따른 추가 초기화
    if (isLoggedIn) {
        console.log('로그인된 사용자:', currentUser.name);

        // 마이페이지 링크 활성화 등 추가 작업 가능
        updateUserSpecificUI();
    } else {
        console.log('비로그인 상태');
    }
});

// 사용자별 UI 업데이트
function updateUserSpecificUI() {
    if (!isLoggedIn || !currentUser) return;

    // 사용자 환영 메시지 (선택사항)
    console.log('환영합니다, ' + currentUser.name + '님!');

    // 예약 알림 확인 (선택사항)
    checkUserNotifications();
}

// 사용자 알림 확인 (선택사항)
function checkUserNotifications() {
    if (!isLoggedIn) return;

    // 최근 예약 또는 알림 확인
    fetch('/reservation/stats')
        .then(response => response.json())
        .then(data => {
            if (data.success && data.stats) {
                console.log('사용자 예약 통계:', data.stats);
                // 필요시 알림 표시
            }
        })
        .catch(error => {
            console.log('알림 확인 중 오류:', error);
        });
}

// 전역 함수로 로그인 상태 확인 제공
window.getLoginStatus = function() {
    return {
        isLoggedIn: isLoggedIn,
        user: currentUser
    };
};

// 로그인 필요한 기능 체크 함수
window.requireLogin = function(callback) {
    if (isLoggedIn) {
        callback();
    } else {
        if (confirm('이 기능을 사용하려면 로그인이 필요합니다.\n로그인 페이지로 이동하시겠습니까?')) {
            window.location.href = '/login?returnUrl=' + encodeURIComponent(window.location.pathname);
        }
    }
};

// 예약 관련 전용 함수들
window.reservationUtils = {
    // 내 예약 목록으로 이동
    goToMyReservations: function() {
        if (isLoggedIn) {
            window.location.href = '/reservation/list';
        } else {
            window.requireLogin();
        }
    },

    // 예약 상세 보기
    viewReservationDetail: function(reservationId) {
        if (!isLoggedIn) {
            window.requireLogin();
            return;
        }

        fetch('/reservation/' + reservationId)
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    console.log('예약 상세 정보:', data.reservation);
                    // 상세 정보 표시 로직
                } else {
                    alert(data.message || '예약 정보를 불러올 수 없습니다.');
                }
            })
            .catch(error => {
                console.error('예약 정보 조회 오류:', error);
                alert('예약 정보 조회 중 오류가 발생했습니다.');
            });
    }
};