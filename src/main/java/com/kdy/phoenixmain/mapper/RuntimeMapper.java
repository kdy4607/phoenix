package com.kdy.phoenixmain.mapper;

import com.kdy.phoenixmain.vo.RuntimeVO;
import org.apache.ibatis.annotations.*;

import java.util.Date;
import java.util.List;

@Mapper
public interface RuntimeMapper {

    // 특정 날짜의 모든 상영시간 조회 (영화 및 상영관 정보 포함)
    @Select("""
        SELECT 
            r.runtime_id,
            r.movie_id,
            r.room_id,
            r.run_date,
            r.start_time,
            r.price,
            r.available_seats,
            m.title as movie_title,
            m.genre as movie_genre,
            m.rating as movie_rating,
            m.poster_url,
            rm.room_name,
            rm.total_seats
        FROM runtimes r
        JOIN movies m ON r.movie_id = m.movie_id
        JOIN rooms rm ON r.room_id = rm.room_id
        WHERE TRUNC(r.run_date) = TRUNC(#{runDate})
        ORDER BY m.title, r.start_time
    """)
    List<RuntimeVO> getRuntimesByDate(@Param("runDate") Date runDate);

    // 현재 날짜부터 7일간의 상영시간 조회
    @Select("""
        SELECT 
            r.runtime_id,
            r.movie_id,
            r.room_id,
            r.run_date,
            r.start_time,
            r.price,
            r.available_seats,
            m.title as movie_title,
            m.genre as movie_genre,
            m.rating as movie_rating,
            m.poster_url,
            rm.room_name,
            rm.total_seats
        FROM runtimes r
        JOIN movies m ON r.movie_id = m.movie_id
        JOIN rooms rm ON r.room_id = rm.room_id
        WHERE r.run_date >= TRUNC(SYSDATE) 
        AND r.run_date < TRUNC(SYSDATE) + 7
        ORDER BY r.run_date, m.title, r.start_time
    """)
    List<RuntimeVO> getUpcomingRuntimes();

    // 특정 영화의 특정 날짜 상영시간 조회
    @Select("""
        SELECT 
            r.runtime_id,
            r.movie_id,
            r.room_id,
            r.run_date,
            r.start_time,
            r.price,
            r.available_seats,
            m.title as movie_title,
            m.genre as movie_genre,
            m.rating as movie_rating,
            m.poster_url,
            rm.room_name,
            rm.total_seats
        FROM runtimes r
        JOIN movies m ON r.movie_id = m.movie_id
        JOIN rooms rm ON r.room_id = rm.room_id
        WHERE r.movie_id = #{movieId} 
        AND TRUNC(r.run_date) = TRUNC(#{runDate})
        ORDER BY r.start_time
    """)
    List<RuntimeVO> getRuntimesByMovieAndDate(@Param("movieId") int movieId, @Param("runDate") Date runDate);

    // 특정 상영시간 정보 조회
    @Select("""
        SELECT 
            r.runtime_id,
            r.movie_id,
            r.room_id,
            r.run_date,
            r.start_time,
            r.price,
            r.available_seats,
            m.title as movie_title,
            m.genre as movie_genre,
            m.rating as movie_rating,
            m.poster_url,
            rm.room_name,
            rm.total_seats
        FROM runtimes r
        JOIN movies m ON r.movie_id = m.movie_id
        JOIN rooms rm ON r.room_id = rm.room_id
        WHERE r.runtime_id = #{runtimeId}
    """)
    RuntimeVO getRuntimeById(@Param("runtimeId") int runtimeId);

    // 좌석 수 업데이트 (예매 시 사용)
    @Update("UPDATE runtimes SET available_seats = #{availableSeats} WHERE runtime_id = #{runtimeId}")
    int updateAvailableSeats(@Param("runtimeId") int runtimeId, @Param("availableSeats") int availableSeats);

    // 상영 중인 영화 목록 조회 (중복 제거)
    @Select("""
        SELECT DISTINCT 
            m.movie_id,
            m.title as movie_title,
            m.genre as movie_genre,
            m.rating as movie_rating,
            m.poster_url
        FROM runtimes r
        JOIN movies m ON r.movie_id = m.movie_id
        WHERE r.run_date >= TRUNC(SYSDATE)
        ORDER BY m.title
    """)
    List<RuntimeVO> getCurrentMovies();
}