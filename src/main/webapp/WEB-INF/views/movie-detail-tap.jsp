<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="/resources/css/clickTap.css">
</head>
<body>
<div class="tap-outBox">
    <!-- 탭 버튼 영역 -->
    <div class="tab" onclick="showTab(0)">동일장르 영화</div>
    <div class="tab" onclick="showTab(1)">스토리</div>
    <div class="tab" onclick="showTab(2)">관객평</div>
</div>
<div class="tap-inBox">
    <!-- 탭 내용 영역 -->
    <div class="content active">
        <div class="related-movie-wrap">
            <c:forEach var="rel" items="${relatedMovies}">
                <div class="related-movie">
                    <img src="${rel.poster_url}" alt="${rel.title}" style="width:150px">
                    <div>${rel.title}</div>
                </div>
            </c:forEach>
        </div>
    </div>
    <div class="content">줄거리:${movieDetail2.description}</div>
    <div class="content">감상평</div>
</div>

<script>
    function showTab(index) {
        const tabs = document.querySelectorAll('.tab');
        const contents = document.querySelectorAll('.content');

        tabs.forEach((tab, i) => {
            tab.classList.toggle('active', i === index);
            contents[i].classList.toggle('active', i === index);
        });
    }
</script>

</body>
</html>

