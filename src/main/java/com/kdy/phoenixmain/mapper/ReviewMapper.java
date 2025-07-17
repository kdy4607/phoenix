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


    @Delete("""
        DELETE FROM reviews
        WHERE r_id = #{r_id} AND u_id = #{u_id}
    """)
    void deleteReview(@Param("r_id") int r_id, @Param("u_id") String u_id);
    }

