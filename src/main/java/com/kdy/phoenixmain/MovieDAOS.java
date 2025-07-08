package com.kdy.phoenixmain;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MovieDAOS {
    //전체조회
    @Autowired
    MovieMapper movieMapper;
    public List<MovieVO> getAllMovies() {
        List<MovieVO> movieVOS = movieMapper.selectAllMovies();
        System.out.println(movieVOS);
        return movieVOS;
    }

    public MovieVO selectOneMovie(int num){
        MovieVO movieOne = movieMapper.selectOneMovie(num);
        System.out.println(movieOne);
        return movieOne;
    }

}
