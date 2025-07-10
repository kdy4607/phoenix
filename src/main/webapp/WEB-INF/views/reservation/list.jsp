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

    <!-- 디버깅 정보 표시 (개발 중에만 사용) -->
    <c:if test="${param.debug == 'true'}">
        <div style="background: #f0f0f0; padding: 10px; margin: 10px 0; border-radius: 4px;">
            <strong>디버깅 정보:</strong><br>
            예약 목록 크기: ${reservations != null ? reservations.size() : 'null'}<br>
            통계 정보: ${stats != null ? 'exists' : 'null'}
        </div>
    </c:if>

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
            <c:forEach var="reservation" items="${reservations}" varStatus="status">
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
                                <!-- 향후 포스터 이미지 추가 가능 -->
                                🎬
                            </div>
                            <div class="movie-details">
                                <h3>${reservation.movie_title}</h3>
                                <p>상영일: <fmt:formatDate value="${reservation.run_date}" pattern="yyyy-MM-dd (E)" /></p>
                                <p>상영시간: ${reservation.start_time}</p>
                                <p>상영관: ${reservation.room_name}</p>
                                <p>관람인원:
                                    <c:if test="${reservation.adult > 0}">성인 ${reservation.adult}명</c:if>
                                    <c:if test="${reservation.youth > 0}">청소년 ${reservation.youth}명</c:if>
                                    <c:if test="${reservation.child > 0}">어린이 ${reservation.child}명</c:if>
                                </p>
                            </div>
                        </div>

                        <div class="reservation-details">
                            <!-- 좌석 정보 표시 개선 -->
                            <div class="seats">
                                <strong>좌석:</strong>
                                <c:choose>
                                    <c:when test="${not empty reservation.selected_seats}">
                                        <span class="seat-numbers">${reservation.selected_seats}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="no-seats" style="color: #999;">좌석 정보 없음</span>
                                        <!-- 디버깅용 정보 -->
                                        <c:if test="${param.debug == 'true'}">
                                            <br><small style="color: #666;">
                                            (예약ID: ${reservation.reservation_id},
                                            성인: ${reservation.adult},
                                            청소년: ${reservation.youth},
                                            어린이: ${reservation.child})
                                        </small>
                                        </c:if>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <div class="price">
                                <fmt:formatNumber value="${reservation.total_amount}" pattern="#,###" />원
                            </div>

                            <div class="reserved-date">
                                예약일: <fmt:formatDate value="${reservation.reserved_at}" pattern="yyyy-MM-dd HH:mm" />
                            </div>

                            <!-- 예약 상태에 따른 버튼 표시 -->
                            <div class="action-buttons">
                                <c:if test="${reservation.reservation_status == '예약완료'}">
                                    <button class="cancel-btn" onclick="cancelReservation(${reservation.reservation_id})">
                                        예약 취소
                                    </button>
                                </c:if>

                                <!-- 상세 정보 버튼 추가 -->
                                <button class="detail-btn" onclick="showReservationDetail(${reservation.reservation_id})"
                                        style="background: #6c757d; color: white; border: none; padding: 8px 16px; border-radius: 4px; cursor: pointer; font-size: 12px; margin-top: 5px;">
                                    상세 정보
                                </button>
                            </div>
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

    <!-- 디버깅 도구 (개발 중에만 표시) -->
    <c:if test="${param.debug == 'true'}">
        <div style="margin-top: 40px; padding: 20px; background: #f8f9fa; border-radius: 8px;">
            <h4>디버깅 도구</h4>
            <button onclick="location.href='/reservation/list?debug=false'" class="btn-secondary">디버그 끄기</button>
            <button onclick="testReservationData()" class="btn-secondary" style="margin-left: 10px;">데이터 테스트</button>
        </div>
    </c:if>

    <!-- 디버깅 링크 (개발 중에만 표시) -->
    <c:if test="${param.debug != 'true'}">
        <div style="text-align: center; margin-top: 20px;">
            <a href="/reservation/list?debug=true" style="color: #999; font-size: 12px;">디버깅 모드 켜기</a>
        </div>
    </c:if>
</div>

<script>
    // 예약 취소 함수
    function cancelReservation(reservationId) {
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

    // 예약 상세 정보 조회
    function showReservationDetail(reservationId) {
        fetch('/reservation/' + reservationId)
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    const reservation = data.reservation;
                    let message = `📋 예약 상세 정보\n\n`;
                    message += `예약번호: ${reservation.reservation_id}\n`;
                    message += `영화: ${reservation.movie_title}\n`;
                    message += `상영관: ${reservation.room_name}\n`;
                    message += `상영일시: ${reservation.run_date} ${reservation.start_time}\n`;
                    message += `좌석: ${reservation.selected_seats || '정보 없음'}\n`;
                    message += `관람인원: 성인 ${reservation.adult}명`;
                    if (reservation.youth > 0) message += `, 청소년 ${reservation.youth}명`;
                    if (reservation.child > 0) message += `, 어린이 ${reservation.child}명`;
                    message += `\n결제금액: ${reservation.total_amount.toLocaleString()}원\n`;
                    message += `예약상태: ${reservation.reservation_status}\n`;
                    message += `예약일시: ${reservation.reserved_at}`;

                    alert(message);
                } else {
                    alert(data.message || '예약 정보를 불러올 수 없습니다.');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('예약 정보를 불러오는 중 오류가 발생했습니다.');
            });
    }

    // 데이터 테스트 함수 (디버깅용)
    function testReservationData() {
        console.log('예약 데이터 테스트 시작...');

        // 현재 페이지의 예약 데이터 출력
        const reservationCards = document.querySelectorAll('.reservation-card');
        console.log(`총 ${reservationCards.length}개의 예약 카드 발견`);

        reservationCards.forEach((card, index) => {
            const reservationId = card.querySelector('.reservation-id').textContent;
            const seats = card.querySelector('.seats').textContent;
            console.log(`예약 ${index + 1}: ${reservationId}, 좌석: ${seats}`);
        });

        alert(`콘솔에서 디버깅 정보를 확인하세요.\n총 ${reservationCards.length}개의 예약이 발견되었습니다.`);
    }

    // 페이지 로드 시 디버깅 정보 출력
    document.addEventListener('DOMContentLoaded', function() {
        const urlParams = new URLSearchParams(window.location.search);
        if (urlParams.get('debug') === 'true') {
            console.log('🔍 디버깅 모드 활성화');
            console.log('예약 목록 데이터:', '${reservations}');
        }
    });
</script>
</body>
</html>