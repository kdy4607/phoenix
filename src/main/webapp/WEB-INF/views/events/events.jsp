<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Events - Phoenix Cinema</title>
    <link rel="stylesheet" href="/resources/css/events.css">
</head>

<body>
<!-- 공통 헤더 포함 -->
<jsp:include page="/WEB-INF/views/header.jsp" />

<div class="container">
    <div class="page-header">
        <h1 class="page-title">🎉 Events & Promotions</h1>
        <p class="page-subtitle">Discover amazing events and exclusive benefits at Phoenix Cinema</p>
    </div>

    <!-- Current Events -->
    <div class="events-section">
        <h2 class="section-title">🔥 Current Events</h2>

        <div class="event-grid">
            <!-- Event 1 -->
            <div class="event-card featured">
                <div class="event-badge">HOT</div>
                <div class="event-image">
                    <img src="/resources/images/event1.jpg" alt="New Member Discount Event"
                         onerror="this.src='data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMzAwIiBoZWlnaHQ9IjIwMCIgdmlld0JveD0iMCAwIDMwMCAyMDAiIGZpbGw9Im5vbmUiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+CjxyZWN0IHdpZHRoPSIzMDAiIGhlaWdodD0iMjAwIiBmaWxsPSIjRjVGNUY1Ii8+Cjx0ZXh0IHg9IjE1MCIgeT0iMTAwIiB0ZXh0LWFuY2hvcj0ibWlkZGxlIiBmaWxsPSIjOTk5IiBmb250LXNpemU9IjE0Ij5OZXcgTWVtYmVyIERpc2NvdW50PC90ZXh0Pgo8L3N2Zz4='">
                </div>
                <div class="event-content">
                    <h3 class="event-title">🎬 New Member Special Discount</h3>
                    <p class="event-description">
                        30% off movie tickets for new members!
                        Valid for 7 days after registration.
                    </p>
                    <div class="event-period">
                        <span class="icon">📅</span>
                        <span>July 1, 2025 ~ July 31, 2025</span>
                    </div>
                    <div class="event-discount">Up to 30% OFF</div>
                </div>
            </div>

            <!-- Event 2 -->
            <div class="event-card">
                <div class="event-image">
                    <img src="/resources/images/event2.jpg" alt="Family Discount Event"
                         onerror="this.src='data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMzAwIiBoZWlnaHQ9IjIwMCIgdmlld0JveD0iMCAwIDMwMCAyMDAiIGZpbGw9Im5vbmUiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+CjxyZWN0IHdpZHRoPSIzMDAiIGhlaWdodD0iMjAwIiBmaWxsPSIjRTNGMkZEIi8+Cjx0ZXh0IHg9IjE1MCIgeT0iMTAwIiB0ZXh0LWFuY2hvcj0ibWlkZGxlIiBmaWxsPSIjNjY2IiBmb250LXNpemU9IjE0Ij5GYW1pbHkgRGlzY291bnQ8L3RleHQ+Cjwvc3ZnPg=='">
                </div>
                <div class="event-content">
                    <h3 class="event-title">👨‍👩‍👧‍👦 Family Discount Event</h3>
                    <p class="event-description">
                        20% off for groups of 4 or more!
                        Create special memories with your family.
                    </p>
                    <div class="event-period">
                        <span class="icon">📅</span>
                        <span>July 15, 2025 ~ August 15, 2025</span>
                    </div>
                    <div class="event-discount">4+ People 20% OFF</div>
                </div>
            </div>

            <!-- Event 3 -->
            <div class="event-card">
                <div class="event-image">
                    <img src="/resources/images/event3.jpg" alt="Late Night Discount"
                         onerror="this.src='data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMzAwIiBoZWlnaHQ9IjIwMCIgdmlld0JveD0iMCAwIDMwMCAyMDAiIGZpbGw9Im5vbmUiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+CjxyZWN0IHdpZHRoPSIzMDAiIGhlaWdodD0iMjAwIiBmaWxsPSIjRkZGM0U5Ii8+Cjx0ZXh0IHg9IjE1MCIgeT0iMTAwIiB0ZXh0LWFuY2hvcj0ibWlkZGxlIiBmaWxsPSIjNjY2IiBmb250LXNpemU9IjE0Ij5MYXRlIE5pZ2h0IFNob3dzPC90ZXh0Pgo8L3N2Zz4='">
                </div>
                <div class="event-content">
                    <h3 class="event-title">🌙 Late Night Discount</h3>
                    <p class="event-description">
                        Special price for shows after 10 PM!
                        Perfect for night owls and movie lovers.
                    </p>
                    <div class="event-period">
                        <span class="icon">📅</span>
                        <span>Ongoing</span>
                    </div>
                    <div class="event-discount">After 10PM 15% OFF</div>
                </div>
            </div>
        </div>
    </div>

    <!-- Membership Benefits -->
    <div class="membership-section">
        <h2 class="section-title">💎 Phoenix Membership Benefits</h2>

        <div class="membership-grid">
            <div class="membership-card bronze">
                <div class="membership-tier">
                    <span class="tier-icon">🥉</span>
                    <h3>Bronze</h3>
                </div>
                <div class="membership-benefits">
                    <ul>
                        <li>3% points on every purchase</li>
                        <li>Free popcorn on your birthday</li>
                        <li>Priority booking line</li>
                    </ul>
                </div>
                <div class="membership-condition">
                    3+ visits per year
                </div>
            </div>

            <div class="membership-card silver">
                <div class="membership-tier">
                    <span class="tier-icon">🥈</span>
                    <h3>Silver</h3>
                </div>
                <div class="membership-benefits">
                    <ul>
                        <li>5% points on every purchase</li>
                        <li>1 free movie ticket monthly</li>
                        <li>10% off concessions</li>
                        <li>Advanced booking access</li>
                    </ul>
                </div>
                <div class="membership-condition">
                    12+ visits per year
                </div>
            </div>

            <div class="membership-card gold">
                <div class="membership-tier">
                    <span class="tier-icon">🥇</span>
                    <h3>Gold</h3>
                </div>
                <div class="membership-benefits">
                    <ul>
                        <li>10% points on every purchase</li>
                        <li>2 free movie tickets monthly</li>
                        <li>20% off concessions</li>
                        <li>Exclusive lounge access</li>
                        <li>Premier screening invites</li>
                    </ul>
                </div>
                <div class="membership-condition">
                    24+ visits per year
                </div>
            </div>
        </div>
    </div>

    <!-- Past Events -->
    <div class="past-events-section">
        <h2 class="section-title">📰 Past Events</h2>

        <div class="past-events-list">
            <div class="past-event-item">
                <div class="past-event-date">June 2025</div>
                <div class="past-event-title">Avatar 3 Release Special Event</div>
                <div class="past-event-status">Ended</div>
            </div>

            <div class="past-event-item">
                <div class="past-event-date">May 2025</div>
                <div class="past-event-title">Children's Day Free Kids Movies</div>
                <div class="past-event-status">Ended</div>
            </div>

            <div class="past-event-item">
                <div class="past-event-date">April 2025</div>
                <div class="past-event-title">Spring Couples Discount Event</div>
                <div class="past-event-status">Ended</div>
            </div>
        </div>
    </div>

    <!-- Event Notice -->
    <div class="event-notice">
        <h3>📢 Event Terms & Conditions</h3>
        <ul>
            <li>Multiple discount events cannot be combined.</li>
            <li>Event terms and periods may change based on cinema operations.</li>
            <li>For detailed usage instructions, please contact the box office or customer service.</li>
            <li>Some movies may be excluded from discount events.</li>
        </ul>
    </div>

    <!-- Bottom Navigation -->
    <div class="bottom-navigation">
        <a href="/" class="nav-button">
            <span class="icon">🏠</span>
            Home
        </a>
        <a href="/schedule" class="nav-button">
            <span class="icon">🎫</span>
            Book Now
        </a>
        <a href="/movie-all" class="nav-button">
            <span class="icon">🎭</span>
            Movies
        </a>
    </div>

    <div class="footer">
        © 2025 Phoenix Cinema. All rights reserved.
    </div>
</div>

<script>
    // Simple interaction effects
    document.addEventListener('DOMContentLoaded', function() {
        // Event card hover effects
        const eventCards = document.querySelectorAll('.event-card');
        eventCards.forEach(card => {
            card.addEventListener('mouseenter', function() {
                this.style.transform = 'translateY(-5px)';
            });

            card.addEventListener('mouseleave', function() {
                this.style.transform = 'translateY(0)';
            });
        });

        // Membership card click effects
        const membershipCards = document.querySelectorAll('.membership-card');
        membershipCards.forEach(card => {
            card.addEventListener('click', function() {
                // Remove active class from all cards
                membershipCards.forEach(c => c.classList.remove('active'));
                // Add active class to clicked card
                this.classList.add('active');
            });
        });
    });
</script>

</body>
</html>