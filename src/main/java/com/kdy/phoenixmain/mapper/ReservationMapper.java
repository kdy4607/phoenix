package com.kdy.phoenixmain.mapper;

import com.kdy.phoenixmain.vo.ReservationVO;
import com.kdy.phoenixmain.vo.ReservationSeatVO;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface ReservationMapper {

    /**
     * 다음 예약 ID 조회
     */
    @Select("SELECT SEQ_RESERVATION_ID.NEXTVAL FROM DUAL")
    int getNextReservationId();

    /**
     * 예약 정보 저장
     */
    @Insert("""
        INSERT INTO RESERVATIONS (reservation_id, u_id, runtime_id, adult, youth, child, total_amount, reservation_status, reserved_at)
        VALUES (#{reservation_id}, #{u_id}, #{runtime_id}, #{adult}, #{youth}, #{child}, #{total_amount}, #{reservation_status}, CURRENT_TIMESTAMP)
    """)
    int insertReservation(ReservationVO reservation);

    /**
     * 예약 좌석 정보 저장
     */
    @Insert("""
        INSERT INTO RESERVATION_SEATS (reservation_seat_id, reservation_id, seat_id)
        VALUES (SEQ_RESERVATION_SEAT_ID.NEXTVAL, #{reservation_id}, #{seat_id})
    """)
    int insertReservationSeat(ReservationSeatVO reservationSeat);

    /**
     * 예약 정보 조회 (기본 정보 + 영화/상영관 정보)
     */
    @Select("""
        SELECT 
            r.reservation_id,
            r.u_id,
            r.runtime_id,
            r.adult,
            r.youth,
            r.child,
            r.total_amount,
            r.reservation_status,
            r.reserved_at,
            u.u_name,
            m.title as movie_title,
            rm.room_name,
            rt.run_date,
            rt.start_time
        FROM RESERVATIONS r
        JOIN USERS u ON r.u_id = u.u_id
        JOIN RUNTIMES rt ON r.runtime_id = rt.runtime_id
        JOIN MOVIES m ON rt.movie_id = m.movie_id
        JOIN ROOMS rm ON rt.room_id = rm.room_id
        WHERE r.reservation_id = #{reservationId}
    """)
    @Results({
            @Result(property = "reservation_id", column = "reservation_id"),
            @Result(property = "u_id", column = "u_id"),
            @Result(property = "runtime_id", column = "runtime_id"),
            @Result(property = "adult", column = "adult"),
            @Result(property = "youth", column = "youth"),
            @Result(property = "child", column = "child"),
            @Result(property = "total_amount", column = "total_amount"),
            @Result(property = "reservation_status", column = "reservation_status"),
            @Result(property = "reserved_at", column = "reserved_at"),
            @Result(property = "u_name", column = "u_name"),
            @Result(property = "movie_title", column = "movie_title"),
            @Result(property = "room_name", column = "room_name"),
            @Result(property = "run_date", column = "run_date"),
            @Result(property = "start_time", column = "start_time")
    })
    ReservationVO getReservationById(@Param("reservationId") int reservationId);

    /**
     * 예약된 좌석 정보 조회
     */
    @Select("""
        SELECT 
            rs.reservation_seat_id,
            rs.reservation_id,
            rs.seat_id,
            s.seat_row,
            s.seat_number
        FROM RESERVATION_SEATS rs
        JOIN SEATS s ON rs.seat_id = s.seat_id
        WHERE rs.reservation_id = #{reservationId}
        ORDER BY s.seat_row, s.seat_number
    """)
    @Results({
            @Result(property = "reservation_seat_id", column = "reservation_seat_id"),
            @Result(property = "reservation_id", column = "reservation_id"),
            @Result(property = "seat_id", column = "seat_id"),
            @Result(property = "seat_row", column = "seat_row"),
            @Result(property = "seat_number", column = "seat_number")
    })
    List<ReservationSeatVO> getReservationSeats(@Param("reservationId") int reservationId);

    /**
     * 사용자별 예약 목록 조회 (좌석 정보 포함)
     */
    @Select("""
        SELECT 
            r.reservation_id,
            r.u_id,
            r.runtime_id,
            r.adult,
            r.youth,
            r.child,
            r.total_amount,
            r.reservation_status,
            r.reserved_at,
            u.u_name,
            m.title as movie_title,
            rm.room_name,
            rt.run_date,
            rt.start_time,
            LISTAGG(s.seat_row || s.seat_number, ', ') WITHIN GROUP (ORDER BY s.seat_row, s.seat_number) as selected_seats
        FROM RESERVATIONS r
        JOIN USERS u ON r.u_id = u.u_id
        JOIN RUNTIMES rt ON r.runtime_id = rt.runtime_id
        JOIN MOVIES m ON rt.movie_id = m.movie_id
        JOIN ROOMS rm ON rt.room_id = rm.room_id
        LEFT JOIN RESERVATION_SEATS rs ON r.reservation_id = rs.reservation_id
        LEFT JOIN SEATS s ON rs.seat_id = s.seat_id
        WHERE r.u_id = #{userId}
        GROUP BY 
            r.reservation_id, r.u_id, r.runtime_id, r.adult, r.youth, r.child, 
            r.total_amount, r.reservation_status, r.reserved_at,
            u.u_name, m.title, rm.room_name, rt.run_date, rt.start_time
        ORDER BY r.reserved_at DESC
    """)
    @Results({
            @Result(property = "reservation_id", column = "reservation_id"),
            @Result(property = "u_id", column = "u_id"),
            @Result(property = "runtime_id", column = "runtime_id"),
            @Result(property = "adult", column = "adult"),
            @Result(property = "youth", column = "youth"),
            @Result(property = "child", column = "child"),
            @Result(property = "total_amount", column = "total_amount"),
            @Result(property = "reservation_status", column = "reservation_status"),
            @Result(property = "reserved_at", column = "reserved_at"),
            @Result(property = "u_name", column = "u_name"),
            @Result(property = "movie_title", column = "movie_title"),
            @Result(property = "room_name", column = "room_name"),
            @Result(property = "run_date", column = "run_date"),
            @Result(property = "start_time", column = "start_time"),
            @Result(property = "selected_seats", column = "selected_seats")
    })
    List<ReservationVO> getReservationsByUser(@Param("userId") String userId);  // int → String 변경

    /**
     * 예약 상태 업데이트
     */
    @Update("""
        UPDATE RESERVATIONS 
        SET reservation_status = #{status}
        WHERE reservation_id = #{reservationId}
    """)
    int updateReservationStatus(@Param("reservationId") int reservationId, @Param("status") String status);

    /**
     * 예약 수정
     */
    @Update("""
        UPDATE RESERVATIONS 
        SET adult = #{adult}, youth = #{youth}, child = #{child}, total_amount = #{total_amount}
        WHERE reservation_id = #{reservation_id}
    """)
    int updateReservation(ReservationVO reservation);

    /**
     * 예약 삭제 (실제로는 상태만 변경)
     */
    @Update("""
        UPDATE RESERVATIONS 
        SET reservation_status = '예약취소'
        WHERE reservation_id = #{reservationId}
    """)
    int deleteReservation(@Param("reservationId") int reservationId);

    /**
     * 사용자별 예약 통계 조회
     */
    @Select("""
        SELECT 
            COUNT(*) as adult,
            SUM(CASE WHEN reservation_status = '예약완료' THEN 1 ELSE 0 END) as youth,
            SUM(CASE WHEN reservation_status = '예약취소' THEN 1 ELSE 0 END) as child,
            SUM(CASE WHEN reservation_status = '예약완료' THEN total_amount ELSE 0 END) as total_amount
        FROM RESERVATIONS
        WHERE u_id = #{userId}
    """)
    @Results({
            @Result(property = "adult", column = "adult"),        // 총 예약 수
            @Result(property = "youth", column = "youth"),        // 진행 중인 예약
            @Result(property = "child", column = "child"),        // 취소된 예약
            @Result(property = "total_amount", column = "total_amount")  // 총 결제 금액
    })
    ReservationVO getReservationStatsByUser(@Param("userId") String userId);  // int → String 변경

    /**
     * 특정 상영시간의 예약 목록 조회
     */
    @Select("""
        SELECT 
            r.reservation_id,
            r.u_id,
            r.adult,
            r.youth,
            r.child,
            r.total_amount,
            r.reservation_status,
            r.reserved_at,
            u.u_name
        FROM RESERVATIONS r
        JOIN USERS u ON r.u_id = u.u_id
        WHERE r.runtime_id = #{runtimeId}
        AND r.reservation_status = '예약완료'
        ORDER BY r.reserved_at DESC
    """)
    @Results({
            @Result(property = "reservation_id", column = "reservation_id"),
            @Result(property = "u_id", column = "u_id"),
            @Result(property = "adult", column = "adult"),
            @Result(property = "youth", column = "youth"),
            @Result(property = "child", column = "child"),
            @Result(property = "total_amount", column = "total_amount"),
            @Result(property = "reservation_status", column = "reservation_status"),
            @Result(property = "reserved_at", column = "reserved_at"),
            @Result(property = "u_name", column = "u_name")
    })
    List<ReservationVO> getReservationsByRuntime(@Param("runtimeId") int runtimeId);

    /**
     * 특정 상영시간의 예약된 좌석 조회
     */
    @Select("""
        SELECT DISTINCT rs.seat_id
        FROM RESERVATION_SEATS rs
        JOIN RESERVATIONS r ON rs.reservation_id = r.reservation_id
        WHERE r.runtime_id = #{runtimeId}
        AND r.reservation_status = '예약완료'
    """)
    List<Integer> getReservedSeatsByRuntime(@Param("runtimeId") int runtimeId);

    /**
     * 예약 취소 (사용자 확인 포함)
     */
    @Update("""
        UPDATE RESERVATIONS 
        SET reservation_status = '예약취소'
        WHERE reservation_id = #{reservationId}
        AND u_id = #{userId}
        AND reservation_status = '예약완료'
    """)
    int cancelReservation(@Param("reservationId") int reservationId, @Param("userId") String userId);  // int → String 변경

    /**
     * 예약 완전 삭제 (관리자용)
     */
    @Delete("""
        DELETE FROM RESERVATIONS 
        WHERE reservation_id = #{reservationId}
    """)
    int deleteReservationCompletely(@Param("reservationId") int reservationId);

    /**
     * 예약 좌석 삭제
     */
    @Delete("""
        DELETE FROM RESERVATION_SEATS 
        WHERE reservation_id = #{reservationId}
    """)
    int deleteReservationSeats(@Param("reservationId") int reservationId);

    /**
     * 일별 예약 통계
     */
    @Select("""
        SELECT 
            TO_CHAR(reserved_at, 'YYYY-MM-DD') as reservation_date,
            COUNT(*) as total_count,
            SUM(CASE WHEN reservation_status = '예약완료' THEN 1 ELSE 0 END) as completed_count,
            SUM(CASE WHEN reservation_status = '예약취소' THEN 1 ELSE 0 END) as cancelled_count,
            SUM(CASE WHEN reservation_status = '예약완료' THEN total_amount ELSE 0 END) as total_amount
        FROM RESERVATIONS
        WHERE reserved_at >= TRUNC(SYSDATE - 7)
        GROUP BY TO_CHAR(reserved_at, 'YYYY-MM-DD')
        ORDER BY reservation_date DESC
    """)
    List<java.util.Map<String, Object>> getDailyReservationStats();

    /**
     * 영화별 예약 통계
     */
    @Select("""
        SELECT 
            m.title as movie_title,
            COUNT(*) as total_reservations,
            SUM(r.adult + r.youth + r.child) as total_audience,
            SUM(r.total_amount) as total_revenue
        FROM RESERVATIONS r
        JOIN RUNTIMES rt ON r.runtime_id = rt.runtime_id
        JOIN MOVIES m ON rt.movie_id = m.movie_id
        WHERE r.reservation_status = '예약완료'
        GROUP BY m.movie_id, m.title
        ORDER BY total_revenue DESC
    """)
    List<java.util.Map<String, Object>> getMovieReservationStats();
}