package com.kdy.phoenixmain.service;


import com.kdy.phoenixmain.mapper.ReservationMapper;
import com.kdy.phoenixmain.vo.MovieVO;
import com.kdy.phoenixmain.vo.RoomVO;
import com.kdy.phoenixmain.vo.RuntimeVO;
import com.kdy.phoenixmain.vo.SeatVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReservationService {

    @Autowired
    ReservationMapper reservationMapper;

    // 전체 조회하는 일
    public List<MovieVO> getAllMovies() {
        List<MovieVO> movies = reservationMapper.getAllMovies();
        System.out.println(movies);
        return movies;
    }

    // 영화관 조회
    public List<RoomVO> getAllRooms() {
        return reservationMapper.getAllRooms();
    }

    // 상영시간 조회
    public List<RuntimeVO> getRuntimeByRoomAndDate(int roomId, String reservationDate) {
        return reservationMapper.getRuntimeByRoomAndDate(roomId, reservationDate);
    }

    //
    public RuntimeVO getRuntimeById(int runtimeId) {
        return reservationMapper.selectRuntimeById(runtimeId);
    }

    public RoomVO getRoomById(int roomId) {
        return reservationMapper.getRoomById(roomId);
    }

    public List<SeatVO> getSeatsByRoomId(int roomId) {
        return reservationMapper.getSeatsByRoomId(roomId);
    }
    public SeatVO getSeatByRoomRowNumber(int roomId, String row, int number) {
        return reservationMapper.getSeatByRoomRowNumber(roomId, row, number);
    }


    
}

