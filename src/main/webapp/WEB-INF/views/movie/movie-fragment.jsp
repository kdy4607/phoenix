<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:forEach var="movie" items="${movies}">
    <div class="movie-card">
        <div> <img src="${movie.poster_url}" alt="포스터"/>
            <div>${movie.user_critic}</div>
        <div class="movie-rating">${movie.rating}</div>
        </div>
        <div>
            <h2>${movie.title}</h2>
            <p>${movie.description}</p>
            <div>
                <c:forEach var="tag" items="${movie.m_tagList}">
                    <c:choose>
                        <c:when test="${tag.tag_type eq 'Genre'}">
                            <span class="tag tag-genre">${tag.tag_name}</span>
                        </c:when>
                        <c:when test="${tag.tag_type eq 'Studio'}">
                            <span class="tag tag-studio">${tag.tag_name}</span>
                        </c:when>
                        <c:when test="${tag.tag_type eq 'Country'}">
                            <span class="tag tag-country">${tag.tag_name}</span>
                        </c:when>
                        <c:when test="${tag.tag_type eq 'Mood'}">
                            <span class="tag tag-mood">${tag.tag_name}</span>
                        </c:when>
                        <c:otherwise>
                            <span class="tag">${tag.tag_name}</span>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </div>
        </div>
        <div>
            <div>movie_id: ${movie.movie_id}</div>
        <button onclick="location.href='oneMovieDetail?movie_id=${movie.movie_id}'">상세페이지</button>
        </div>
    </div>
</c:forEach>
