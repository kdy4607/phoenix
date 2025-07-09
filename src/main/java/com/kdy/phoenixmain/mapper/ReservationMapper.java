package com.kdy.phoenixmain.mapper;


import com.kdy.phoenixmain.vo.MovieVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface ReservationMapper {

    @Select("select title from movies")
    List<MovieVO> getAllMovies();



}
