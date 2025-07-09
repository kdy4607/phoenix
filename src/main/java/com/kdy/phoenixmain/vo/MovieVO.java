package com.kdy.phoenixmain.vo;


import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MovieVO {
    private int movie_id;
    private String title;
    private String genre;
    private String rating;
    private String description;
    private int running_time;
    private String poster_url;
    private List<TagVO> m_tagList;
}
