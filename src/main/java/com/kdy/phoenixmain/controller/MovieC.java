package com.kdy.phoenixmain.controller;

import com.kdy.phoenixmain.service.MovieService;
import com.kdy.phoenixmain.service.ReviewService;
import com.kdy.phoenixmain.service.TagService;
import com.kdy.phoenixmain.service.UserBookMServiceT;
import com.kdy.phoenixmain.vo.LoginVO;
import com.kdy.phoenixmain.vo.MovieVO;
import com.kdy.phoenixmain.vo.ReviewVO;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class MovieC {

    @Autowired
    private MovieService movieService;

    @Autowired
    private TagService tagService;

    @Autowired
    private UserBookMServiceT userBookMServiceT;

    @Autowired
    private ReviewService reviewService;

    // ✅ 프론트 필터링용 전체 데이터 API
    @GetMapping("/movies/all-data")
    @ResponseBody
    public Map<String, Object> getAllMovieAndTags() {
        Map<String, Object> result = new HashMap<>();
        result.put("movies", movieService.getAllMovie());     // 모든 영화 정보
        result.put("tags", tagService.getAllTags());          // 모든 태그 정보
        return result;
    }

    // ✅ 진입용 JSP만 보여주는 라우트
    @GetMapping("/movie-all")
    public String movieAll() {
        return "movie/movie"; // 실제 데이터는 JS에서 fetch로 처리
    }

    // ✅ 영화 상세 페이지
    @GetMapping("/oneMovieDetail")
    public String movieDetailOne(@RequestParam("movie_id") int movie_id, Model model, HttpSession session) {
        session.setAttribute("lastMovieId", movie_id);

        MovieVO movie = movieService.selectOneMovie(movie_id);
        int proStar = (int) Math.floor(movie.getPro_critic());
        int userStar = (int) Math.floor(movie.getUser_critic());
        int plusStar = (proStar + userStar) / 2;

        model.addAttribute("proStar", proStar);
        model.addAttribute("userStar", userStar);
        model.addAttribute("plusStar", plusStar);

        model.addAttribute("movieDetail", "movie-detail.jsp");
        model.addAttribute("movieDetail2", movie);
        model.addAttribute("movieTapClic", "movie-detail-tap.jsp");

        // 영화 + 관련 영화 + 리뷰
        model.addAttribute("movie", movie);
        model.addAttribute("relatedMovies", movieService.getRelatedByGenre(movie_id));
        model.addAttribute("reviewList", reviewService.getReviews(movie_id));

        // 북마크 여부 확인
        LoginVO uservo = (LoginVO) session.getAttribute("user");
        if (uservo != null) {
            String u_id = uservo.getU_id();
            boolean existsBookmark = userBookMServiceT.existsBookmark(u_id, movie_id);
            model.addAttribute("existsBookmark", existsBookmark);
        } else {
            model.addAttribute("existsBookmark", false);
        }

        return "movieDetailView";
    }

    // ✅ 리뷰 작성
    @PostMapping("/reviews")
    public String writeReview(@ModelAttribute ReviewVO review, HttpSession session) {
        LoginVO user = (LoginVO) session.getAttribute("user");
        if (user == null) return "redirect:/login";

        review.setU_id(user.getU_id());
        reviewService.writeReview(review);

        return "redirect:/oneMovieDetail?movie_id=" + review.getMovie_id();
    }

    // ✅ 리뷰 수정
    @PostMapping("/reviews/update")
    public String updateReview(@ModelAttribute ReviewVO review, HttpSession session) {
        LoginVO user = (LoginVO) session.getAttribute("user");
        if (user == null) return "redirect:/login";

        review.setU_id(user.getU_id());
        reviewService.updateReview(review);

        return "redirect:/oneMovieDetail?movie_id=" + review.getMovie_id();
    }

    // ✅ 리뷰 삭제
    @PostMapping("/reviews/delete")
    public String deleteReview(@RequestParam("r_id") int r_id,
                               @RequestParam("movie_id") int movie_id,
                               HttpSession session) {
        LoginVO user = (LoginVO) session.getAttribute("user");
        if (user == null) return "redirect:/login";

        reviewService.deleteReview(r_id, user.getU_id());

        return "redirect:/oneMovieDetail?movie_id=" + movie_id;
    }
}
