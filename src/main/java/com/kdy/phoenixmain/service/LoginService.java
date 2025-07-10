package com.kdy.phoenixmain.service;

import com.kdy.phoenixmain.mapper.LoginMapper;
import com.kdy.phoenixmain.vo.LoginVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class LoginService {

    @Autowired
    private LoginMapper loginMapper;

    // 등록
    @Transactional
    public void insertLogin(LoginVO loginVO) {
        if (loginMapper.insertLogin(loginVO) == 1) {
            System.out.println("insert new user success");
        }
    }


    // 조회 nickname
    @Transactional
    public LoginVO selectLoginById(String u_id) {
        LoginVO loginVO = (LoginVO) loginMapper.selectLoginByNick(u_id);

        System.out.println("select user success");
        return loginVO;
    }

    // 조회 ID
    @Transactional
    public LoginVO selectLoginByID(String u_id) {
        LoginVO loginVO = (LoginVO) loginMapper.selectLoginByID(u_id);

        System.out.println("select user success");
        return loginVO;
    }

    // 수정
    @Transactional
    public void updateLogins(LoginVO loginVO) {
        if (loginMapper.updateLoginByID(loginVO) == 1) {
            System.out.println("update user success");
        }
    }

    // 삭제
    @Transactional
    public void deleteLogin(String u_id) {
        if (loginMapper.deleteLoginByID(u_id) == 1) {
            System.out.println("delete user success");
        }
    }


}