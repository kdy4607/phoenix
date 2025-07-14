package com.kdy.phoenixmain.mapper;


import com.kdy.phoenixmain.vo.UserVO;
import org.apache.catalina.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface BookmarkMapper {
    @Select("select * from users where u_id = #{username}")
    UserVO findByUsername(@Param("username") String username);
    // ✅ [북마크 추가]
    void insertBookmark(@Param("u_id") String u_id, @Param("movie_id") int movie_id);

    // ✅ [북마크 삭제]
    void deleteBookmark(@Param("u_id") String u_id, @Param("movie_id") int movie_id);

    // (선택) 북마크 여부 확인
    boolean existsBookmark(@Param("u_id") String u_id, @Param("movie_id") int movie_id);
}
