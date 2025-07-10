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
import java.util.stream.Collectors;

@Controller
public class MovieC {

    @Autowired          // 의존성 주입   DI
    private MovieService movieService;
    @Autowired
    private TagMapper tagMapper;


    @GetMapping("/movie-all")
    public String movieAll(Model model) {
        model.addAttribute("movies", movieService.getAllMovie());
        List<TagVO> tagList = tagMapper.selectAllTag();
        model.addAttribute("tagList", tagList);
        return "movie/movie";
    }


    @GetMapping("/oneMovieDetail")
    public String movieDetailOne(@RequestParam("MOVIE_ID") int MOVIE_ID, Model model) {
        //별개수 출력
        MovieVO movie = movieService.selectOneMovie(MOVIE_ID);
        //model.addAttribute("movieStar", movie);
        int proStar = (int) Math.floor(movie.getPro_critic());
        int userStar = (int) Math.floor(movie.getUser_critic());
        int plusStar = (proStar + userStar) / 2;
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
        model.addAttribute("movieTapClic", "movie-detail-tap.jsp");
        System.out.println(model.getAttribute("movieDetail"));

        // tap 중에서 뭐더라 그 음... 추천영화..
        List<TagVO> tagList = movieService.getTagsByMovieId(MOVIE_ID);
        List<Integer> tagIds = tagList.stream()
                .map(TagVO::getTag_id)
                .toList();
        List<MovieVO> relatedMovies = movieService.selectMoviesByAnyTag(tagIds, MOVIE_ID); // 자기 자신 제외
        model.addAttribute("relatedMovies", relatedMovies);

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
