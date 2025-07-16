<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2025-07-03
  Time: 오후 7:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
</head>
<body>

<div class="cay-myPage-content">
    <div class="cay-myPage-wrap">
        <div> My Point </div>

        <div>
            <div>Point History</div>
            <div>
                <table class="cay-myPage-reward-table">
                    <tr>
                        <td>Birthday Cinema Ticket</td>
                        <td> ${user.u_birth} </td>
                        <td> 12,000 ₩</td>
                    </tr>
                    <tr>
                        <td>Welcome Cinema Ticket</td>
                        <td> 12,000 ₩</td>
                    </tr>
                </table>
            </div>
        </div>

        </form>
    </div>
</div>

</body>
</html>
