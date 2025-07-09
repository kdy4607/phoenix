package com.kdy.phoenixmain.vo;

import lombok.Data;

@Data
public class ScheduleVO {
    private int scheduleId;
    private int movieId;
    private String date;
    private String startTime;
    private String theaterName;
    private int availableSeats;

}