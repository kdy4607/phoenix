package com.kdy.phoenixmain.controller;

import com.kdy.phoenixmain.service.ReservationService;
import com.kdy.phoenixmain.service.RuntimeService;
import com.kdy.phoenixmain.service.SeatService;
import com.kdy.phoenixmain.vo.LoginVO;
import com.kdy.phoenixmain.vo.ReservationVO;
import com.kdy.phoenixmain.vo.RuntimeVO;
import com.kdy.phoenixmain.vo.SeatVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/seat")
public class SeatC {

    @Autowired
    private SeatService seatService;

    @Autowired
    private RuntimeService runtimeService;

    @Autowired
    private ReservationService reservationService;

    /**
     * 안전한 정수 변환 메서드
     */
    private int convertToInteger(Object obj) {
        if (obj == null) {
            return 0;
        }
        if (obj instanceof Integer) {
            return (Integer) obj;
        }
        if (obj instanceof Number) {
            return ((Number) obj).intValue();
        }
        if (obj instanceof String) {
            try {
                return Integer.parseInt((String) obj);
            } catch (NumberFormatException e) {
                return 0;
            }
        }
        return 0;
    }

    /**
     * 특정 상영시간의 좌석 정보 조회 (AJAX)
     */
    @GetMapping("/{runtimeId}/seats")
    @ResponseBody
    public Map<String, Object> getSeatsByRuntime(@PathVariable int runtimeId) {
        Map<String, Object> response = new HashMap<>();

        try {
            System.out.println("🪑 좌석 정보 조회 요청 - Runtime ID: " + runtimeId);

            // 상영시간 정보 조회
            RuntimeVO runtime = runtimeService.getRuntimeById(runtimeId);
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

            System.out.println("✅ Runtime " + runtimeId + "의 좌석 조회 완료: " + allSeats.size() + "석");

        } catch (Exception e) {
            System.err.println("❌ 좌석 조회 오류: " + e.getMessage());
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
    public Map<String, Object> createReservation(@RequestBody Map<String, Object> request, HttpSession session) {
        Map<String, Object> response = new HashMap<>();

        try {
            System.out.println("🎫 예약 생성 요청 시작");

            // 로그인 확인
            LoginVO user = (LoginVO) session.getAttribute("user");
            if (user == null) {
                response.put("success", false);
                response.put("message", "예약을 위해 로그인이 필요합니다.");
                response.put("requireLogin", true);
                return response;
            }

            // 안전한 형변환 처리
            int runtimeId = convertToInteger(request.get("runtimeId"));
            @SuppressWarnings("unchecked")
            List<Object> selectedSeatIdsObj = (List<Object>) request.get("selectedSeatIds");

            // 입력 검증
            if (runtimeId <= 0) {
                response.put("success", false);
                response.put("message", "유효하지 않은 상영시간입니다.");
                return response;
            }

            if (selectedSeatIdsObj == null || selectedSeatIdsObj.isEmpty()) {
                response.put("success", false);
                response.put("message", "좌석을 선택해주세요.");
                return response;
            }

            // List<Object>를 List<Integer>로 변환
            List<Integer> selectedSeatIds = selectedSeatIdsObj.stream()
                    .map(this::convertToInteger)
                    .filter(id -> id > 0)  // 유효한 좌석 ID만 필터링
                    .toList();

            if (selectedSeatIds.isEmpty()) {
                response.put("success", false);
                response.put("message", "유효한 좌석을 선택해주세요.");
                return response;
            }

            String userId = user.getU_id();  // 로그인한 사용자 ID 사용

            System.out.println("📋 예약 정보:");
            System.out.println("   - 사용자: " + user.getU_name() + " (" + userId + ")");
            System.out.println("   - 상영시간 ID: " + runtimeId);
            System.out.println("   - 선택 좌석 수: " + selectedSeatIds.size());
            System.out.println("   - 좌석 ID 목록: " + selectedSeatIds);

            // 예약 가능 여부 확인
            if (!reservationService.isReservationAvailable(runtimeId, selectedSeatIds)) {
                response.put("success", false);
                response.put("message", "선택한 좌석 중 이미 예약된 좌석이 있습니다. 페이지를 새로고침하여 다시 시도해주세요.");
                return response;
            }

            // 예약 생성
            ReservationVO reservation = reservationService.createReservation(runtimeId, selectedSeatIds, userId);

            if (reservation != null) {
                response.put("success", true);
                response.put("reservation", reservation);
                response.put("message", "예약이 완료되었습니다.");

                System.out.println("✅ 예약 생성 성공 - 예약 ID: " + reservation.getReservation_id());
            } else {
                response.put("success", false);
                response.put("message", "예약 생성에 실패했습니다.");
                System.err.println("❌ 예약 생성 실패 - 반환된 예약 정보가 null");
            }

        } catch (Exception e) {
            System.err.println("❌ 예약 생성 오류: " + e.getMessage());
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "예약 처리 중 오류가 발생했습니다: " + e.getMessage());
        }

        return response;
    }

    /**
     * 좌석 예약 가능 여부 확인 (AJAX)
     */
    @PostMapping("/check-availability")
    @ResponseBody
    public Map<String, Object> checkSeatAvailability(@RequestBody Map<String, Object> request) {
        Map<String, Object> response = new HashMap<>();

        try {
            int runtimeId = convertToInteger(request.get("runtimeId"));
            @SuppressWarnings("unchecked")
            List<Object> selectedSeatIdsObj = (List<Object>) request.get("selectedSeatIds");

            List<Integer> selectedSeatIds = selectedSeatIdsObj.stream()
                    .map(this::convertToInteger)
                    .filter(id -> id > 0)
                    .toList();

            boolean available = reservationService.isReservationAvailable(runtimeId, selectedSeatIds);

            response.put("success", true);
            response.put("available", available);

            if (!available) {
                response.put("message", "선택한 좌석 중 일부가 이미 예약되었습니다.");
            }

        } catch (Exception e) {
            System.err.println("좌석 가용성 확인 오류: " + e.getMessage());
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "좌석 가용성 확인 중 오류가 발생했습니다.");
        }

        return response;
    }

    /**
     * 특정 상영관의 모든 좌석 조회 (관리자용)
     */
    @GetMapping("/room/{roomId}")
    @ResponseBody
    public Map<String, Object> getSeatsByRoom(@PathVariable int roomId) {
        Map<String, Object> response = new HashMap<>();

        try {
            List<SeatVO> seats = seatService.getSeatsByRoom(roomId);

            response.put("success", true);
            response.put("seats", seats);
            response.put("totalSeats", seats.size());

        } catch (Exception e) {
            System.err.println("상영관 좌석 조회 오류: " + e.getMessage());
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "좌석 정보를 불러오는 중 오류가 발생했습니다.");
        }

        return response;
    }

    /**
     * 좌석 상태 새로고침 (AJAX)
     */
    @GetMapping("/{runtimeId}/refresh")
    @ResponseBody
    public Map<String, Object> refreshSeatStatus(@PathVariable int runtimeId) {
        Map<String, Object> response = new HashMap<>();

        try {
            System.out.println("🔄 좌석 상태 새로고침 - Runtime ID: " + runtimeId);

            // 예약된 좌석 ID 목록 조회
            List<Integer> reservedSeatIds = seatService.getReservedSeats(runtimeId);

            response.put("success", true);
            response.put("reservedSeats", reservedSeatIds);
            response.put("timestamp", System.currentTimeMillis());

            System.out.println("✅ 좌석 상태 새로고침 완료 - 예약된 좌석: " + reservedSeatIds.size() + "개");

        } catch (Exception e) {
            System.err.println("❌ 좌석 상태 새로고침 오류: " + e.getMessage());
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "좌석 상태를 새로고침하는 중 오류가 발생했습니다.");
        }

        return response;
    }

    /**
     * 디버깅용 좌석 정보 조회
     */
    @GetMapping("/debug/{runtimeId}")
    @ResponseBody
    public Map<String, Object> debugSeatInfo(@PathVariable int runtimeId) {
        Map<String, Object> response = new HashMap<>();

        try {
            RuntimeVO runtime = runtimeService.getRuntimeById(runtimeId);
            List<SeatVO> allSeats = seatService.getSeatsByRoom(runtime.getRoom_id());
            List<Integer> reservedSeatIds = seatService.getReservedSeats(runtimeId);

            response.put("success", true);
            response.put("runtime", runtime);
            response.put("totalSeats", allSeats.size());
            response.put("reservedSeats", reservedSeatIds);
            response.put("availableSeats", allSeats.size() - reservedSeatIds.size());

            System.out.println("🐛 디버깅 정보:");
            System.out.println("   - 상영시간: " + runtime.getMovie_title() + " " + runtime.getStart_time());
            System.out.println("   - 전체 좌석: " + allSeats.size());
            System.out.println("   - 예약 좌석: " + reservedSeatIds.size());
            System.out.println("   - 사용 가능: " + (allSeats.size() - reservedSeatIds.size()));

        } catch (Exception e) {
            System.err.println("❌ 디버깅 정보 조회 오류: " + e.getMessage());
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "디버깅 정보 조회 중 오류가 발생했습니다.");
        }

        return response;
    }
}