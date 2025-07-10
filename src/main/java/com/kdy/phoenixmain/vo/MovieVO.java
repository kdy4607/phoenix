package com.kdy.phoenixmain.vo;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MovieVO {
    private int movie_id;             // 영화 고유 ID (PK)
    private String title;            // 영화 제목
    private String director;         // 감독
    private String actor;            // 주연 배우
    private String genre;            // 장르 (단일 문자열 컬럼)
    private String rating;           // 등급
    private double user_critic;      // 유저 평점
    private double pro_critic;       // 전문가 평점
    private String description;      // 줄거리 설명
    private int running_time;        // 상영 시간 (분 단위)
    private String poster_url;       // 포스터 이미지 URL

    // 연결된 태그 리스트 (다대다 관계)
    private List<TagVO> m_tagList;
}
