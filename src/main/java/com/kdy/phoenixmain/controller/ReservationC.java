package com.kdy.phoenixmain.controller;

import com.kdy.phoenixmain.service.ReservationService;
import com.kdy.phoenixmain.vo.ReservationVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/reservation")
public class ReservationC {

    @Autowired
    private ReservationService reservationService;

    /**
     * 예약 내역 페이지
     */
    @GetMapping("/list")
    public String reservationList(Model model) {
        try {
            // 임시 사용자 ID (실제 구현에서는 세션에서 가져와야 함)
            int userId = 1;

            // 사용자 예약 목록 조회
            List<ReservationVO> reservations = reservationService.getUserReservations(userId);

            // 예약 통계 조회
            ReservationVO stats = reservationService.getReservationStats(userId);

            model.addAttribute("reservations", reservations);
            model.addAttribute("stats", stats);

            return "reservation/list";

        } catch (Exception e) {
            System.err.println("예약 내역 조회 오류: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("error", "예약 내역을 불러오는 중 오류가 발생했습니다.");
            return "reservation/list";
        }
    }

    /**
     * 예약 상세 정보 조회 (AJAX)
     */
    @GetMapping("/{reservationId}")
    @ResponseBody
    public Map<String, Object> getReservationDetail(@PathVariable int reservationId) {
        Map<String, Object> response = new HashMap<>();

        try {
            ReservationVO reservation = reservationService.getReservationDetail(reservationId);

            if (reservation == null) {
                response.put("success", false);
                response.put("message", "예약 정보를 찾을 수 없습니다.");
                return response;
            }

            response.put("success", true);
            response.put("reservation", reservation);

        } catch (Exception e) {
            System.err.println("예약 상세 조회 오류: " + e.getMessage());
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "예약 정보를 불러오는 중 오류가 발생했습니다.");
        }

        return response;
    }

    /**
     * 예약 취소 (AJAX)
     */
    @PostMapping("/{reservationId}/cancel")
    @ResponseBody
    public Map<String, Object> cancelReservation(@PathVariable int reservationId) {
        Map<String, Object> response = new HashMap<>();

        try {
            // 임시 사용자 ID (실제 구현에서는 세션에서 가져와야 함)
            int userId = 1;

            boolean success = reservationService.cancelReservation(reservationId, userId);

            if (success) {
                response.put("success", true);
                response.put("message", "예약이 취소되었습니다.");
            } else {
                response.put("success", false);
                response.put("message", "예약 취소에 실패했습니다.");
            }

        } catch (Exception e) {
            System.err.println("예약 취소 오류: " + e.getMessage());
            e.printStackTrace();
            response.put("success", false);
            response.put("message", e.getMessage());
        }

        return response;
    }

    /**
     * 예약 가능 여부 확인 (AJAX)
     */
    @PostMapping("/check")
    @ResponseBody
    public Map<String, Object> checkReservationAvailability(@RequestBody Map<String, Object> request) {
        Map<String, Object> response = new HashMap<>();

        try {
            int runtimeId = Integer.parseInt(request.get("runtimeId").toString());
            @SuppressWarnings("unchecked")
            List<Integer> seatIds = (List<Integer>) request.get("seatIds");

            boolean isAvailable = reservationService.isReservationAvailable(runtimeId, seatIds);

            response.put("success", true);
            response.put("available", isAvailable);

            if (!isAvailable) {
                response.put("message", "선택한 좌석 중 이미 예약된 좌석이 있습니다.");
            }

        } catch (Exception e) {
            System.err.println("예약 가능 여부 확인 오류: " + e.getMessage());
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "예약 가능 여부를 확인하는 중 오류가 발생했습니다.");
        }

        return response;
    }
}