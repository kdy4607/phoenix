package com.kdy.phoenixmain.service;

import com.kdy.phoenixmain.mapper.MovieMapper;
import com.kdy.phoenixmain.vo.MovieVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ScheduleService {

    @Autowired
    private MovieMapper movieMapper;

    // 전체조회
    public List<MovieVO> getAllMovies() {
        List<MovieVO> movies = movieMapper.selectAllMovies();
        System.out.println(movies);
        return movies;
    }

}
