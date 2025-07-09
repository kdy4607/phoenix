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
    <div class="tab" onclick="showTab(0)">관객평</div>
    <div class="tab" onclick="showTab(1)">스토리</div>
    <div class="tab" onclick="showTab(2)">동일장르 영화</div>
</div>
<div class="tap-inBox">
    <!-- 탭 내용 영역 -->
    <div class="content active"></div>
    <div class="content">줄거리:${movieDetail2.description}</div>
    <div class="content">탭 3의 내용입니다</div>
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

