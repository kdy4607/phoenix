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
public class LoginVO {
    private String u_id;        // INT에서 VARCHAR2(20)로 변경
    private String u_pw;        // VARCHAR2(100)
    private String u_name;      // VARCHAR2(50)
    private Date u_birth;       // DATE
    private String u_address;   // VARCHAR2(500)
}