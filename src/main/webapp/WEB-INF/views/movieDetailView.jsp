<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="/resources/css/logoin.css">
    <link rel="stylesheet" href="/resources/css/menuCon.css">
</head>
<body>
<body>
<button onclick="location.href='/all-movie'">전부 보는거</button>
<%-- 메뉴 로고 및 로그인 창 입니다--%>
<div class="head-info">
    <%-- 공간을 맞춰주기위해 빈 div 넣었습니다. --%>
    <div class="nothing"></div>
    <div class="title-img">
        <img style="width: 200px"
             src=""
             alt="">
    </div>
    <div class="login-status">
        <div>로그인상태창.</div>
    </div>
</div>

<%-- 메뉴 선택 창입니다. --%>
<div class="menu-sel">
    <div>menu1</div>
    <div>menu2</div>
    <div>menu3</div>
    <div>menu4</div>
</div>

<%--<p>include 경로: ${movieDetail}</p>--%>
<div>
    <jsp:include page="${movieDetail}"></jsp:include>
</div>

<%--<c:if test="${not empty movieDetail}">--%>
<%--    <jsp:include page="${movieDetail}" />--%>
<%--</c:if>--%>
<%-- 위 movie 디테일
(사진, 타이틀, 총 별점, 감독,주연,관객별점, 전문가 평점, 북마크)
값을 사용하는 기준으로 같이 묶음.) --%>
<%-- El 값 받을때 사용 이름 movieDetail--%>
<%--<div>--%>
<%--    <jsp:include page="${movieDetail}"></jsp:include>--%>
<%--</div>--%>

<%-- 컨트롤러를 타고 갖고오는 jsp 이름 movieDetail.jsp --%>
<%-- 현재 movieHome.jsp 로
movie-detail.jsp 를 갖고와줄 컨트롤러 이름 MovieDetailCON--%>

<%-- 이하 영화 정보 셀렉트--%>
<%-- 인클루드 해줄 이름 --%>
<%--<div>--%>
<%--    <jsp:include page="${clickMovieDetail}"></jsp:include>--%>
<%--</div>--%>
<%-- 거쳐야하는 기능창 지금은 movieDao  --%>
<%--<div>--%>
<%--    <jsp:include page="${clickMovieDetail}"></jsp:include>--%>
<%--</div>--%>
</body>

<%--<c:forEach var="movie" items="${Allmovie}">--%>
<%--    <div>--%>
<%--        <div>--%>
<%--            <div>${movie.m_title}</div>--%>
<%--            <img src="" alt="movieFile/${movie.m_img}">--%>
<%--        </div>--%>
<%--        <div>--%>
<%--            <div>${movie.m_style}</div>--%>
<%--            <div>${movie.m_country}</div>--%>
<%--        </div>--%>
<%--        <div>코멘트</div>--%>
<%--        <div>표 가격</div>--%>
<%--    </div>--%>
<%--</c:forEach>--%>
</html>
