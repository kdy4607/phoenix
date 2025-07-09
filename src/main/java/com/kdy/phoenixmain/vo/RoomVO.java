package com.kdy.phoenixmain.vo;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class RoomVO {
    private int room_id;
    private String room_name;
    private int total_seats;
}
