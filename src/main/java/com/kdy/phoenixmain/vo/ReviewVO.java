package com.kdy.phoenixmain.vo;

import lombok.Data;

import java.util.Date;
import java.util.List;

@Data
public class ReviewVO {
        private int r_id;
        private int movie_id;
        private String u_id;
        private int r_rating;
        private String r_text;
        private Date r_date;

        private MovieVO movie;
}
