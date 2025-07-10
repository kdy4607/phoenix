<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Movie Schedule</title>
    <link rel="stylesheet" href="/resources/css/schedule.css">
</head>
<body>
<header class="header">
    <div class="header-content">
        <a href="/"><div class="logo">Phoenix</div></a>
        <ul class="nav-menu">
            <li><a href="#">영화</a></li>
            <li><a href="#">예매</a></li>
            <li><a href="#">극장</a></li>
            <li><a href="#">이벤트</a></li>
            <li><a href="#">스토어</a></li>
        </ul>
    </div>
</header>

<div class="container">
    <!-- Booking Steps -->
    <div class="booking-steps">
        <div class="steps">
            <div class="step" id="step1">
                <div class="step-number">1</div>
                <span>상영시간</span>
            </div>
            <div class="step inactive" id="step2">
                <div class="step-number">2</div>
                <span>인원/좌석</span>
            </div>
            <div class="step inactive" id="step3">
                <div class="step-number">3</div>
                <span>결제</span>
            </div>
            <div class="step inactive" id="step4">
                <div class="step-number">4</div>
                <span>완료</span>
            </div>
        </div>
    </div>

    <!-- Error Message -->
    <c:if test="${not empty error}">
        <div class="error-message" style="background-color: #ffebee; color: #c62828; padding: 10px; margin: 10px 0; border-radius: 4px;">
                ${error}
        </div>
    </c:if>

    <!-- Current Theater -->
    <div class="section">
        <div class="section-header">Phoenix 종각점</div>
        <div class="section-content">
            <p style="color: #666; font-size: 14px;">서울특별시 종로구 종로12길 15</p>
        </div>
    </div>

    <!-- Movie Schedule Section -->
    <div class="section" id="scheduleSection">
        <div class="section-header">날짜 및 상영시간 선택</div>
        <div class="section-content">
            <!-- Date Selection -->
            <div class="date-selection">
                <c:forEach var="date" items="${dates}" varStatus="status">
                    <div class="date-item ${status.index == 0 ? 'active' : ''}"
                         data-date="${date.dateString}"
                         onclick="selectDate('${date.dateString}', this)">
                        <div class="date-day">${date.dayName}</div>
                        <div class="date-number">${date.dayNumber}</div>
                    </div>
                </c:forEach>
            </div>

            <!-- Movie Selection -->
            <div class="movie-grid" id="movieGrid">
                <c:choose>
                    <c:when test="${not empty movieRuntimes}">
                        <c:forEach var="movieEntry" items="${movieRuntimes}">
                            <c:set var="movieTitle" value="${movieEntry.key}" />
                            <c:set var="runtimes" value="${movieEntry.value}" />
                            <c:set var="firstRuntime" value="${runtimes[0]}" />

                            <div class="movie-card">
                                <div class="movie-poster">
                                    <c:choose>
                                        <c:when test="${not empty firstRuntime.poster_url}">
                                            <img src="${firstRuntime.poster_url}" alt="${movieTitle}"
                                                 style="width: 100%; height: 100%; object-fit: cover;" />
                                        </c:when>
                                        <c:otherwise>
                                            <div style="display: flex; align-items: center; justify-content: center; height: 100%; background: #f0f0f0; color: #666;">
                                                    ${movieTitle}
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                <div class="movie-info">
                                    <div class="movie-title">${movieTitle}</div>
                                    <div class="movie-genre">${firstRuntime.movie_genre}</div>
                                    <div class="movie-rating">${firstRuntime.movie_rating}</div>
                                    <div class="showtimes-grid">
                                        <c:forEach var="runtime" items="${runtimes}">
                                            <c:set var="isSoldOut" value="${soldOutStatus[runtime.runtime_id]}" />
                                            <div class="showtime-btn ${isSoldOut ? 'full' : ''}"
                                                 data-runtime-id="${runtime.runtime_id}"
                                                 data-movie-title="${movieTitle}"
                                                 data-start-time="${runtime.start_time}"
                                                 data-room-name="${runtime.room_name}"
                                                 data-available-seats="${runtime.available_seats}"
                                                 onclick="${isSoldOut ? '' : 'selectShowtime(this)'}">
                                                    ${runtime.start_time}
                                                <br><small>${runtime.room_name}</small>
                                                <br><small>${runtime.available_seats}석</small>
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div style="text-align: center; padding: 40px; color: #666;">
                            선택하신 날짜에 상영 중인 영화가 없습니다.
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- 선택된 상영시간 정보 -->
            <div id="selectedShowtimeInfo" style="display: none; background: #f8f9fa; padding: 15px; margin-top: 20px; border-radius: 8px;">
                <h4>선택된 상영시간</h4>
                <p id="selectedDetails"></p>
                <button type="button" class="btn-primary" onclick="loadSeatSelection()">좌석 선택하기</button>
            </div>
        </div>
    </div>

    <!-- Seat Selection Section -->
    <div class="section seat-selection" id="seatSelection">
        <div class="section-header">좌석 선택</div>
        <div class="section-content">
            <!-- Runtime Info -->
            <div class="seat-info">
                <div id="seatRuntimeInfo"></div>
            </div>

            <!-- Seat Legend -->
            <div class="seat-legend">
                <div class="legend-item">
                    <div class="legend-seat legend-available"></div>
                    <span>선택가능</span>
                </div>
                <div class="legend-item">
                    <div class="legend-seat legend-selected"></div>
                    <span>선택됨</span>
                </div>
                <div class="legend-item">
                    <div class="legend-seat legend-reserved"></div>
                    <span>예약됨</span>
                </div>
            </div>

            <!-- Cinema Screen -->
            <div class="cinema-screen">SCREEN</div>

            <!-- Seat Map -->
            <div class="seat-map" id="seatMap">
                <!-- 좌석 배치는 JavaScript로 동적 생성 -->
            </div>

            <!-- Selected Seats Info -->
            <div class="selected-seats" id="selectedSeatsInfo">
                <h4>선택된 좌석</h4>
                <div id="selectedSeatsList"></div>
                <div id="totalPrice"></div>
            </div>

            <!-- Seat Buttons -->
            <div class="seat-buttons">
                <button type="button" class="btn-secondary" onclick="cancelSeatSelection()">이전 단계</button>
                <button type="button" class="btn-primary" id="confirmSeatsBtn" onclick="confirmSeats()" disabled>다음 단계</button>
            </div>
        </div>
    </div>
</div>
</body>
<script src="/resources/js/schedule.js"></script>
</html>