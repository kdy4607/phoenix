package com.kdy.phoenixmain.service;

import com.kdy.phoenixmain.vo.UserVO;

public interface UserBookMServiceT {
    void save(String userId, int movieId);
    void delete(String userId, int movieId);
    boolean isBookmarked(String userId, int movieId);
    UserVO findByUsername(String username);
}