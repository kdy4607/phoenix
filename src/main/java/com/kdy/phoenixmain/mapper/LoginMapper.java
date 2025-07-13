package com.kdy.phoenixmain.mapper;

import com.kdy.phoenixmain.vo.LoginVO;
import org.apache.ibatis.annotations.*;

import java.util.Date;
import java.util.List;

@Mapper
public interface LoginMapper {

    /**
     * 로그인 (ID와 비밀번호로 사용자 조회)
     */
    @Select("""
        SELECT u_id, u_pw, u_name, u_birth, u_address
        FROM USERS
        WHERE u_id = #{u_id} AND u_pw = #{u_pw}
    """)
    @Results({
            @Result(property = "u_id", column = "u_id"),
            @Result(property = "u_pw", column = "u_pw"),
            @Result(property = "u_name", column = "u_name"),
            @Result(property = "u_birth", column = "u_birth"),
            @Result(property = "u_address", column = "u_address")
    })
    LoginVO findByIdAndPassword(@Param("u_id") String u_id, @Param("u_pw") String u_pw);

    /**
     * 사용자 정보 조회 (ID로)
     */
    @Select("""
        SELECT u_id, u_pw, u_name, u_birth, u_address
        FROM USERS
        WHERE u_id = #{u_id}
    """)
    @Results({
            @Result(property = "u_id", column = "u_id"),
            @Result(property = "u_pw", column = "u_pw"),
            @Result(property = "u_name", column = "u_name"),
            @Result(property = "u_birth", column = "u_birth"),
            @Result(property = "u_address", column = "u_address")
    })
    LoginVO findById(@Param("u_id") String u_id);

    /**
     * 회원 가입
     */
    @Insert("INSERT INTO USERS VALUES (#{u_id}, #{u_pw}, #{u_name}, #{u_birth, jdbcType=DATE}, #{u_address, jdbcType=VARCHAR})")
    int insertLogin(LoginVO loginVO);

    /**
     * 회원 정보 수정
     */
    @Update("""
        UPDATE USERS
        SET u_pw = #{u_pw},
            u_name = #{u_name},
            u_birth = #{u_birth, jdbcType=DATE},
            u_address = #{u_address, jdbcType=VARCHAR}
        WHERE u_id = #{u_id}
    """)
    int updateLogin(LoginVO loginVO);

    /**
     * 회원 삭제
     */
    @Delete("DELETE FROM USERS WHERE u_id = #{u_id}")
    int deleteLogin(@Param("u_id") String u_id);

    /**
     * 비밀번호 변경
     */
    @Update("""
        UPDATE USERS
        SET u_pw = #{newPassword}
        WHERE u_id = #{u_id}
    """)
    int updatePassword(@Param("u_id") String u_id, @Param("newPassword") String newPassword);

    /**
     * 모든 사용자 조회 (관리자용)
     */
    @Select("""
        SELECT u_id, u_pw, u_name, u_birth, u_address
        FROM USERS
        ORDER BY u_id
    """)
    @Results({
            @Result(property = "u_id", column = "u_id"),
            @Result(property = "u_pw", column = "u_pw"),
            @Result(property = "u_name", column = "u_name"),
            @Result(property = "u_birth", column = "u_birth"),
            @Result(property = "u_address", column = "u_address")
    })
    List<LoginVO> getAllUsers();

    /**
     * 사용자 수 조회
     */
    @Select("SELECT COUNT(*) FROM USERS")
    int getUserCount();

    /**
     * 아이디 중복 확인
     */
    @Select("SELECT COUNT(*) FROM USERS WHERE u_id = #{u_id}")
    int countById(@Param("u_id") String u_id);

    /**
     * 사용자 존재 여부 확인
     */
    @Select("SELECT COUNT(*) > 0 FROM USERS WHERE u_id = #{u_id}")
    boolean existsById(@Param("u_id") String u_id);

    // ===== 기존 메서드들 (하위 호환성을 위해 유지) =====

    /**
     * 삭제 (기존 메서드명)
     */
    @Delete("DELETE FROM USERS WHERE u_id = #{u_id}")
    int deleteLoginByID(String u_id);

    /**
     * 수정 (기존 메서드명)
     */
    @Update("UPDATE USERS SET u_pw= #{u_pw}, u_name = #{u_name}, u_birth = #{u_birth, jdbcType=DATE}, u_address = #{u_address, jdbcType=VARCHAR} WHERE u_id = #{u_id}")
    int updateLoginByID(LoginVO loginVO);
}