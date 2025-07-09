package com.kdy.phoenixmain.VO;

import lombok.Data;

@Data
public class MoviesVO {
    private int movie_id;
    private String title;
    private String genre;
    private String rating;
    private int running_time;
    private String poster_url;

}