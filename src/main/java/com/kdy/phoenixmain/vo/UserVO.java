package com.kdy.phoenixmain.vo;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class UserVO {
    private String u_id;
    private String u_pw;
    private String u_name;
    private Date u_birth;
    private String u_address;
}
