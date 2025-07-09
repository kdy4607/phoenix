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
    public String schedule(Model model, @RequestParam(value = "selected", required = false) Integer selectedRuntimeId) {
        try {
            System.out.println("=== Schedule 페이지 접근 ===");

            // 오늘 날짜 기준으로 상영시간 조회
            Date today = new Date();
            System.out.println("오늘 날짜: " + today);

            // 다음 7일간의 날짜 목록
            List<Map<String, Object>> dates = scheduleService.getNext7Days();
            System.out.println("날짜 목록 생성 완료: " + dates.size() + "개");

            // 오늘의 영화별 상영시간 조회
            Map<String, List<RuntimeVO>> movieRuntimes = scheduleService.getRuntimesGroupedByMovie(today);
            System.out.println("영화별 상영시간 조회 완료: " + movieRuntimes.size() + "개 영화");

            // 매진 상태 체크
            List<RuntimeVO> allRuntimes = new ArrayList<>();
            movieRuntimes.values().forEach(allRuntimes::addAll);
            Map<Integer, Boolean> soldOutStatus = scheduleService.getSoldOutStatus(allRuntimes);
            System.out.println("전체 상영시간: " + allRuntimes.size() + "건");

            model.addAttribute("dates", dates);
            model.addAttribute("movieRuntimes", movieRuntimes);
            model.addAttribute("soldOutStatus", soldOutStatus);
            model.addAttribute("selectedDate", today);

            // 선택된 상영시간이 있는 경우 정보 추가
            if (selectedRuntimeId != null) {
                try {
                    RuntimeVO selectedRuntime = scheduleService.getRuntimeById(selectedRuntimeId);
                    if (selectedRuntime != null) {
                        model.addAttribute("selectedRuntime", selectedRuntime);
                        model.addAttribute("message", "상영시간이 선택되었습니다: " +
                                selectedRuntime.getMovie_title() + " " + selectedRuntime.getStart_time());
                    }
                } catch (Exception e) {
                    System.err.println("선택된 상영시간 조회 오류: " + e.getMessage());
                }
            }

            System.out.println("=== Schedule 페이지 로딩 완료 ===");
            return "schedule/schedule";

        } catch (Exception e) {
            System.err.println("=== Schedule 페이지 오류 ===");
            System.err.println("오류 메시지: " + e.getMessage());
            e.printStackTrace();

            model.addAttribute("error", "상영시간 정보를 불러오는 중 오류가 발생했습니다. 관리자에게 문의하세요.");
            model.addAttribute("errorDetails", e.getMessage());
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
            System.out.println("날짜별 상영시간 조회: " + dateString);

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

            System.out.println("날짜 " + dateString + " 상영시간 조회 완료: " + allRuntimes.size() + "건");

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
            System.out.println("상영시간 정보 조회: " + runtimeId);
            RuntimeVO runtime = scheduleService.getRuntimeById(runtimeId);
            if (runtime != null) {
                System.out.println("상영시간 정보 조회 완료: " + runtime.getMovie_title());
            } else {
                System.out.println("상영시간 정보를 찾을 수 없음: " + runtimeId);
            }
            return runtime;
        } catch (Exception e) {
            System.err.println("Runtime 정보 조회 오류: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    /**
     * 상영시간 선택 후 좌석 선택 페이지로 이동
     */
    @PostMapping("/schedule/select")
    public String selectShowtime(@RequestParam int runtimeId, Model model) {
        try {
            System.out.println("상영시간 선택: " + runtimeId);

            RuntimeVO runtime = scheduleService.getRuntimeById(runtimeId);

            if (runtime == null) {
                System.err.println("상영시간 정보를 찾을 수 없음: " + runtimeId);
                model.addAttribute("error", "상영시간 정보를 찾을 수 없습니다.");
                return "redirect:/schedule";
            }

            if (scheduleService.isSoldOut(runtime)) {
                System.err.println("매진된 상영시간 선택 시도: " + runtimeId);
                model.addAttribute("error", "선택하신 상영시간은 매진되었습니다.");
                return "redirect:/schedule";
            }

            model.addAttribute("selectedRuntime", runtime);
            System.out.println("상영시간 선택 완료: " + runtime.getMovie_title() + " " + runtime.getStart_time());

            // 다음 단계 (좌석 선택) 페이지로 이동
            // 현재는 스케줄 페이지로 리다이렉트 (추후 좌석 선택 페이지 구현 시 변경)
            return "redirect:/schedule?selected=" + runtimeId;

        } catch (Exception e) {
            System.err.println("상영시간 선택 오류: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("error", "상영시간 선택 중 오류가 발생했습니다: " + e.getMessage());
            return "redirect:/schedule";
        }
    }

    /**
     * 현재 상영 중인 영화 목록 조회 (AJAX)
     */
    @GetMapping("/schedule/movies")
    @ResponseBody
    public List<RuntimeVO> getCurrentMovies() {
        try {
            System.out.println("현재 상영 영화 목록 조회");
            List<RuntimeVO> movies = scheduleService.getCurrentMovies();
            System.out.println("현재 상영 영화 수: " + movies.size());
            return movies;
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
            System.out.println("영화별 상영시간 조회: 영화ID=" + movieId + ", 날짜=" + dateString);

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Date selectedDate = sdf.parse(dateString);

            List<RuntimeVO> runtimes = scheduleService.getRuntimesByMovieAndDate(movieId, selectedDate);
            System.out.println("영화별 상영시간 조회 완료: " + runtimes.size() + "건");
            return runtimes;

        } catch (ParseException e) {
            System.err.println("영화 상영시간 조회 - 날짜 파싱 오류: " + e.getMessage());
            return new ArrayList<>();
        } catch (Exception e) {
            System.err.println("영화 상영시간 조회 오류: " + e.getMessage());
            e.printStackTrace();
            return new ArrayList<>();
        }
    }
}