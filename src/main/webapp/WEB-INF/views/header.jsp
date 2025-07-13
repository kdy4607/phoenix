<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="/resources/css/header.css">

<!-- 디버깅용 정보 표시 -->
<div style="background-color: yellow; padding: 10px; font-size: 12px;">
    <strong>디버깅 정보:</strong><br>
    세션 사용자: ${sessionScope.user}<br>
    사용자 이름: ${sessionScope.user.u_name}<br>
    사용자 ID: ${sessionScope.user.u_id}<br>
    세션 존재 여부: ${not empty sessionScope.user}<br>
    사용자 객체: ${user}<br>
    사용자 이름2: ${user.u_name}
</div>

<header class="phoenix-header">
    <div class="header-content">
        <div class="header-left">
            <a href="/" class="header-logo">🎬 Phoenix</a>
            <nav>
                <ul class="nav-menu">
                    <li><a href="/movie-all">영화</a></li>
                    <li><a href="/schedule">예매</a></li>
                    <li><a href="/reservation/list">예약내역</a></li>
                    <li><a href="#" onclick="alert('준비 중입니다!')">극장</a></li>
                    <li><a href="#" onclick="alert('준비 중입니다!')">이벤트</a></li>
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
                                    ${sessionScope.user.u_name}님
                                </c:when>
                                <c:otherwise>사용자님</c:otherwise>
                            </c:choose>
                        </span>
                        <div class="user-menu">
                            <button class="user-menu-btn" onclick="toggleUserMenu()">⋮</button>
                            <div class="user-dropdown" id="userDropdown">
                                <a href="/mypage" class="dropdown-item">👤 마이페이지</a>
                                <a href="/reservation/list" class="dropdown-item">📋 예약내역</a>
                                <a href="#" class="dropdown-item" onclick="alert('설정 준비 중')">⚙️ 설정</a>
                                <div class="dropdown-divider"></div>
                                <button class="dropdown-item" onclick="logout()">🚪 로그아웃</button>
                            </div>
                        </div>
                    </div>
                </c:when>
                <c:otherwise>
                    <!-- 로그인 전 상태 -->
                    <div class="auth-section" id="authSection">
                        <a href="/login" class="auth-btn login-btn">로그인</a>
                        <a href="/join/step1" class="auth-btn signup-btn">회원가입</a>
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
        if (confirm('로그아웃하시겠습니까?')) {
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
                        alert('로그아웃 되었습니다.');
                        // 메인 페이지로 이동
                        window.location.href = '/';
                    } else {
                        console.error('로그아웃 실패');
                        alert('로그아웃 중 오류가 발생했습니다.');
                    }
                })
                .catch(error => {
                    console.error('로그아웃 오류:', error);
                    // 오류가 발생해도 로그아웃 처리
                    alert('로그아웃 되었습니다.');
                    window.location.href = '/';
                });
        }
    }
</script>