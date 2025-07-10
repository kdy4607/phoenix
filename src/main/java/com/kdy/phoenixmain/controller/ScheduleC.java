package com.kdy.phoenixmain.controller;

import com.kdy.phoenixmain.service.ScheduleService;
import com.kdy.phoenixmain.vo.RuntimeVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
public class ScheduleC {

    @Autowired
    private ScheduleService scheduleService;

    /**
     * 스케줄 메인 페이지
     */
    @GetMapping("/schedule")
    public String schedule(Model model) {
        try {
            // 오늘 날짜 기준으로 상영시간 조회
            Date today = new Date();

            // 다음 7일간의 날짜 목록
            List<Map<String, Object>> dates = scheduleService.getNext7Days();

            // 오늘의 영화별 상영시간 조회
            Map<String, List<RuntimeVO>> movieRuntimes = scheduleService.getRuntimesGroupedByMovie(today);

            // 매진 상태 체크
            List<RuntimeVO> allRuntimes = new ArrayList<>();
            movieRuntimes.values().forEach(allRuntimes::addAll);
            Map<Integer, Boolean> soldOutStatus = scheduleService.getSoldOutStatus(allRuntimes);

            model.addAttribute("dates", dates);
            model.addAttribute("movieRuntimes", movieRuntimes);
            model.addAttribute("soldOutStatus", soldOutStatus);
            model.addAttribute("selectedDate", today);

            // 디버깅 정보 추가
            System.out.println("날짜 목록 수: " + dates.size());
            System.out.println("영화 수: " + movieRuntimes.size());
            System.out.println("전체 상영시간 수: " + allRuntimes.size());

            return "schedule/schedule";

        } catch (Exception e) {
            System.err.println("Schedule 페이지 오류: " + e.getMessage());
            e.printStackTrace();

            model.addAttribute("error", "상영시간 정보를 불러오는 중 오류가 발생했습니다: " + e.getMessage());
            model.addAttribute("dates", new ArrayList<>());
            model.addAttribute("movieRuntimes", new HashMap<>());
            model.addAttribute("soldOutStatus", new HashMap<>());

            return "schedule/schedule";
        }
    }

    /**
     * 특정 날짜의 상영시간 조회 (AJAX)
     */
    @GetMapping("/schedule/date/{dateString}")
    @ResponseBody
    public Map<String, Object> getScheduleByDate(@PathVariable String dateString) {
        Map<String, Object> response = new HashMap<>();

        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date selectedDate = sdf.parse(dateString);

            // 선택된 날짜의 영화별 상영시간 조회
            Map<String, List<RuntimeVO>> movieRuntimes = scheduleService.getRuntimesGroupedByMovie(selectedDate);

            // 매진 상태 체크
            List<RuntimeVO> allRuntimes = new ArrayList<>();
            movieRuntimes.values().forEach(allRuntimes::addAll);
            Map<Integer, Boolean> soldOutStatus = scheduleService.getSoldOutStatus(allRuntimes);

            response.put("movieRuntimes", movieRuntimes);
            response.put("soldOutStatus", soldOutStatus);
            response.put("success", true);

            System.out.println("날짜 " + dateString + "의 상영시간 조회 완료: " + allRuntimes.size() + "건");

        } catch (ParseException e) {
            System.err.println("날짜 파싱 오류: " + e.getMessage());
            response.put("success", false);
            response.put("message", "잘못된 날짜 형식입니다: " + dateString);
        } catch (Exception e) {
            System.err.println("상영시간 조회 오류: " + e.getMessage());
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "상영시간 조회 중 오류가 발생했습니다: " + e.getMessage());
        }

        return response;
    }

    /**
     * 특정 상영시간 정보 조회 (AJAX)
     */
    @GetMapping("/schedule/runtime/{runtimeId}")
    @ResponseBody
    public RuntimeVO getRuntimeInfo(@PathVariable int runtimeId) {
        try {
            return scheduleService.getRuntimeById(runtimeId);
        } catch (Exception e) {
            System.err.println("Runtime 정보 조회 오류: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    /**
     * 현재 상영 중인 영화 목록 조회 (AJAX)
     */
    @GetMapping("/schedule/movies")
    @ResponseBody
    public List<RuntimeVO> getCurrentMovies() {
        try {
            return scheduleService.getCurrentMovies();
        } catch (Exception e) {
            System.err.println("현재 상영 영화 조회 오류: " + e.getMessage());
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    /**
     * 특정 영화의 상영시간 조회 (AJAX)
     */
    @GetMapping("/schedule/movie/{movieId}/date/{dateString}")
    @ResponseBody
    public List<RuntimeVO> getMovieRuntimes(@PathVariable int movieId, @PathVariable String dateString) {
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date selectedDate = sdf.parse(dateString);

            return scheduleService.getRuntimesByMovieAndDate(movieId, selectedDate);

        } catch (ParseException e) {
            System.err.println("영화 상영시간 조회 - 날짜 파싱 오류: " + e.getMessage());
            return new ArrayList<>();
        } catch (Exception e) {
            System.err.println("영화 상영시간 조회 오류: " + e.getMessage());
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    /**
     * 예약 프로세스 시작 (좌석 선택 후)
     */
    @PostMapping("/schedule/booking")
    @ResponseBody
    public Map<String, Object> startBookingProcess(@RequestBody Map<String, Object> request) {
        Map<String, Object> response = new HashMap<>();

        try {
            int runtimeId = (Integer) request.get("runtimeId");
            @SuppressWarnings("unchecked")
            List<Integer> selectedSeatIds = (List<Integer>) request.get("selectedSeatIds");

            // 예약 프로세스 시작 (여기서는 세션에 저장하거나 임시 예약 테이블에 저장)
            // 실제 구현에서는 사용자 정보, 결제 정보 등을 처리

            response.put("success", true);
            response.put("message", "예약이 시작되었습니다.");
            response.put("nextStep", "payment"); // 다음 단계 지시

            System.out.println("예약 프로세스 시작 - Runtime: " + runtimeId + ", 좌석 수: " + selectedSeatIds.size());

        } catch (Exception e) {
            System.err.println("예약 프로세스 시작 오류: " + e.getMessage());
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "예약 프로세스 시작 중 오류가 발생했습니다: " + e.getMessage());
        }

        return response;
    }
}