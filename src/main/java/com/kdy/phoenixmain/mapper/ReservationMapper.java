package com.kdy.phoenixmain.mapper;


import com.kdy.phoenixmain.vo.MovieVO;
import com.kdy.phoenixmain.vo.RoomVO;
import com.kdy.phoenixmain.vo.RuntimeVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface ReservationMapper {

    @Select("select title from movies")
    List<MovieVO> getAllMovies();

    @Select("SELECT * FROM rooms")
    List<RoomVO> getAllRooms();

    @Select("SELECT * FROM runtimes WHERE room_id = #{roomId} AND run_date = #{reservationDate}")
    List<RuntimeVO> getRuntimeByRoomAndDate(@Param("roomId") int room_id, @Param("reservationDate") String reservationDate);

    @Select("SELECT * FROM runtimes WHERE runtime_id = #{runtime_id}")
    RuntimeVO getRuntimeById(@Param("runtimeId") int runtime_id); // runtime_id로 단일 상영 정보 조회 메서드 추가

}