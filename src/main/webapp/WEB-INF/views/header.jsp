<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="/resources/css/header.css">
<link rel="icon" href="/resources/images/logo.png" type="image/png">

<!-- 디버깅용 정보 표시 -->
<%--<div style="background-color: yellow; padding: 10px; font-size: 12px;">--%>
<%--    <strong>디버깅 정보:</strong><br>--%>
<%--    세션 사용자: ${sessionScope.user}<br>--%>
<%--    사용자 이름: ${sessionScope.user.u_name}<br>--%>
<%--    사용자 ID: ${sessionScope.user.u_id}<br>--%>
<%--    세션 존재 여부: ${not empty sessionScope.user}<br>--%>
<%--    사용자 객체: ${user}<br>--%>
<%--    사용자 이름2: ${user.u_name}--%>
<%--</div>--%>

<header class="phoenix-header">
    <div class="header-content">
        <div class="header-left">
            <a href="/" class="header-logo">
                <img src="/resources/images/logo.png" alt="Phoenix Cinema Logo" class="logo-image">
            </a>
            <nav>
                <ul class="nav-menu">
                    <li><a href="/movie-all">Movies</a></li>
                    <li><a href="/schedule">Schedule</a></li>
                    <li><a href="/reservation/list">My Bookings</a></li>
                    <li><a href="/events">Events</a></li>
                </ul>
            </nav>
        </div>

        <div class="header-right">
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <!-- 로그인 후 상태 -->
                    <div class="user-info" id="userInfo">
                        <div class="user-avatar" id="userAvatar">
                            <c:choose>
                                <c:when test="${not empty sessionScope.user.u_name}">
                                    ${sessionScope.user.u_name.substring(0, 1)}
                                </c:when>
                                <c:otherwise>U</c:otherwise>
                            </c:choose>
                        </div>
                        <span class="user-name" id="userName">
                            <c:choose>
                                <c:when test="${not empty sessionScope.user.u_name}">
                                    ${sessionScope.user.u_name}
                                </c:when>
                                <c:otherwise>Guest</c:otherwise>
                            </c:choose>
                        </span>
                        <div class="user-menu">
                            <button class="user-menu-btn" onclick="toggleUserMenu()">⋮</button>
                            <div class="user-dropdown" id="userDropdown">
                                <a href="/mypage" class="dropdown-item">👤 MyPage</a>
                                <a href="/reservation/list" class="dropdown-item">📋 My Bookings</a>
                                <a href="#" class="dropdown-item" onclick="alert('설정 준비 중')">⚙️ Setting</a>
                                <div class="dropdown-divider"></div>
                                <button class="dropdown-item" onclick="logout()">🚪 Logout</button>
                            </div>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <!-- 로그인 전 상태 -->
                    <div class="auth-section" id="authSection">
                        <a href="/login" class="auth-btn login-btn">Sign in</a>
                        <a href="/join/step1" class="auth-btn signup-btn">Sign up</a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</header>

<!-- JavaScript 변수 설정 -->
<script>
    // 서버에서 전달받은 정보를 JavaScript 변수로 설정
    const isLoggedIn = ${not empty sessionScope.user};
    const currentUser = isLoggedIn ? {
        <c:if test="${not empty sessionScope.user}">
        id: '${sessionScope.user.u_id}',
        name: '${sessionScope.user.u_name}',
        loginId: '${sessionScope.user.u_id}'
        </c:if>
    } : null;

    console.log('현재 로그인 상태:', isLoggedIn);
    if (currentUser) {
        console.log('로그인 사용자:', currentUser.name);
    }

    // 사용자 메뉴 토글
    function toggleUserMenu() {
        const dropdown = document.getElementById('userDropdown');
        if (dropdown) {
            dropdown.classList.toggle('show');

            // 외부 클릭 시 메뉴 닫기
            document.addEventListener('click', function(event) {
                if (!event.target.closest('.user-menu')) {
                    dropdown.classList.remove('show');
                }
            });
        }
    }

    // 로그아웃 함수
    function logout() {
        if (confirm('want to logout?')) {
            console.log('로그아웃 처리 시작');

            // 서버에 로그아웃 요청
            fetch('/logout', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                }
            })
                .then(response => {
                    if (response.ok) {
                        console.log('로그아웃 성공');
                        alert('logout complete.');
                        // 메인 페이지로 이동
                        window.location.href = '/';
                    } else {
                        console.error('로그아웃 실패');
                        alert('there is error during logout.');
                    }
                })
                .catch(error => {
                    console.error('로그아웃 오류:', error);
                    // 오류가 발생해도 로그아웃 처리
                    alert('logout complete.');
                    window.location.href = '/';
                });
        }
    }
</script>