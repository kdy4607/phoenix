<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Movie List</title>
    <style>
        .tag {
            display: inline-block;
            padding: 5px 10px;
            border-radius: 5px;
            margin: 3px;
        }

        .tag.selected {
            border: 2px solid #000;
            font-weight: bold;
        }

        .tag-genre { background-color: #f99; }
        .tag-studio { background-color: #9cf; }
        .tag-country { background-color: #9f9; }
        .tag-mood { background-color: #ff88be; }

        .movie-card {
            border: 1px solid #ccc;
            margin: 10px;
            padding: 10px;
            border-radius: 8px;
            display: flex;
        }

        .movie-card img {
            width: 100px;
            height: 150px;
            margin-right: 10px;
        }

        .tag-group.genre .tag { background-color: #f88; }
        .tag-group.studio .tag { background-color: #9cf; }
        .tag-group.country .tag { background-color: #8f8; }
        .tag-group.mood .tag { background-color: #ff88be; }
    </style>
</head>
<body>
<h1>🎬 Movie List</h1>

<form action="/movie-keyword">
    <input type="text" name="keyword" placeholder="Movie Name"/>
    <button>검색</button>
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

<div id="movie-container">
    <jsp:include page="movie-fragment.jsp"/>
</div>

<script>
    const selectedTags = new Set();

    function toggleTag(el) {
        const tagId = parseInt(el.dataset.id);

        if (el.classList.contains("selected")) {
            el.classList.remove("selected");
            selectedTags.delete(tagId);
        } else {
            el.classList.add("selected");
            selectedTags.add(tagId);
        }

        fetch("/movies/filter", {
            method: "POST",
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify([...selectedTags])
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
