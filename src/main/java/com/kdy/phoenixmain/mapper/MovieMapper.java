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

    // 단일 영화 조회
    @Select("select * from movies where MOVIE_ID=#{MOVIE_ID}")
    public MovieVO selectOneMovie(@Param("MOVIE_ID") int MOVIE_ID);

    // 영화 삭제


    // 영화 수정


    // 영화 등록



    @Select("""
            SELECT
                m.m_no,
                m.m_title,
                m.m_description,
                m.m_poster,
                t.t_no,
                t.t_name,
                t.t_type
            FROM movie_test m
            LEFT JOIN movie_tag_test mt ON m.m_no = mt.movie_no
            LEFT JOIN tag_test t ON mt.tag_no = t.t_no
            ORDER BY m.m_no
            """)
    @Results(id = "movieWithTags", value = {
            @Result(column = "m_no", property = "m_no", id = true),
            @Result(column = "m_title", property = "m_title"),
            @Result(column = "m_description", property = "m_description"),
            @Result(column = "m_poster", property = "m_poster"),
            @Result(property = "m_tagList", column = "m_no",
                    many = @Many(select = "getTagsByMovieNo"))
    })
    List<MovieVO> selectMovieWithTags();


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
    List<MovieVO> selectMoviesByTagIds(@Param("tags") List<Integer> tags, @Param("tagCount") int tagCount);

    // 상세페이지  영화 태그에서 하나만 겹쳐도 갖고오게 하는거
    @SelectProvider(type = MovieSqlBuilder.class, method = "buildQueryByAnyTag")
    List<MovieVO> selectMoviesByAnyTag(@Param("tags") List<Integer> tags, @Param("excludeId") int excludeId);
}

