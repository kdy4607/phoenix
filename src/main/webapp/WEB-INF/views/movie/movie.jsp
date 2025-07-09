<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Movie List</title>
    <style>
        /* 간단한 스타일 */
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
        .tag-genre {
            background-color: #f99;
        }

        .tag-studio {
            background-color: #9cf;
        }

        .tag-country {
            background-color: #9f9;
        }

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

        .tag-group.genre .tag {
            background-color: #f88;
        }

        .tag-group.studio .tag {
            background-color: #9cf;
        }

        .tag-group.country .tag {
            background-color: #8f8;
        }
    </style>
</head>
<body>
<h1>🎬 Movie List</h1>

<form onsubmit="searchMovies(); return false;">
    <input type="text" id="keyword" name="keyword" placeholder="Movie Name"/>
    <button type="submit">검색</button>
</form>

<!-- Genre -->
<div class="tag-group genre">
    <c:forEach var="tag" items="${tagList}">
        <c:if test="${tag.t_type eq 'Genre'}">
            <span class="tag" data-name="${tag.t_name}" onclick="toggleTag(this)">${tag.t_name}</span>
        </c:if>
    </c:forEach>
</div>

<!-- Studio -->
<div class="tag-group studio">
    <c:forEach var="tag" items="${tagList}">
        <c:if test="${tag.t_type eq 'Studio'}">
            <span class="tag" data-name="${tag.t_name}" onclick="toggleTag(this)">${tag.t_name}</span>
        </c:if>
    </c:forEach>
</div>

<!-- Country -->
<div class="tag-group country">
    <c:forEach var="tag" items="${tagList}">
        <c:if test="${tag.t_type eq 'Country'}">
            <span class="tag" data-name="${tag.t_name}" onclick="toggleTag(this)">${tag.t_name}</span>
        </c:if>
    </c:forEach>
</div>


<hr/>

<div id="movie-container">
    <jsp:include page="movie-fragment.jsp"/>
</div>

</body>
<script>
    const selectedTags = new Set();



    function toggleTag(el) {
        const tag = el.dataset.name;

        if (el.classList.contains("selected")) {
            el.classList.remove("selected");
            selectedTags.delete(tag);
        } else {
            el.classList.add("selected");
            selectedTags.add(tag);
        }

        // AJAX 요청
        fetch("/movies/filter", {
            method: "POST",
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify([...selectedTags])  // 배열로 변환
        })
            .then(res => res.text()) // JSP fragment는 HTML로 받음
            .then(html => {
                document.getElementById("movie-container").innerHTML = html;
            })
            .catch(err => console.error("필터링 실패:", err));
    }
</script>
</html>
