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
    // 관련 영화 가져오기 메서드 추가
    List<MovieVO> getRelatedMovies(int movieId);


    // 북마크 수 체크용 <- 2025년 07월 18일 12시경 추가했습니다. (최아영)
    int getBookmarkCountByUserId(String u_id);

}