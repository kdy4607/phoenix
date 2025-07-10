<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="/resources/css/header.css">
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
            <!-- 로그인 전 (기본 상태) -->
            <div class="auth-section" id="authSection">
                <a href="/login" class="auth-btn login-btn">로그인</a>
                <a href="/join/step1" class="auth-btn signup-btn">회원가입</a>
            </div>

            <!-- 로그인 후 (숨김 상태 - 나중에 JavaScript로 표시) -->
            <div class="user-info" id="userInfo">
                <div class="user-avatar" id="userAvatar">김</div>
                <span class="user-name" id="userName">김도연님</span>
                <div class="user-menu">
                    <button class="user-menu-btn" onclick="toggleUserMenu()">⋮</button>
                    <div class="user-dropdown" id="userDropdown">
                        <a href="/mypage" class="dropdown-item" onclick="alert('마이페이지 준비 중')">👤 마이페이지</a>
                        <a href="/reservation/list" class="dropdown-item">📋 예약내역</a>
                        <a href="#" class="dropdown-item" onclick="alert('설정 준비 중')">⚙️ 설정</a>
                        <div class="dropdown-divider"></div>
                        <button class="dropdown-item" onclick="logout()">🚪 로그아웃</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</header>

<!-- JavaScript 함수들 -->
<script>
    // 로그인 모달 표시 (임시 - 나중에 실제 모달로 교체)
    function showLoginModal() {
        alert('로그인 기능 준비 중입니다.\n\n나중에 실제 로그인 폼으로 교체될 예정입니다.');
        // 임시로 로그인 상태로 변경 (테스트용)
        // simulateLogin();
    }

    // 회원가입 모달 표시 (임시 - 나중에 실제 모달로 교체)
    function showSignupModal() {
        alert('회원가입 기능 준비 중입니다.\n\n나중에 실제 회원가입 폼으로 교체될 예정입니다.');
    }

    // 사용자 메뉴 토글
    function toggleUserMenu() {
        const dropdown = document.getElementById('userDropdown');
        dropdown.classList.toggle('show');

        // 외부 클릭 시 메뉴 닫기
        document.addEventListener('click', function(event) {
            if (!event.target.closest('.user-menu')) {
                dropdown.classList.remove('show');
            }
        });
    }

    // 로그아웃
    function logout() {
        if (confirm('로그아웃하시겠습니까?')) {
            // 실제 로그아웃 처리는 나중에 구현
            alert('로그아웃 되었습니다.');

            // UI 상태 변경
            document.getElementById('authSection').style.display = 'flex';
            document.getElementById('userInfo').style.display = 'none';
            document.getElementById('userDropdown').classList.remove('show');
        }
    }

    // 로그인 상태 시뮬레이션 (테스트용 - 나중에 제거)
    function simulateLogin() {
        document.getElementById('authSection').style.display = 'none';
        document.getElementById('userInfo').style.display = 'flex';

        // 사용자 정보 설정 (나중에 서버에서 받아올 데이터)
        document.getElementById('userAvatar').textContent = '김';
        document.getElementById('userName').textContent = '김도연님';
    }

    // 페이지 로드 시 로그인 상태 확인 (나중에 서버와 연동)
    document.addEventListener('DOMContentLoaded', function() {
        // 현재는 기본적으로 로그아웃 상태
        // 나중에 세션 체크하여 로그인 상태 확인
        checkLoginStatus();
    });

    // 로그인 상태 확인 함수 (나중에 AJAX로 서버 체크)
    function checkLoginStatus() {
        // 임시: 로컬스토리지나 세션에서 로그인 상태 확인
        // const isLoggedIn = sessionStorage.getItem('isLoggedIn') === 'true';
        const isLoggedIn = false; // 기본값: 로그아웃 상태

        if (isLoggedIn) {
            simulateLogin();
        }
    }
</script>