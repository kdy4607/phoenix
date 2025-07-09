<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>메인 페이지</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            background-color: #f4f4f4;
            color: #333;
        }
        .main-container {
            text-align: center;
            padding: 40px;
            background-color: #ffffff;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }
        h1 {
            color: #0056b3;
            margin-bottom: 30px;
        }
        .start-button {
            display: inline-block;
            padding: 15px 30px;
            font-size: 1.2em;
            color: #ffffff;
            background-color: #007bff;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            transition: background-color 0.3s ease;
        }
        .start-button:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<div class="main-container">
    <h1>영화 예매 시스템</h1>
    <p>환영합니다! 영화 예매를 시작하려면 아래 버튼을 클릭해주세요.</p>
    <a href="/step1" class="start-button">예매 시작하기</a>
</div>
</body>
</html>