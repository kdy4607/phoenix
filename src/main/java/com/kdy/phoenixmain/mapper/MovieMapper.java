package com.kdy.phoenixmain.mapper;

import com.kdy.phoenixmain.vo.MovieVO;
import com.kdy.phoenixmain.vo.TagVO;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface MovieMapper {

    @Results(id = "movieMap", value = {
            @Result(property = "movie_id", column = "MOVIE_ID"),
            @Result(property = "running_time", column = "RUNNING_TIME"),
            @Result(property = "user_critic", column = "USER_CRITIC"),
            @Result(property = "pro_critic", column = "PRO_CRITIC"),
            @Result(property = "m_tagList", column = "MOVIE_ID",
                    many = @Many(select = "getTagsByMovieId"))
    })

    @Select("SELECT * FROM MOVIES")
    List<MovieVO> selectAllMovie();

    @Select("SELECT * FROM MOVIES WHERE MOVIE_ID = #{movie_id}")
    MovieVO selectOneMovie(@Param("movie_id") int movie_id);

    @Select("""
        SELECT t.tag_id, t.tag_name, t.tag_type
        FROM MOVIE_TAGS mt
        JOIN TAGS t ON mt.tag_id = t.tag_id
        WHERE mt.movie_id = #{movie_id}
    """)
    List<TagVO> getTagsByMovieId(int movie_id);

    @SelectProvider(type = MovieSqlBuilder.class, method = "buildQueryByTagIds")
    @ResultMap("movieMap")
    List<MovieVO> selectMoviesByTagIds(
            @Param("tagIds") List<Integer> tagIds,
            @Param("tagCount") int tagCount
    );

    @Select("SELECT * FROM MOVIES WHERE title LIKE '%' || #{title} || '%'")
    @ResultMap("movieMap")
    List<MovieVO> findByTitle(@Param("title") String title);

    @SelectProvider(type = MovieSqlBuilder.class, method = "buildQueryByTagsAndTitle")
    @ResultMap("movieMap")
    List<MovieVO> selectMoviesByTagsAndTitle(
            @Param("tagIds") List<Integer> tagIds,
            @Param("tagCount") int tagCount,
            @Param("title") String title
    );

    @Select("""
        SELECT m.movie_id, m.title, m.poster_url
        FROM MOVIES m
        JOIN MOVIE_TAGS mt ON m.movie_id = mt.movie_id
        JOIN TAGS t ON mt.tag_id = t.tag_id
        WHERE t.tag_name = #{tagName}
    """)
    @Results({
            @Result(property = "movie_id", column = "MOVIE_ID")
    })
    List<MovieVO> findMoviesByTagName(@Param("tagName") String tagName);

    @SelectProvider(type = MovieSqlBuilder.class, method = "buildQueryByAnyTag")
    @ResultMap("movieMap")
    List<MovieVO> selectMoviesByAnyTag(@Param("tags") List<Integer> tags, @Param("excludeId") int excludeId);

    @Select("""
    SELECT * FROM MOVIES
    WHERE release_date BETWEEN SYSDATE - 250 AND SYSDATE
    """)
    @ResultMap("movieMap")
    List<MovieVO> selectNowShowingMovies();

    @Select("""
        SELECT * FROM MOVIES
        WHERE release_date > SYSDATE
    """)
    @ResultMap("movieMap")
    List<MovieVO> selectUpcomingMovies();

    // ✅ [추가] 제목 + 상태 필터링
    @Select("""
        SELECT * FROM MOVIES
        WHERE title LIKE '%' || #{title} || '%'
        AND (
            (#{status} = 'showing' AND release_date <= SYSDATE)
            OR (#{status} = 'upcoming' AND release_date > SYSDATE)
            OR (#{status} = 'all')
        )
    """)
    @ResultMap("movieMap")
    List<MovieVO> selectMoviesByTitleAndStatus(
            @Param("title") String title,
            @Param("status") String status
    );

    // ✅ [추가] 태그 + 상태 필터링
    @SelectProvider(type = MovieSqlBuilder.class, method = "buildQueryByTagsAndStatus")
    @ResultMap("movieMap")
    List<MovieVO> selectMoviesByTagsAndStatus(
            @Param("tagIds") List<Integer> tagIds,
            @Param("tagCount") int tagCount,
            @Param("status") String status
    );

    // ✅ [추가] 태그 + 제목 + 상태 필터링
    @SelectProvider(type = MovieSqlBuilder.class, method = "buildQueryByTagsTitleAndStatus")
    @ResultMap("movieMap")
    List<MovieVO> selectMoviesByTagsTitleAndStatus(
            @Param("tagIds") List<Integer> tagIds,
            @Param("tagCount") int tagCount,
            @Param("title") String title,
            @Param("status") String status
    );

    @Select("""
    SELECT *
    FROM movies
    WHERE movie_id != #{excludeId}
      AND REGEXP_LIKE(
            genre,
            '(^|/)(#{regexGenres})(/|$)'
        )
""")
    List<MovieVO> selectSimilarMoviesByGenre(@Param("excludeId") int excludeId,
                                             @Param("regexGenres") String regexGenres);
}
