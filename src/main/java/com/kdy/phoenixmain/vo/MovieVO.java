package com.kdy.phoenixmain.vo;


import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MovieVO {
    private int movie_id;
    private String title;
    private String genre;
    private String rating;
    private int running_time;
    private String poster_url;
}
