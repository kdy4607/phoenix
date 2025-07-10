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
            <!-- 로그인 전 상태 -->
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <!-- 로그인 후 상태 -->
                    <div class="user-info" id="userInfo">
                        <div class="user-avatar" id="userAvatar">
                                ${sessionScope.user.u_name.substring(0, 1)}
                        </div>
                        <span class="user-name" id="userName">${sessionScope.user.u_name}님</span>
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

<!-- JavaScript 함수들 -->
<script src="resources/js/header.js"></script>