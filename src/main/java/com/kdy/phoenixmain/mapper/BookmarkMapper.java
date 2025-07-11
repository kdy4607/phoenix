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

}
