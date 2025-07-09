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
        // '다음' 버튼 활성화/비활성화 함수
        function toggleNextButton() {
            if ($('input[name="schedule_id"]:checked').length > 0) {
                $('#nextButton').prop('disabled', false); // 라디오 버튼이 선택되면 활성화
            } else {
                $('#nextButton').prop('disabled', true); // 선택되지 않으면 비활성화
            }
        }

        // 페이지 로드 시 초기 상태 확인
        toggleNextButton();

        $('#room_id').change(function () {
            const roomId = $(this).val();
            const date = "${reservation.reservationDate}"; // 예약 날짜는 reservation 객체에 이미 있음
            if (roomId) {
                // 상영 시간 데이터를 가져오기 위해 $.get 사용
                $.get("/step3/runtime", { room_id: roomId, reservationDate: date }, function (data) {
                    $('#runtimeSection').html(data);
                    // 동적으로 로드된 라디오 버튼에 change 리스너 연결
                    $('#runtimeSection').on('change', 'input[name="schedule_id"]', toggleNextButton);
                    toggleNextButton(); // 새로운 상영 시간 로드 후 버튼 상태 재확인
                }).fail(function() {
                    $('#runtimeSection').html("<p>상영 시간 정보를 불러오는 데 실패했습니다.</p>");
                    toggleNextButton();
                });
            } else {
                $('#runtimeSection').html("<p>상영 시간을 선택하려면 영화관을 먼저 선택하세요.</p>");
                toggleNextButton();
            }
        });

        // runtimeSection 내의 schedule_id 라디오 버튼 변경 감지 (동적 로드된 요소에 대한 이벤트 위임)
        $('#runtimeSection').on('change', 'input[name="schedule_id"]', toggleNextButton);
    });
</script>

</body>
</html>