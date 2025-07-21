<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2025-07-03
  Time: 오후 7:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>MyPage : My Event - Phoenix Cinema</title>
</head>
<body>

<div class="cay-myPage-content">
    <div class="cay-myPage-wrap">
        <div> My Event</div>
        <div class="cay-myPage-tabs">
            <input type="radio" id="ongoing" name="radio" checked/>
            <input type="radio" id="upcoming" name="radio">
            <input type="radio" id="done" name="radio"/>
            <label class="tab_items" for="ongoing">
                <div>Ongoing</div>
            </label>
            <label class="tab_items" for="upcoming">
                <div>Upcoming</div>
            </label>
            <label class="tab_items" for="done">
                <div>Done</div>
            </label>
            <div class="cay-myPage-tabs-content" id="ongoing_content">
                <div class="cay-myPage-order">
                    <h1>Ongoing Event</h1>
                    <div>
                        <div>
                            <div>
                                <c:if test="${empty event}">
                                    <span> Your recent event reservation details do not exist.  </span>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="cay-myPage-tabs-content" id="upcoming_content">
                <div class="cay-myPage-order">
                    <h1>Upcoming Event</h1>
                    <div>
                        <div>
                            <div>
                                <c:if test="${empty reservations}">
                                    <span> Your recent event reservation details do not exist.  </span>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="cay-myPage-tabs-content" id="done_content">
                <div class="cay-myPage-order">
                    <h1>Done Event</h1>
                    <div>
                        <div>
                            <div>
                                <c:if test="${empty reservations}">
                                    <span> Your past event reservation details do not exist.  </span>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>
