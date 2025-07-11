package com.kdy.phoenixmain.service;

import com.kdy.phoenixmain.mapper.LoginMapper;
import com.kdy.phoenixmain.vo.LoginVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class LoginService {

    @Autowired
    private LoginMapper loginMapper;

    /**
     * 로그인 인증
     */
    public LoginVO login(String u_id, String u_pw) {
        try {
            System.out.println("🔐 로그인 시도 - ID: " + u_id);

            // 사용자 정보 조회
            LoginVO user = loginMapper.findByIdAndPassword(u_id, u_pw);

            if (user != null) {
                System.out.println("✅ 로그인 성공 - 사용자: " + user.getU_name());
                return user;
            } else {
                System.out.println("❌ 로그인 실패 - 잘못된 인증 정보");
                return null;
            }

        } catch (Exception e) {
            System.err.println("❌ 로그인 처리 오류: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    /**
     * 사용자 정보 조회 (ID로)
     */
    public LoginVO findById(String u_id) {
        try {
            return loginMapper.findById(u_id);
        } catch (Exception e) {
            System.err.println("사용자 조회 오류: " + e.getMessage());
            return null;
        }
    }

    /**
     * 회원 가입
     */
    public void insertLogin(LoginVO loginVO) {
        try {
            System.out.println("📝 회원 가입 시도 - ID: " + loginVO.getU_id() + ", 이름: " + loginVO.getU_name());

            // 중복 확인
            LoginVO existingUser = findById(loginVO.getU_id());
            if (existingUser != null) {
                throw new RuntimeException("이미 사용 중인 아이디입니다.");
            }

            // 회원 정보 저장
            loginMapper.insertLogin(loginVO);

            System.out.println("✅ 회원 가입 완료 - ID: " + loginVO.getU_id());

        } catch (Exception e) {
            System.err.println("❌ 회원 가입 오류: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("회원 가입 중 오류가 발생했습니다: " + e.getMessage());
        }
    }

    /**
     * 회원 정보 수정
     */
    public void updateLogin(LoginVO loginVO) {
        try {
            System.out.println("📝 회원 정보 수정 시도 - ID: " + loginVO.getU_id());

            // 사용자 존재 확인
            LoginVO existingUser = findById(loginVO.getU_id());
            if (existingUser == null) {
                throw new RuntimeException("사용자를 찾을 수 없습니다.");
            }

            // 회원 정보 업데이트
            loginMapper.updateLogin(loginVO);

            System.out.println("✅ 회원 정보 수정 완료 - ID: " + loginVO.getU_id());

        } catch (Exception e) {
            System.err.println("❌ 회원 정보 수정 오류: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("회원 정보 수정 중 오류가 발생했습니다: " + e.getMessage());
        }
    }

    /**
     * 회원 삭제
     */
    public void deleteLogin(String u_id) {
        try {
            System.out.println("🗑️ 회원 삭제 시도 - ID: " + u_id);

            // 사용자 존재 확인
            LoginVO existingUser = findById(u_id);
            if (existingUser == null) {
                throw new RuntimeException("사용자를 찾을 수 없습니다.");
            }

            // 회원 삭제
            loginMapper.deleteLogin(u_id);

            System.out.println("✅ 회원 삭제 완료 - ID: " + u_id);

        } catch (Exception e) {
            System.err.println("❌ 회원 삭제 오류: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("회원 삭제 중 오류가 발생했습니다: " + e.getMessage());
        }
    }

    /**
     * 아이디 중복 체크
     */
    public boolean isIdExists(String u_id) {
        try {
            LoginVO user = findById(u_id);
            return user != null;
        } catch (Exception e) {
            System.err.println("아이디 중복 체크 오류: " + e.getMessage());
            return false;
        }
    }

    /**
     * 비밀번호 변경
     */
    public void changePassword(String u_id, String oldPassword, String newPassword) {
        try {
            System.out.println("🔐 비밀번호 변경 시도 - ID: " + u_id);

            // 기존 비밀번호 확인
            LoginVO user = loginMapper.findByIdAndPassword(u_id, oldPassword);
            if (user == null) {
                throw new RuntimeException("기존 비밀번호가 올바르지 않습니다.");
            }

            // 새 비밀번호로 업데이트
            loginMapper.updatePassword(u_id, newPassword);

            System.out.println("✅ 비밀번호 변경 완료 - ID: " + u_id);

        } catch (Exception e) {
            System.err.println("❌ 비밀번호 변경 오류: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("비밀번호 변경 중 오류가 발생했습니다: " + e.getMessage());
        }
    }

    /**
     * 사용자 목록 조회 (관리자용)
     */
    public java.util.List<LoginVO> getAllUsers() {
        try {
            return loginMapper.getAllUsers();
        } catch (Exception e) {
            System.err.println("사용자 목록 조회 오류: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("사용자 목록 조회 중 오류가 발생했습니다: " + e.getMessage());
        }
    }

    /**
     * 사용자 수 조회
     */
    public int getUserCount() {
        try {
            return loginMapper.getUserCount();
        } catch (Exception e) {
            System.err.println("사용자 수 조회 오류: " + e.getMessage());
            return 0;
        }
    }
}