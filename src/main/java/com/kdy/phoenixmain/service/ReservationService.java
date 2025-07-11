package com.kdy.phoenixmain.service;

import com.kdy.phoenixmain.mapper.ReservationMapper;
import com.kdy.phoenixmain.mapper.RuntimeMapper;
import com.kdy.phoenixmain.vo.ReservationVO;
import com.kdy.phoenixmain.vo.ReservationSeatVO;
import com.kdy.phoenixmain.vo.RuntimeVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Date;

@Service
public class ReservationService {

    @Autowired
    private ReservationMapper reservationMapper;

    @Autowired
    private RuntimeMapper runtimeMapper;

    @Autowired
    private SeatService seatService;

    /**
     * 예약 생성
     */
    @Transactional
    public ReservationVO createReservation(int runtimeId, List<Integer> seatIds, String userId) {
        try {
            System.out.println("📝 예약 생성 시작");
            System.out.println("   - 사용자 ID: " + userId);
            System.out.println("   - 상영시간 ID: " + runtimeId);
            System.out.println("   - 선택 좌석 수: " + seatIds.size());

            // 1. 상영시간 정보 확인
            RuntimeVO runtime = runtimeMapper.getRuntimeById(runtimeId);
            if (runtime == null) {
                throw new RuntimeException("상영시간 정보를 찾을 수 없습니다.");
            }

            // 2. 좌석 가용성 확인
            if (!seatService.checkSeatAvailability(runtimeId, seatIds)) {
                throw new RuntimeException("선택한 좌석 중 이미 예약된 좌석이 있습니다.");
            }

            // 3. ✅ 예약 ID 먼저 생성 (이 부분이 누락되었음!)
            int reservationId = reservationMapper.getNextReservationId();
            System.out.println("🎫 생성된 예약 ID: " + reservationId);

            // 4. 예약 기본 정보 생성
            ReservationVO reservation = new ReservationVO();
            reservation.setReservation_id(reservationId);  // ✅ ID 설정 추가!
            reservation.setU_id(userId);
            reservation.setRuntime_id(runtimeId);
            reservation.setAdult(seatIds.size()); // 임시로 좌석 수만큼 성인으로 설정
            reservation.setYouth(0);
            reservation.setChild(0);
            reservation.setTotal_amount(seatIds.size() * 12000); // 기본 가격 12,000원
            reservation.setReservation_status("예약완료");
            reservation.setReserved_at(new Date());

            // 5. 예약 정보 저장
            int insertResult = reservationMapper.insertReservation(reservation);
            if (insertResult <= 0) {
                throw new RuntimeException("예약 정보 저장에 실패했습니다.");
            }

            System.out.println("✅ 예약 기본 정보 저장 완료 - ID: " + reservationId);

            // 6. 예약 좌석 정보 저장
            for (Integer seatId : seatIds) {
                ReservationSeatVO reservationSeat = new ReservationSeatVO();
                reservationSeat.setReservation_id(reservationId);
                reservationSeat.setSeat_id(seatId);

                int seatInsertResult = reservationMapper.insertReservationSeat(reservationSeat);
                if (seatInsertResult <= 0) {
                    throw new RuntimeException("좌석 정보 저장에 실패했습니다. 좌석 ID: " + seatId);
                }
            }

            System.out.println("✅ 예약 좌석 정보 저장 완료 - " + seatIds.size() + "개");

            // 7. 상영시간 잔여 좌석 수 업데이트
            int newAvailableSeats = runtime.getAvailable_seats() - seatIds.size();
            int updateResult = runtimeMapper.updateAvailableSeats(runtimeId, newAvailableSeats);
            if (updateResult <= 0) {
                throw new RuntimeException("잔여 좌석 수 업데이트에 실패했습니다.");
            }

            System.out.println("✅ 잔여 좌석 수 업데이트 완료: " + newAvailableSeats + "석");

            // 8. 예약 완료 정보 조회하여 반환
            ReservationVO completedReservation = getReservationDetail(reservationId);
            if (completedReservation == null) {
                // 기본 정보라도 반환
                completedReservation = reservation;
            }

            System.out.println("🎉 예약 완료 - ID: " + reservationId + ", 좌석 수: " + seatIds.size());

            return completedReservation;

        } catch (Exception e) {
            System.err.println("❌ 예약 생성 오류: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("예약 생성 중 오류가 발생했습니다: " + e.getMessage());
        }
    }

    /**
     * 예약 상세 정보 조회
     */
    public ReservationVO getReservationDetail(int reservationId) {
        try {
            System.out.println("🔍 예약 상세 정보 조회 시작 - ID: " + reservationId);

            // 1. 기본 예약 정보 조회
            ReservationVO reservation = reservationMapper.getReservationById(reservationId);

            if (reservation == null) {
                System.err.println("❌ 예약 정보를 찾을 수 없음 - ID: " + reservationId);
                return null;
            }

            System.out.println("✅ 기본 예약 정보 조회 성공:");
            System.out.println("   - 예약 ID: " + reservation.getReservation_id());
            System.out.println("   - 사용자 ID: " + reservation.getU_id());
            System.out.println("   - 영화: " + reservation.getMovie_title());
            System.out.println("   - 상영관: " + reservation.getRoom_name());
            System.out.println("   - 상영일: " + reservation.getRun_date());
            System.out.println("   - 상영시간: " + reservation.getStart_time());
            System.out.println("   - 예약상태: " + reservation.getReservation_status());
            System.out.println("   - 총금액: " + reservation.getTotal_amount());

            // 2. 예약된 좌석 정보 조회
            List<ReservationSeatVO> reservationSeats = reservationMapper.getReservationSeats(reservationId);

            System.out.println("🪑 좌석 정보 조회 결과: " + (reservationSeats != null ? reservationSeats.size() : 0) + "개");

            if (reservationSeats != null && !reservationSeats.isEmpty()) {
                // 좌석 라벨 생성
                StringBuilder seatLabels = new StringBuilder();
                for (int i = 0; i < reservationSeats.size(); i++) {
                    ReservationSeatVO seat = reservationSeats.get(i);
                    System.out.println("   - 좌석 " + (i+1) + ": " + seat.getSeat_row() + seat.getSeat_number());

                    seatLabels.append(seat.getSeat_row()).append(seat.getSeat_number());
                    if (i < reservationSeats.size() - 1) {
                        seatLabels.append(", ");
                    }
                }
                reservation.setSelected_seats(seatLabels.toString());
                System.out.println("✅ 좌석 정보 설정 완료: " + reservation.getSelected_seats());
            } else {
                reservation.setSelected_seats("");
                System.out.println("⚠️ 좌석 정보가 없음");
            }

            System.out.println("🔍 예약 상세 정보 조회 완료");
            return reservation;

        } catch (Exception e) {
            System.err.println("❌ 예약 상세 정보 조회 오류: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    /**
     * 사용자별 예약 목록 조회 (좌석 정보 포함)
     */
    public List<ReservationVO> getUserReservations(String userId) {  // int -> String 변경
        try {
            List<ReservationVO> reservations = reservationMapper.getReservationsByUser(userId);

            // 로그 추가
            System.out.println("사용자 " + userId + "의 예약 목록 조회: " + reservations.size() + "건");

            // 각 예약의 좌석 정보 확인 (디버깅용)
            for (ReservationVO reservation : reservations) {
                System.out.println("예약 ID: " + reservation.getReservation_id() +
                        ", 사용자 ID: " + reservation.getU_id() +
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
    public boolean cancelReservation(int reservationId, String userId) {  // int -> String 변경
        try {
            // 1. 예약 정보 확인
            ReservationVO reservation = reservationMapper.getReservationById(reservationId);
            if (reservation == null) {
                throw new RuntimeException("예약 정보를 찾을 수 없습니다.");
            }

            if (!reservation.getU_id().equals(userId)) {  // == 비교에서 .equals()로 변경
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

            System.out.println("예약 취소 완료 - ID: " + reservationId + ", 사용자: " + userId);
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
    public ReservationVO getReservationStats(String userId) {  // int -> String 변경
        return reservationMapper.getReservationStatsByUser(userId);
    }
}