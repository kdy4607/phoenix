package com.kdy.phoenixmain.service;


import com.kdy.phoenixmain.VO.MoviesVO;
import com.kdy.phoenixmain.mapper.ReservationMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReservationService {

    @Autowired
    ReservationMapper reservationMapper;

    // 전체 조회하는 일
    public List<MoviesVO> getAllMovies() {
        List<MoviesVO> movies = reservationMapper.getAllMovies();
        System.out.println(movies);
        return movies;
    }

    //




    }

