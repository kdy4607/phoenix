<%@ page language = "java" contentType = "text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Movie Schedule</title>
    <link rel="stylesheet" href="resources/css/sample.css">
</head>
<body>
<header class="header">
    <div class="header-content">
        <div class="logo">Pheonix</div>
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

    <!-- Current Theater -->
    <div class="section">
        <div class="section-header">Phoenix 종각점</div>
        <div class="section-content">
            <p style="color: #666; font-size: 14px;">서울특별시 종로구 종로12길 15 </p>
        </div>
    </div>

    <!-- Date Selection -->
    <div class="section">
        <div class="section-header">날짜 선택</div>
        <div class="section-content">
            <div class="date-selection">
                <div class="date-item active">
                    <div class="date-day">오늘</div>
                    <div class="date-number">7</div>
                </div>
                <div class="date-item">
                    <div class="date-day">화</div>
                    <div class="date-number">8</div>
                </div>
                <div class="date-item">
                    <div class="date-day">수</div>
                    <div class="date-number">9</div>
                </div>
                <div class="date-item">
                    <div class="date-day">목</div>
                    <div class="date-number">10</div>
                </div>
                <div class="date-item">
                    <div class="date-day">금</div>
                    <div class="date-number">11</div>
                </div>
                <div class="date-item">
                    <div class="date-day">토</div>
                    <div class="date-number">12</div>
                </div>
                <div class="date-item">
                    <div class="date-day">일</div>
                    <div class="date-number">13</div>
                </div>
            </div>
        </div>
    </div>

    <!-- Movie Selection -->
    <div class="section">
        <div class="section-header">영화 선택</div>
        <div class="section-content">
            <div class="movie-grid">
                <div class="movie-card">
                    <div class="movie-poster">영화 포스터</div>
                    <div class="movie-info">
                        <div class="movie-title">인사이드 아웃 2</div>
                        <div class="movie-genre">애니메이션/가족</div>
                        <div class="movie-rating">전체관람가</div>
                        <div class="showtimes-grid">
                            <div class="showtime-btn">10:00</div>
                            <div class="showtime-btn">12:30</div>
                            <div class="showtime-btn">15:00</div>
                            <div class="showtime-btn">17:30</div>
                            <div class="showtime-btn">20:00</div>
                            <div class="showtime-btn full">22:30</div>
                        </div>
                    </div>
                </div>

                <div class="movie-card">
                    <div class="movie-poster">영화 포스터</div>
                    <div class="movie-info">
                        <div class="movie-title">디스피커블 미 4</div>
                        <div class="movie-genre">애니메이션/코미디</div>
                        <div class="movie-rating">전체관람가</div>
                        <div class="showtimes-grid">
                            <div class="showtime-btn">09:30</div>
                            <div class="showtime-btn">11:45</div>
                            <div class="showtime-btn">14:15</div>
                            <div class="showtime-btn">16:45</div>
                            <div class="showtime-btn">19:15</div>
                            <div class="showtime-btn">21:45</div>
                        </div>
                    </div>
                </div>

                <div class="movie-card">
                    <div class="movie-poster">영화 포스터</div>
                    <div class="movie-info">
                        <div class="movie-title">탈주</div>
                        <div class="movie-genre">액션/범죄</div>
                        <div class="movie-rating">15세관람가</div>
                        <div class="showtimes-grid">
                            <div class="showtime-btn">11:00</div>
                            <div class="showtime-btn">13:40</div>
                            <div class="showtime-btn">16:20</div>
                            <div class="showtime-btn">19:00</div>
                            <div class="showtime-btn">21:40</div>
                        </div>
                    </div>
                </div>

                <div class="movie-card">
                    <div class="movie-poster">영화 포스터</div>
                    <div class="movie-info">
                        <div class="movie-title">헤드리거</div>
                        <div class="movie-genre">액션/드라마</div>
                        <div class="movie-rating">12세관람가</div>
                        <div class="showtimes-grid">
                            <div class="showtime-btn">10:30</div>
                            <div class="showtime-btn">13:10</div>
                            <div class="showtime-btn">15:50</div>
                            <div class="showtime-btn">18:30</div>
                            <div class="showtime-btn">21:10</div>
                        </div>
                    </div>
                </div>

                <div class="movie-card">
                    <div class="movie-poster">영화 포스터</div>
                    <div class="movie-info">
                        <div class="movie-title">파일럿</div>
                        <div class="movie-genre">코미디</div>
                        <div class="movie-rating">12세관람가</div>
                        <div class="showtimes-grid">
                            <div class="showtime-btn">11:20</div>
                            <div class="showtime-btn">14:00</div>
                            <div class="showtime-btn">16:40</div>
                            <div class="showtime-btn">19:20</div>
                            <div class="showtime-btn">22:00</div>
                        </div>
                    </div>
                </div>

                <div class="movie-card">
                    <div class="movie-poster">영화 포스터</div>
                    <div class="movie-info">
                        <div class="movie-title">트위스터스</div>
                        <div class="movie-genre">액션/스릴러</div>
                        <div class="movie-rating">12세관람가</div>
                        <div class="showtimes-grid">
                            <div class="showtime-btn">09:45</div>
                            <div class="showtime-btn">12:25</div>
                            <div class="showtime-btn">15:05</div>
                            <div class="showtime-btn">17:45</div>
                            <div class="showtime-btn">20:25</div>
                        </div>
                    </div>
                </div>
            </div>

            <button class="btn-primary">다음 단계로</button>
        </div>
    </div>
</div>

<script>
    // 날짜 선택 기능
    document.querySelectorAll('.date-item').forEach(item => {
        item.addEventListener('click', function() {
            document.querySelectorAll('.date-item').forEach(i => i.classList.remove('active'));
            this.classList.add('active');
        });
    });

    // 상영시간 선택 기능
    document.querySelectorAll('.showtime-btn').forEach(btn => {
        btn.addEventListener('click', function() {
            if (!this.classList.contains('full')) {
                document.querySelectorAll('.showtime-btn').forEach(b => b.classList.remove('selected'));
                this.classList.add('selected');
            } else {

            }
        });
    });

    // 영화 카드 호버 효과
    document.querySelectorAll('.movie-card').forEach(card => {
        card.addEventListener('mouseenter', function() {
            this.style.borderColor = '#FB4357';
        });

        card.addEventListener('mouseleave', function() {
            this.style.borderColor = '#e5e5e5';
        });
    });
</script>
</body>
</html>