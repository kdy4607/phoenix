<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Bookings - Phoenix Cinema</title>
    <link rel="stylesheet" href="/resources/css/schedule.css">
    <link rel="stylesheet" href="/resources/css/reservation.css">
    <link rel="icon" href="/resources/images/logo.png" type="image/png">
</head>
<body>
<!-- 헤더 포함 -->
<jsp:include page="/WEB-INF/views/header.jsp" />

<div class="reservation-container">
    <!-- 페이지 헤더 -->
    <div class="page-header">
        <h1>My Bookings</h1>
        <a href="/schedule" class="btn-primary2">🎫 New Booking</a>
    </div>

    <!-- 사용자 환영 메시지 -->
    <c:if test="${not empty user}">
        <div class="user-welcome">
            <h2>Hello, ${user.u_name}! 👋</h2>
            <p>You can check your reservation history here.</p>
        </div>
    </c:if>

    <!-- 예약 통계 -->
    <c:if test="${not empty stats}">
        <div class="reservation-stats">
            <div class="stat-item">
                <div class="stat-number">${stats.adult != null ? stats.adult : 0}</div>
                <div class="stat-label">Total Bookings</div>
            </div>
            <div class="stat-item">
                <div class="stat-number">${stats.youth != null ? stats.youth : 0}</div>
                <div class="stat-label">Active Bookings</div>
            </div>
            <div class="stat-item">
                <div class="stat-number">${stats.child != null ? stats.child : 0}</div>
                <div class="stat-label">Cancelled Bookings</div>
            </div>
            <div class="stat-item">
                <div class="stat-number">
                    <fmt:formatNumber value="${stats.total_amount != null ? stats.total_amount : 0}" type="currency" currencySymbol="₩"/>
                </div>
                <div class="stat-label">Total Amount</div>
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
            My Bookings Management
        </div>
        <div class="section-content">
            <!-- 예약 필터 -->
            <c:if test="${not empty reservations}">
                <div class="reservation-filters">
                    <div class="filter-group">
                        <label for="statusFilter">Booking Status</label>
                        <select id="statusFilter" onchange="filterReservations()">
                            <option value="all">All</option>
                            <option value="예약완료">Confirmed</option>
                            <option value="예약취소">Cancelled</option>
                        </select>

                        <label for="sortOrder">Sort:</label>
                        <select id="sortOrder" onchange="sortReservations()">
                            <option value="recent">Latest</option>
                            <option value="old">Oldest</option>
                            <option value="amount">By Amount</option>
                        </select>

                        <button type="button" onclick="refreshReservations()" class="btn-primary2">
                            🔄 Refresh
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
                                    <div class="reservation-id">Booking number: ${reservation.reservation_id}</div>
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
                                                <span class="label">Seat:</span>
                                                <span class="value">
                    <c:choose>
                        <c:when test="${not empty reservation.selected_seats}">
                            ${reservation.selected_seats}
                        </c:when>
                        <c:otherwise>
                            No Information
                        </c:otherwise>
                    </c:choose>
                </span>
                                            </div>
                                            <div class="detail-row">
                                                <span class="label">Booking Date:</span>
                                                <span class="value">
                    <fmt:formatDate value="${reservation.reservation_date}" pattern="yyyy.MM.dd HH:mm" />
                </span>
                                            </div>
                                            <div class="detail-row">
                                                <span class="label">Payment Amount:</span>
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
                                                     alt="${reservation.movie_title} poster"
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
                                        Detail
                                    </button>

                                    <c:if test="${reservation.reservation_status == '예약완료'}">
                                        <button type="button"
                                                onclick="cancelReservation(${reservation.reservation_id})"
                                                class="btn-cancel">
                                            Cancel
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
                        <h3>No Reservation History Yet</h3>
                        <p>Make your first reservation by booking a movie!</p>
                        <a href="/schedule" class="btn-primary2">🎫 Book Movie</a>
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
    // Reservation detail inquiry function
    function viewReservationDetail(reservationId) {
        console.log('🔍 Viewing reservation details - ID:', reservationId);

        fetch('/reservation/' + reservationId)
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    showReservationModal(data.reservation);
                } else {
                    alert('❌ ' + (data.message || 'Unable to load reservation information.'));
                }
            })
            .catch(error => {
                console.error('Reservation information inquiry error:', error);
                alert('❌ An error occurred while retrieving reservation information.');
            });
    }

    // Reservation cancellation function
    function cancelReservation(reservationId) {
        console.log('🗑️ Attempting reservation cancellation - ID:', reservationId);

        if (!confirm('Are you sure you want to cancel this reservation?\n\nCancelled reservations cannot be recovered.')) {
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
                    alert('✅ Reservation has been cancelled.');
                    location.reload();
                } else {
                    alert('❌ ' + (data.message || 'An error occurred while cancelling the reservation.'));
                }
            })
            .catch(error => {
                console.error('Reservation cancellation error:', error);
                alert('❌ An error occurred while cancelling the reservation.');
            });
    }

    // Reservation filtering function
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

    // Reservation sorting function
    function sortReservations() {
        const sortOrder = document.getElementById('sortOrder').value;
        const container = document.getElementById('reservationList');
        const cards = Array.from(container.querySelectorAll('.reservation-card'));

        console.log('🔄 Starting sort:', sortOrder);

        cards.sort((a, b) => {
            switch (sortOrder) {
                case 'recent':
                    // Sort by latest based on actual reservation date
                    const dateA = new Date(a.getAttribute('data-reserved-date'));
                    const dateB = new Date(b.getAttribute('data-reserved-date'));
                    return dateB - dateA; // Latest first

                case 'old':
                    // Sort by oldest based on actual reservation date
                    const oldDateA = new Date(a.getAttribute('data-reserved-date'));
                    const oldDateB = new Date(b.getAttribute('data-reserved-date'));
                    return oldDateA - oldDateB; // Oldest first

                case 'amount':
                    // Sort by amount (highest amount first)
                    const amountA = parseInt(a.getAttribute('data-amount')) || 0;
                    const amountB = parseInt(b.getAttribute('data-amount')) || 0;
                    return amountB - amountA;

                default:
                    return 0;
            }
        });

        // Re-add sorted cards to container
        cards.forEach(card => container.appendChild(card));

        console.log('✅ Sort completed:', sortOrder);
    }

    // Refresh function
    function refreshReservations() {
        location.reload();
    }

    // Reservation detail modal display function
    function showReservationModal(reservation) {
        // Modal implementation should be adjusted according to the project's modal system
        alert('Reservation Details:\n' +
            'Movie: ' + reservation.movie_title + '\n' +
            'Show Date: ' + reservation.run_date + '\n' +
            'Amount: ' + reservation.total_amount + '₩');
    }

    // Execute on page load
    document.addEventListener('DOMContentLoaded', function() {
        console.log('Reservation history page loaded successfully');

        // Card hover effect
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