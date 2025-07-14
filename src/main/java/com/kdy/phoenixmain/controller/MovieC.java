package com.kdy.phoenixmain.controller;

import com.kdy.phoenixmain.mapper.TagMapper;
import com.kdy.phoenixmain.service.MovieService;
import com.kdy.phoenixmain.service.TagService;
import com.kdy.phoenixmain.vo.MovieVO;
import com.kdy.phoenixmain.vo.TagVO;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

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
    public String movieAll(Model model) {
        model.addAttribute("movies", movieService.getAllMovie());
        model.addAttribute("tagList", tagMapper.selectAllTag());
        return "movie/movie";
    }


    @GetMapping("/oneMovieDetail")
    public String movieDetailOne(@RequestParam("movie_id") int movie_id, Model model, HttpSession session) {
        //이전 세션값 저장용
        session.setAttribute("lastMovieId", movie_id);

        //별개수 출력
        MovieVO movie = movieService.selectOneMovie(movie_id);
        //model.addAttribute("movieStar", movie);
        int proStar = (int) Math.floor(movie.getPro_critic());
        int userStar = (int) Math.floor(movie.getUser_critic());
        int plusStar = (proStar + userStar) / 2;
        model.addAttribute("proStar", proStar);
        model.addAttribute("userStar", userStar);
        model.addAttribute("plusStar", plusStar);
        //페이지 출력
        System.out.println(movie_id);
        //페이지출력 - 인클루드1 - 영화1개선택시 보이는 세부화면
        model.addAttribute("movieDetail", "movie-detail.jsp");
        //인클루드1의 데이터주는곳
        model.addAttribute("movieDetail2", movieService.selectOneMovie(movie_id));
        //페이지 출력 - 인클루드2 -무비 탭 클릭부분
        model.addAttribute("movieTapClic", "movie-detail-tap.jsp");
        System.out.println(model.getAttribute("movieDetail"));

        // tap 중에서 뭐더라 그 음... 추천영화..
        List<TagVO> tagList = movieService.getTagsByMovieId(movie_id);
        List<Integer> tagIds = tagList.stream()
                .map(TagVO::getTag_id)
                .toList();
        List<MovieVO> relatedMovies = movieService.selectMoviesByAnyTag(tagIds, movie_id); // 자기 자신 제외
        model.addAttribute("relatedMovies", relatedMovies);

        return "movieDetailView";
    }


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
