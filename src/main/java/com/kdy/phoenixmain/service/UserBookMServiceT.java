package com.kdy.phoenixmain.service;

import com.kdy.phoenixmain.vo.MovieVO;
import com.kdy.phoenixmain.vo.UserVO;

import java.util.List;

public interface UserBookMServiceT {
    void save(String u_id, int movie_id);

    void delete(String u_id, int movie_id);

    UserVO findByUsername(String username);

    int isStarmark(String u_id, int movie_id);

    boolean existsBookmark(String u_id, int movie_id);


    //북마크 마이페이지용 입니다.
    List<MovieVO> getBookMarkWhidMovie(String u_id);
}