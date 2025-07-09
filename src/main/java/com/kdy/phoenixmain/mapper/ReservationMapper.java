package com.kdy.phoenixmain.mapper;


import com.kdy.phoenixmain.VO.MoviesVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface ReservationMapper {

    @Select("select title from movies")
    List<MoviesVO> getAllMovies();



}
