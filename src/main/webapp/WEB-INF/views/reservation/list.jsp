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
        <div class="debug-info">
            <strong>🔍 디버깅 정보:</strong><br>
            예약 목록 크기: ${reservations != null ? reservations.size() : 'null'}<br>
            통계 정보: ${stats != null ? 'exists' : 'null'}<br>
            <button onclick="location.href='/reservation/debug/check'" class="btn-debug">전체 데이터 확인</button>
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
        <div class="error-message">
                ${error}
        </div>
    </c:if>

    <!-- 예약 목록 -->
    <c:choose>
        <c:when test="${not empty reservations}">
            <c:forEach var="reservation" items="${reservations}" varStatus="status">
                <div class="reservation-card" data-reservation-id="${reservation.reservation_id}">
                    <div class="reservation-header">
                        <div class="reservation-id">예약번호: ${reservation.reservation_id}</div>
                        <div class="reservation-status ${reservation.reservation_status == '예약완료' ? 'status-completed' : 'status-cancelled'}">
                                ${reservation.reservation_status}
                        </div>
                    </div>

                    <div class="reservation-info">
                        <div class="movie-info">
                            <div class="movie-poster">
                                🎬
                            </div>
                            <div class="movie-details">
                                <h3>${reservation.movie_title}</h3>
                                <p><strong>상영일:</strong> <fmt:formatDate value="${reservation.run_date}" pattern="yyyy-MM-dd (E)" /></p>
                                <p><strong>상영시간:</strong> ${reservation.start_time}</p>
                                <p><strong>상영관:</strong> ${reservation.room_name}</p>
                                <p><strong>관람인원:</strong>
                                    <c:if test="${reservation.adult > 0}">성인 ${reservation.adult}명</c:if>
                                    <c:if test="${reservation.youth > 0}">
                                        <c:if test="${reservation.adult > 0}">, </c:if>청소년 ${reservation.youth}명
                                    </c:if>
                                    <c:if test="${reservation.child > 0}">
                                        <c:if test="${reservation.adult > 0 || reservation.youth > 0}">, </c:if>어린이 ${reservation.child}명
                                    </c:if>
                                </p>
                            </div>
                        </div>

                        <div class="reservation-details">
                            <!-- 좌석 정보 표시 개선 -->
                            <div class="seats-info">
                                <strong>🪑 좌석:</strong>
                                <c:choose>
                                    <c:when test="${not empty reservation.selected_seats}">
                                        <span class="seat-numbers">${reservation.selected_seats}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="no-seats">좌석 정보 없음</span>
                                        <!-- 디버깅용 정보 -->
                                        <c:if test="${param.debug == 'true'}">
                                            <br><small class="debug-text">
                                            (예약ID: ${reservation.reservation_id},
                                            성인: ${reservation.adult},
                                            청소년: ${reservation.youth},
                                            어린이: ${reservation.child})
                                        </small>
                                        </c:if>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <div class="price-info">
                                <strong>💰 결제금액:</strong>
                                <span class="price-amount">
                                    <fmt:formatNumber value="${reservation.total_amount}" pattern="#,###" />원
                                </span>
                            </div>

                            <div class="reserved-date">
                                <strong>📝 예약일:</strong>
                                <fmt:formatDate value="${reservation.reserved_at}" pattern="yyyy-MM-dd HH:mm" />
                            </div>

                            <!-- 액션 버튼들 -->
                            <div class="action-buttons">
                                <c:if test="${reservation.reservation_status == '예약완료'}">
                                    <button class="cancel-btn" onclick="cancelReservation(${reservation.reservation_id})">
                                        예약 취소
                                    </button>
                                </c:if>

                                <!-- 상세 정보 버튼 -->
                                <button class="detail-btn" onclick="showReservationDetail(${reservation.reservation_id})">
                                    상세 정보
                                </button>

                                <!-- 디버그 모드에서만 표시되는 추가 버튼 -->
                                <c:if test="${param.debug == 'true'}">
                                    <button class="debug-btn" onclick="showReservationDetailDebug(${reservation.reservation_id})">
                                        🐛 디버그
                                    </button>
                                </c:if>
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
        <div class="debug-tools">
            <h4>🛠️ 디버깅 도구</h4>
            <div class="debug-buttons">
                <button onclick="location.href='/reservation/list?debug=false'" class="btn-secondary">디버그 끄기</button>
                <button onclick="testReservationData()" class="btn-secondary">데이터 테스트</button>
                <button onclick="testAllReservations()" class="btn-secondary">전체 예약 테스트</button>
            </div>
        </div>
    </c:if>

    <!-- 디버깅 링크 (개발 중에만 표시) -->
    <c:if test="${param.debug != 'true'}">
        <div class="debug-link">
            <a href="/reservation/list?debug=true">🔍 디버깅 모드 켜기</a>
        </div>
    </c:if>
</div>

<script src="/resources/js/reservation.js"></script>
</body>
</html>