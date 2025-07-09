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
        model.addAttribute("movies",  movieService.getAllmovie() );
        List<TagVO> tagList = tagMapper.selectAllTag();
        model.addAttribute("tagList", tagList);

        return "movie/movie";
    }

    @GetMapping("/oneMovieDetail")
    public String movieDetailOne(@RequestParam("MOVIE_ID") int MOVIE_ID, Model model) {
        //별개수 출력
        MovieVO movie = movieService.selectOneMovie(MOVIE_ID);
        //model.addAttribute("movieStar", movie);
        int proStar = (int)Math.floor(movie.getPro_critic());
        int userStar = (int)Math.floor(movie.getUser_critic());
        int plusStar = (proStar + userStar) /2;
        model.addAttribute("proStar", proStar);
        model.addAttribute("userStar", userStar);
        model.addAttribute("plusStar", plusStar);
        //페이지 출력
        System.out.println(MOVIE_ID);
        //페이지출력 - 인클루드1 - 영화1개선택시 보이는 세부화면
        model.addAttribute("movieDetail", "movie-detail.jsp");
        //인클루드1의 데이터주는곳
        model.addAttribute("movieDetail2", movieService.selectOneMovie(MOVIE_ID));
        //페이지 출력 - 인클루드2 -무비 탭 클릭부분
        model.addAttribute("movieTapClic","movie-detail-tap.jsp");
        System.out.println(model.getAttribute("movieDetail"));
        return "movieDetailView";
    }

    @PostMapping("/movies/filter")
    public String filterMovies(@RequestBody List<String> tags, Model model) {
        System.out.println("선택된 태그: " + tags);

        List<MovieVO> filteredMovies = movieService.findMoviesByTags(tags);
        model.addAttribute("movies", filteredMovies);

        return "movie/movie-fragment";  // ➜ partial JSP 경로 맞게 수정
    }









}
