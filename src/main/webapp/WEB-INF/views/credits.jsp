<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Phoenix Cinema - Credits</title>
    <link rel="stylesheet" href="/resources/css/credits.css">
</head>
<body>
<div class="credits-container">
    <!-- 헤더 -->
    <div class="credits-header">
        <a href="/" class="back-btn">
            <span>← 메인으로 돌아가기</span>
        </a>
        <div class="cinema-logo">Phoenix Cinema</div>
    </div>

    <!-- 메인 크레딧 섹션 -->
    <div class="credits-content">
        <div class="credits-title">
            <h1>Development Team</h1>
            <p>"영화의 모든 순간을 함께하는 프리미엄 시네마"</p>
        </div>

        <!-- 팀 소개 -->
        <div class="team-intro">
            <div class="intro-text">
                <h2> Team Phoenix</h2>
                <p>5명의 열정적인 개발자들이 만든 영화관 예약 시스템</p>
                <p>기능별 팀 구성으로 체계적인 협업을 통해 완성된 Full-Stack 웹 애플리케이션</p>
            </div>
        </div>

        <!-- 팀 구성 소개 -->
        <div class="team-structure">
            <div class="team-group">
                <h3>🎫 영화 예매 기능팀</h3>
                <p>김도연(팀장) + 김건오가 연계하여 예매 시스템 구현</p>
            </div>
            <div class="team-group">
                <h3>🎬 영화 정보 기능팀</h3>
                <p>이동주 + 한생명이 연계하여 영화 정보 시스템 구현</p>
            </div>
            <div class="team-group">
                <h3>👤 사용자 관리팀</h3>
                <p>최아영이 담당하여 로그인 및 회원 시스템 구현</p>
            </div>
        </div>

        <!-- 팀원 크레딧 -->
        <div class="team-members">
            <!-- 팀장 - 김도연 -->
            <div class="member-card director">
                <div class="role-badge">🎬 Project Leader</div>
                <div class="member-info">
                    <h3>김도연</h3>
                    <p class="position">Team Leader & 영화 예매 페이지 개발</p>
                    <div class="responsibilities">
                        <span>• 프로젝트 총괄 관리 및 일정 조율</span>
                        <span>• 영화 예매 페이지 설계 및 구현</span>
                        <span>• 좌석 선택 시스템 개발</span>
                        <span>• 예약 프로세스 로직 구현</span>
                        <span>• 김건오와 연계하여 예매 기능 완성</span>
                    </div>
                    <div class="tech-stack">
                        <span class="tech">Spring Boot</span>
                        <span class="tech">JSP/JSTL</span>
                        <span class="tech">JavaScript</span>
                        <span class="tech">Oracle DB</span>
                    </div>
                </div>
            </div>

            <!-- 이동주 -->
            <div class="member-card detail">
                <div class="role-badge">🎥 Movie Detail</div>
                <div class="member-info">
                    <h3>이동주</h3>
                    <p class="position">영화 상세 페이지 개발</p>
                    <div class="responsibilities">
                        <span>• 영화 상세 정보 페이지 구현</span>
                        <span>• 영화 정보 표시 시스템 개발</span>
                        <span>• 평점 및 리뷰 시스템 구현</span>
                        <span>• 한생명과 연계하여 영화 정보 연동</span>
                        <span>• 상세 페이지 UI/UX 최적화</span>
                    </div>
                    <div class="tech-stack">
                        <span class="tech">JSP</span>
                        <span class="tech">CSS3</span>
                        <span class="tech">JavaScript</span>
                        <span class="tech">AJAX</span>
                    </div>
                </div>
            </div>

            <!-- 최아영 -->
            <div class="member-card user">
                <div class="role-badge">👤 User System</div>
                <div class="member-info">
                    <h3>최아영</h3>
                    <p class="position">로그인 기능 & 유저정보 관리 개발</p>
                    <div class="responsibilities">
                        <span>• 회원가입 및 로그인 시스템 구현</span>
                        <span>• 사용자 인증 및 세션 관리</span>
                        <span>• 회원 정보 관리 페이지 개발</span>
                        <span>• 보안 및 권한 관리 시스템</span>
                        <span>• 마이페이지 및 예약 내역 관리</span>
                    </div>
                    <div class="tech-stack">
                        <span class="tech">Spring Security</span>
                        <span class="tech">Session Management</span>
                        <span class="tech">Oracle DB</span>
                        <span class="tech">JSP</span>
                    </div>
                </div>
            </div>


            <!-- 김건오 -->
            <div class="member-card schedule">
                <div class="role-badge">📅 Schedule & MainPage</div>
                <div class="member-info">
                    <h3>김건오</h3>
                    <p class="position">영화 상영 스케줄 & 메인 페이지 개발</p>
                    <div class="responsibilities">
                        <span>• 메인 페이지 설계 및 구현</span>
                        <span>• 영화 상영시간표 시스템 개발</span>
                        <span>• 날짜별 상영 스케줄 관리</span>
                        <span>• 김도연과 연계하여 예매 시스템 연동</span>
                        <span>• 사용자 인터페이스 최적화</span>
                    </div>
                    <div class="tech-stack">
                        <span class="tech">Spring MVC</span>
                        <span class="tech">HTML5/CSS3</span>
                        <span class="tech">JavaScript</span>
                        <span class="tech">MyBatis</span>
                    </div>
                </div>
            </div>


            <!-- 한생명 -->
            <div class="member-card movie">
                <div class="role-badge">🎞️ Movie List</div>
                <div class="member-info">
                    <h3>한생명</h3>
                    <p class="position">전체 영화 조회 페이지 개발</p>
                    <div class="responsibilities">
                        <span>• 전체 영화 목록 페이지 구현</span>
                        <span>• 영화 검색 및 필터링 기능</span>
                        <span>• 장르별 영화 분류 시스템</span>
                        <span>• 이동주와 연계하여 상세 정보 연동</span>
                        <span>• 영화 데이터 관리 및 표시</span>
                    </div>
                    <div class="tech-stack">
                        <span class="tech">Spring Boot</span>
                        <span class="tech">MyBatis</span>
                        <span class="tech">JSP/JSTL</span>
                        <span class="tech">Oracle SQL</span>
                    </div>
                </div>
            </div>


        </div>


        <!-- 기술 스택 및 프로젝트 정보 -->
        <div class="project-info">
            <div class="tech-summary">
                <h3> Technology Stack</h3>
                <div class="tech-categories">
                    <div class="tech-category">
                        <h4>Backend</h4>
                        <span>Spring Boot 3.4.7</span>
                        <span>Java 17</span>
                        <span>MyBatis</span>
                        <span>Oracle Database</span>
                    </div>
                    <div class="tech-category">
                        <h4>Frontend</h4>
                        <span>HTML5 / CSS3</span>
                        <span>JavaScript ES6+</span>
                        <span>JSP / JSTL</span>
                        <span>Responsive Design</span>
                    </div>
                    <div class="tech-category">
                        <h4>Tools</h4>
                        <span>IntelliJ IDEA</span>
                        <span>Git / GitHub</span>
                        <span>SQL Developer</span>
                        <span>Gradle</span>
                    </div>
                </div>
            </div>

            <div class="project-stats">
                <h3> Project Statistics</h3>
                <div class="stats-grid">
                    <div class="stat-item">
                        <span class="stat-number">2025</span>
                        <span class="stat-label">개발 년도</span>
                    </div>
                    <div class="stat-item">
                        <span class="stat-number">14</span>
                        <span class="stat-label">개발 기간 (days)</span>
                    </div>
                    <div class="stat-item">
                        <span class="stat-number">50+</span>
                        <span class="stat-label">총 파일 수</span>
                    </div>
                    <div class="stat-item">
                        <span class="stat-number">5000+</span>
                        <span class="stat-label">코드 라인 수</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- 감사 인사 -->
        <div class="thanks-section">
            <h3>🙏 Special Thanks</h3>
            <p>이 프로젝트를 완성할 수 있도록 도움을 주신 모든 분들께 감사드립니다.</p>
            <div class="thanks-list">
                <span>• 이명재 강사님의 세심한 가이드</span>
                <span>• 동기들의 아이디어 제공과 피드백</span>
                <span>• Spring Boot & Oracle 공식 문서</span>
            </div>
        </div>

        <!-- 마지막 메시지 -->
        <div class="closing-message">
            <div class="message-content">
                <h2>🎬 "영화의 시작은 여기서부터"</h2>
                <p>Phoenix Cinema와 함께 특별한 영화 경험을 만들어가세요!</p>
                <div class="closing-buttons">
                    <a href="/" class="btn-home">🏠 홈으로</a>
                    <a href="/schedule" class="btn-booking">🎫 영화 예매</a>
                </div>
            </div>
        </div>
    </div>

    <!-- 푸터 -->
    <div class="credits-footer">
        <p>&copy; 2025 Phoenix Cinema Development Team. All rights reserved.</p>
        <p>Made by Team Phoenix</p>
    </div>
</div>

<!-- 스크롤 애니메이션 스크립트 -->
<script>
    // 스크롤에 따른 애니메이션 효과
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

    // 페이지 로드 시 첫 번째 멤버 카드 애니메이션
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