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
    <title>Title</title>
</head>
<body>

<div class="cay-myPage-content">
    <div class="cay-myPage-wrap">
        <div> My Coupon </div>

        <h1 style="text-align: center"> 쿠폰 </h1>

${userBirth}

        ${userBirth.isEqual(today) ? "쿠폰 지급" : "없음"}

        ${userBirth.isBefore(today) ? "쿠폰 지급" : "없음"}

        ${userBirth.isAfter(today) ? "쿠폰 지급" : "없음"}

        Date of issuance
        <table class="cay-myPage-reward-table">
            <tr>
                <td>Birthday Cinema Ticket</td>
                <td> 12,000 ₩</td>
                <td>  <fmt:formatDate value="${user.u_birth}" pattern="yyyy-MM-dd"/> </td>
            </tr>
            <tr>
                <td>Welcome Cinema Ticket</td>
                <td> 12,000 ₩</td>
                <td> Date of subscription </td>
            </tr>
        </table>

    </div>
</div>

</body>
</html>
