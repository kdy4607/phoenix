package com.kdy.phoenixmain.mapper;


import com.kdy.phoenixmain.vo.MovieVO;
import com.kdy.phoenixmain.vo.UserVO;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface BookmarkMapper {


    // 1. 로그인 시 사용자의 정보 조회
    //    - users 테이블에서 u_id가 전달받은 username과 일치하는 레코드를 찾아 UserVO 객체로 반환
    @Select("SELECT * FROM users WHERE u_id = #{username}")
    UserVO findByUsername(@Param("username") String username);

    // 2. 북마크 추가
    //    - bookmarks 테이블에 유저 ID(u_id)와 영화 ID(movie_id)를 삽입하여 북마크를 등록
    @Insert("INSERT INTO bookmarks (u_id, movie_id) VALUES (#{u_id}, #{movie_id})")
    int insertBookmark(@Param("u_id") String u_id, @Param("movie_id") int movie_id);


    // 3. 북마크 삭제
    //    - bookmarks 테이블에서 유저 ID와 영화 ID가 일치하는 레코드를 삭제하여 북마크 해제
    @Delete("DELETE FROM bookmarks WHERE u_id = #{u_id} AND movie_id = #{movie_id}")
    void deleteBookmark(@Param("u_id") String u_id, @Param("movie_id") int movie_id);

    // 4. 북마크 존재 여부 확인
    //    - bookmarks 테이블에서 유저 ID와 영화 ID가 존재하는지 체크해서 boolean 값 반환
    //    - true면 북마크 되어있음, false면 안 되어있음
    @Select("SELECT CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END FROM bookmarks " +
            "WHERE u_id = #{u_id} AND movie_id = #{movie_id}")
    boolean existsBookmark(@Param("u_id") String u_id, @Param("movie_id") int movie_id);

    //북마크 있으면 별을 유지시키기 위한거.
    @Select("SELECT CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END FROM bookmarks " +
            "WHERE u_id = #{u_id} AND movie_id = #{movie_id}")
    int isStarmark(@Param("u_id") String u_id, @Param("movie_id") int movie_id);

    //북마크 테이블과 무비테이블을 조인(마이페이지 북마크영화내용 조회)
    @Select("SELECT m.movie_id, m.title, m.poster_url " +
            "FROM bookmarks b1 " +
            "JOIN movies m ON b1.movie_id = m.movie_id " +
            "WHERE b1.u_id = #{u_id}")
    List<MovieVO> getBookMarkWhidMovie(@Param("u_id") String u_id);

}
