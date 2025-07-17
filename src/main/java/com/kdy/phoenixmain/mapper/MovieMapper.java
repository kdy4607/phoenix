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

    // ✅ 전체 영화 조회
    @Select("SELECT * FROM MOVIES")
    List<MovieVO> selectAllMovie();

    // ✅ 단일 영화 조회 (모든 정보)
    @Select("SELECT * FROM MOVIES WHERE MOVIE_ID = #{movie_id}")
    @ResultMap("movieMap")
    MovieVO selectOneMovie(@Param("movie_id") int movie_id);

    // ✅ 특정 영화의 태그 목록
    @Select("""
        SELECT t.tag_id, t.tag_name, t.tag_type
        FROM MOVIE_TAGS mt
        JOIN TAGS t ON mt.tag_id = t.tag_id
        WHERE mt.movie_id = #{movie_id}
    """)
    List<TagVO> getTagsByMovieId(int movie_id);

    // ✅ 추천 영화: 하나라도 태그가 겹치는 영화 (상세페이지용)
    @SelectProvider(type = MovieSqlBuilder.class, method = "buildQueryByAnyTag")
    @ResultMap("movieMap")
    List<MovieVO> selectMoviesByAnyTag(@Param("tags") List<Integer> tags, @Param("excludeId") int excludeId);

    // ✅ 단순 정보만 가져오는 select (장르 기반 추천용)
    @Select("""
        SELECT movie_id, title, genre
        FROM movies
        WHERE movie_id = #{movieId}
        FETCH FIRST 1 ROWS ONLY
    """)
    MovieVO selectMovieById(@Param("movieId") int movieId);

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


    // 1) 영화 ID로 영화 정보 가져오기
     @Select("""
            SELECT movie_id, title, genre
            FROM movies
            WHERE movie_id = #{movieId}
            FETCH FIRST 1 ROWS ONLY
        """)
        MovieVO selectMovieById(@Param("movieId") int movieId);
    // ② 특정 영화와 장르가 겹치는 다른 영화 목록 조회
    @Select("""
        SELECT DISTINCT m2.movie_id, m2.title, m2.poster_url
        FROM movies m1
        JOIN movies m2 ON m1.genre = m2.genre
        WHERE m1.movie_id = #{movieId}
          AND m2.movie_id != #{movieId}
    """)
    List<MovieVO> selectRelatedMovies(@Param("movieId") int movieId);
}
