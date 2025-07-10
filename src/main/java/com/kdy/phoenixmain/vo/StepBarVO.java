package com.kdy.phoenixmain.vo;

import lombok.Data;

import java.util.Date;
import java.util.List; // List import 추가

@Data
public class StepBarVO {
    private int currentStep;
    // Step 1: 영화 선택
    private Integer movie_id;
    private String title;

    // Step 2: 날짜 선택
    private String reservationDate; // YYYY-MM-DD 형식

    // Step 3: 시간/상영관 선택
    private Integer scheduleId; // 스케줄 ID
    private String start_time;   // 상영 시작 시간 (예: "14:30")
    private String theaterName; // 상영관 이름 (예: "1관")
    private int runtime_id;
    private int room_id;
    private Date run_date;
    private int price;
    private int available_seats;
    private String room_name;

    // Step 4: 좌석 선택
    private int seat_id;
    private String seat_row;
    private int seat_number;
    private String status;

    // Step 5: 결제
    private double totalAmount; // 총 결제 금액

    // 추가: 예약 ID (insert 시 자동 생성될 경우)
    private Integer reservationId;
}