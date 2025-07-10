package com.kdy.phoenixmain.service;

import com.kdy.phoenixmain.mapper.ReservationMapper;
import com.kdy.phoenixmain.mapper.RuntimeMapper;
import com.kdy.phoenixmain.vo.ReservationVO;
import com.kdy.phoenixmain.vo.ReservationSeatVO;
import com.kdy.phoenixmain.vo.RuntimeVO;
import com.kdy.phoenixmain.vo.SeatVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class ReservationService {

    @Autowired
    private ReservationMapper reservationMapper;

    @Autowired
    private RuntimeMapper runtimeMapper;

    @Autowired
    private SeatService seatService;

    /**
     * 좌석 예약 생성 (트랜잭션 처리)
     */
    @Transactional
    public ReservationVO createReservation(int runtimeId, List<Integer> seatIds, int userId) {
        try {
            // 1. 상영시간 정보 조회
            RuntimeVO runtime = runtimeMapper.getRuntimeById(runtimeId);
            if (runtime == null) {
                throw new RuntimeException("상영시간 정보를 찾을 수 없습니다.");
            }

            // 2. 좌석 가용성 재확인
            if (!seatService.checkSeatAvailability(runtimeId, seatIds)) {
                throw new RuntimeException("선택한 좌석 중 이미 예약된 좌석이 있습니다.");
            }

            // 3. 좌석 정보 조회
            List<SeatVO> selectedSeats = seatService.getSeatsByIds(seatIds);
            if (selectedSeats.size() != seatIds.size()) {
                throw new RuntimeException("일부 좌석 정보를 찾을 수 없습니다.");
            }

            // 4. 다음 예약 ID 조회
            int reservationId = reservationMapper.getNextReservationId();

            // 5. 예약 정보 생성
            ReservationVO reservation = new ReservationVO();
            reservation.setReservation_id(reservationId);
            reservation.setU_id((long) userId);
            reservation.setRuntime_id(runtimeId);
            reservation.setAdult(seatIds.size()); // 일단 모두 성인으로 처리
            reservation.setYouth(0);
            reservation.setChild(0);
            reservation.setTotal_amount(runtime.getPrice() * seatIds.size());
            reservation.setReservation_status("예약완료");
            // reserved_at은 DB에서 CURRENT_TIMESTAMP로 자동 설정

            // 6. 예약 정보 DB 저장
            reservationMapper.insertReservation(reservation);

            // 7. 예약 좌석 정보 저장
            for (Integer seatId : seatIds) {
                ReservationSeatVO reservationSeat = new ReservationSeatVO();
                reservationSeat.setReservation_id(reservationId);
                reservationSeat.setSeat_id(seatId);
                reservationMapper.insertReservationSeat(reservationSeat);
            }

            // 8. 상영시간 잔여 좌석 수 업데이트
            int newAvailableSeats = runtime.getAvailable_seats() - seatIds.size();
            runtimeMapper.updateAvailableSeats(runtimeId, newAvailableSeats);

            // 9. 예약 완료 정보 조회하여 반환
            ReservationVO completedReservation = getReservationDetail(reservationId);

            System.out.println("예약 완료 - ID: " + reservationId + ", 좌석 수: " + seatIds.size());

            return completedReservation;

        } catch (Exception e) {
            System.err.println("예약 생성 오류: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("예약 생성 중 오류가 발생했습니다: " + e.getMessage());
        }
    }

    /**
     * 예약 상세 정보 조회
     */
    public ReservationVO getReservationDetail(int reservationId) {
        ReservationVO reservation = reservationMapper.getReservationById(reservationId);
        if (reservation != null) {
            // 예약된 좌석 정보 조회
            List<ReservationSeatVO> reservationSeats = reservationMapper.getReservationSeats(reservationId);

            // 좌석 라벨 생성
            StringBuilder seatLabels = new StringBuilder();
            for (int i = 0; i < reservationSeats.size(); i++) {
                ReservationSeatVO seat = reservationSeats.get(i);
                seatLabels.append(seat.getSeat_row()).append(seat.getSeat_number());
                if (i < reservationSeats.size() - 1) {
                    seatLabels.append(", ");
                }
            }
            reservation.setSelected_seats(seatLabels.toString());
        }
        return reservation;
    }

    /**
     * 사용자별 예약 목록 조회 (좌석 정보 포함)
     */
    public List<ReservationVO> getUserReservations(int userId) {
        try {
            List<ReservationVO> reservations = reservationMapper.getReservationsByUser(userId);

            // 로그 추가
            System.out.println("사용자 " + userId + "의 예약 목록 조회: " + reservations.size() + "건");

            // 각 예약의 좌석 정보 확인 (디버깅용)
            for (ReservationVO reservation : reservations) {
                System.out.println("예약 ID: " + reservation.getReservation_id() +
                        ", 좌석: " + reservation.getSelected_seats());
            }

            return reservations;
        } catch (Exception e) {
            System.err.println("사용자별 예약 목록 조회 오류: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("예약 목록을 불러오는 중 오류가 발생했습니다: " + e.getMessage());
        }
    }

    /**
     * 예약 취소
     */
    @Transactional
    public boolean cancelReservation(int reservationId, int userId) {
        try {
            // 1. 예약 정보 확인
            ReservationVO reservation = reservationMapper.getReservationById(reservationId);
            if (reservation == null) {
                throw new RuntimeException("예약 정보를 찾을 수 없습니다.");
            }

            if (reservation.getU_id() != userId) {
                throw new RuntimeException("본인의 예약만 취소할 수 있습니다.");
            }

            if (!"예약완료".equals(reservation.getReservation_status())) {
                throw new RuntimeException("이미 취소된 예약입니다.");
            }

            // 2. 예약 상태 업데이트
            reservationMapper.updateReservationStatus(reservationId, "예약취소");

            // 3. 상영시간 잔여 좌석 수 복원
            RuntimeVO runtime = runtimeMapper.getRuntimeById(reservation.getRuntime_id());
            if (runtime != null) {
                int totalSeats = reservation.getAdult() + reservation.getYouth() + reservation.getChild();
                int newAvailableSeats = runtime.getAvailable_seats() + totalSeats;
                runtimeMapper.updateAvailableSeats(reservation.getRuntime_id(), newAvailableSeats);
            }

            System.out.println("예약 취소 완료 - ID: " + reservationId);
            return true;

        } catch (Exception e) {
            System.err.println("예약 취소 오류: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("예약 취소 중 오류가 발생했습니다: " + e.getMessage());
        }
    }

    /**
     * 예약 가능 여부 확인
     */
    public boolean isReservationAvailable(int runtimeId, List<Integer> seatIds) {
        // 상영시간 존재 여부 확인
        RuntimeVO runtime = runtimeMapper.getRuntimeById(runtimeId);
        if (runtime == null) {
            return false;
        }

        // 좌석 가용성 확인
        return seatService.checkSeatAvailability(runtimeId, seatIds);
    }

    /**
     * 예약 통계 조회
     */
    public ReservationVO getReservationStats(int userId) {
        return reservationMapper.getReservationStatsByUser(userId);
    }
}