package com.kdy.phoenixmain.controller;

import com.kdy.phoenixmain.mapper.TagMapper;
import com.kdy.phoenixmain.service.MovieService;
import com.kdy.phoenixmain.service.TagService;
import com.kdy.phoenixmain.vo.MovieVO;
import com.kdy.phoenixmain.vo.TagVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@Controller
public class MovieC {

    @Autowired
    private MovieService movieService;

    @Autowired
    private TagService tagService;

    @Autowired
    private TagMapper tagMapper;

    // 전체 영화 목록 or 검색어 기반 목록 출력
    @GetMapping("/movie-all")
    public String movieAll(@RequestParam(value = "title", required = false) String title, Model model) {
        List<MovieVO> movies = (title != null && !title.isBlank())
                ? movieService.findMoviesBySearch(title)
                : movieService.getAllMovie();

        List<TagVO> tagList = tagMapper.selectAllTag();

        model.addAttribute("movies", movies);
        model.addAttribute("tagList", tagList);

        return "movie/movie";
    }

    // 단일 영화 상세 페이지
    @GetMapping("/oneMovieDetail")
    public String movieDetailOne(@RequestParam("MOVIE_ID") int movieId, Model model) {
        model.addAttribute("movieDetail", "movie-detail.jsp");
        model.addAttribute("movieDetail2", movieService.selectOneMovie(movieId));
        return "movieDetailView";
    }

    // 태그 및 제목을 활용한 비동기 필터링
    @PostMapping("/movies/filter")
    public String filterMovies(@RequestBody Map<String, Object> payload, Model model) {
        String title = (String) payload.get("title");
        @SuppressWarnings("unchecked")
        List<Integer> tagIds = (List<Integer>) payload.get("tagIds");

        List<MovieVO> filteredMovies;

        if (tagIds == null || tagIds.isEmpty()) {
            filteredMovies = (title == null || title.isBlank())
                    ? movieService.getAllMovie()
                    : movieService.findMoviesBySearch(title);
        } else if (title != null && !title.isBlank()) {
            filteredMovies = movieService.findMoviesByTagsAndTitle(tagIds, title);
        } else {
            filteredMovies = movieService.findMoviesByTagIds(tagIds);
        }

        model.addAttribute("movies", filteredMovies);
        return "movie/movie-fragment";
    }
}
