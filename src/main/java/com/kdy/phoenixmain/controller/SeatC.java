package com.kdy.phoenixmain.controller;

import com.kdy.phoenixmain.service.SeatService;
import com.kdy.phoenixmain.service.ScheduleService;
import com.kdy.phoenixmain.service.ReservationService;
import com.kdy.phoenixmain.vo.RuntimeVO;
import com.kdy.phoenixmain.vo.SeatVO;
import com.kdy.phoenixmain.vo.ReservationVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/seat")
public class SeatC {

    @Autowired
    private SeatService seatService;

    @Autowired
    private ScheduleService scheduleService;

    @Autowired
    private ReservationService reservationService;

    /**
     * 특정 상영시간의 좌석 상태 조회 (AJAX)
     */
    @GetMapping("/runtime/{runtimeId}")
    @ResponseBody
    public Map<String, Object> getSeatsByRuntime(@PathVariable int runtimeId) {
        Map<String, Object> response = new HashMap<>();

        try {
            // 상영시간 정보 조회
            RuntimeVO runtime = scheduleService.getRuntimeById(runtimeId);
            if (runtime == null) {
                response.put("success", false);
                response.put("message", "상영시간 정보를 찾을 수 없습니다.");
                return response;
            }

            // 해당 상영관의 모든 좌석 조회
            List<SeatVO> allSeats = seatService.getSeatsByRoom(runtime.getRoom_id());

            // 해당 상영시간에 예약된 좌석 ID 목록 조회
            List<Integer> reservedSeatIds = seatService.getReservedSeats(runtimeId);

            // 좌석 상태 설정
            for (SeatVO seat : allSeats) {
                if (reservedSeatIds.contains(seat.getSeat_id())) {
                    seat.setStatus("예약됨");
                } else {
                    seat.setStatus("사용가능");
                }
            }

            response.put("success", true);
            response.put("runtime", runtime);
            response.put("seats", allSeats);
            response.put("reservedSeats", reservedSeatIds);

            System.out.println("Runtime " + runtimeId + "의 좌석 조회 완료: " + allSeats.size() + "석");

        } catch (Exception e) {
            System.err.println("좌석 조회 오류: " + e.getMessage());
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "좌석 정보를 불러오는 중 오류가 발생했습니다: " + e.getMessage());
        }

        return response;
    }

    /**
     * 좌석 예약 생성 (AJAX) - 실제 예약 생성
     */
    @PostMapping("/reserve")
    @ResponseBody
    public Map<String, Object> createReservation(@RequestBody Map<String, Object> request) {
        Map<String, Object> response = new HashMap<>();

        try {
            // 안전한 형변환 처리
            int runtimeId = convertToInteger(request.get("runtimeId"));
            @SuppressWarnings("unchecked")
            List<Object> selectedSeatIdsObj = (List<Object>) request.get("selectedSeatIds");

            // List<Object>를 List<Integer>로 변환
            List<Integer> selectedSeatIds = selectedSeatIdsObj.stream()
                    .map(this::convertToInteger)
                    .toList();

            // 임시 사용자 ID (실제 구현에서는 세션에서 가져와야 함)
            int userId = 1; // 테스트용으로 첫 번째 사용자 사용

            // 예약 생성
            ReservationVO reservation = reservationService.createReservation(runtimeId, selectedSeatIds, userId);

            response.put("success", true);
            response.put("reservation", reservation);
            response.put("message", "예약이 완료되었습니다.");

            System.out.println("예약 생성 완료 - ID: " + reservation.getReservation_id());

        } catch (Exception e) {
            System.err.println("예약 생성 오류: " + e.getMessage());
            e.printStackTrace();
            response.put("success", false);
            response.put("message", e.getMessage());
        }

        return response;
    }

    /**
     * 좌석 선택 임시 확인 (AJAX) - 예약 전 검증
     */
    @PostMapping("/select")
    @ResponseBody
    public Map<String, Object> selectSeats(@RequestBody Map<String, Object> request) {
        Map<String, Object> response = new HashMap<>();

        try {
            // 안전한 형변환 처리
            int runtimeId = convertToInteger(request.get("runtimeId"));
            @SuppressWarnings("unchecked")
            List<Object> selectedSeatIdsObj = (List<Object>) request.get("selectedSeatIds");

            // List<Object>를 List<Integer>로 변환
            List<Integer> selectedSeatIds = selectedSeatIdsObj.stream()
                    .map(this::convertToInteger)
                    .toList();

            // 좌석 사용 가능 여부 확인
            boolean isAvailable = seatService.checkSeatAvailability(runtimeId, selectedSeatIds);

            if (!isAvailable) {
                response.put("success", false);
                response.put("message", "선택한 좌석 중 이미 예약된 좌석이 있습니다.");
                return response;
            }

            // 선택한 좌석 정보 조회
            List<SeatVO> selectedSeats = seatService.getSeatsByIds(selectedSeatIds);

            response.put("success", true);
            response.put("selectedSeats", selectedSeats);
            response.put("message", "좌석이 선택되었습니다. 예약을 진행하시겠습니까?");

            System.out.println("좌석 선택 검증 완료: " + selectedSeatIds.size() + "석");

        } catch (Exception e) {
            System.err.println("좌석 선택 오류: " + e.getMessage());
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "좌석 선택 중 오류가 발생했습니다: " + e.getMessage());
        }

        return response;
    }

    /**
     * 좌석 선택 취소 (AJAX)
     */
    @PostMapping("/cancel")
    @ResponseBody
    public Map<String, Object> cancelSeatSelection(@RequestBody Map<String, Object> request) {
        Map<String, Object> response = new HashMap<>();

        try {
            int runtimeId = convertToInteger(request.get("runtimeId"));
            // 임시 예약 취소 로직 (현재는 세션 기반이므로 특별한 처리 없음)

            response.put("success", true);
            response.put("message", "좌석 선택이 취소되었습니다.");

        } catch (Exception e) {
            System.err.println("좌석 선택 취소 오류: " + e.getMessage());
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "좌석 선택 취소 중 오류가 발생했습니다: " + e.getMessage());
        }

        return response;
    }

    /**
     * 안전한 Integer 변환 헬퍼 메서드
     */
    private int convertToInteger(Object value) {
        if (value == null) {
            throw new IllegalArgumentException("값이 null입니다.");
        }

        if (value instanceof Integer) {
            return (Integer) value;
        } else if (value instanceof String) {
            try {
                return Integer.parseInt((String) value);
            } catch (NumberFormatException e) {
                throw new IllegalArgumentException("숫자로 변환할 수 없는 문자열입니다: " + value);
            }
        } else if (value instanceof Number) {
            return ((Number) value).intValue();
        } else {
            throw new IllegalArgumentException("Integer로 변환할 수 없는 타입입니다: " + value.getClass().getName());
        }
    }
}