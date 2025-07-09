package com.kdy.phoenixmain.controller;

// servlet -> url 파일을 다수로 운용.
// url 매핑 / 흐름 제어

import com.kdy.phoenixmain.mapper.TagMapper;
import com.kdy.phoenixmain.service.MovieService;
import com.kdy.phoenixmain.vo.MovieVO;
import com.kdy.phoenixmain.vo.TagVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
public class MovieC {

    @Autowired          // 의존성 주입   DI
    private MovieService movieService;
    @Autowired
    private TagMapper tagMapper;


    @GetMapping("/movie-all")
    public String movieAll(Model model){
        model.addAttribute("movies",  movieService.getAllMovie());
        List<TagVO> tagList = tagMapper.selectAllTag();
        model.addAttribute("tagList", tagList);
        return "movie/movie";
    }

    @GetMapping("/oneMovieDetail")
    public String movieDetailOne(@RequestParam("MOVIE_ID") int MOVIE_ID, Model model) {
        System.out.println(MOVIE_ID);
        model.addAttribute("movieDetail", "movie-detail.jsp");
        model.addAttribute("movieDetail2", movieService.selectOneMovie(MOVIE_ID));
        System.out.println(model.getAttribute("movieDetail"));
        return "movieDetailView";
    }

    @PostMapping("/movies/filter")
    public String filterMovies(@RequestBody(required = false) List<Integer> tagIds, Model model) {
        try {
            List<MovieVO> filteredMovies = movieService.findMoviesByTagIds(tagIds);
            model.addAttribute("movies", filteredMovies);
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("movies", List.of()); // 에러 시 빈 리스트
        }
        return "movie/movie-fragment";
    }










}
