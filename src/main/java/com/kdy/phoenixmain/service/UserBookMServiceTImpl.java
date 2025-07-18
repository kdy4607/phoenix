package com.kdy.phoenixmain.service;

import com.kdy.phoenixmain.mapper.BookmarkMapper;
import com.kdy.phoenixmain.mapper.MovieMapper;
import com.kdy.phoenixmain.vo.MovieVO;
import com.kdy.phoenixmain.vo.UserVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
public class UserBookMServiceTImpl implements UserBookMServiceT {

    @Autowired
    private BookmarkMapper bookmarkMapper;
    @Autowired
    private MovieMapper movieMapper;  //영화조회 위해서 여기다 끌어다 썻어요

    @Override
    @Transactional
    public void save(String u_id, int movie_id) {

        try{
            boolean exist = bookmarkMapper.existsBookmark(u_id, movie_id);
            if(exist){
                System.out.println("이미 북마크됨: userId=" + u_id + ", movieId=" + movie_id);
                return; // 중복 방지
            }
            int result = bookmarkMapper.insertBookmark(u_id, movie_id);
            System.out.println("북마크 저장 시도: userId=" + u_id + ", movieId=" + movie_id);

           // bookmarkMapper.insertBookmark(u_id, movie_id);
            System.out.println("북마크 insert 결과: " + result + " row(s) 삽입됨");
        }catch(Exception e){
            System.out.println("북마크 저장 중 오류 발생: " + e.getMessage());
            e.printStackTrace();
        }
        }

    @Override
    @Transactional
    public void delete(String u_id, int movie_id) {
        bookmarkMapper.deleteBookmark(u_id, movie_id);
    }

    @Override
    @Transactional
    public UserVO findByUsername(String username) {
        return bookmarkMapper.findByUsername(username);
    }
    @Override // 별모양용
    public int isStarmark(String u_id, int movie_id) {
        return bookmarkMapper.isStarmark(u_id, movie_id);
    }
    // 북마크 기존 확인용
    @Override
    public boolean existsBookmark(String u_id, int movie_id) {
        return bookmarkMapper.existsBookmark(u_id, movie_id);
    }
    //북마크 마이페이지용 입니다.
    @Override
    public List<MovieVO> getBookMarkWhidMovie(String u_id) {
        return bookmarkMapper.getBookMarkWhidMovie(u_id);
    }

    @Override //하나라도 일치하는 영화 / 기준 앞뒤 조사 조회
    public List<MovieVO> getRelatedMovies(int movieId) {
        MovieVO movie = movieMapper.selectOneMovie(movieId);  // 해당 영화 정보 조회
        if (movie == null || movie.getGenre() == null) {
            return new ArrayList<>();
        }

        String[] genres = movie.getGenre().split("/");
        String genre1 = genres.length > 0 ? genres[0] : null;
        String genre2 = genres.length > 1 ? genres[1] : null;

        return movieMapper.selectRelatedMovies(movieId, genre1, genre2);


    }
}
