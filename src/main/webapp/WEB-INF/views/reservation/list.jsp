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
<header class="header">
    <div class="header-content">
        <a href="/"><div class="logo">Phoenix</div></a>
        <ul class="nav-menu">
            <li><a href="/movie-all">영화</a></li>
            <li><a href="/schedule">예매</a></li>
            <li><a href="#">극장</a></li>
            <li><a href="#">이벤트</a></li>
            <li><a href="/reservation/list">예약내역</a></li>
        </ul>
    </div>
</header>

<div class="reservation-container">
    <h1>예약 내역</h1>

    <!-- 예약 통계 -->
    <c:if test="${not empty stats}">
        <div class="reservation-stats">
            <div class="stat-item">
                <div class="stat-number">${stats.adult}</div>
                <div class="stat-label">총 예약 수</div>
            </div>
            <div class="stat-item">
                <div class="stat-number">${stats.youth}</div>
                <div class="stat-label">진행 중</div>
            </div>
            <div class="stat-item">
                <div class="stat-number">${stats.child}</div>
                <div class="stat-label">취소됨</div>
            </div>
            <div class="stat-item">
                <div class="stat-number">
                    <fmt:formatNumber value="${stats.total_amount}" pattern="#,###" />원
                </div>
                <div class="stat-label">총 결제 금액</div>
            </div>
        </div>
    </c:if>

    <!-- 오류 메시지 -->
    <c:if test="${not empty error}">
        <div class="error-message" style="background-color: #ffebee; color: #c62828; padding: 15px; margin: 20px 0; border-radius: 4px;">
                ${error}
        </div>
    </c:if>

    <!-- 예약 목록 -->
    <c:choose>
        <c:when test="${not empty reservations}">
            <c:forEach var="reservation" items="${reservations}">
                <div class="reservation-card">
                    <div class="reservation-header">
                        <div class="reservation-id">예약번호: ${reservation.reservation_id}</div>
                        <div class="reservation-status ${reservation.reservation_status == '예약완료' ? 'status-completed' : 'status-cancelled'}">
                                ${reservation.reservation_status}
                        </div>
                    </div>

                    <div class="reservation-info">
                        <div class="movie-info">
                            <div class="movie-poster">
                                <!-- 포스터 이미지가 있으면 표시 -->
                                포스터
                            </div>
                            <div class="movie-details">
                                <h3>${reservation.movie_title}</h3>
                                <p>상영일: <fmt:formatDate value="${reservation.run_date}" pattern="yyyy-MM-dd" /></p>
                                <p>상영시간: ${reservation.start_time}</p>
                                <p>상영관: ${reservation.room_name}</p>
                            </div>
                        </div>

                        <div class="reservation-details">
                            <div class="seats">좌석: ${reservation.selected_seats}</div>
                            <div class="price">
                                <fmt:formatNumber value="${reservation.total_amount}" pattern="#,###" />원
                            </div>
                            <div class="reserved-date">
                                예약일: <fmt:formatDate value="${reservation.reserved_at}" pattern="yyyy-MM-dd HH:mm" />
                            </div>

                            <c:if test="${reservation.reservation_status == '예약완료'}">
                                <button class="cancel-btn" onclick="cancelReservation(${reservation.reservation_id})">
                                    예약 취소
                                </button>
                            </c:if>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </c:when>
        <c:otherwise>
            <div class="empty-state">
                <div class="icon">🎬</div>
                <h3>예약 내역이 없습니다</h3>
                <p>아직 예약한 영화가 없습니다. 지금 바로 영화를 예약해보세요!</p>
                <a href="/schedule" class="btn-primary">영화 예약하기</a>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<script>
    // 예약 취소 함수
    function cancelReservation(reservationId) {
        if (!confirm('정말로 예약을 취소하시겠습니까?')) {
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
                    alert('예약이 취소되었습니다.');
                    location.reload();
                } else {
                    alert(data.message || '예약 취소 중 오류가 발생했습니다.');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('예약 취소 중 오류가 발생했습니다.');
            });
    }
</script>
</body>
</html>