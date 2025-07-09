package com.kdy.phoenixmain.mapper;

import com.kdy.phoenixmain.vo.MovieVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface MovieMapper {
    @Select("select * from movies")
    public List<MovieVO> selectAllMovies();

    @Select("select * from movies where MOVIE_ID=#{MOVIE_ID}")
    public MovieVO selectOneMovie(@Param("MOVIE_ID") int MOVIE_ID);
}
