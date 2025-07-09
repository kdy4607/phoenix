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
            <div class="step">
                <div class="step-number">1</div>
                <span>상영시간</span>
            </div>
            <div class="step inactive">
                <div class="step-number">2</div>
                <span>인원/좌석</span>
            </div>
            <div class="step inactive">
                <div class="step-number">3</div>
                <span>결제</span>
            </div>
            <div class="step inactive">
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

    <!-- Date Selection -->
    <div class="section">
        <div class="section-header">날짜 선택</div>
        <div class="section-content">
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
        </div>
    </div>

    <!-- Movie Selection -->
    <div class="section">
        <div class="section-header">영화 선택</div>
        <div class="section-content">
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
                                            ${movieTitle}
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
            <div id="selectedShowtimeInfo" style="display: none; background: #f5f5f5; padding: 15px; margin-top: 20px; border-radius: 8px;">
                <h4>선택된 상영시간</h4>
                <p id="selectedDetails"></p>
            </div>

            <form id="showtimeForm" action="/schedule/select" method="post" style="display: none;">
                <input type="hidden" id="selectedRuntimeId" name="runtimeId" />
                <button type="submit" class="btn-primary">다음 단계로</button>
            </form>
        </div>
    </div>
</div>

<script>
    let selectedShowtime = null;

    // 날짜 선택 기능
    function selectDate(dateString, element) {
        // 모든 날짜 아이템에서 active 클래스 제거
        document.querySelectorAll('.date-item').forEach(item => {
            item.classList.remove('active');
        });

        // 선택된 날짜에 active 클래스 추가
        element.classList.add('active');

        // 해당 날짜의 상영시간 조회
        fetch(`/schedule/date/\${dateString}`)
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    updateMovieGrid(data.movieRuntimes, data.soldOutStatus);
                } else {
                    alert(data.message || '데이터를 불러올 수 없습니다.');
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('오류가 발생했습니다. 다시 시도해 주세요.');
            });
    }

    // 영화 그리드 업데이트
    function updateMovieGrid(movieRuntimes, soldOutStatus) {
        const movieGrid = document.getElementById('movieGrid');

        if (!movieRuntimes || Object.keys(movieRuntimes).length === 0) {
            movieGrid.innerHTML = '<div style="text-align: center; padding: 40px; color: #666;">선택하신 날짜에 상영 중인 영화가 없습니다.</div>';
            return;
        }

        let html = '';
        for (const [movieTitle, runtimes] of Object.entries(movieRuntimes)) {
            const firstRuntime = runtimes[0];
            html += `
            <div class="movie-card">
                <div class="movie-poster">
                    \${firstRuntime.poster_url ?
                        `<img src="\${firstRuntime.poster_url}" alt="\${movieTitle}" style="width: 100%; height: 100%; object-fit: cover;" />` :
                        movieTitle
                    }
                </div>
                <div class="movie-info">
                    <div class="movie-title">\${movieTitle}</div>
                    <div class="movie-genre">\${firstRuntime.movie_genre}</div>
                    <div class="movie-rating">\${firstRuntime.movie_rating}</div>
                    <div class="showtimes-grid">`;

            runtimes.forEach(runtime => {
                const isSoldOut = soldOutStatus[runtime.runtime_id];
                html += `
                <div class="showtime-btn \${isSoldOut ? 'full' : ''}"
                     data-runtime-id="\${runtime.runtime_id}"
                     data-movie-title="\${movieTitle}"
                     data-start-time="\${runtime.start_time}"
                     data-room-name="\${runtime.room_name}"
                     data-available-seats="\${runtime.available_seats}"
                     onclick="\${isSoldOut ? '' : 'selectShowtime(this)'}">
                    \${runtime.start_time}
                    <br><small>\${runtime.room_name}</small>
                    <br><small>\${runtime.available_seats}석</small>
                </div>`;
            });

            html += `
                    </div>
                </div>
            </div>`;
        }

        movieGrid.innerHTML = html;
    }

    // 상영시간 선택 기능
    function selectShowtime(element) {
        // 이전 선택 해제
        document.querySelectorAll('.showtime-btn').forEach(btn => {
            btn.classList.remove('selected');
        });

        // 현재 선택 표시
        element.classList.add('selected');

        // 선택된 정보 저장
        selectedShowtime = {
            runtimeId: element.dataset.runtimeId,
            movieTitle: element.dataset.movieTitle,
            startTime: element.dataset.startTime,
            roomName: element.dataset.roomName,
            availableSeats: element.dataset.availableSeats
        };

        // 선택된 정보 표시
        showSelectedInfo();
    }

    // 선택된 상영시간 정보 표시
    function showSelectedInfo() {
        if (selectedShowtime) {
            const infoDiv = document.getElementById('selectedShowtimeInfo');
            const detailsP = document.getElementById('selectedDetails');
            const form = document.getElementById('showtimeForm');
            const runtimeIdInput = document.getElementById('selectedRuntimeId');

            detailsP.innerHTML = `
            <strong>\${selectedShowtime.movieTitle}</strong><br>
            \${selectedShowtime.startTime} | \${selectedShowtime.roomName} | 잔여좌석: \${selectedShowtime.availableSeats}석
        `;

            runtimeIdInput.value = selectedShowtime.runtimeId;

            infoDiv.style.display = 'block';
            form.style.display = 'block';
        }
    }

    // 영화 카드 호버 효과
    document.addEventListener('DOMContentLoaded', function() {
        document.querySelectorAll('.movie-card').forEach(card => {
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