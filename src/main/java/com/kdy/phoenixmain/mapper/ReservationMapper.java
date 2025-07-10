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
        INSERT INTO reservations (reservation_id, u_id, runtime_id, adult, youth, child, total_amount, reservation_status, reserved_at)
        VALUES (#{reservation_id}, #{u_id}, #{runtime_id}, #{adult}, #{youth}, #{child}, #{total_amount}, #{reservation_status}, CURRENT_TIMESTAMP)
    """)
    int insertReservation(ReservationVO reservation);

    /**
     * 마지막 삽입된 예약 ID 조회
     */
    @Select("SELECT SEQ_RESERVATION_ID.CURRVAL FROM DUAL")
    int getLastReservationId();

    /**
     * 예약 좌석 정보 저장
     */
    @Insert("""
        INSERT INTO reservation_seats (reservation_seat_id, reservation_id, seat_id)
        VALUES (SEQ_RESERVATION_SEAT_ID.NEXTVAL, #{reservation_id}, #{seat_id})
    """)
    int insertReservationSeat(ReservationSeatVO reservationSeat);

    /**
     * 예약 정보 조회 (모든 관련 정보 포함)
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
        u.u_nickname,
        u.u_name,
        m.title as movie_title,
        m.genre as movie_genre,
        m.rating as movie_rating,
        m.running_time,
        rm.room_name,
        rt.run_date,
        rt.start_time,
        rt.price
    FROM reservations r
    JOIN users u ON r.u_id = u.u_id
    JOIN runtimes rt ON r.runtime_id = rt.runtime_id
    JOIN movies m ON rt.movie_id = m.movie_id
    JOIN rooms rm ON rt.room_id = rm.room_id
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
            @Result(property = "u_nickname", column = "u_nickname"),
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
            s.seat_number,
            s.seat_row || s.seat_number as seat_label
        FROM reservation_seats rs
        JOIN seats s ON rs.seat_id = s.seat_id
        WHERE rs.reservation_id = #{reservationId}
        ORDER BY s.seat_row, s.seat_number
    """)
    @Results({
            @Result(property = "reservation_seat_id", column = "reservation_seat_id"),
            @Result(property = "reservation_id", column = "reservation_id"),
            @Result(property = "seat_id", column = "seat_id"),
            @Result(property = "seat_row", column = "seat_row"),
            @Result(property = "seat_number", column = "seat_number"),
            @Result(property = "seat_label", column = "seat_label")
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
            u.u_nickname,
            u.u_name,
            m.title as movie_title,
            rm.room_name,
            rt.run_date,
            rt.start_time,
            LISTAGG(s.seat_row || s.seat_number, ', ') 
                WITHIN GROUP (ORDER BY s.seat_row, s.seat_number) as selected_seats
        FROM reservations r
        JOIN users u ON r.u_id = u.u_id
        JOIN runtimes rt ON r.runtime_id = rt.runtime_id
        JOIN movies m ON rt.movie_id = m.movie_id
        JOIN rooms rm ON rt.room_id = rm.room_id
        LEFT JOIN reservation_seats rs ON r.reservation_id = rs.reservation_id
        LEFT JOIN seats s ON rs.seat_id = s.seat_id
        WHERE r.u_id = #{userId}
        GROUP BY r.reservation_id, r.u_id, r.runtime_id, r.adult, r.youth, r.child,
                 r.total_amount, r.reservation_status, r.reserved_at, u.u_nickname,
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
            @Result(property = "u_nickname", column = "u_nickname"),
            @Result(property = "u_name", column = "u_name"),
            @Result(property = "movie_title", column = "movie_title"),
            @Result(property = "room_name", column = "room_name"),
            @Result(property = "run_date", column = "run_date"),
            @Result(property = "start_time", column = "start_time"),
            @Result(property = "selected_seats", column = "selected_seats")
    })
    List<ReservationVO> getReservationsByUser(@Param("userId") int userId);

    /**
     * 예약 상태 업데이트
     */
    @Update("""
        UPDATE reservations 
        SET reservation_status = #{status}
        WHERE reservation_id = #{reservationId}
    """)
    int updateReservationStatus(@Param("reservationId") int reservationId, @Param("status") String status);

    /**
     * 예약 수정
     */
    @Update("""
        UPDATE reservations 
        SET adult = #{adult}, youth = #{youth}, child = #{child}, total_amount = #{total_amount}
        WHERE reservation_id = #{reservation_id}
    """)
    int updateReservation(ReservationVO reservation);

    /**
     * 예약 삭제 (실제로는 상태만 변경)
     */
    @Delete("""
        UPDATE reservations 
        SET reservation_status = '예약취소'
        WHERE reservation_id = #{reservationId}
    """)
    int deleteReservation(@Param("reservationId") int reservationId);

    /**
     * 사용자별 예약 통계
     */
    @Select("""
        SELECT 
            COUNT(*) as total_reservations,
            SUM(CASE WHEN reservation_status = '예약완료' THEN 1 ELSE 0 END) as active_reservations,
            SUM(CASE WHEN reservation_status = '예약취소' THEN 1 ELSE 0 END) as cancelled_reservations,
            SUM(CASE WHEN reservation_status = '예약완료' THEN total_amount ELSE 0 END) as total_spent
        FROM reservations
        WHERE u_id = #{userId}
    """)
    @Results({
            @Result(property = "adult", column = "total_reservations"),
            @Result(property = "youth", column = "active_reservations"),
            @Result(property = "child", column = "cancelled_reservations"),
            @Result(property = "total_amount", column = "total_spent")
    })
    ReservationVO getReservationStatsByUser(@Param("userId") int userId);

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
        FROM reservations r
        JOIN users u ON r.u_id = u.u_id
        WHERE r.runtime_id = #{runtimeId}
        AND r.reservation_status = '예약완료'
        ORDER BY r.reserved_at DESC
    """)
    List<ReservationVO> getReservationsByRuntime(@Param("runtimeId") int runtimeId);
}