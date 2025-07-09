<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
    <title>시간/극장 선택</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="/resources/css/stepbar.css">
</head>
<body>

<div class="container">
    <h1>시간/극장 선택</h1>

    <jsp:include page="/WEB-INF/views/stepbar.jsp">
        <jsp:param name="currentStep" value="${reservation.currentStep}"/>
    </jsp:include>

    <c:if test="${not empty errorMessage}">
        <p style="color: red;">${errorMessage}</p>
    </c:if>

    <form action="/step4" method="post" id="reservationForm">
        <label for="room_id">영화관 선택:</label>
        <select id="room_id" name="room_id" required>
            <option value="">-- 선택하세요 --</option>
            <c:forEach var="room" items="${rooms}">
                <option value="${room.room_id}">${room.room_name}</option>
            </c:forEach>
        </select>

        <div id="runtimeSection">
            <p>상영 시간을 선택하려면 영화관을 먼저 선택하세요.</p>
        </div>

        <input type="hidden" name="reservationDate" value="${reservation.reservationDate}"/>
        <input type="hidden" name="movie_id" value="${reservation.movie_id}"/>

        <button type="submit" id="nextButton" disabled>다음</button>
    </form>
</div>
<script>
    $(document).ready(function () {
        // Function to enable/disable the next button based on radio button selection
        function toggleNextButton() {
            if ($('input[name="schedule_id"]:checked').length > 0) {
                $('#nextButton').prop('disabled', false);
            } else {
                $('#nextButton').prop('disabled', true);
            }
        }

        // Initial check on page load (in case user goes back and reloads)
        toggleNextButton();

        $('#room_id').change(function () {
            const roomId = $(this).val();
            const date = "${reservation.reservationDate}"; // reservationDate is already in the reservation object
            if (roomId) {
                // Change to $.get for the runtime data
                $.get("/step3/runtime", { room_id: roomId, reservationDate: date }, function (data) {
                    $('#runtimeSection').html(data);
                    // Attach change listener to the newly loaded radio buttons
                    $('#runtimeSection').on('change', 'input[name="schedule_id"]', toggleNextButton);
                    toggleNextButton(); // Re-check button state after new runtimes are loaded
                }).fail(function() {
                    $('#runtimeSection').html("<p>상영 시간 정보를 불러오는 데 실패했습니다.</p>");
                    toggleNextButton();
                });
            } else {
                $('#runtimeSection').html("<p>상영 시간을 선택하려면 영화관을 먼저 선택하세요.</p>");
                toggleNextButton();
            }
        });

        // Listen for changes on the radio buttons within the runtimeSection
        // This is important because the radio buttons are loaded dynamically
        $('#runtimeSection').on('change', 'input[name="schedule_id"]', toggleNextButton);
    });
</script>

</body>
</html>