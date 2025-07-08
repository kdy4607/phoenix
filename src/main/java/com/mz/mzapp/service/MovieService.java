package com.mz.mzapp.service;

import com.mz.mzapp.mapper.MovieMapper;
import com.mz.mzapp.vo.MovieVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MovieService {

    @Autowired
    private MovieMapper movieMapper;


    // 전체조회
    public List<MovieVO> getAllmovie() {
        List<MovieVO> movies = movieMapper.selectAllMovie();
        System.out.println(movies);
        return movies;
    }
    



//태그로 영화 검색
    public List<MovieVO> findMoviesByTags(List<String> tags) {
        if (tags == null || tags.isEmpty()) {
            return movieMapper.selectAllMovie();  // 태그 없으면 전체 조회
        }
        return movieMapper.selectMoviesByTags(tags, tags.size());
    }

}
