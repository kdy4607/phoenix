<%-- /WEB-INF/views/stepbar.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Step Bar</title>
</head>
<body>
<div class="step-bar-container">
    <ul class="step-bar">
        <li class="step ${param.currentStep >= 1 ? 'active' : ''}">
            <div class="step-circle">1</div>
            <div class="step-text">영화 선택</div>
        </li>
        <li class="step ${param.currentStep >= 2 ? 'active' : ''}">
            <div class="step-circle">2</div>
            <div class="step-text">날짜 선택</div>
        </li>
        <li class="step ${param.currentStep >= 3 ? 'active' : ''}">
            <div class="step-circle">3</div>
            <div class="step-text">시간/극장 선택</div>
        </li>
        <li class="step ${param.currentStep >= 4 ? 'active' : ''}">
            <div class="step-circle">4</div>
            <div class="step-text">좌석 선택</div>
        </li>
        <li class="step ${param.currentStep >= 5 ? 'active' : ''}">
            <div class="step-circle">5</div>
            <div class="step-text">결제</div>
        </li>
    </ul>
</div>
</body>
</html>