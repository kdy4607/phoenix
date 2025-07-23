<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Phoenix Cinema - Credits</title>
    <link rel="stylesheet" href="/resources/css/credits.css">
    <!-- Font Awesome CDN 추가 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="icon" href="/resources/images/logo.png" type="image/png">
</head>
<body>
<div class="credits-container">
    <!-- Header -->
    <div class="credits-header">
        <a href="/" class="back-btn">
            <span>← Back to Main</span>
        </a>
        <div class="cinema-logo">Phoenix Cinema</div>
    </div>

    <!-- Main Credits Section -->
    <div class="credits-content">
        <div class="credits-title">
            <h1>Development Team</h1>
            <p>"Premium cinema experience for every moment of movies"</p>
        </div>

        <!-- Team Introduction -->
        <div class="team-intro">
            <div class="intro-text">
                <h2>Team Phoenix</h2>
                <p>Cinema booking system created by 5 passionate developers</p>
                <p>Full-Stack web application completed through systematic collaboration with function-based team structure</p>
            </div>
        </div>

        <!-- Team Structure Introduction -->
        <div class="team-structure">
            <div class="team-group">
                <h3><i class="fas fa-ticket-alt"></i> Movie Booking Function Team</h3>
                <p>Kim Do-yeon (Team Leader) + Kim Gun-oh collaborated to implement booking system</p>
            </div>
            <div class="team-group">
                <h3><i class="fas fa-film"></i> Movie Information Function Team</h3>
                <p>Lee Dong-ju + Han Saeng-myeong collaborated to implement movie information system</p>
            </div>
            <div class="team-group">
                <h3><i class="fas fa-user"></i> User Management Team</h3>
                <p>Choi A-young handled login and membership system implementation</p>
            </div>
        </div>

        <!-- Team Member Credits -->
        <div class="team-members">
            <!-- Team Leader - Kim Do-yeon -->
            <div class="member-card director">
                <div class="role-badge"><i class="fas fa-crown"></i> Project Leader</div>
                <div class="member-info">
                    <h3>Kim Do-yeon</h3>
                    <p class="position">Team Leader & Movie Booking Page Development</p>
                    <div class="responsibilities">
                        <span>• Overall project management and schedule coordination</span>
                        <span>• Movie booking page design and implementation</span>
                        <span>• Seat selection system development</span>
                        <span>• Reservation process logic implementation</span>
                        <span>• Collaborated with Kim Gun-oh to complete booking features</span>
                    </div>
                    <div class="tech-stack">
                        <span class="tech">Spring Boot</span>
                        <span class="tech">JSP/JSTL</span>
                        <span class="tech">JavaScript</span>
                        <span class="tech">Oracle DB</span>
                    </div>
                </div>
            </div>

            <!-- Kim Gun-oh -->
            <div class="member-card schedule">
                <div class="role-badge"><i class="fas fa-calendar-alt"></i> Schedule System</div>
                <div class="member-info">
                    <h3>Kim Gun-oh</h3>
                    <p class="position">Schedule & Booking System Development</p>
                    <div class="responsibilities">
                        <span>• Movie schedule system implementation</span>
                        <span>• Runtime management system development</span>
                        <span>• Booking workflow optimization</span>
                        <span>• Collaborated with Kim Do-yeon for booking feature integration</span>
                        <span>• Database schema design for scheduling</span>
                    </div>
                    <div class="tech-stack">
                        <span class="tech">Spring Boot</span>
                        <span class="tech">MyBatis</span>
                        <span class="tech">Oracle DB</span>
                        <span class="tech">CSS3</span>
                    </div>
                </div>
            </div>

            <!-- Choi A-young -->
            <div class="member-card user">
                <div class="role-badge"><i class="fas fa-user-cog"></i> User System</div>
                <div class="member-info">
                    <h3>Choi A-young</h3>
                    <p class="position">User Management System Development</p>
                    <div class="responsibilities">
                        <span>• User registration and login system implementation</span>
                        <span>• User authentication and authorization</span>
                        <span>• User profile management features</span>
                        <span>• Security implementation and session management</span>
                        <span>• User experience optimization</span>
                    </div>
                    <div class="tech-stack">
                        <span class="tech">Spring Security</span>
                        <span class="tech">JSP</span>
                        <span class="tech">JavaScript</span>
                        <span class="tech">Oracle DB</span>
                    </div>
                </div>
            </div>


            <!-- Han Saeng-myeong -->
            <div class="member-card movie">
                <div class="role-badge"><i class="fas fa-list"></i> Movie List</div>
                <div class="member-info">
                    <h3>Han Saeng-myeong</h3>
                    <p class="position">Movie List & Information System Development</p>
                    <div class="responsibilities">
                        <span>• Movie list page implementation</span>
                        <span>• Movie filtering and search functionality</span>
                        <span>• Movie information database management</span>
                        <span>• Collaborated with Lee Dong-ju for detail page integration</span>
                        <span>• Movie data management system development</span>
                    </div>
                    <div class="tech-stack">
                        <span class="tech">Spring MVC</span>
                        <span class="tech">JSP</span>
                        <span class="tech">SQL</span>
                        <span class="tech">Bootstrap</span>
                    </div>
                </div>
            </div>

        <!-- Lee Dong-ju -->
        <div class="member-card detail">
            <div class="role-badge"><i class="fas fa-info-circle"></i> Movie Detail</div>
            <div class="member-info">
                <h3>Lee Dong-ju</h3>
                <p class="position">Movie Detail Page Development</p>
                <div class="responsibilities">
                    <span>• Movie detail information page implementation</span>
                    <span>• Movie information display system development</span>
                    <span>• Rating and review system implementation</span>
                    <span>• Collaborated with Han Saeng-myeong for movie information integration</span>
                    <span>• Detail page UI/UX optimization</span>
                </div>
                <div class="tech-stack">
                    <span class="tech">JSP</span>
                    <span class="tech">CSS3</span>
                    <span class="tech">JavaScript</span>
                    <span class="tech">AJAX</span>
                </div>
            </div>
        </div>
        </div>

        <!-- Project Information -->
        <div class="project-info">
            <div class="tech-summary">
                <h3><i class="fas fa-cogs"></i> Technology Stack</h3>
                <div class="tech-categories">
                    <div class="tech-category">
                        <h4>Backend Framework</h4>
                        <span>Spring Boot</span>
                        <span>Spring MVC</span>
                        <span>MyBatis</span>
                    </div>
                    <div class="tech-category">
                        <h4>Frontend</h4>
                        <span>JSP/JSTL</span>
                        <span>JavaScript</span>
                        <span>CSS3</span>
                        <span>Bootstrap</span>
                    </div>
                    <div class="tech-category">
                        <h4>Database</h4>
                        <span>Oracle Database</span>
                        <span>SQL</span>
                    </div>
                    <div class="tech-category">
                        <h4>Build Tools</h4>
                        <span>Maven</span>
                        <span>Gradle</span>
                    </div>
                </div>
            </div>

            <div class="project-stats">
                <h3><i class="fas fa-chart-bar"></i> Project Statistics</h3>
                <div class="stats-grid">
                    <div class="stat-item">
                        <span class="stat-number">2025</span>
                        <span class="stat-label">Development Year</span>
                    </div>
                    <div class="stat-item">
                        <span class="stat-number">14</span>
                        <span class="stat-label">Development Period (days)</span>
                    </div>
                    <div class="stat-item">
                        <span class="stat-number">50+</span>
                        <span class="stat-label">Total Files</span>
                    </div>
                    <div class="stat-item">
                        <span class="stat-number">5000+</span>
                        <span class="stat-label">Lines of Code</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- Special Thanks -->
        <div class="thanks-section">
            <h3><i class="fas fa-heart"></i> Special Thanks</h3>
            <p>We express our gratitude to everyone who helped us complete this project.</p>
            <div class="thanks-list">
                <span>• Instructor Lee Myeong-jae for detailed guidance</span>
                <span>• Colleagues for idea sharing and feedback</span>
                <span>• Spring Boot & Oracle official documentation</span>
            </div>
        </div>

        <!-- Closing Message -->
        <div class="closing-message">
            <div class="message-content">
                <h2><i class="fas fa-film"></i> "Movies start from here"</h2>
                <p>Create a special movie experience with Phoenix Cinema!</p>
                <div class="closing-buttons">
                    <a href="/" class="btn-home"><i class="fas fa-home"></i> Home</a>
                    <a href="/schedule" class="btn-booking"><i class="fas fa-ticket-alt"></i> Book Movie</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <div class="credits-footer">
        <p>&copy; 2025 Phoenix Cinema Development Team. All rights reserved.</p>
        <p>Made with passion by Team Phoenix</p>
    </div>
</div>

<script>
    // Animation effects for member cards
    document.addEventListener('DOMContentLoaded', function() {
        const memberCards = document.querySelectorAll('.member-card');

        const observerOptions = {
            threshold: 0.1,
            rootMargin: '0px 0px -50px 0px'
        };

        const observer = new IntersectionObserver(function(entries) {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add('animate');
                }
            });
        }, observerOptions);

        memberCards.forEach(card => {
            observer.observe(card);
        });

        // Add smooth scrolling for back button
        const backBtn = document.querySelector('.back-btn');
        backBtn.addEventListener('click', function(e) {
            e.preventDefault();
            window.location.href = '/';
        });
    });
</script>

</body>
</html>