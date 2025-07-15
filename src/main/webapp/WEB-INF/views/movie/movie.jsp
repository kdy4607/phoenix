<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <title>Movie List</title>
    <link rel="stylesheet" href="/resources/css/movie.css" />
    <script src="/resources/js/movie.js"></script>
  </head>
  <body>
    <jsp:include page="/WEB-INF/views/header.jsp" />
    <div class="container">
      <h1 onclick="location.href='/movie-all?status=showing'" style="cursor: pointer;">🎬 Movie List</h1>

      <%--         상영중 전체 미개봉--%>
      <div class="movie-tab">
        <a href="/movie-all?status=all" class="${status == 'all' ? 'active' : ''}">All Movies</a>
        <a href="/movie-all?status=showing" class="${status == 'showing' ? 'active' : ''}">Showing Movies</a>
        <a href="/movie-all?status=upcoming" class="${status == 'upcoming' ? 'active' : ''}">Upcoming Movies</a>
      </div>




      <!-- 🔍 검색 폼 -->
      <form
        id="searchForm"
        class="search-form"
        onsubmit="return handleSearch(event);"
      >
        <input type="hidden" name="status" value="${status}">
        <button type="button" class="toggle-button" onclick="toggleTags()">
          Tag Filter
        </button>
        <input
          type="text"
          name="title"
          placeholder="Movie Title"
          class="search-input"
        />
        <button type="submit" class="search-button">Search</button>
      </form>

      <div class="tag-container">
        <!-- 🎭 태그 그룹 - 장르 -->
        <div class="tag-group genre tag-group-genre">
          <div class="tag-group-name">Genre</div>
          <div class="tags-group">
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
        </div>

        <!-- 🎥 태그 그룹 - 제작사 -->
        <div class="tag-group studio tag-group-studio">
          <div class="tag-group-name">Studio</div>
          <div class="tags-group">
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
        </div>

        <!-- 🌍 태그 그룹 - 국가 -->
        <div class="tag-group country tag-group-country">
          <div class="tag-group-name">Country</div>
          <div class="tags-group">
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
        </div>
        <!-- 😎 태그 그룹 - 분위기 -->
        <div class="tag-group mood tag-group-mood">
          <div class="tag-group-name">Mood</div>
          <div class="tags-group">
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
      </div>


      <!-- 🎞️ 영화 목록 컨테이너 -->
      <div id="movie-container" class="movie-container movie-list-section">
        <jsp:include page="movie-fragment.jsp" />
      </div>
    </div>

  </body>
</html>
