package com.kdy.phoenixmain.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.util.Date;

@NoArgsConstructor
@AllArgsConstructor
@ToString
@Data
public class ReservationVO {
    // 기본 예약 정보
    private int reservation_id;
    private String u_id;              // INT에서 VARCHAR2(20)로 변경
    private int runtime_id;
    private int adult;
    private int youth;
    private int child;
    private int total_amount;
    private String reservation_status;
    private Date reserved_at;

    // 조인된 정보 (뷰나 조인 쿼리에서 사용)
    private String movie_title;       // 영화 제목
    private String room_name;         // 상영관 이름
    private Date run_date;            // 상영 날짜
    private String start_time;        // 상영 시작 시간
    private String selected_seats;    // 선택된 좌석 정보 (예: "A1, A2, A3")
    private Date reservation_date;    // 예약 날짜 (reserved_at와 동일)

    // 통계용 필드들
    private int total_reservations;   // 총 예약 수
    private int completed_reservations; // 완료된 예약 수
    private int cancelled_reservations; // 취소된 예약 수
    private int total_revenue;        // 총 수익


    // 총 관람 인원 계산
    public int getTotalPeople() {
        return adult + youth + child;
    }

    // 예약 상태 확인 메서드
    public boolean isCompleted() {
        return "예약완료".equals(reservation_status);
    }

    public boolean isCancelled() {
        return "예약취소".equals(reservation_status);
    }

    // 예약 날짜 설정 (reserved_at과 동기화)
    public void setReserved_at(Date reserved_at) {
        this.reserved_at = reserved_at;
        this.reservation_date = reserved_at;
    }

    // 예약 날짜 가져오기 (reserved_at과 동기화)
    public Date getReservation_date() {
        return reserved_at != null ? reserved_at : reservation_date;
    }
}