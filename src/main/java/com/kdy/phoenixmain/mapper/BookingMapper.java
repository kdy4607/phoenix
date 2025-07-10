package com.kdy.phoenixmain.mapper;


import com.kdy.phoenixmain.vo.MovieVO;
import com.kdy.phoenixmain.vo.RoomVO;
import com.kdy.phoenixmain.vo.RuntimeVO;
import com.kdy.phoenixmain.vo.SeatVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface BookingMapper {

    @Select("SELECT title FROM movies")
    List<MovieVO> getAllMovies();

    @Select("SELECT * FROM rooms")
    List<RoomVO> getAllRooms();

    @Select("""
        SELECT * FROM runtimes
        WHERE room_id = #{roomId}
          AND TRUNC(run_date) = TO_DATE(#{reservationDate}, 'YYYY-MM-DD')
    """)
    List<RuntimeVO> getRuntimeByRoomAndDate(@Param("roomId") int room_id,
                                            @Param("reservationDate") String reservationDate);

    @Select("SELECT * FROM runtimes WHERE runtime_id = #{runtimeId}")
    RuntimeVO getRuntimeById(@Param("runtimeId") int runtime_id);

    @Select("""
        SELECT r.runtime_id,
               r.start_time,
               r.price,
               r.available_seats,
               r.room_id,
               rm.room_name
        FROM runtimes r
        JOIN rooms rm ON r.room_id = rm.room_id
        WHERE r.runtime_id = #{runtimeId}
    """)
    RuntimeVO selectRuntimeById(@Param("runtimeId") int runtimeId);

    @Select("SELECT * FROM rooms WHERE room_id = #{roomId}")
    RoomVO getRoomById(@Param("roomId") int roomId);

    @Select("SELECT * FROM SEATS WHERE ROOM_ID = #{roomId} ORDER BY seat_row, seat_number")
    List<SeatVO> getSeatsByRoomId(@Param("roomId") int roomId);

    @Select("""
    SELECT * FROM seats
    WHERE room_id = #{roomId}
      AND seat_row = #{seatRow}
      AND seat_number = #{seatNumber}
""")
    SeatVO getSeatByRoomRowNumber(@Param("roomId") int roomId,
                                  @Param("seatRow") String seatRow,
                                  @Param("seatNumber") int seatNumber);
}
