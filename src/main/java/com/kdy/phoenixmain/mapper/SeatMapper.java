package com.kdy.phoenixmain.mapper;

import com.kdy.phoenixmain.vo.SeatVO;
import org.apache.ibatis.annotations.*;

import java.util.List;
import java.util.Map;

@Mapper
public interface SeatMapper {

    /**
     * 특정 상영관의 모든 좌석 조회
     */
    @Select("""
        SELECT seat_id, room_id, seat_row, seat_number, status
        FROM seats
        WHERE room_id = #{roomId}
        ORDER BY seat_row, seat_number
    """)
    List<SeatVO> getSeatsByRoom(@Param("roomId") int roomId);

    /**
     * 특정 상영시간에 예약된 좌석 ID 목록 조회
     */
    @Select("""
        SELECT rs.seat_id
        FROM reservation_seats rs
        JOIN reservations r ON rs.reservation_id = r.reservation_id
        WHERE r.runtime_id = #{runtimeId}
        AND r.reservation_status = '예약완료'
    """)
    List<Integer> getReservedSeatsByRuntime(@Param("runtimeId") int runtimeId);

    /**
     * 좌석 ID 목록으로 좌석 정보 조회
     */
    @Select("""
        <script>
        SELECT seat_id, room_id, seat_row, seat_number, status
        FROM seats
        WHERE seat_id IN
        <foreach collection="seatIds" item="seatId" open="(" close=")" separator=",">
            #{seatId}
        </foreach>
        ORDER BY seat_row, seat_number
        </script>
    """)
    List<SeatVO> getSeatsByIds(@Param("seatIds") List<Integer> seatIds);

    /**
     * 좌석 배치 정보 (행별로 정렬)
     */
    @Select("""
        SELECT seat_id, room_id, seat_row, seat_number, status
        FROM seats
        WHERE room_id = #{roomId}
        ORDER BY seat_row, seat_number
    """)
    List<SeatVO> getSeatLayoutByRoom(@Param("roomId") int roomId);

    /**
     * 좌석 상태 업데이트
     */
    @Update("""
        UPDATE seats
        SET status = #{status}
        WHERE seat_id = #{seatId}
    """)
    int updateSeatStatus(@Param("seatId") int seatId, @Param("status") String status);

    /**
     * 특정 상영관의 좌석 통계
     */
    @Select("""
        SELECT 
            COUNT(*) as total_seats,
            COUNT(CASE WHEN status = '사용가능' THEN 1 END) as available_seats,
            COUNT(CASE WHEN status = '예약됨' THEN 1 END) as reserved_seats
        FROM seats
        WHERE room_id = #{roomId}
    """)
    @Results({
            @Result(property = "total_seats", column = "total_seats"),
            @Result(property = "available_seats", column = "available_seats"),
            @Result(property = "reserved_seats", column = "reserved_seats")
    })
    Map<String, Integer> getSeatStatsByRoom(@Param("roomId") int roomId);
}