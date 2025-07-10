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
    @Insert("""
        INSERT INTO USERS (u_id, u_pw, u_name, u_birth, u_address)
        VALUES (#{u_id}, #{u_pw}, #{u_name}, #{u_birth}, #{u_address})
    """)
    int insertLogin(LoginVO loginVO);

    /**
     * 회원 정보 수정
     */
    @Update("""
        UPDATE USERS
        SET u_pw = #{u_pw},
            u_name = #{u_name},
            u_birth = #{u_birth},
            u_address = #{u_address}
        WHERE u_id = #{u_id}
    """)
    int updateLogin(LoginVO loginVO);

    /**
     * 회원 삭제
     */
    @Delete("""
        DELETE FROM USERS
        WHERE u_id = #{u_id}
    """)
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
     * 사용자 이름으로 검색
     */
    @Select("""
        SELECT u_id, u_pw, u_name, u_birth, u_address
        FROM USERS
        WHERE u_name LIKE '%' || #{u_name} || '%'
    """)
    @Results({
            @Result(property = "u_id", column = "u_id"),
            @Result(property = "u_pw", column = "u_pw"),
            @Result(property = "u_name", column = "u_name"),
            @Result(property = "u_birth", column = "u_birth"),
            @Result(property = "u_address", column = "u_address")
    })
    List<LoginVO> findByName(@Param("u_name") String u_name);

    /**
     * 최근 가입자 조회
     */
    @Select("""
        SELECT u_id, u_pw, u_name, u_birth, u_address
        FROM USERS
        ORDER BY u_id DESC
        FETCH FIRST #{limit} ROWS ONLY
    """)
    @Results({
            @Result(property = "u_id", column = "u_id"),
            @Result(property = "u_pw", column = "u_pw"),
            @Result(property = "u_name", column = "u_name"),
            @Result(property = "u_birth", column = "u_birth"),
            @Result(property = "u_address", column = "u_address")
    })
    List<LoginVO> getRecentUsers(@Param("limit") int limit);

    /**
     * 생년월일로 검색
     */
    @Select("""
        SELECT u_id, u_pw, u_name, u_birth, u_address
        FROM USERS
        WHERE u_birth BETWEEN #{startDate} AND #{endDate}
    """)
    @Results({
            @Result(property = "u_id", column = "u_id"),
            @Result(property = "u_pw", column = "u_pw"),
            @Result(property = "u_name", column = "u_name"),
            @Result(property = "u_birth", column = "u_birth"),
            @Result(property = "u_address", column = "u_address")
    })
    List<LoginVO> findByBirthDate(@Param("startDate") Date startDate, @Param("endDate") Date endDate);

    /**
     * 주소로 검색
     */
    @Select("""
        SELECT u_id, u_pw, u_name, u_birth, u_address
        FROM USERS
        WHERE u_address LIKE '%' || #{address} || '%'
    """)
    @Results({
            @Result(property = "u_id", column = "u_id"),
            @Result(property = "u_pw", column = "u_pw"),
            @Result(property = "u_name", column = "u_name"),
            @Result(property = "u_birth", column = "u_birth"),
            @Result(property = "u_address", column = "u_address")
    })
    List<LoginVO> findByAddress(@Param("address") String address);

    /**
     * 이메일로 사용자 검색 (확장 기능)
     */
    @Select("""
        SELECT u_id, u_pw, u_name, u_birth, u_address
        FROM USERS
        WHERE u_id LIKE '%@%' AND u_id = #{email}
    """)
    @Results({
            @Result(property = "u_id", column = "u_id"),
            @Result(property = "u_pw", column = "u_pw"),
            @Result(property = "u_name", column = "u_name"),
            @Result(property = "u_birth", column = "u_birth"),
            @Result(property = "u_address", column = "u_address")
    })
    LoginVO findByEmail(@Param("email") String email);

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

    /**
     * 활성 사용자 수 조회 (예약이 있는 사용자)
     */
    @Select("""
        SELECT COUNT(DISTINCT u.u_id) 
        FROM USERS u 
        JOIN RESERVATIONS r ON u.u_id = r.u_id 
        WHERE r.reservation_status = '예약완료'
    """)
    int getActiveUserCount();

    /**
     * 사용자 정보 부분 업데이트 (비밀번호 제외)
     */
    @Update("""
        UPDATE USERS
        SET u_name = #{u_name},
            u_birth = #{u_birth},
            u_address = #{u_address}
        WHERE u_id = #{u_id}
    """)
    int updateUserInfo(LoginVO loginVO);

    /**
     * 사용자 통계 정보 조회
     */
    @Select("""
        SELECT 
            u.u_id,
            u.u_name,
            COUNT(r.reservation_id) as total_reservations,
            SUM(CASE WHEN r.reservation_status = '예약완료' THEN 1 ELSE 0 END) as active_reservations,
            SUM(CASE WHEN r.reservation_status = '예약완료' THEN r.total_amount ELSE 0 END) as total_spent
        FROM USERS u
        LEFT JOIN RESERVATIONS r ON u.u_id = r.u_id
        WHERE u.u_id = #{u_id}
        GROUP BY u.u_id, u.u_name
    """)
    @Results({
            @Result(property = "u_id", column = "u_id"),
            @Result(property = "u_name", column = "u_name"),
            @Result(property = "adult", column = "total_reservations"),     // 총 예약 수
            @Result(property = "youth", column = "active_reservations"),    // 활성 예약 수
            @Result(property = "total_amount", column = "total_spent")      // 총 결제 금액
    })
    LoginVO getUserStats(@Param("u_id") String u_id);

    /**
     * 모든 사용자 통계 조회 (관리자용)
     */
    @Select("""
        SELECT 
            u.u_id,
            u.u_name,
            u.u_birth,
            COUNT(r.reservation_id) as total_reservations,
            SUM(CASE WHEN r.reservation_status = '예약완료' THEN 1 ELSE 0 END) as active_reservations,
            SUM(CASE WHEN r.reservation_status = '예약완료' THEN r.total_amount ELSE 0 END) as total_spent
        FROM USERS u
        LEFT JOIN RESERVATIONS r ON u.u_id = r.u_id
        GROUP BY u.u_id, u.u_name, u.u_birth
        ORDER BY total_spent DESC
    """)
    List<java.util.Map<String, Object>> getAllUsersStats();

    /**
     * 특정 기간 내 가입자 조회
     */
    @Select("""
        SELECT u_id, u_pw, u_name, u_birth, u_address
        FROM USERS
        WHERE u_id IN (
            SELECT u_id FROM USERS WHERE ROWNUM <= #{limit}
        )
        ORDER BY u_id DESC
    """)
    @Results({
            @Result(property = "u_id", column = "u_id"),
            @Result(property = "u_pw", column = "u_pw"),
            @Result(property = "u_name", column = "u_name"),
            @Result(property = "u_birth", column = "u_birth"),
            @Result(property = "u_address", column = "u_address")
    })
    List<LoginVO> getRecentJoiners(@Param("limit") int limit);

    /**
     * 사용자 프로필 요약 정보 조회 (비밀번호 제외)
     */
    @Select("""
        SELECT u_id, u_name, u_birth, u_address
        FROM USERS
        WHERE u_id = #{u_id}
    """)
    @Results({
            @Result(property = "u_id", column = "u_id"),
            @Result(property = "u_name", column = "u_name"),
            @Result(property = "u_birth", column = "u_birth"),
            @Result(property = "u_address", column = "u_address")
    })
    LoginVO getUserProfile(@Param("u_id") String u_id);
}