package com.kdy.phoenixmain.mapper;

import com.kdy.phoenixmain.vo.MovieVO;
import com.kdy.phoenixmain.vo.TagVO;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface MovieMapper {

    // 전체 영화 조회 (태그 리스트 포함)
    @Select("SELECT * FROM MOVIES")
    @Results({
            @Result(property = "movie_id", column = "MOVIE_ID"),
            @Result(property = "running_time", column = "RUNNING_TIME"),
            @Result(property = "m_tagList", column = "movie_id",
                    many = @Many(select = "getTagsByMovieId"))
    })
    List<MovieVO> selectAllMovie();

    // 단일 영화 조회 (태그 제외)
    @Select("SELECT * FROM MOVIES WHERE MOVIE_ID = #{movie_id}")
    MovieVO selectOneMovie(@Param("movie_id") int movie_id);

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
            @Result(property = "m_tagList", column = "movie_id",
                    many = @Many(select = "getTagsByMovieId"))
    })
    List<MovieVO> selectMoviesByTagIds(
            @Param("tagIds") List<Integer> tagIds,
            @Param("tagCount") int tagCount
    );

    // 제목으로 영화 검색
    @Select("SELECT * FROM MOVIES WHERE title LIKE '%' || #{title} || '%'")
    @Results({
            @Result(property = "m_tagList", column = "movie_id",
                    many = @Many(select = "getTagsByMovieId"))
    })
    List<MovieVO> findByTitle(@Param("title") String title);

    // 제목 + 태그로 영화 검색
    @SelectProvider(type = MovieSqlBuilder.class, method = "buildQueryByTagsAndTitle")
    @Results({
            @Result(property = "m_tagList", column = "movie_id",
                    many = @Many(select = "getTagsByMovieId"))
    })
    List<MovieVO> selectMoviesByTagsAndTitle(
            @Param("tagIds") List<Integer> tagIds,
            @Param("tagCount") int tagCount,
            @Param("title") String title
    );

    // 태그명으로 영화 검색(상세페이지에서 쓰는듯)
    @Select("""
        SELECT m.movie_id, m.title, m.poster_url
        FROM MOVIES m
        JOIN MOVIE_TAGS mt ON m.movie_id = mt.movie_id
        JOIN TAGS t ON mt.tag_id = t.tag_id
        WHERE t.tag_name = #{tagName}
    """)
    List<MovieVO> findMoviesByTagName(@Param("tagName") String tagName);
}
