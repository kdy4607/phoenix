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
    <div class="aaa">
        <div class="content active">
            <div class="related-movie-wrap">
                <c:forEach var="rel" items="${relatedMovies}" end="5">
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
</div>

<script>

    function showTab(index) {
        const tabs = document.querySelectorAll('.tab');
        const contents = document.querySelectorAll('.content');

        tabs.forEach((tab, i) => {
            tab.classList.toggle('active', i === index);
        });

        contents.forEach((content, i) => {
            content.classList.toggle('active', i === index);
            // 관련영화 탭(index === 0)일 때만 height 자동 조정
            if (i === index) {
                if (i === 0) {
                    content.style.height = 'auto';
                } else {
                    content.style.height = '280px';
                }
            } else {
                // 비활성화된 콘텐츠는 초기화 (안 보여도 height 남으면 깔끔하지 않음)
                content.style.height = '';
            }
        });
    }
</script>

</body>
</html>

