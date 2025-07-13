package com.kdy.phoenixmain.service;


import com.kdy.phoenixmain.mapper.RuntimeMapper;
import com.kdy.phoenixmain.vo.RuntimeVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;


import java.util.List;

@Service
public class ScheduleService {

    @Autowired
    private RuntimeMapper runtimeMapper;

    // 특정 날짜의 상영시간 조회

//    public List<RuntimeVO> getRuntimesByDate(Date date) {
//        return runtimeMapper.getRuntimesByDate(date);
//    }

    // 현재부터 7일간의 상영시간 조회

//    public List<RuntimeVO> getUpcomingRuntimes() {
//        return runtimeMapper.getUpcomingRuntimes();
//    }

    // 영화별로 그룹화된 상영시간 조회

    public Map<String, List<RuntimeVO>> getRuntimesGroupedByMovie(Date date) {
        List<RuntimeVO> runtimes = runtimeMapper.getRuntimesByDate(date);

        return runtimes.stream()
                .collect(Collectors.groupingBy(
                        RuntimeVO::getMovie_title,
                        LinkedHashMap::new,
                        Collectors.toList()
                ));
    }

    // 특정 영화의 특정 날짜 상영시간 조회

    public List<RuntimeVO> getRuntimesByMovieAndDate(int movieId, Date date) {
        return runtimeMapper.getRuntimesByMovieAndDate(movieId, date);
    }

    // 특정 상영시간 정보 조회

    public RuntimeVO getRuntimeById(int runtimeId) {
        return runtimeMapper.getRuntimeById(runtimeId);
    }

    // 현재 상영 중인 영화 목록 조회

    public List<RuntimeVO> getCurrentMovies() {
        return runtimeMapper.getCurrentMovies();
    }

    // 다음 7일간의 날짜 목록 생성

    public List<Map<String, Object>> getNext7Days() {
        List<Map<String, Object>> dates = new ArrayList<>();
        Calendar cal = Calendar.getInstance();

        String[] dayNames = {"일", "월", "화", "수", "목", "금", "토"};

        for (int i = 0; i < 7; i++) {
            Map<String, Object> dateInfo = new HashMap<>();

            if (i == 0) {
                dateInfo.put("dayName", "오늘");
            } else if (i == 1) {
                dateInfo.put("dayName", "내일");
            } else {
                dateInfo.put("dayName", dayNames[cal.get(Calendar.DAY_OF_WEEK) - 1]);
            }

            dateInfo.put("dayNumber", cal.get(Calendar.DAY_OF_MONTH));
            dateInfo.put("fullDate", new Date(cal.getTimeInMillis()));
            dateInfo.put("dateString", String.format("%04d-%02d-%02d",
                    cal.get(Calendar.YEAR),
                    cal.get(Calendar.MONTH) + 1,
                    cal.get(Calendar.DAY_OF_MONTH)));

            dates.add(dateInfo);
            cal.add(Calendar.DAY_OF_MONTH, 1);
        }

        return dates;
    }

    // 좌석 수 업데이트

    public boolean updateAvailableSeats(int runtimeId, int availableSeats) {
        return runtimeMapper.updateAvailableSeats(runtimeId, availableSeats) > 0;
    }

    // 상영시간이 매진인지 확인

    public boolean isSoldOut(RuntimeVO runtime) {
        return runtime.getAvailable_seats() <= 0;
    }

    //상영시간별 매진 상태 체크

    public Map<Integer, Boolean> getSoldOutStatus(List<RuntimeVO> runtimes) {
        return runtimes.stream()
                .collect(Collectors.toMap(
                        RuntimeVO::getRuntime_id,
                        this::isSoldOut
                ));
    }

}
