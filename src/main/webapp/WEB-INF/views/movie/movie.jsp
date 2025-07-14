<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <title>Movie List</title>
    <link rel="stylesheet" href="/resources/css/movie.css" />
  </head>
  <body>
    <jsp:include page="/WEB-INF/views/header.jsp" />
    <div class="container">
      <h1>🎬 Movie List</h1>

      <!-- 🔍 검색 폼 -->
      <form
        id="searchForm"
        class="search-form"
        onsubmit="return handleSearch(event);"
      >
        <button type="button" class="toggle-button" onclick="toggleTags()">
          Tag Filter
        </button>
        <input
          type="text"
          name="title"
          placeholder="Movie Name"
          class="search-input"
        />
        <button type="submit" class="search-button">검색</button>
      </form>

      <div class="tag-container">
        <!-- 🎭 태그 그룹 - 장르 -->
        <div class="tag-group genre tag-group-genre">
          <c:forEach var="tag" items="${tagList}">
            <c:if test="${tag.tag_type eq 'Genre'}">
              <span
                class="tag"
                data-id="${tag.tag_id}"
                onclick="toggleTag(this)"
              >
                ${tag.tag_name}
              </span>
            </c:if>
          </c:forEach>
        </div>

        <!-- 🎥 태그 그룹 - 제작사 -->
        <div class="tag-group studio tag-group-studio">
          <c:forEach var="tag" items="${tagList}">
            <c:if test="${tag.tag_type eq 'Studio'}">
              <span
                class="tag"
                data-id="${tag.tag_id}"
                onclick="toggleTag(this)"
              >
                ${tag.tag_name}
              </span>
            </c:if>
          </c:forEach>
        </div>

        <!-- 🌍 태그 그룹 - 국가 -->
        <div class="tag-group country tag-group-country">
          <c:forEach var="tag" items="${tagList}">
            <c:if test="${tag.tag_type eq 'Country'}">
              <span
                class="tag"
                data-id="${tag.tag_id}"
                onclick="toggleTag(this)"
              >
                ${tag.tag_name}
              </span>
            </c:if>
          </c:forEach>
        </div>

        <!-- 😎 태그 그룹 - 분위기 -->
        <div class="tag-group mood tag-group-mood">
          <c:forEach var="tag" items="${tagList}">
            <c:if test="${tag.tag_type eq 'Mood'}">
              <span
                class="tag"
                data-id="${tag.tag_id}"
                onclick="toggleTag(this)"
              >
                ${tag.tag_name}
              </span>
            </c:if>
          </c:forEach>
        </div>
      </div>

      <!-- 🎞️ 영화 목록 컨테이너 -->
      <div id="movie-container" class="movie-container movie-list-section">
        <jsp:include page="movie-fragment.jsp" />
      </div>
    </div>
    <script>
      const selectedTags = new Set();

      function toggleTag(el) {
        const tagId = parseInt(el.dataset.id);
        el.classList.toggle("selected");
        selectedTags.has(tagId)
          ? selectedTags.delete(tagId)
          : selectedTags.add(tagId);
        submitFilter();
      }

      function handleSearch(event) {
        event.preventDefault();
        submitFilter();
        return false;
      }

      function submitFilter() {
        const title = document.querySelector('input[name="title"]').value;

        fetch("/movies/filter", {
          method: "POST",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({
            title: title,
            tagIds: [...selectedTags],
          }),
        })
          .then((res) => res.text())
          .then((html) => {
            document.getElementById("movie-container").innerHTML = html;
          })
          .catch((err) => console.error("필터링 실패:", err));
      }

      // 태그 접기펴기
      function toggleTags() {
        const container = document.querySelector(".tag-container");
        container.classList.toggle("collapsed");
      }

      // 기존 코드 그대로 유지…
    </script>
  </body>
</html>
