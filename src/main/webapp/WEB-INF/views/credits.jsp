<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Phoenix Cinema - Credits</title>
    <link rel="stylesheet" href="/resources/css/credits.css">
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
                <h3>🎫 Movie Booking Function Team</h3>
                <p>Kim Do-yeon (Team Leader) + Kim Gun-oh collaborated to implement booking system</p>
            </div>
            <div class="team-group">
                <h3>🎬 Movie Information Function Team</h3>
                <p>Lee Dong-ju + Han Saeng-myeong collaborated to implement movie information system</p>
            </div>
            <div class="team-group">
                <h3>👤 User Management Team</h3>
                <p>Choi A-young handled login and membership system implementation</p>
            </div>
        </div>

        <!-- Team Member Credits -->
        <div class="team-members">
            <!-- Team Leader - Kim Do-yeon -->
            <div class="member-card director">
                <div class="role-badge">🎬 Project Leader</div>
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

            <!-- Lee Dong-ju -->
            <div class="member-card detail">
                <div class="role-badge">🎥 Movie Detail</div>
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

            <!-- Choi A-young -->
            <div class="member-card user">
                <div class="role-badge">👤 User System</div>
                <div class="member-info">
                    <h3>Choi A-young</h3>
                    <p class="position">Login Function & User Information Management Development</p>
                    <div class="responsibilities">
                        <span>• User registration and login system implementation</span>
                        <span>• User information management page development</span>
                        <span>• Session management and security implementation</span>
                        <span>• User authentication and authorization logic</span>
                        <span>• My page and user profile management</span>
                    </div>
                    <div class="tech-stack">
                        <span class="tech">Spring Security</span>
                        <span class="tech">Session Management</span>
                        <span class="tech">JSP</span>
                        <span class="tech">Oracle DB</span>
                    </div>
                </div>
            </div>

            <!-- Kim Gun-oh -->
            <div class="member-card booking">
                <div class="role-badge">🎯 Booking System</div>
                <div class="member-info">
                    <h3>Kim Gun-oh</h3>
                    <p class="position">Movie Schedule & Booking System Development</p>
                    <div class="responsibilities">
                        <span>• Movie schedule management system implementation</span>
                        <span>• Booking process backend logic development</span>
                        <span>• Database design and optimization</span>
                        <span>• Collaborated with Kim Do-yeon for booking page integration</span>
                        <span>• Booking history and management features</span>
                    </div>
                    <div class="tech-stack">
                        <span class="tech">Spring Boot</span>
                        <span class="tech">MyBatis</span>
                        <span class="tech">Oracle DB</span>
                        <span class="tech">REST API</span>
                    </div>
                </div>
            </div>

            <!-- Han Saeng-myeong -->
            <div class="member-card movie">
                <div class="role-badge">🎭 Movie Management</div>
                <div class="member-info">
                    <h3>Han Saeng-myeong</h3>
                    <p class="position">Movie List & Information Management Development</p>
                    <div class="responsibilities">
                        <span>• Movie list page implementation</span>
                        <span>• Movie data management system development</span>
                        <span>• Movie search and filtering features</span>
                        <span>• Collaborated with Lee Dong-ju for movie information integration</span>
                        <span>• Movie categorization and sorting system</span>
                    </div>
                    <div class="tech-stack">
                        <span class="tech">JSP/JSTL</span>
                        <span class="tech">JavaScript</span>
                        <span class="tech">CSS3</span>
                        <span class="tech">Oracle DB</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- Project Information -->
        <div class="project-info">
            <div class="tech-overview">
                <h3>🔧 Technology Stack</h3>
                <div class="tech-categories">
                    <div class="tech-category">
                        <h4>Backend</h4>
                        <span>Spring Boot</span>
                        <span>MyBatis</span>
                        <span>Oracle Database</span>
                    </div>
                    <div class="tech-category">
                        <h4>Frontend</h4>
                        <span>JSP/JSTL</span>
                        <span>JavaScript</span>
                        <span>CSS3</span>
                        <span>AJAX</span>
                    </div>
                    <div class="tech-category">
                        <h4>Tools</h4>
                        <span>IntelliJ IDEA</span>
                        <span>Git</span>
                        <span>Gradle</span>
                    </div>
                </div>
            </div>

            <div class="project-stats">
                <h3>📊 Project Statistics</h3>
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
            <h3>🙏 Special Thanks</h3>
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
                <h2>🎬 "Movies start from here"</h2>
                <p>Create a special movie experience with Phoenix Cinema!</p>
                <div class="closing-buttons">
                    <a href="/" class="btn-home">🏠 Home</a>
                    <a href="/schedule" class="btn-booking">🎫 Book Movie</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <div class="credits-footer">
        <p>&copy; 2025 Phoenix Cinema Development Team. All rights reserved.</p>
        <p>Made by Team Phoenix</p>
    </div>
</div>

<!-- Scroll Animation Script -->
<script>
    // Animation effects based on scroll
    window.addEventListener('scroll', () => {
        const members = document.querySelectorAll('.member-card');
        members.forEach(member => {
            const rect = member.getBoundingClientRect();
            const isVisible = rect.top < window.innerHeight && rect.bottom > 0;

            if (isVisible) {
                member.classList.add('animate');
            }
        });
    });

    // First member card animation on page load
    document.addEventListener('DOMContentLoaded', () => {
        setTimeout(() => {
            const firstCard = document.querySelector('.member-card');
            if (firstCard) {
                firstCard.classList.add('animate');
            }
        }, 500);
    });
</script>
</body>
</html>