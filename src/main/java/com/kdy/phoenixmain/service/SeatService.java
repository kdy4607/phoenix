package com.kdy.phoenixmain.service;

import com.kdy.phoenixmain.mapper.SeatMapper;
import com.kdy.phoenixmain.vo.SeatVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SeatService {

    @Autowired
    private SeatMapper seatMapper;

    /**
     * 특정 상영관의 모든 좌석 조회
     */
    public List<SeatVO> getSeatsByRoom(int roomId) {
        return seatMapper.getSeatsByRoom(roomId);
    }

    /**
     * 특정 상영시간에 예약된 좌석 ID 목록 조회
     */
    public List<Integer> getReservedSeats(int runtimeId) {
        return seatMapper.getReservedSeatsByRuntime(runtimeId);
    }

    /**
     * 좌석 ID 목록으로 좌석 정보 조회
     */
    public List<SeatVO> getSeatsByIds(List<Integer> seatIds) {
        return seatMapper.getSeatsByIds(seatIds);
    }

    /**
     * 좌석 사용 가능 여부 확인
     */
    public boolean checkSeatAvailability(int runtimeId, List<Integer> seatIds) {
        List<Integer> reservedSeats = getReservedSeats(runtimeId);

        // 선택한 좌석 중 예약된 좌석이 있는지 확인
        for (Integer seatId : seatIds) {
            if (reservedSeats.contains(seatId)) {
                return false;
            }
        }

        return true;
    }

    /**
     * 좌석 배치 정보 (행별로 그룹화)
     */
    public List<SeatVO> getSeatLayout(int roomId) {
        return seatMapper.getSeatLayoutByRoom(roomId);
    }
}