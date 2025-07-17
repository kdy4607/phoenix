
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>Title</title>
</head>
<body>
<c:forEach var="rel" items="${bookmarks}" varStatus="loop">
    ${rel.title}
    <c:if test="${loop.index < 5}">
        <!-- 동일장르 -->
        <div class="related-movie">
            <img src="${rel.poster_url}" alt="${rel.title}" style="width:150px">
            <div>${rel.title}</div>
        </div>
    </c:if>
</c:forEach>
${bookmarks}

</body>

</html>
