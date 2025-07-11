package com.kdy.phoenixmain.controller;

import com.kdy.phoenixmain.service.ReservationService;
import com.kdy.phoenixmain.vo.LoginVO;
import com.kdy.phoenixmain.vo.ReservationVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/reservation")
public class ReservationC {

    @Autowired
    private ReservationService reservationService;

    /**
     * 예약 내역 페이지 - 로그인 사용자별 예약 목록 표시
     */
    @GetMapping("/list")
    public String reservationList(Model model, HttpSession session) {
        try {
            // 세션에서 로그인 사용자 정보 확인
            LoginVO user = (LoginVO) session.getAttribute("user");

            if (user == null) {
                // 로그인하지 않은 경우 로그인 페이지로 리다이렉트
                model.addAttribute("message", "예약 내역을 확인하려면 로그인이 필요합니다.");
                return "redirect:/login?returnUrl=/reservation/list";
            }

            // 로그인한 사용자의 ID로 예약 목록 조회
            String userId = user.getU_id();
            System.out.println("🔍 사용자별 예약 조회 - 사용자: " + user.getU_name() + " (ID: " + userId + ")");

            // 사용자 예약 목록 조회
            List<ReservationVO> reservations = reservationService.getUserReservations(userId);

            // 예약 통계 조회
            ReservationVO stats = reservationService.getReservationStats(userId);

            // 로그인 사용자 정보와 예약 정보를 모델에 추가
            model.addAttribute("user", user);
            model.addAttribute("reservations", reservations);
            model.addAttribute("stats", stats);

            System.out.println("✅ 예약 목록 조회 완료 - " + reservations.size() + "건");

            return "reservation/list";

        } catch (Exception e) {
            System.err.println("❌ 예약 내역 조회 오류: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("error", "예약 내역을 불러오는 중 오류가 발생했습니다.");
            return "reservation/list";
        }
    }

    /**
     * 예약 상세 정보 조회 (AJAX) - 본인 예약만 조회 가능
     */
    @GetMapping("/{reservationId}")
    @ResponseBody
    public Map<String, Object> getReservationDetail(@PathVariable int reservationId, HttpSession session) {
        Map<String, Object> response = new HashMap<>();

        try {
            // 로그인 확인
            LoginVO user = (LoginVO) session.getAttribute("user");
            if (user == null) {
                response.put("success", false);
                response.put("message", "로그인이 필요합니다.");
                return response;
            }

            System.out.println("🌐 REST API 호출 - 예약 ID: " + reservationId + ", 사용자: " + user.getU_name());

            ReservationVO reservation = reservationService.getReservationDetail(reservationId);

            if (reservation == null) {
                System.err.println("❌ 예약 정보 없음 - ID: " + reservationId);
                response.put("success", false);
                response.put("message", "예약 정보를 찾을 수 없습니다.");
                return response;
            }

            // 본인의 예약인지 확인
            if (!reservation.getU_id().equals(user.getU_id())) {
                System.err.println("❌ 권한 없음 - 예약 ID: " + reservationId + ", 사용자 ID: " + user.getU_id());
                response.put("success", false);
                response.put("message", "본인의 예약만 조회할 수 있습니다.");
                return response;
            }

            // 응답 데이터 구성
            response.put("success", true);
            response.put("reservation", reservation);

            // 디버깅을 위한 추가 정보
            response.put("debug", Map.of(
                    "reservationId", reservation.getReservation_id(),
                    "movieTitle", reservation.getMovie_title() != null ? reservation.getMovie_title() : "NULL",
                    "roomName", reservation.getRoom_name() != null ? reservation.getRoom_name() : "NULL",
                    "runDate", reservation.getRun_date() != null ? reservation.getRun_date().toString() : "NULL",
                    "startTime", reservation.getStart_time() != null ? reservation.getStart_time() : "NULL",
                    "selectedSeats", reservation.getSelected_seats() != null ? reservation.getSelected_seats() : "NULL",
                    "totalAmount", reservation.getTotal_amount(),
                    "status", reservation.getReservation_status() != null ? reservation.getReservation_status() : "NULL"
            ));

            System.out.println("✅ 예약 상세 조회 성공 - ID: " + reservationId);

        } catch (Exception e) {
            System.err.println("❌ 예약 상세 조회 오류: " + e.getMessage());
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "예약 정보 조회 중 오류가 발생했습니다: " + e.getMessage());
        }

        return response;
    }

    /**
     * 예약 취소 (AJAX) - 본인 예약만 취소 가능
     */
    @PostMapping("/{reservationId}/cancel")
    @ResponseBody
    public Map<String, Object> cancelReservation(@PathVariable int reservationId, HttpSession session) {
        Map<String, Object> response = new HashMap<>();

        try {
            // 로그인 확인
            LoginVO user = (LoginVO) session.getAttribute("user");
            if (user == null) {
                response.put("success", false);
                response.put("message", "로그인이 필요합니다.");
                return response;
            }

            System.out.println("🗑️ 예약 취소 요청 - 예약 ID: " + reservationId + ", 사용자: " + user.getU_name());

            // 예약 취소 처리
            boolean success = reservationService.cancelReservation(reservationId, user.getU_id());

            if (success) {
                response.put("success", true);
                response.put("message", "예약이 성공적으로 취소되었습니다.");
                System.out.println("✅ 예약 취소 완료 - ID: " + reservationId);
            } else {
                response.put("success", false);
                response.put("message", "예약 취소에 실패했습니다.");
                System.err.println("❌ 예약 취소 실패 - ID: " + reservationId);
            }

        } catch (Exception e) {
            System.err.println("❌ 예약 취소 오류: " + e.getMessage());
            e.printStackTrace();
            response.put("success", false);
            response.put("message", e.getMessage());
        }

        return response;
    }

    /**
     * 사용자 예약 통계 조회 (AJAX)
     */
    @GetMapping("/stats")
    @ResponseBody
    public Map<String, Object> getReservationStats(HttpSession session) {
        Map<String, Object> response = new HashMap<>();

        try {
            // 로그인 확인
            LoginVO user = (LoginVO) session.getAttribute("user");
            if (user == null) {
                response.put("success", false);
                response.put("message", "로그인이 필요합니다.");
                return response;
            }

            System.out.println("📊 예약 통계 조회 - 사용자: " + user.getU_name());

            // 예약 통계 조회
            ReservationVO stats = reservationService.getReservationStats(user.getU_id());

            response.put("success", true);
            response.put("stats", stats);
            response.put("userName", user.getU_name());

            System.out.println("✅ 예약 통계 조회 완료");

        } catch (Exception e) {
            System.err.println("❌ 예약 통계 조회 오류: " + e.getMessage());
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "통계 정보 조회 중 오류가 발생했습니다: " + e.getMessage());
        }

        return response;
    }

    /**
     * 디버깅용 예약 정보 확인 (개발 중에만 사용)
     */
    @GetMapping("/debug/check")
    @ResponseBody
    public Map<String, Object> debugReservationInfo(@RequestParam(required = false) Integer reservationId,
                                                    HttpSession session) {
        Map<String, Object> response = new HashMap<>();

        try {
            // 로그인 확인
            LoginVO user = (LoginVO) session.getAttribute("user");
            if (user == null) {
                response.put("success", false);
                response.put("message", "로그인이 필요합니다.");
                return response;
            }

            System.out.println("🔧 디버깅 정보 조회 - 사용자: " + user.getU_name());

            if (reservationId != null) {
                // 특정 예약 디버깅
                ReservationVO reservation = reservationService.getReservationDetail(reservationId);
                if (reservation != null && reservation.getU_id().equals(user.getU_id())) {
                    response.put("success", true);
                    response.put("type", "single");
                    response.put("reservation", reservation);
                } else {
                    response.put("success", false);
                    response.put("message", "예약 정보를 찾을 수 없거나 접근 권한이 없습니다.");
                }
            } else {
                // 사용자 전체 예약 디버깅
                List<ReservationVO> reservations = reservationService.getUserReservations(user.getU_id());
                ReservationVO stats = reservationService.getReservationStats(user.getU_id());

                response.put("success", true);
                response.put("type", "list");
                response.put("reservations", reservations);
                response.put("stats", stats);
                response.put("count", reservations.size());
            }

            response.put("user", Map.of(
                    "id", user.getU_id(),
                    "name", user.getU_name(),
                    "loginId", user.getU_id()
            ));

        } catch (Exception e) {
            System.err.println("❌ 디버깅 정보 조회 오류: " + e.getMessage());
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "디버깅 정보 조회 중 오류가 발생했습니다: " + e.getMessage());
        }

        return response;
    }
}