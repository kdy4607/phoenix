<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:forEach var="movie" items="${movies}">
    <div class="movie-card">
        <img src="${movie.m_poster}" alt="포스터"/>
        <div>
            <h2>${movie.m_title}</h2>
            <p>${movie.m_description}</p>
            <div>
                    <c:forEach var="tag" items="${movie.m_tagList}">
                    <span class="tag
                        <c:choose>
                            <c:when test="${tag.t_type eq 'Genre'}">tag-genre</c:when>
                            <c:when test="${tag.t_type eq 'Studio'}">tag-studio</c:when>
                            <c:when test="${tag.t_type eq 'Country'}">tag-country</c:when>
                        </c:choose>
                    ">${tag.t_name}</span>
                </c:forEach>
            </div>
        </div>
    </div>
</c:forEach>
