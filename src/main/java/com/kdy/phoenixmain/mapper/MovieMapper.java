package com.kdy.phoenixmain.mapper;

import com.kdy.phoenixmain.vo.MovieVO;
import com.kdy.phoenixmain.vo.TagVO;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface MovieMapper {

    // 전체 조회 + 태그 리스트 포함
    @Select("SELECT * FROM movie_test")
    @Results({
            @Result(property = "m_no", column = "m_no"),
            @Result(property = "m_title", column = "m_title"),
            @Result(property = "m_description", column = "m_description"),
            @Result(property = "m_poster", column = "m_poster"),
            @Result(property = "m_tagList", column = "m_no",
                    many = @Many(select = "getTagsByMovieNo"))
    })
    public List<MovieVO> selectAllMovie();

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
            LEFT JOIN tag_test t ON mt.tag_n o = t.t_no
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
        SELECT t.t_no, t.t_name, t.t_type
        FROM movie_tag_test mt
        JOIN tag_test t ON mt.tag_no = t.t_no
        WHERE mt.movie_no = #{m_no}
        """)
    List<TagVO> getTagsByMovieNo(int m_no);


    // 선택된 태그들이 모두 포함된 영화만 조회 (AND 조건)
    @SelectProvider(type = MovieSqlBuilder.class, method = "buildQueryByTags")
    @Results({
            @Result(property = "m_no", column = "m_no"),
            @Result(property = "m_title", column = "m_title"),
            @Result(property = "m_description", column = "m_description"),
            @Result(property = "m_poster", column = "m_poster"),
            @Result(property = "m_tagList", column = "m_no",
                    many = @Many(select = "getTagsByMovieNo"))
    })
    List<MovieVO> selectMoviesByTags(@Param("tags") List<String> tags, @Param("tagCount") int tagCount);

}
