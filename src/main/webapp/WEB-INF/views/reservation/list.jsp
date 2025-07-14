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
    <link rel="stylesheet" href="/resources/css/reservation.css">
</head>
<body>
<!-- 헤더 포함 -->
<jsp:include page="/WEB-INF/views/header.jsp" />

<div class="reservation-container">
    <!-- 페이지 헤더 -->
    <div class="page-header">
        <h1>예약 내역</h1>
        <a href="/schedule" class="btn-primary2">🎫 새 예매</a>
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

                        <button type="button" onclick="refreshReservations()" class="btn-primary2">
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
                                 data-reserved-date="<fmt:formatDate value='${reservation.reserved_at}' pattern='yyyy-MM-dd HH:mm:ss' />"
                                 data-run-date="${reservation.run_date}">

                                <div class="reservation-header">
                                    <div class="reservation-id">예약번호: ${reservation.reservation_id}</div>
                                    <div class="reservation-status ${reservation.reservation_status == '예약완료' ? 'status-completed' : 'status-cancelled'}">
                                            ${reservation.reservation_status}
                                    </div>
                                </div>

                                <div class="reservation-content">
                                    <!-- 왼쪽 영화 정보 영역 -->
                                    <div class="reservation-info">
                                        <div class="movie-info">
                                            <div class="movie-title">${reservation.movie_title}</div>
                                            <div class="screening-info">
                                                <fmt:formatDate value="${reservation.run_date}" pattern="yyyy.MM.dd (E)" />
                                                    ${reservation.start_time} / ${reservation.room_name}
                                            </div>
                                        </div>

                                        <div class="reservation-details">
                                            <div class="detail-row">
                                                <span class="label">좌석:</span>
                                                <span class="value">
                    <c:choose>
                        <c:when test="${not empty reservation.selected_seats}">
                            ${reservation.selected_seats}
                        </c:when>
                        <c:otherwise>
                            정보 없음
                        </c:otherwise>
                    </c:choose>
                </span>
                                            </div>
                                            <div class="detail-row">
                                                <span class="label">예매일:</span>
                                                <span class="value">
                    <fmt:formatDate value="${reservation.reservation_date}" pattern="yyyy.MM.dd HH:mm" />
                </span>
                                            </div>
                                            <div class="detail-row">
                                                <span class="label">결제금액:</span>
                                                <span class="value amount">
                    <fmt:formatNumber value="${reservation.total_amount}" pattern="#,###" />원
                </span>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- 오른쪽 포스터 영역 -->
                                    <div class="reservation-poster">
                                        <c:choose>
                                            <c:when test="${not empty reservation.poster_url}">
                                                <img src="${reservation.poster_url}"
                                                     alt="${reservation.movie_title} 포스터"
                                                     onerror="this.parentElement.innerHTML='<div class=&quot;poster-placeholder&quot;><div class=&quot;icon&quot;>🎬</div><div>No Image</div></div>'">
                                            </c:when>
                                            <c:otherwise>
                                                <div class="poster-placeholder">
                                                    <div class="icon">🎬</div>
                                                    <div>No Image</div>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>

                                <div class="reservation-actions">
                                    <button type="button"
                                            onclick="viewReservationDetail(${reservation.reservation_id})"
                                            class="btn-detail">
                                        상세보기
                                    </button>

                                    <c:if test="${reservation.reservation_status == '예약완료'}">
                                        <button type="button"
                                                onclick="cancelReservation(${reservation.reservation_id})"
                                                class="btn-cancel">
                                            예약취소
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
                        <a href="/schedule" class="btn-primary2">🎫 영화 예매하기</a>
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

        console.log('🔄 정렬 시작:', sortOrder);

        cards.sort((a, b) => {
            switch (sortOrder) {
                case 'recent':
                    // 실제 예약 날짜 기준으로 최신순 정렬
                    const dateA = new Date(a.getAttribute('data-reserved-date'));
                    const dateB = new Date(b.getAttribute('data-reserved-date'));
                    return dateB - dateA; // 최신이 먼저

                case 'old':
                    // 실제 예약 날짜 기준으로 오래된순 정렬
                    const oldDateA = new Date(a.getAttribute('data-reserved-date'));
                    const oldDateB = new Date(b.getAttribute('data-reserved-date'));
                    return oldDateA - oldDateB; // 오래된 것이 먼저

                case 'amount':
                    // 금액순 정렬 (높은 금액부터)
                    const amountA = parseInt(a.getAttribute('data-amount')) || 0;
                    const amountB = parseInt(b.getAttribute('data-amount')) || 0;
                    return amountB - amountA;

                default:
                    return 0;
            }
        });

        // 정렬된 카드들을 다시 컨테이너에 추가
        cards.forEach(card => container.appendChild(card));

        console.log('✅ 정렬 완료:', sortOrder);
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