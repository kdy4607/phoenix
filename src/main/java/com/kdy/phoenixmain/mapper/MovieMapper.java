package com.kdy.phoenixmain.mapper;

import com.kdy.phoenixmain.vo.MovieVO;
import com.kdy.phoenixmain.vo.TagVO;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface MovieMapper {

    // 전체 영화 조회 + 태그 리스트 포함
    @Select("SELECT * FROM MOVIES")
    @Results({
            @Result(property = "movie_id", column = "movie_id"),
            @Result(property = "title", column = "title"),
            @Result(property = "director", column = "director"),
            @Result(property = "actor", column = "actor"),
            @Result(property = "genre", column = "genre"),
            @Result(property = "rating", column = "rating"),
            @Result(property = "user_critic", column = "user_critic"),
            @Result(property = "pro_critic", column = "pro_critic"),
            @Result(property = "description", column = "description"),
            @Result(property = "running_time", column = "running_time"),
            @Result(property = "poster_url", column = "poster_url"),
            @Result(property = "m_tagList", column = "movie_id",
                    many = @Many(select = "getTagsByMovieId"))
    })
    List<MovieVO> selectAllMovie();

    // 단일 영화 조회 (태그 제외)
    @Select("SELECT * FROM MOVIES WHERE movie_id = #{MOVIE_ID}")
    MovieVO selectOneMovie(@Param("MOVIE_ID") int MOVIE_ID);

    // 특정 영화의 태그 목록 조회
    @Select("""
        SELECT t.tag_id, t.tag_name, t.tag_type
        FROM MOVIE_TAGS mt
        JOIN TAGS t ON mt.tag_id = t.tag_id
        WHERE mt.movie_id = #{movie_id}
    """)
    List<TagVO> getTagsByMovieId(int movie_id);

    // 선택한 태그 ID들을 모두 포함한 영화 조회 (AND 조건)
    @SelectProvider(type = MovieSqlBuilder.class, method = "buildQueryByTagIds")
    @Results({
            @Result(property = "movie_id", column = "movie_id"),
            @Result(property = "title", column = "title"),
            @Result(property = "director", column = "director"),
            @Result(property = "actor", column = "actor"),
            @Result(property = "genre", column = "genre"),
            @Result(property = "rating", column = "rating"),
            @Result(property = "user_critic", column = "user_critic"),
            @Result(property = "pro_critic", column = "pro_critic"),
            @Result(property = "description", column = "description"),
            @Result(property = "running_time", column = "running_time"),
            @Result(property = "poster_url", column = "poster_url"),
            @Result(property = "m_tagList", column = "movie_id",
                    many = @Many(select = "getTagsByMovieId"))
    })
    List<MovieVO> selectMoviesByTagIds(
            @Param("tagIds") List<Integer> tagIds,
            @Param("tagCount") int tagCount
    );
}
