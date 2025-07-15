package com.kdy.phoenixmain.service;

import com.kdy.phoenixmain.vo.UserVO;

public interface UserBookMServiceT {
    void save(String u_id, int movie_id);
    void delete(String u_id, int movie_id);
    UserVO findByUsername(String username);
}