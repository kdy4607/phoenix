<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>예약 내역 - Phoenix Cinema</title>
    <link rel="stylesheet" href="/resources/css/schedule.css">
    <style>
        /* schedule 페이지와 통일된 디자인 시스템 */
        body {
            font-family: 'Segoe UI', -apple-system, BlinkMacSystemFont, sans-serif;
            background-color: #f5f5f5;
            color: #333;
            line-height: 1.6;
            margin: 0;
            padding: 0;
        }

        .reservation-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        /* 헤더 섹션 */
        .page-header {
            background-color: #fff;
            padding: 20px;
            margin-bottom: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .page-header h1 {
            font-size: 28px;
            font-weight: 600;
            color: #333;
            margin: 0;
        }

        /* 사용자 환영 메시지 */
        .user-welcome {
            background-color: #fff;
            padding: 20px;
            margin-bottom: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            border-left: 4px solid #FB4357;
        }

        .user-welcome h2 {
            font-size: 20px;
            color: #333;
            margin: 0 0 8px 0;
        }

        .user-welcome p {
            color: #666;
            margin: 0;
        }

        /* 통계 섹션 - schedule과 동일 */
        .reservation-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 20px;
        }

        .stat-item {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            text-align: center;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
            border: 1px solid #e5e5e5;
        }

        .stat-number {
            font-size: 24px;
            font-weight: bold;
            color: #FB4357;
            margin-bottom: 8px;
        }

        .stat-label {
            color: #666;
            font-size: 14px;
        }

        /* 섹션 스타일 - schedule과 동일 */
        .section {
            background-color: #fff;
            margin-bottom: 20px;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        .section-header {
            background-color: #333;
            color: white;
            padding: 15px 20px;
            font-size: 18px;
            font-weight: 600;
        }

        .section-content {
            padding: 20px;
        }

        /* 필터 바 */
        .reservation-filters {
            margin-bottom: 20px;
        }

        .filter-group {
            display: flex;
            gap: 15px;
            align-items: center;
            flex-wrap: wrap;
        }

        .filter-group label {
            font-weight: 600;
            color: #333;
        }

        .filter-group select {
            padding: 8px 12px;
            border: 1px solid #e5e5e5;
            border-radius: 4px;
            background-color: #fff;
            color: #333;
        }

        /* 버튼 시스템 - schedule과 동일 */
        .btn, .btn-primary, .btn-secondary, .btn-detail, .btn-cancel, .btn-debug {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            padding: 12px 24px;
            border: none;
            border-radius: 4px;
            font-size: 14px;
            font-weight: 600;
            text-decoration: none;
            cursor: pointer;
            transition: all 0.2s;
            text-align: center;
        }

        .btn-primary {
            background-color: #FB4357;
            color: white;
        }

        .btn-primary:hover {
            background-color: #e63946;
        }

        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }

        .btn-secondary:hover {
            background-color: #545b62;
        }

        .btn-detail {
            background-color: transparent;
            color: #FB4357;
            border: 1px solid #FB4357;
            padding: 8px 16px;
            font-size: 12px;
        }

        .btn-detail:hover {
            background-color: #FB4357;
            color: white;
        }

        .btn-cancel {
            background-color: #dc3545;
            color: white;
            padding: 8px 16px;
            font-size: 12px;
        }

        .btn-cancel:hover {
            background-color: #c82333;
        }

        .btn-debug {
            background-color: #ffc107;
            color: #212529;
        }

        /* 예약 카드 */
        .reservation-card {
            border: 1px solid #e5e5e5;
            border-radius: 8px;
            margin-bottom: 15px;
            overflow: hidden;
            transition: all 0.2s;
            background-color: #fff;
        }

        .reservation-card:hover {
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
            border-color: #FB4357;
        }

        .reservation-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 20px;
            background-color: #f8f9fa;
            border-bottom: 1px solid #e5e5e5;
        }

        .reservation-id {
            font-weight: 600;
            color: #333;
        }

        .reservation-status {
            padding: 6px 12px;
            border-radius: 4px;
            font-size: 12px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .reservation-status.active {
            background-color: #28a745;
            color: white;
        }

        .reservation-status.canceled {
            background-color: #dc3545;
            color: white;
        }

        .reservation-content {
            padding: 20px;
        }

        .movie-info {
            margin-bottom: 15px;
        }

        .movie-title {
            font-size: 18px;
            font-weight: bold;
            color: #333;
            margin-bottom: 8px;
        }

        .screening-info {
            color: #666;
            font-size: 14px;
            margin-bottom: 10px;
        }

        .reservation-details {
            margin-bottom: 15px;
        }

        .reservation-details > div {
            margin-bottom: 5px;
            color: #666;
            font-size: 14px;
        }

        .seat-info, .ticket-info, .amount-info, .reservation-date {
            padding: 5px 0;
        }

        .amount-info {
            font-weight: 600;
            color: #FB4357;
        }

        .reservation-actions {
            display: flex;
            gap: 10px;
            padding: 15px 20px;
            background-color: #f8f9fa;
            border-top: 1px solid #e5e5e5;
            flex-wrap: wrap;
        }

        /* 빈 상태 */
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: #999;
        }

        .empty-state-icon {
            font-size: 48px;
            margin-bottom: 20px;
            opacity: 0.5;
        }

        .empty-state h3 {
            margin-bottom: 10px;
            color: #666;
        }

        .empty-state p {
            margin-bottom: 20px;
            color: #999;
        }

        /* 오류 메시지 */
        .error-message {
            background-color: #f8d7da;
            color: #721c24;
            padding: 15px;
            border-radius: 8px;
            border: 1px solid #f5c6cb;
            margin-bottom: 20px;
        }

        /* 디버깅 정보 */
        .debug-info {
            background: #f8f9fa;
            padding: 20px;
            margin-top: 20px;
            border-radius: 8px;
            border: 1px solid #e5e5e5;
        }

        /* 반응형 */
        @media (max-width: 768px) {
            .reservation-container {
                padding: 10px;
            }

            .page-header {
                flex-direction: column;
                gap: 15px;
                text-align: center;
            }

            .reservation-header {
                flex-direction: column;
                gap: 10px;
                text-align: center;
            }

            .reservation-actions {
                flex-direction: column;
            }

            .filter-group {
                flex-direction: column;
                align-items: flex-start;
            }

            .reservation-stats {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
<!-- 헤더 포함 -->
<jsp:include page="/WEB-INF/views/header.jsp" />

<div class="reservation-container">
    <!-- 페이지 헤더 -->
    <div class="page-header">
        <h1>예약 내역</h1>
        <a href="/schedule" class="btn-primary">🎫 새 예매</a>
    </div>

    <!-- 사용자 환영 메시지 -->
    <c:if test="${not empty user}">
        <div class="user-welcome">
            <h2>안녕하세요, ${user.u_name}님! 👋</h2>
            <p>회원님의 예약 내역을 확인하실 수 있습니다.</p>
        </div>
    </c:if>

    <!-- 예약 통계 -->
    <c:if test="${not empty stats}">
        <div class="reservation-stats">
            <div class="stat-item">
                <div class="stat-number">${stats.adult != null ? stats.adult : 0}</div>
                <div class="stat-label">총 예약 수</div>
            </div>
            <div class="stat-item">
                <div class="stat-number">${stats.youth != null ? stats.youth : 0}</div>
                <div class="stat-label">진행 중인 예약</div>
            </div>
            <div class="stat-item">
                <div class="stat-number">${stats.child != null ? stats.child : 0}</div>
                <div class="stat-label">취소된 예약</div>
            </div>
            <div class="stat-item">
                <div class="stat-number">
                    <fmt:formatNumber value="${stats.total_amount != null ? stats.total_amount : 0}" pattern="#,###" />원
                </div>
                <div class="stat-label">총 결제 금액</div>
            </div>
        </div>
    </c:if>

    <!-- 오류 메시지 -->
    <c:if test="${not empty error}">
        <div class="error-message">
            ❌ ${error}
        </div>
    </c:if>

    <!-- 예약 내역 섹션 -->
    <div class="section">
        <div class="section-header">
            예약 내역 관리
        </div>
        <div class="section-content">
            <!-- 예약 필터 -->
            <c:if test="${not empty reservations}">
                <div class="reservation-filters">
                    <div class="filter-group">
                        <label for="statusFilter">예약 상태:</label>
                        <select id="statusFilter" onchange="filterReservations()">
                            <option value="all">전체</option>
                            <option value="예약완료">예약완료</option>
                            <option value="예약취소">예약취소</option>
                        </select>

                        <label for="sortOrder">정렬:</label>
                        <select id="sortOrder" onchange="sortReservations()">
                            <option value="recent">최신순</option>
                            <option value="old">오래된순</option>
                            <option value="amount">금액순</option>
                        </select>

                        <button type="button" onclick="refreshReservations()" class="btn-primary">
                            🔄 새로고침
                        </button>
                    </div>
                </div>
            </c:if>

            <!-- 예약 목록 -->
            <c:choose>
                <c:when test="${not empty reservations}">
                    <div id="reservationList">
                        <c:forEach var="reservation" items="${reservations}" varStatus="status">
                            <div class="reservation-card"
                                 data-reservation-id="${reservation.reservation_id}"
                                 data-status="${reservation.reservation_status}"
                                 data-amount="${reservation.total_amount}"
                                 data-date="${reservation.run_date}">

                                <div class="reservation-header">
                                    <div class="reservation-id">예약번호: ${reservation.reservation_id}</div>
                                    <div class="reservation-status ${reservation.reservation_status == '예약완료' ? 'active' : 'canceled'}">
                                            ${reservation.reservation_status}
                                    </div>
                                </div>

                                <div class="reservation-content">
                                    <div class="movie-info">
                                        <h3 class="movie-title">${reservation.movie_title}</h3>
                                        <div class="screening-info">
                                            📅 <fmt:formatDate value="${reservation.run_date}" pattern="yyyy년 MM월 dd일 (E)" /> |
                                            🕐 ${reservation.start_time} |
                                            🏢 ${reservation.room_name}
                                        </div>
                                    </div>

                                    <div class="reservation-details">
                                        <c:if test="${not empty reservation.selected_seats}">
                                            <div class="seat-info">
                                                🪑 좌석: ${reservation.selected_seats}
                                            </div>
                                        </c:if>

                                        <div class="ticket-info">
                                            👥 성인 ${reservation.adult}명
                                            <c:if test="${reservation.youth > 0}"> | 청소년 ${reservation.youth}명</c:if>
                                            <c:if test="${reservation.child > 0}"> | 어린이 ${reservation.child}명</c:if>
                                        </div>

                                        <div class="amount-info">
                                            💰 총 금액: <fmt:formatNumber value="${reservation.total_amount}" pattern="#,###" />원
                                        </div>

                                        <div class="reservation-date">
                                            📝 예약일시: <fmt:formatDate value="${reservation.reservation_date}" pattern="yyyy-MM-dd HH:mm" />
                                        </div>
                                    </div>
                                </div>

                                <div class="reservation-actions">
                                    <button type="button"
                                            onclick="viewReservationDetail(${reservation.reservation_id})"
                                            class="btn-detail">
                                        📋 상세보기
                                    </button>

                                    <c:if test="${reservation.reservation_status == '예약완료'}">
                                        <button type="button"
                                                onclick="cancelReservation(${reservation.reservation_id})"
                                                class="btn-cancel">
                                            ❌ 예약취소
                                        </button>
                                    </c:if>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <!-- 예약 내역이 없는 경우 -->
                    <div class="empty-state">
                        <div class="empty-state-icon">🎬</div>
                        <h3>아직 예약 내역이 없습니다</h3>
                        <p>영화 예매를 통해 첫 예약을 만들어보세요!</p>
                        <a href="/schedule" class="btn-primary">🎫 영화 예매하기</a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- 디버깅 정보 (개발 중에만 표시) -->
    <c:if test="${param.debug == 'true'}">
        <div class="debug-info">
            <strong>🔍 디버깅 정보:</strong><br>
            로그인 사용자: ${user != null ? user.u_name : 'null'} (ID: ${user != null ? user.u_id : 'null'})<br>
            예약 목록 크기: ${reservations != null ? reservations.size() : 'null'}<br>
            통계 정보: ${stats != null ? 'exists' : 'null'}<br>
            <button onclick="location.href='/reservation/debug/check'" class="btn-debug" style="margin-top: 10px;">
                전체 데이터 확인
            </button>
        </div>
    </c:if>
</div>

<!-- JavaScript -->
<script>
    // 예약 상세 조회 함수
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

    // 예약 취소 함수
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

    // 예약 필터링 함수
    function filterReservations() {
        const statusFilter = document.getElementById('statusFilter').value;
        const cards = document.querySelectorAll('.reservation-card');

        cards.forEach(card => {
            const status = card.getAttribute('data-status');
            if (statusFilter === 'all' || status === statusFilter) {
                card.style.display = 'block';
            } else {
                card.style.display = 'none';
            }
        });
    }

    // 예약 정렬 함수
    function sortReservations() {
        const sortOrder = document.getElementById('sortOrder').value;
        const container = document.getElementById('reservationList');
        const cards = Array.from(container.querySelectorAll('.reservation-card'));

        cards.sort((a, b) => {
            switch (sortOrder) {
                case 'recent':
                    return new Date(b.getAttribute('data-date')) - new Date(a.getAttribute('data-date'));
                case 'old':
                    return new Date(a.getAttribute('data-date')) - new Date(b.getAttribute('data-date'));
                case 'amount':
                    return parseInt(b.getAttribute('data-amount')) - parseInt(a.getAttribute('data-amount'));
                default:
                    return 0;
            }
        });

        // 정렬된 카드들을 다시 컨테이너에 추가
        cards.forEach(card => container.appendChild(card));
    }

    // 새로고침 함수
    function refreshReservations() {
        location.reload();
    }

    // 예약 상세 모달 표시 함수
    function showReservationModal(reservation) {
        // 모달 구현은 프로젝트의 모달 시스템에 맞게 조정
        alert('예약 상세 정보:\n' +
            '영화: ' + reservation.movie_title + '\n' +
            '상영일: ' + reservation.run_date + '\n' +
            '금액: ' + reservation.total_amount + '원');
    }

    // 페이지 로드 시 실행
    document.addEventListener('DOMContentLoaded', function() {
        console.log('예약 내역 페이지 로드 완료');

        // 카드 호버 효과
        document.querySelectorAll('.reservation-card').forEach(card => {
            card.addEventListener('mouseenter', function() {
                this.style.borderColor = '#FB4357';
            });

            card.addEventListener('mouseleave', function() {
                this.style.borderColor = '#e5e5e5';
            });
        });
    });
</script>

</body>
</html>