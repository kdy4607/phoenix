package com.kdy.phoenixmain.vo;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@NoArgsConstructor
@AllArgsConstructor
public class ReservationSeatVO {
    private int reservation_seat_id;
    private int reservation_id;
    private int seat_id;

    // 조인용 필드들
    private String seat_row;
    private int seat_number;
    private String seat_label;
}
