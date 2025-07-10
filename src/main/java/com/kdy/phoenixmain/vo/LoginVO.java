package com.kdy.phoenixmain.vo;

import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

//@NoArgsConstructor
//@AllArgsConstructor
//@Getter
//@Setter
@Data // = getter, setter
public class LoginVO {
    private String u_id;        // batis 를 통한 DB 자동 연결을 위해 테이블 컬럼과 일치 하도록 설정
    private String u_pw;
    private String u_name;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date u_birth;

    private String u_address;
}

// Data = View 에서 전달 받은 param 을  자동 으로 기본 생성자 에 setter를 통해 값을 세팅해 줌.
