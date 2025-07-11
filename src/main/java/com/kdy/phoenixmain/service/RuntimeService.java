package com.kdy.phoenixmain.service;

import com.kdy.phoenixmain.mapper.RuntimeMapper;
import com.kdy.phoenixmain.vo.RuntimeVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.LinkedHashMap;

@Service
public class RuntimeService {

    @Autowired
    private RuntimeMapper runtimeMapper;

    /**
     * 특정 상영시간 ID로 상영시간 정보 조회
     */
    public RuntimeVO getRuntimeById(int runtimeId) {
        try {
            System.out.println("🎬 상영시간 조회 - ID: " + runtimeId);

            RuntimeVO runtime = runtimeMapper.getRuntimeById(runtimeId);

            if (runtime != null) {
                System.out.println("✅ 상영시간 조회 성공 - " + runtime.getMovie_title() + " " + runtime.getStart_time());
            } else {
                System.out.println("❌ 상영시간 조회 실패 - ID: " + runtimeId);
            }

            return runtime;
        } catch (Exception e) {
            System.err.println("❌ 상영시간 조회 오류: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    /**
     * 특정 날짜의 모든 상영시간 조회
     */
    public List<RuntimeVO> getRuntimesByDate(Date date) {
        try {
            System.out.println("📅 날짜별 상영시간 조회 - 날짜: " + date);

            List<RuntimeVO> runtimes = runtimeMapper.getRuntimesByDate(date);

            System.out.println("✅ 날짜별 상영시간 조회 완료 - " + runtimes.size() + "건");

            return runtimes;
        } catch (Exception e) {
            System.err.println("❌ 날짜별 상영시간 조회 오류: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("날짜별 상영시간 조회 중 오류가 발생했습니다: " + e.getMessage());
        }
    }

    /**
     * 현재부터 7일간의 상영시간 조회
     */
    public List<RuntimeVO> getUpcomingRuntimes() {
        try {
            System.out.println("🗓️ 향후 7일간 상영시간 조회 시작");

            List<RuntimeVO> runtimes = runtimeMapper.getUpcomingRuntimes();

            System.out.println("✅ 향후 7일간 상영시간 조회 완료 - " + runtimes.size() + "건");

            return runtimes;
        } catch (Exception e) {
            System.err.println("❌ 향후 상영시간 조회 오류: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("향후 상영시간 조회 중 오류가 발생했습니다: " + e.getMessage());
        }
    }

    /**
     * 특정 영화의 특정 날짜 상영시간 조회
     */
    public List<RuntimeVO> getRuntimesByMovieAndDate(int movieId, Date date) {
        try {
            System.out.println("🎭 영화별 날짜별 상영시간 조회 - 영화 ID: " + movieId + ", 날짜: " + date);

            List<RuntimeVO> runtimes = runtimeMapper.getRuntimesByMovieAndDate(movieId, date);

            System.out.println("✅ 영화별 날짜별 상영시간 조회 완료 - " + runtimes.size() + "건");

            return runtimes;
        } catch (Exception e) {
            System.err.println("❌ 영화별 날짜별 상영시간 조회 오류: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("영화별 상영시간 조회 중 오류가 발생했습니다: " + e.getMessage());
        }
    }

    /**
     * 현재 상영 중인 영화 목록 조회
     */
    public List<RuntimeVO> getCurrentMovies() {
        try {
            System.out.println("🎬 현재 상영 중인 영화 조회 시작");

            List<RuntimeVO> movies = runtimeMapper.getCurrentMovies();

            System.out.println("✅ 현재 상영 중인 영화 조회 완료 - " + movies.size() + "편");

            return movies;
        } catch (Exception e) {
            System.err.println("❌ 현재 상영 영화 조회 오류: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("현재 상영 영화 조회 중 오류가 발생했습니다: " + e.getMessage());
        }
    }

    /**
     * 영화별로 그룹화된 상영시간 조회
     */
    public Map<String, List<RuntimeVO>> getRuntimesGroupedByMovie(Date date) {
        try {
            System.out.println("🎭 영화별 그룹화 상영시간 조회 - 날짜: " + date);

            List<RuntimeVO> runtimes = getRuntimesByDate(date);

            Map<String, List<RuntimeVO>> groupedRuntimes = runtimes.stream()
                    .collect(Collectors.groupingBy(
                            RuntimeVO::getMovie_title,
                            LinkedHashMap::new,
                            Collectors.toList()
                    ));

            System.out.println("✅ 영화별 그룹화 완료 - " + groupedRuntimes.size() + "개 영화");

            return groupedRuntimes;
        } catch (Exception e) {
            System.err.println("❌ 영화별 그룹화 오류: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("영화별 상영시간 그룹화 중 오류가 발생했습니다: " + e.getMessage());
        }
    }

    /**
     * 상영시간 잔여 좌석 수 업데이트
     */
    public boolean updateAvailableSeats(int runtimeId, int availableSeats) {
        try {
            System.out.println("🪑 잔여 좌석 수 업데이트 - Runtime ID: " + runtimeId + ", 잔여 좌석: " + availableSeats);

            int result = runtimeMapper.updateAvailableSeats(runtimeId, availableSeats);

            if (result > 0) {
                System.out.println("✅ 잔여 좌석 수 업데이트 완료");
                return true;
            } else {
                System.out.println("❌ 잔여 좌석 수 업데이트 실패 - 대상 행 없음");
                return false;
            }
        } catch (Exception e) {
            System.err.println("❌ 잔여 좌석 수 업데이트 오류: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("잔여 좌석 수 업데이트 중 오류가 발생했습니다: " + e.getMessage());
        }
    }

    /**
     * 특정 상영시간의 예약 가능 여부 확인
     */
    public boolean isRuntimeAvailable(int runtimeId) {
        try {
            RuntimeVO runtime = getRuntimeById(runtimeId);

            if (runtime == null) {
                System.out.println("❌ 상영시간 정보 없음 - ID: " + runtimeId);
                return false;
            }

            boolean available = runtime.getAvailable_seats() > 0;
            System.out.println("🔍 상영시간 예약 가능 여부 - ID: " + runtimeId + ", 가능: " + available);

            return available;
        } catch (Exception e) {
            System.err.println("❌ 상영시간 예약 가능 여부 확인 오류: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /**
     * 특정 상영시간의 총 좌석 수 조회
     */
    public int getTotalSeats(int runtimeId) {
        try {
            RuntimeVO runtime = getRuntimeById(runtimeId);

            if (runtime == null) {
                System.out.println("❌ 상영시간 정보 없음 - ID: " + runtimeId);
                return 0;
            }

            int totalSeats = runtime.getTotal_seats();
            System.out.println("🪑 총 좌석 수 조회 - Runtime ID: " + runtimeId + ", 총 좌석: " + totalSeats);

            return totalSeats;
        } catch (Exception e) {
            System.err.println("❌ 총 좌석 수 조회 오류: " + e.getMessage());
            e.printStackTrace();
            return 0;
        }
    }

    /**
     * 특정 상영시간의 예약된 좌석 수 계산
     */
    public int getReservedSeats(int runtimeId) {
        try {
            RuntimeVO runtime = getRuntimeById(runtimeId);

            if (runtime == null) {
                System.out.println("❌ 상영시간 정보 없음 - ID: " + runtimeId);
                return 0;
            }

            int reservedSeats = runtime.getTotal_seats() - runtime.getAvailable_seats();
            System.out.println("🪑 예약된 좌석 수 계산 - Runtime ID: " + runtimeId + ", 예약 좌석: " + reservedSeats);

            return reservedSeats;
        } catch (Exception e) {
            System.err.println("❌ 예약된 좌석 수 계산 오류: " + e.getMessage());
            e.printStackTrace();
            return 0;
        }
    }

    /**
     * 상영시간 검색 (영화 제목으로)
     */
    public List<RuntimeVO> searchRuntimesByMovieTitle(String movieTitle) {
        try {
            System.out.println("🔍 영화 제목으로 상영시간 검색 - 제목: " + movieTitle);

            List<RuntimeVO> allRuntimes = getUpcomingRuntimes();

            List<RuntimeVO> filteredRuntimes = allRuntimes.stream()
                    .filter(runtime -> runtime.getMovie_title() != null &&
                            runtime.getMovie_title().toLowerCase().contains(movieTitle.toLowerCase()))
                    .collect(Collectors.toList());

            System.out.println("✅ 영화 제목 검색 완료 - " + filteredRuntimes.size() + "건");

            return filteredRuntimes;
        } catch (Exception e) {
            System.err.println("❌ 영화 제목 검색 오류: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("영화 제목 검색 중 오류가 발생했습니다: " + e.getMessage());
        }
    }

    /**
     * 특정 상영관의 상영시간 조회
     */
    public List<RuntimeVO> getRuntimesByRoom(int roomId, Date date) {
        try {
            System.out.println("🏢 상영관별 상영시간 조회 - 상영관 ID: " + roomId + ", 날짜: " + date);

            List<RuntimeVO> allRuntimes = getRuntimesByDate(date);

            List<RuntimeVO> roomRuntimes = allRuntimes.stream()
                    .filter(runtime -> runtime.getRoom_id() == roomId)
                    .collect(Collectors.toList());

            System.out.println("✅ 상영관별 상영시간 조회 완료 - " + roomRuntimes.size() + "건");

            return roomRuntimes;
        } catch (Exception e) {
            System.err.println("❌ 상영관별 상영시간 조회 오류: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("상영관별 상영시간 조회 중 오류가 발생했습니다: " + e.getMessage());
        }
    }

    /**
     * 상영시간 통계 조회
     */
    public Map<String, Object> getRuntimeStats(Date date) {
        try {
            System.out.println("📊 상영시간 통계 조회 - 날짜: " + date);

            List<RuntimeVO> runtimes = getRuntimesByDate(date);

            Map<String, Object> stats = new LinkedHashMap<>();
            stats.put("totalRuntimes", runtimes.size());
            stats.put("totalMovies", runtimes.stream().map(RuntimeVO::getMovie_title).distinct().count());
            stats.put("totalSeats", runtimes.stream().mapToInt(RuntimeVO::getTotal_seats).sum());
            stats.put("availableSeats", runtimes.stream().mapToInt(RuntimeVO::getAvailable_seats).sum());
            stats.put("reservedSeats", (Integer)stats.get("totalSeats") - (Integer)stats.get("availableSeats"));

            System.out.println("✅ 상영시간 통계 조회 완료");

            return stats;
        } catch (Exception e) {
            System.err.println("❌ 상영시간 통계 조회 오류: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("상영시간 통계 조회 중 오류가 발생했습니다: " + e.getMessage());
        }
    }

    /**
     * 상영시간 존재 여부 확인
     */
    public boolean runtimeExists(int runtimeId) {
        try {
            RuntimeVO runtime = getRuntimeById(runtimeId);
            return runtime != null;
        } catch (Exception e) {
            System.err.println("❌ 상영시간 존재 여부 확인 오류: " + e.getMessage());
            return false;
        }
    }

    /**
     * 인기 상영시간 조회 (예약률 기준)
     */
    public List<RuntimeVO> getPopularRuntimes(Date date, int limit) {
        try {
            System.out.println("🔥 인기 상영시간 조회 - 날짜: " + date + ", 제한: " + limit);

            List<RuntimeVO> runtimes = getRuntimesByDate(date);

            List<RuntimeVO> popularRuntimes = runtimes.stream()
                    .sorted((r1, r2) -> {
                        // 예약률 기준 내림차순 정렬
                        double rate1 = (double)(r1.getTotal_seats() - r1.getAvailable_seats()) / r1.getTotal_seats();
                        double rate2 = (double)(r2.getTotal_seats() - r2.getAvailable_seats()) / r2.getTotal_seats();
                        return Double.compare(rate2, rate1);
                    })
                    .limit(limit)
                    .collect(Collectors.toList());

            System.out.println("✅ 인기 상영시간 조회 완료 - " + popularRuntimes.size() + "건");

            return popularRuntimes;
        } catch (Exception e) {
            System.err.println("❌ 인기 상영시간 조회 오류: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("인기 상영시간 조회 중 오류가 발생했습니다: " + e.getMessage());
        }
    }
}