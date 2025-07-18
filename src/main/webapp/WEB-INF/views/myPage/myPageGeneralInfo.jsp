<%-- Created by IntelliJ IDEA. User: user Date: 2025-07-03 Time: 오후 7:54 To
change this template use File | Settings | File Templates. --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
  <head>
    <title>MyPage : User Information - Phoenix Cinema</title>
  </head>
  <body>

    <div class="cay-myPage-content">
      <div class="cay-myPage-wrap">
        <div>Your Account Information</div>
        <form action="/mypage/general-info/update" method="post">
          <div>
            <h1>Your user ID</h1>
            <input type="text" name="u_id" readonly value="${user.u_id}" />
          </div>
          <div>
            <h1>Your user Password</h1>
            <input
              type="text"
              name="u_pw"
              readonly
              value="${sessionScope.user.u_pw}"
            />
          </div>
          <div>
            <h1>Your Name</h1>
            <input
              type="text"
              readonly
              name="u_name"
              value="${sessionScope.user.u_name}"
            />
          </div>
          <div>
            <h1>Your Birth Date</h1>
            <input
              type="text"
              readonly
              name="u_birth"
              value="<fmt:formatDate value='${sessionScope.user.u_birth}' pattern='yyyy-MM-dd'/>"
            />
          </div>
          <div>
            <h1>Your Address</h1>
            <input
              type="text"
              readonly
              name="u_address"
              value="${sessionScope.user.u_address}"
            />
          </div>
          <div>
            <button class="cay-update-btn">Update Account Information</button>
          </div>
        </form>
        <form action="/mypage/deleteAccount">
          <input type="hidden" name="u_id" value="${sessionScope.user.u_id}" />
          <button class="cay-delete-btn">Delete account</button>
        </form>
      </div>
    </div>

  </body>
</html>
