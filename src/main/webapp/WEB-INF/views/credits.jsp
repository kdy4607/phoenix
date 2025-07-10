<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
        <div class="cinema-logo">🎬 Phoenix Cinema</div>
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
                <h2>🎭 Team Phoenix</h2>
                <p>5명의 열정적인 개발자들이 만든 영화관 예약 시스템</p>
                <p>Spring Boot와 Oracle DB를 활용한 Full-Stack 웹 애플리케이션</p>
            </div>
        </div>

        <!-- 팀원 크레딧 -->
        <div class="team-members">
            <!-- 팀장/백엔드 리더 -->
            <div class="member-card director">
                <div class="role-badge">🎬 Project Director</div>
                <div class="member-info">
                    <h3>김도연 (KDY)</h3>
                    <p class="position">Team Leader & Backend Developer</p>
                    <div class="responsibilities">
                        <span>• 프로젝트 총괄 관리</span>
                        <span>• Spring Boot 아키텍처 설계</span>
                        <span>• 데이터베이스 설계 및 최적화</span>
                        <span>• 예약 시스템 핵심 로직 개발</span>
                    </div>
                    <div class="tech-stack">
                        <span class="tech">Spring Boot</span>
                        <span class="tech">Oracle DB</span>
                        <span class="tech">MyBatis</span>
                    </div>
                </div>
            </div>

            <!-- 프론트엔드 개발자 -->
            <div class="member-card frontend">
                <div class="role-badge">🎨 UI/UX Director</div>
                <div class="member-info">
                    <h3>김건오 (KGO)</h3>
                    <p class="position">Frontend Developer</p>
                    <div class="responsibilities">
                        <span>• 사용자 인터페이스 설계</span>
                        <span>• 반응형 웹 디자인 구현</span>
                        <span>• JavaScript 인터랙션 개발</span>
                        <span>• CSS 애니메이션 및 스타일링</span>
                    </div>
                    <div class="tech-stack">
                        <span class="tech">HTML5/CSS3</span>
                        <span class="tech">JavaScript</span>
                        <span class="tech">JSP</span>
                    </div>
                </div>
            </div>

            <!-- 백엔드 개발자 1 -->
            <div class="member-card backend">
                <div class="role-badge">⚙️ System Architect</div>
                <div class="member-info">
                    <h3>이동주 (LDJ)</h3>
                    <p class="position">Backend Developer</p>
                    <div class="responsibilities">
                        <span>• REST API 설계 및 개발</span>
                        <span>• 좌석 예약 시스템 구현</span>
                        <span>• 보안 및 인증 시스템</span>
                        <span>• 서버 성능 최적화</span>
                    </div>
                    <div class="tech-stack">
                        <span class="tech">Spring Security</span>
                        <span class="tech">REST API</span>
                        <span class="tech">JPA</span>
                    </div>
                </div>
            </div>

            <!-- 백엔드 개발자 2 -->
            <div class="member-card backend">
                <div class="role-badge">📊 Data Specialist</div>
                <div class="member-info">
                    <h3>한생명 (HSM)</h3>
                    <p class="position">Backend Developer & DBA</p>
                    <div class="responsibilities">
                        <span>• 데이터베이스 스키마 설계</span>
                        <span>• 영화 정보 관리 시스템</span>
                        <span>• 쿼리 성능 튜닝</span>
                        <span>• 데이터 마이그레이션</span>
                    </div>
                    <div class="tech-stack">
                        <span class="tech">Oracle SQL</span>
                        <span class="tech">Database Design</span>
                        <span class="tech">Performance Tuning</span>
                    </div>
                </div>
            </div>

            <!-- QA/테스터 -->
            <div class="member-card qa">
                <div class="role-badge">🔍 Quality Assurance</div>
                <div class="member-info">
                    <h3>최아영 (CAY)</h3>
                    <p class="position">QA Engineer & Frontend Support</p>
                    <div class="responsibilities">
                        <span>• 전체 시스템 품질 관리</span>
                        <span>• 사용자 테스트 시나리오 작성</span>
                        <span>• 버그 발견 및 리포팅</span>
                        <span>• 사용자 경험 개선 제안</span>
                    </div>
                    <div class="tech-stack">
                        <span class="tech">Manual Testing</span>
                        <span class="tech">User Experience</span>
                        <span class="tech">Bug Tracking</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- 기술 스택 및 프로젝트 정보 -->
        <div class="project-info">
            <div class="tech-summary">
                <h3>🛠 Technology Stack</h3>
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
                <h3>📈 Project Statistics</h3>
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
                <span>• 테스트에 참여해주신 사용자분들</span>
                <span>• Stack Overflow 커뮤니티</span>
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
        <p>Made with ❤️ by Team Phoenix</p>
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