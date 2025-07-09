package com.kdy.phoenixmain.vo;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class RuntimeVO {
    private int runtime_id;
    private int movie_id;
    private int room_id;
    private Date run_date;
    private String start_time;
    private int price;
    private int available_seats;

    // 조인용 필드들 (뷰나 조인 쿼리 결과용)
    private String movie_title;
    private String movie_genre;
    private String movie_rating;
    private String poster_url;
    private String room_name;
    private int total_seats;
    private int running_time;
}
