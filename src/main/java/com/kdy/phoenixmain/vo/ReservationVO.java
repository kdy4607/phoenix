package com.kdy.phoenixmain.vo;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReservationVO {
    private int reservation_id;
    private Long u_id;
    private int runtime_id;
    private int adult;
    private int youth;
    private int child;
    private int total_amount;
    private String reservation_status;
    private LocalDateTime reserved_at;

    // 조인용 필드들
    private String u_nickname;
    private String u_name;
    private String movie_title;
    private String room_name;
    private Date run_date;
    private String start_time;
    private String selected_seats;
}
