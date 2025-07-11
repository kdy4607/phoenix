<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Movie List</title>
    <link rel="stylesheet" href="/resources/css/movie.css">
</head>
<body>
<h1>🎬 Movie List</h1>

<form id="searchForm" onsubmit="return handleSearch(event);">
    <input type="text" name="title" placeholder="Movie Name"/>
    <button type="submit">검색</button>
</form>

<!-- Genre -->
<div class="tag-group genre">
    <c:forEach var="tag" items="${tagList}">
        <c:if test="${tag.tag_type eq 'Genre'}">
            <span class="tag" data-id="${tag.tag_id}" onclick="toggleTag(this)">
                    ${tag.tag_name}
            </span>
        </c:if>
    </c:forEach>
</div>

<!-- Studio -->
<div class="tag-group studio">
    <c:forEach var="tag" items="${tagList}">
        <c:if test="${tag.tag_type eq 'Studio'}">
            <span class="tag" data-id="${tag.tag_id}" onclick="toggleTag(this)">
                    ${tag.tag_name}
            </span>
        </c:if>
    </c:forEach>
</div>

<!-- Country -->
<div class="tag-group country">
    <c:forEach var="tag" items="${tagList}">
        <c:if test="${tag.tag_type eq 'Country'}">
            <span class="tag" data-id="${tag.tag_id}" onclick="toggleTag(this)">
                    ${tag.tag_name}
            </span>
        </c:if>
    </c:forEach>
</div>

<!-- Mood -->
<div class="tag-group mood">
    <c:forEach var="tag" items="${tagList}">
        <c:if test="${tag.tag_type eq 'Mood'}">
            <span class="tag" data-id="${tag.tag_id}" onclick="toggleTag(this)">
                    ${tag.tag_name}
            </span>
        </c:if>
    </c:forEach>
</div>

<hr/>

<div id="movie-container" class="movie-container">
    <jsp:include page="movie-fragment.jsp"/>
</div>

<script>
    const selectedTags = new Set();

    function toggleTag(el) {
        const tagId = parseInt(el.dataset.id);
        el.classList.toggle("selected");
        selectedTags.has(tagId) ? selectedTags.delete(tagId) : selectedTags.add(tagId);
        submitFilter(); // 태그 변경 시 바로 전송
    }

    function handleSearch(event) {
        event.preventDefault(); // 기본 submit 막기
        submitFilter(); // fetch 호출
        return false;
    }

    function submitFilter() {
        const title = document.querySelector('input[name="title"]').value;

        fetch("/movies/filter", {
            method: "POST",
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({
                title: title,
                tagIds: [...selectedTags]
            })
        })
            .then(res => res.text())
            .then(html => {
                document.getElementById("movie-container").innerHTML = html;
            })
            .catch(err => console.error("필터링 실패:", err));
    }
</script>


</body>
</html>
