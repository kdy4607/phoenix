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
    <style>

    </style>
</head>
<body>
<!-- 헤더 포함 -->
<jsp:include page="/WEB-INF/views/header.jsp" />

<div class="reservation-container">
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
                                    📅 ${reservation.run_date} |
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

    <!-- 디버깅 정보 (개발 중에만 표시) -->
    <c:if test="${param.debug == 'true'}">
        <div class="debug-info" style="background: #f8f9fa; padding: 20px; margin-top: 20px; border-radius: 8px;">
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

    // 예약 상세 모달 표시 함수
    function showReservationModal(reservation) {
        // JSP에서는 백틱 대신 문자열 연결 사용
        var modal = '<div class="modal-overlay" onclick="closeModal()">' +
            '<div class="modal-content" onclick="event.stopPropagation()">' +
            '<div class="modal-header">' +
            '<h3>예약 상세 정보</h3>' +
            '<button onclick="closeModal()" class="modal-close">×</button>' +
            '</div>' +
            '<div class="modal-body">' +
            '<p><strong>예약번호:</strong> ' + reservation.reservation_id + '</p>' +
            '<p><strong>영화:</strong> ' + reservation.movie_title + '</p>' +
            '<p><strong>상영관:</strong> ' + reservation.room_name + '</p>' +
            '<p><strong>상영일:</strong> ' + reservation.run_date + '</p>' +
            '<p><strong>상영시간:</strong> ' + reservation.start_time + '</p>' +
            '<p><strong>좌석:</strong> ' + (reservation.selected_seats || '정보 없음') + '</p>' +
            '<p><strong>관람인원:</strong> 성인 ' + reservation.adult + '명, 청소년 ' + reservation.youth + '명, 어린이 ' + reservation.child + '명</p>' +
            '<p><strong>총 금액:</strong> ' + reservation.total_amount.toLocaleString() + '원</p>' +
            '<p><strong>예약상태:</strong> ' + reservation.reservation_status + '</p>' +
            '</div>' +
            '</div>' +
            '</div>';

        document.body.insertAdjacentHTML('beforeend', modal);
    }

    // 모달 닫기 함수
    function closeModal() {
        var modal = document.querySelector('.modal-overlay');
        if (modal) {
            modal.remove();
        }
    }

    // 예약 필터링 함수
    function filterReservations() {
        var filter = document.getElementById('statusFilter').value;
        var cards = document.querySelectorAll('.reservation-card');

        cards.forEach(function(card) {
            var status = card.getAttribute('data-status');
            if (filter === 'all' || status === filter) {
                card.style.display = 'block';
            } else {
                card.style.display = 'none';
            }
        });
    }

    // 예약 정렬 함수
    function sortReservations() {
        var sortOrder = document.getElementById('sortOrder').value;
        var container = document.getElementById('reservationList');
        var cards = Array.from(container.children);

        cards.sort(function(a, b) {
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

        cards.forEach(function(card) {
            container.appendChild(card);
        });
    }

    // 예약 목록 새로고침 함수
    function refreshReservations() {
        console.log('🔄 예약 목록 새로고침');
        location.reload();
    }

    // 페이지 로드 시 초기화
    document.addEventListener('DOMContentLoaded', function() {
        console.log('예약 내역 페이지 초기화 완료');

        // 함수 정의 확인
        console.log('viewReservationDetail 함수:', typeof viewReservationDetail);
        console.log('cancelReservation 함수:', typeof cancelReservation);

        // 초기 정렬 (최신순)
        if (document.getElementById('sortOrder')) {
            sortReservations();
        }
    });
</script>