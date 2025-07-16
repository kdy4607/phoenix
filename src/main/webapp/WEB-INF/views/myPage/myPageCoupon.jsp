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

        ${userBirthMonthDay.isEqual(todayMonthDay) ? "쿠폰 지급" : "없음"}

        ${userBirthMonthDay.isBefore(todayMonthDay) ? "쿠폰 지급" : "없음"}

        ${userBirthMonthDay.isAfter(todayMonthDay) ? "쿠폰 지급" : "없음"}

        <table class="cay-myPage-ticket-table">
            <th> Ticket</th>
            <th> Price</th>
            <th> Date of issuance</th>
            <tr>
                <td>Birthday Cinema Ticket</td>
                <td> 12,000 ₩</td>
                <td>  ${userBirth} </td>
            </tr>
            <tr>
                <td>Welcome Cinema Ticket</td>
                <td> 12,000 ₩</td>
                <td> Date of subscription </td>
            </tr>
        </table>
        <div> </div>

        <table class="cay-myPage-coupon-table">
            <th> Coupon </th>
            <th> Benefit </th>
            <th> Date of issuance </th>
            <tr>
                <td>Birthday Cinema Ticket</td>
                <td> 12,000 ₩</td>
                <td>  ${userBirth} </td>
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
