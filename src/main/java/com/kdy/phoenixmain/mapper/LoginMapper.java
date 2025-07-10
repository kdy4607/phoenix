package com.kdy.phoenixmain.mapper;

import com.kdy.phoenixmain.vo.LoginVO;
import org.apache.ibatis.annotations.*;

@Mapper
public interface LoginMapper {

    // 조회
    @Select("select * from users where u_nickname = #{u_nickname}")
    LoginVO selectLoginByNick(String nickname);

    @Select("select * from users where u_id = #{u_id}")
    LoginVO selectLoginByID(String id);

    // 삭제
    @Delete("delete users where u_id = #{u_id}")
    int deleteLoginByID(String u_id);

    // 수정
    @Update("update users set u_nickname = #{u_nickname}, u_name = #{u_name}, u_birth = #{u_birth, jdbcType=DATE}, u_address = #{u_address, jdbcType=VARCHAR} where u_id = #{u_id}")
    int updateLoginByID(LoginVO loginVO);

    // 추가
    @Insert("insert into users values (SEQ_U_ID.NEXTVAl, #{u_pw}, #{u_nickname}, #{u_name}, #{u_birth, jdbcType=DATE}, #{u_address, jdbcType=VARCHAR})")
    int insertLogin(LoginVO loginVO);

}
