<%--
  Created by IntelliJ IDEA.
  User: Doyeon
  Date: 2025-07-12
  Time: 오후 4:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8"/>
    <link rel="icon" href="https://static.toss.im/icons/png/4x/icon-toss-logo.png"/>
    <link rel="stylesheet" type="text/css" href="/resources/css/payment.css"/>
    <link rel="icon" href="/resources/images/logo.png" type="image/png">
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>토스페이먼츠 샘플 프로젝트</title>

</head>
<body>
<div id="info" class="box_section" style="width: 600px">
    <img width="100px" src="https://static.toss.im/lotties/error-spot-no-loop-space-apng.png"/>
    <h2>결제를 실패했어요</h2>

    <div class="p-grid typography--p" style="margin-top: 50px">
        <div class="p-grid-col text--left"><b>에러메시지</b></div>
        <div class="p-grid-col text--right" id="message"></div>
    </div>
    <div class="p-grid typography--p" style="margin-top: 10px">
        <div class="p-grid-col text--left"><b>에러코드</b></div>
        <div class="p-grid-col text--right" id="code"></div>
    </div>
    <div class="p-grid">
        <button class="button p-grid-col5"
                onclick="location.href='https://docs.tosspayments.com/guides/v2/payment-widget/integration';">연동 문서
        </button>
        <button class="button p-grid-col5" onclick="location.href='https://discord.gg/A4fRFXQhRu';"
                style="background-color: #e8f3ff; color: #1b64da">실시간 문의
        </button>
    </div>
</div>
<script>
    const urlParams = new URLSearchParams(window.location.search);

    const codeElement = document.getElementById("code");
    const messageElement = document.getElementById("message");

    codeElement.textContent = urlParams.get("code");
    messageElement.textContent = urlParams.get("message");
</script>

</body>
</html>
