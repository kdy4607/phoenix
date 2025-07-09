package com.kdy.phoenixmain.VO;
import lombok.Data;

@Data
public class SeatVO {
    private int seatId;
    private String seatNumber; // 예: "A1", "B5"
    private boolean available; // true면 선택 가능, false면 예약 불가능

}