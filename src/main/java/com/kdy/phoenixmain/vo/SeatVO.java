package com.kdy.phoenixmain.vo;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class SeatVO {
    private int seat_id;
    private int room_id;
    private String seat_row;
    private int seat_number;
    private String status;
}
