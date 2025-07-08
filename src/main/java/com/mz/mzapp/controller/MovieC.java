package com.mz.mzapp.controller;

// servlet -> url 파일을 다수로 운용.
// url 매핑 / 흐름 제어

import com.mz.mzapp.mapper.TagMapper;
import com.mz.mzapp.service.MovieService;
import com.mz.mzapp.vo.MovieVO;
import com.mz.mzapp.vo.TagVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@Controller
public class MovieC {

    @Autowired          // 의존성 주입   DI
    private MovieService movieService;
    @Autowired
    private TagMapper tagMapper;


    @GetMapping("/movie-all")
    public String movieAll(Model model){
        model.addAttribute("movies",  movieService.getAllmovie() );
        List<TagVO> tagList = tagMapper.selectAllTag();
        model.addAttribute("tagList", tagList);

        return "movie/movie";
    }

    @PostMapping("/movies/filter")
    public String filterMovies(@RequestBody List<String> tags, Model model) {
        System.out.println("선택된 태그: " + tags);

        List<MovieVO> filteredMovies = movieService.findMoviesByTags(tags);
        model.addAttribute("movies", filteredMovies);

        return "movie/movie-fragment";  // ➜ partial JSP 경로 맞게 수정
    }









}
