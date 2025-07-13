package com.kdy.phoenixmain.mapper;

import com.kdy.phoenixmain.vo.RuntimeVO;
import org.apache.ibatis.annotations.*;

import java.util.Date;
import java.util.List;

@Mapper
public interface RuntimeMapper {

    /**
     * 특정 날짜의 모든 상영시간 조회 (영화 및 상영관 정보 포함)
     */
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
        FROM RUNTIMES r
        JOIN MOVIES m ON r.movie_id = m.movie_id
        JOIN ROOMS rm ON r.room_id = rm.room_id
        WHERE TRUNC(r.run_date) = TRUNC(#{runDate})
        ORDER BY m.title, r.start_time
    """)
    @Results({
            @Result(property = "runtime_id", column = "runtime_id"),
            @Result(property = "movie_id", column = "movie_id"),
            @Result(property = "room_id", column = "room_id"),
            @Result(property = "run_date", column = "run_date"),
            @Result(property = "start_time", column = "start_time"),
            @Result(property = "price", column = "price"),
            @Result(property = "available_seats", column = "available_seats"),
            @Result(property = "movie_title", column = "movie_title"),
            @Result(property = "movie_genre", column = "movie_genre"),
            @Result(property = "movie_rating", column = "movie_rating"),
            @Result(property = "poster_url", column = "poster_url"),
            @Result(property = "room_name", column = "room_name"),
            @Result(property = "total_seats", column = "total_seats")
    })
    List<RuntimeVO> getRuntimesByDate(@Param("runDate") Date runDate);

    /**
     * 현재 날짜부터 7일간의 상영시간 조회
     */
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
        FROM RUNTIMES r
        JOIN MOVIES m ON r.movie_id = m.movie_id
        JOIN ROOMS rm ON r.room_id = rm.room_id
        WHERE r.run_date >= TRUNC(SYSDATE) 
        AND r.run_date < TRUNC(SYSDATE) + 7
        ORDER BY r.run_date, m.title, r.start_time
    """)
    @Results({
            @Result(property = "runtime_id", column = "runtime_id"),
            @Result(property = "movie_id", column = "movie_id"),
            @Result(property = "room_id", column = "room_id"),
            @Result(property = "run_date", column = "run_date"),
            @Result(property = "start_time", column = "start_time"),
            @Result(property = "price", column = "price"),
            @Result(property = "available_seats", column = "available_seats"),
            @Result(property = "movie_title", column = "movie_title"),
            @Result(property = "movie_genre", column = "movie_genre"),
            @Result(property = "movie_rating", column = "movie_rating"),
            @Result(property = "poster_url", column = "poster_url"),
            @Result(property = "room_name", column = "room_name"),
            @Result(property = "total_seats", column = "total_seats")
    })
    List<RuntimeVO> getUpcomingRuntimes();

    /**
     * 특정 영화의 특정 날짜 상영시간 조회
     */
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
        FROM RUNTIMES r
        JOIN MOVIES m ON r.movie_id = m.movie_id
        JOIN ROOMS rm ON r.room_id = rm.room_id
        WHERE r.movie_id = #{movieId} 
        AND TRUNC(r.run_date) = TRUNC(#{runDate})
        ORDER BY r.start_time
    """)
    @Results({
            @Result(property = "runtime_id", column = "runtime_id"),
            @Result(property = "movie_id", column = "movie_id"),
            @Result(property = "room_id", column = "room_id"),
            @Result(property = "run_date", column = "run_date"),
            @Result(property = "start_time", column = "start_time"),
            @Result(property = "price", column = "price"),
            @Result(property = "available_seats", column = "available_seats"),
            @Result(property = "movie_title", column = "movie_title"),
            @Result(property = "movie_genre", column = "movie_genre"),
            @Result(property = "movie_rating", column = "movie_rating"),
            @Result(property = "poster_url", column = "poster_url"),
            @Result(property = "room_name", column = "room_name"),
            @Result(property = "total_seats", column = "total_seats")
    })
    List<RuntimeVO> getRuntimesByMovieAndDate(@Param("movieId") int movieId, @Param("runDate") Date runDate);

    /**
     * 특정 상영시간 정보 조회
     */
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
        FROM RUNTIMES r
        JOIN MOVIES m ON r.movie_id = m.movie_id
        JOIN ROOMS rm ON r.room_id = rm.room_id
        WHERE r.runtime_id = #{runtimeId}
    """)
    @Results({
            @Result(property = "runtime_id", column = "runtime_id"),
            @Result(property = "movie_id", column = "movie_id"),
            @Result(property = "room_id", column = "room_id"),
            @Result(property = "run_date", column = "run_date"),
            @Result(property = "start_time", column = "start_time"),
            @Result(property = "price", column = "price"),
            @Result(property = "available_seats", column = "available_seats"),
            @Result(property = "movie_title", column = "movie_title"),
            @Result(property = "movie_genre", column = "movie_genre"),
            @Result(property = "movie_rating", column = "movie_rating"),
            @Result(property = "poster_url", column = "poster_url"),
            @Result(property = "room_name", column = "room_name"),
            @Result(property = "total_seats", column = "total_seats")
    })
    RuntimeVO getRuntimeById(@Param("runtimeId") int runtimeId);

    /**
     * 현재 상영 중인 영화 목록 조회 (중복 제거)
     */
    @Select("""
        SELECT DISTINCT
            r.movie_id,
            m.title as movie_title,
            m.genre as movie_genre,
            m.rating as movie_rating,
            m.poster_url
        FROM RUNTIMES r
        JOIN MOVIES m ON r.movie_id = m.movie_id
        WHERE r.run_date >= TRUNC(SYSDATE)
        ORDER BY m.title
    """)
    @Results({
            @Result(property = "movie_id", column = "movie_id"),
            @Result(property = "movie_title", column = "movie_title"),
            @Result(property = "movie_genre", column = "movie_genre"),
            @Result(property = "movie_rating", column = "movie_rating"),
            @Result(property = "poster_url", column = "poster_url")
    })
    List<RuntimeVO> getCurrentMovies();

    /**
     * 잔여 좌석 수 업데이트
     */
    @Update("""
        UPDATE RUNTIMES 
        SET available_seats = #{availableSeats}
        WHERE runtime_id = #{runtimeId}
    """)
    int updateAvailableSeats(@Param("runtimeId") int runtimeId, @Param("availableSeats") int availableSeats);

    /**
     * 상영시간 추가
     */
    @Insert("""
        INSERT INTO RUNTIMES (runtime_id, movie_id, room_id, run_date, start_time, price, available_seats)
        VALUES (SEQ_RUNTIME_ID.NEXTVAL, #{movie_id}, #{room_id}, #{run_date}, #{start_time}, #{price}, #{available_seats})
    """)
    @Options(useGeneratedKeys = true, keyProperty = "runtime_id")
    int insertRuntime(RuntimeVO runtime);

    /**
     * 상영시간 수정
     */
    @Update("""
        UPDATE RUNTIMES 
        SET movie_id = #{movie_id},
            room_id = #{room_id},
            run_date = #{run_date},
            start_time = #{start_time},
            price = #{price},
            available_seats = #{available_seats}
        WHERE runtime_id = #{runtime_id}
    """)
    int updateRuntime(RuntimeVO runtime);

    /**
     * 상영시간 삭제
     */
    @Delete("""
        DELETE FROM RUNTIMES 
        WHERE runtime_id = #{runtimeId}
    """)
    int deleteRuntime(@Param("runtimeId") int runtimeId);

    /**
     * 특정 상영관의 특정 날짜 상영시간 조회
     */
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
        FROM RUNTIMES r
        JOIN MOVIES m ON r.movie_id = m.movie_id
        JOIN ROOMS rm ON r.room_id = rm.room_id
        WHERE r.room_id = #{roomId} 
        AND TRUNC(r.run_date) = TRUNC(#{runDate})
        ORDER BY r.start_time
    """)
    @Results({
            @Result(property = "runtime_id", column = "runtime_id"),
            @Result(property = "movie_id", column = "movie_id"),
            @Result(property = "room_id", column = "room_id"),
            @Result(property = "run_date", column = "run_date"),
            @Result(property = "start_time", column = "start_time"),
            @Result(property = "price", column = "price"),
            @Result(property = "available_seats", column = "available_seats"),
            @Result(property = "movie_title", column = "movie_title"),
            @Result(property = "movie_genre", column = "movie_genre"),
            @Result(property = "movie_rating", column = "movie_rating"),
            @Result(property = "poster_url", column = "poster_url"),
            @Result(property = "room_name", column = "room_name"),
            @Result(property = "total_seats", column = "total_seats")
    })
    List<RuntimeVO> getRuntimesByRoomAndDate(@Param("roomId") int roomId, @Param("runDate") Date runDate);

    /**
     * 특정 영화의 모든 상영시간 조회
     */
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
        FROM RUNTIMES r
        JOIN MOVIES m ON r.movie_id = m.movie_id
        JOIN ROOMS rm ON r.room_id = rm.room_id
        WHERE r.movie_id = #{movieId}
        AND r.run_date >= TRUNC(SYSDATE)
        ORDER BY r.run_date, r.start_time
    """)
    @Results({
            @Result(property = "runtime_id", column = "runtime_id"),
            @Result(property = "movie_id", column = "movie_id"),
            @Result(property = "room_id", column = "room_id"),
            @Result(property = "run_date", column = "run_date"),
            @Result(property = "start_time", column = "start_time"),
            @Result(property = "price", column = "price"),
            @Result(property = "available_seats", column = "available_seats"),
            @Result(property = "movie_title", column = "movie_title"),
            @Result(property = "movie_genre", column = "movie_genre"),
            @Result(property = "movie_rating", column = "movie_rating"),
            @Result(property = "poster_url", column = "poster_url"),
            @Result(property = "room_name", column = "room_name"),
            @Result(property = "total_seats", column = "total_seats")
    })
    List<RuntimeVO> getRuntimesByMovie(@Param("movieId") int movieId);

    /**
     * 상영시간 존재 여부 확인
     */
    @Select("SELECT COUNT(*) > 0 FROM RUNTIMES WHERE runtime_id = #{runtimeId}")
    boolean existsById(@Param("runtimeId") int runtimeId);

    /**
     * 상영시간 수 조회
     */
    @Select("SELECT COUNT(*) FROM RUNTIMES WHERE TRUNC(run_date) = TRUNC(#{runDate})")
    int getRuntimeCountByDate(@Param("runDate") Date runDate);

    /**
     * 특정 기간의 상영시간 조회
     */
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
        FROM RUNTIMES r
        JOIN MOVIES m ON r.movie_id = m.movie_id
        JOIN ROOMS rm ON r.room_id = rm.room_id
        WHERE r.run_date >= #{startDate} 
        AND r.run_date <= #{endDate}
        ORDER BY r.run_date, m.title, r.start_time
    """)
    @Results({
            @Result(property = "runtime_id", column = "runtime_id"),
            @Result(property = "movie_id", column = "movie_id"),
            @Result(property = "room_id", column = "room_id"),
            @Result(property = "run_date", column = "run_date"),
            @Result(property = "start_time", column = "start_time"),
            @Result(property = "price", column = "price"),
            @Result(property = "available_seats", column = "available_seats"),
            @Result(property = "movie_title", column = "movie_title"),
            @Result(property = "movie_genre", column = "movie_genre"),
            @Result(property = "movie_rating", column = "movie_rating"),
            @Result(property = "poster_url", column = "poster_url"),
            @Result(property = "room_name", column = "room_name"),
            @Result(property = "total_seats", column = "total_seats")
    })
    List<RuntimeVO> getRuntimesByDateRange(@Param("startDate") Date startDate, @Param("endDate") Date endDate);

    /**
     * 매진 상영시간 조회
     */
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
        FROM RUNTIMES r
        JOIN MOVIES m ON r.movie_id = m.movie_id
        JOIN ROOMS rm ON r.room_id = rm.room_id
        WHERE r.available_seats = 0
        AND TRUNC(r.run_date) = TRUNC(#{runDate})
        ORDER BY m.title, r.start_time
    """)
    @Results({
            @Result(property = "runtime_id", column = "runtime_id"),
            @Result(property = "movie_id", column = "movie_id"),
            @Result(property = "room_id", column = "room_id"),
            @Result(property = "run_date", column = "run_date"),
            @Result(property = "start_time", column = "start_time"),
            @Result(property = "price", column = "price"),
            @Result(property = "available_seats", column = "available_seats"),
            @Result(property = "movie_title", column = "movie_title"),
            @Result(property = "movie_genre", column = "movie_genre"),
            @Result(property = "movie_rating", column = "movie_rating"),
            @Result(property = "poster_url", column = "poster_url"),
            @Result(property = "room_name", column = "room_name"),
            @Result(property = "total_seats", column = "total_seats")
    })
    List<RuntimeVO> getSoldOutRuntimes(@Param("runDate") Date runDate);

    /**
     * 일일 상영시간 통계 조회
     */
    @Select("""
        SELECT 
            TO_CHAR(run_date, 'YYYY-MM-DD') as run_date,
            COUNT(*) as total_runtimes,
            SUM(rm.total_seats) as total_seats,
            SUM(r.available_seats) as available_seats,
            SUM(rm.total_seats - r.available_seats) as reserved_seats
        FROM RUNTIMES r
        JOIN ROOMS rm ON r.room_id = rm.room_id
        WHERE TRUNC(r.run_date) = TRUNC(#{runDate})
        GROUP BY TO_CHAR(run_date, 'YYYY-MM-DD')
    """)
    java.util.Map<String, Object> getDailyRuntimeStats(@Param("runDate") Date runDate);
}