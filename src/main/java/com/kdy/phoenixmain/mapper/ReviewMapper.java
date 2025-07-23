package com.kdy.phoenixmain.mapper;

import com.kdy.phoenixmain.vo.ReviewVO;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
    public interface ReviewMapper {
    @Insert("""
        INSERT INTO reviews (movie_id, u_id, r_rating, r_text, r_date)
        VALUES (#{movie_id}, #{u_id}, #{r_rating}, #{r_text}, SYSDATE)
    """)
    void insertReview(ReviewVO review);

    @Select("""
        SELECT * FROM reviews
        WHERE movie_id = #{movie_id}
        ORDER BY r_date DESC
    """)
    List<ReviewVO> getReviewsByMovieId(int movie_id);

    @Results(id = "reviewWithMovieInfoMap", value = {
            // ReviewVO의 기본 필드 매핑
            @Result(property = "r_id", column = "R_ID", id = true),
            @Result(property = "movie_id", column = "MOVIE_ID"), // reviews 테이블의 movie_id
            @Result(property = "u_id", column = "U_ID"),
            @Result(property = "r_rating", column = "R_RATING"),
            @Result(property = "r_text", column = "R_TEXT"),
            @Result(property = "r_date", column = "R_DATE"),

            // MovieVO 객체 ('movie' 필드) 매핑
            // ReviewVO 내의 movie 필드는 MovieVO 타입이므로,
            // 각 MovieVO 필드에 직접 매핑될 SQL 컬럼과 그 컬럼에서 가져온 값을 연결합니다.
            // 이때, 컬럼 이름은 SQL 쿼리에서 지정한 별칭을 사용합니다.
            // 예를 들어, SQL에서 'MOVIE_TITLE'로 가져온 값을 ReviewVO의 'movie.title'에 매핑합니다.
            @Result(property = "movie.movie_id", column = "MOVIE_ID_ALIAS"), // MovieVO의 movie_id
            @Result(property = "movie.title", column = "MOVIE_TITLE_ALIAS"), // MovieVO의 title
            @Result(property = "movie.poster_url", column = "MOVIE_POSTER_URL_ALIAS") // MovieVO의 poster_url
            // MovieVO의 다른 필드들도 필요하다면 같은 방식으로 추가합니다.
            // 예: @Result(property = "movie.director", column = "MOVIE_DIRECTOR_ALIAS")
    })
    @Select("""
        SELECT
            r.R_ID, r.MOVIE_ID, r.U_ID, r.R_RATING, r.R_TEXT, r.R_DATE, -- ReviewVO 필드
            m.MOVIE_ID AS MOVIE_ID_ALIAS,             -- MovieVO의 movie_id 필드를 위한 별칭
            m.TITLE AS MOVIE_TITLE_ALIAS,             -- MovieVO의 title 필드를 위한 별칭
            m.POSTER_URL AS MOVIE_POSTER_URL_ALIAS    -- MovieVO의 poster_url 필드를 위한 별칭
        FROM reviews r
        INNER JOIN movies m ON r.MOVIE_ID = m.MOVIE_ID
        WHERE r.u_id = #{u_id}
    """)
    List<ReviewVO> getReviewsByUserId(String u_id);


    @Delete("""
        DELETE FROM reviews
        WHERE r_id = #{r_id} AND u_id = #{u_id}
    """)
    void deleteReview(@Param("r_id") int r_id, @Param("u_id") String u_id);
    }

