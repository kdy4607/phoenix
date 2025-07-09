<%-- /WEB-INF/views/step2_date_select.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>날짜 선택</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/sample.css">
    <style>
        .container {
            display: flex;
            flex-direction: column; /* 세로 정렬 */
            max-width: 900px;
            margin: 30px auto;
            gap: 30px;
        }

        .top-section {
            text-align: center;
        }

        .content-section {
            display: flex;
            gap: 40px;
        }

        .left-pane, .right-pane {
            flex: 1;
            border: 1px solid #ccc;
            border-radius: 10px;
            padding: 20px;
            background-color: #f9f9f9;
        }

        .left-pane img {
            width: 200px;
            height: 280px;
            object-fit: cover;
            border-radius: 8px;
            display: block;
            margin: 0 auto;
        }

        .left-pane h3 {
            margin-top: 15px;
            font-size: 24px;
            color: #333;
            text-align: center;
        }
    </style>
    <!-- flatpickr CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css">

    <!-- flatpickr JS -->
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
</head>
<body>
<div class="container">

    <!-- 상단 영역: 제목 + stepbar (세로 정렬) -->
    <div class="top-section">
        <h1>영화 예매</h1>
        <jsp:include page="/WEB-INF/views/stepbar.jsp">
            <jsp:param name="currentStep" value="${reservation.currentStep}"/>
        </jsp:include>
    </div>


    <div>
        <h2>2. 날짜 선택</h2>
        <form action="/step3" method="post">
            <input type="hidden" name="title" value="${movies.title}">
            <input type="hidden" name="movie_id" value="${movies}">

            <label for="reservationDate">날짜 선택</label>
            <input type="text" id="reservationDate" name="reservationDate" required>
            <div>
                <button type="submit">다음</button>

            </div>
        </form>
    </div>
</div>


<script>
    window.addEventListener('DOMContentLoaded', function () {
        flatpickr("#reservationDate", {
            dateFormat: "Y-m-d",
            defaultDate: new Date(), // 오늘 날짜 기본값
        });
    });
</script>
</body>
</html>