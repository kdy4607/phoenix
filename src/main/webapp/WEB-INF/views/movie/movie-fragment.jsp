<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>


<c:forEach var="movie" items="${movies}">

    <div class="movie-card movie-card-wrapper">
        <div class="poster-rating-wrapper" onclick="location.href='oneMovieDetail?movie_id=${movie.movie_id}'">
            <img src="${movie.poster_url}" alt="포스터"/>
            <div class="movie-ranking">${movie.ranking}</div>
            <div class="movie-rating">${movie.rating}</div>
        </div>
        <div class="movie-text-wrapper">
            <div class="movie-title">${movie.title}</div>

            <span class="value movie-stars">
                <c:forEach begin="1" end="${movie.user_critic}">⭐</c:forEach>
            </span>
            <div class="movie-release-date">
                <fmt:formatDate value="${movie.release_date}" pattern="yyyy.MM.dd" />
            </div>
<%--            <div class="movie-description">${movie.description}</div>--%>
            <div class="tag-list-wrapper">
                <c:forEach var="tag" items="${movie.m_tagList}">
                    <c:choose>
                        <c:when test="${tag.tag_type eq 'Genre'}">
                            <span class="tag tag-genre tag-item">${tag.tag_name}</span>
                        </c:when>
                        <c:when test="${tag.tag_type eq 'Studio'}">
                            <span class="tag tag-studio tag-item">${tag.tag_name}</span>
                        </c:when>
                        <c:when test="${tag.tag_type eq 'Country'}">
                            <span class="tag tag-country tag-item">${tag.tag_name}</span>
                        </c:when>
                        <c:when test="${tag.tag_type eq 'Mood'}">
                            <span class="tag tag-mood tag-item">${tag.tag_name}</span>
                        </c:when>
                        <c:otherwise>
                            <span class="tag tag-item">${tag.tag_name}</span>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </div>
        </div>
        <div class="movie-director">${movie.director}</div>
        <c:if test="${status eq 'showing'}">
            <button class="btn-book-tickets" onclick="location.href='schedule?movie_id=${movie.movie_id}'">
                Book Tickets
            </button>
        </c:if>
    </div>
</c:forEach>

