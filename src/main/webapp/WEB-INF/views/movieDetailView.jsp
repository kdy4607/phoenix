<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="/resources/css/detailmovie-menu-logoin.css">
    <link rel="stylesheet" href="/resources/css/menuCon.css">
</head>
<body>
<jsp:include page="/WEB-INF/views/header.jsp"/>

<%-- 메뉴 선택 창입니다. --%>
<div class="menu-sel">
    <h1>
        MOVIE INFORMATION
    </h1>
</div>
<div>
    <jsp:include page="${movieDetail}"></jsp:include>
</div>
<div>
    <jsp:include page="${movieTapClic}"></jsp:include>
</div>
<%--    <div onclick="location.href='/movie-all'">--%>
<%--        <span class="icon">🎭</span>영화 목록--%>
<%--    </div>--%>
<%--    <div onclick="location.href='/schedule'">--%>
<%--        <span class=" icon">🎫</span>상영시간표 & 예매--%>
<%--    </div>--%>
<%--    <div onclick="alert('준비 중입니다!')">--%>
<%--        <span class="icon">🏢</span>극장 정보--%>
<%--    </div>--%>
<%--    <div onclick="alert('준비 중입니다!')">--%>
<%--        <span class="icon">🎉</span>이벤트--%>
<%--    </div>--%>
</body>

</html>
