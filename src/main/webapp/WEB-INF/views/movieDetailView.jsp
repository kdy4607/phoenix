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
<div class="container">
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

</div>
<%--<a href="/userBookMarks">북마크 보기 테스트</a>--%>
</body>

</html>
