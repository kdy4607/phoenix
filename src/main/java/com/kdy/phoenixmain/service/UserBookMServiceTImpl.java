package com.kdy.phoenixmain.service;

import com.kdy.phoenixmain.mapper.BookmarkMapper;
import com.kdy.phoenixmain.vo.UserVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class UserBookMServiceTImpl implements UserBookMServiceT {

    @Autowired
    private BookmarkMapper bookmarkMapper;

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
    public boolean existsBookmark(String u_id, int movie_id) {
        return bookmarkMapper.existsBookmark(u_id, movie_id);
    }
}
