package com.kdy.phoenixmain.vo;

import lombok.Data;

import java.util.List; // List import 추가

@Data
public class StepBarVO {
    private int currentStep;
    // Step 1: 영화 선택
    private Integer movieId;
    private String movieTitle;

    // Step 2: 날짜 선택
    private String reservationDate; // YYYY-MM-DD 형식

    // Step 3: 시간/상영관 선택
    private Integer scheduleId; // 스케줄 ID
    private String startTime;   // 상영 시작 시간 (예: "14:30")
    private String theaterName; // 상영관 이름 (예: "1관")

    // Step 4: 좌석 선택
    private List<Integer> selectedSeatIds;    // 선택된 좌석 ID 목록 (DB PK)
    private List<String> selectedSeatNumbers; // 선택된 좌석 번호 목록 (예: "A1", "A2") - 화면 표시용

    // Step 5: 결제
    private double totalAmount; // 총 결제 금액

    // 추가: 예약 ID (insert 시 자동 생성될 경우)
    private Integer reservationId;
}