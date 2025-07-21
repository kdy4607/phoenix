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

    // // ✅ 영화 상세 페이지
    // @GetMapping("/oneMovieDetail")
    // public String movieDetailOne(@RequestParam("movie_id") int movie_id, Model model, HttpSession session) {
    //     session.setAttribute("lastMovieId", movie_id);

    //     MovieVO movie = movieService.selectOneMovie(movie_id);
    //     int proStar = (int) Math.floor(movie.getPro_critic());
    //     int userStar = (int) Math.floor(movie.getUser_critic());
    //     int plusStar = (proStar + userStar) / 2;

    //     model.addAttribute("proStar", proStar);
    //     model.addAttribute("userStar", userStar);
    //     model.addAttribute("plusStar", plusStar);

    //     model.addAttribute("movieDetail", "movie-detail.jsp");
    //     model.addAttribute("movieDetail2", movie);
    //     model.addAttribute("movieTapClic", "movie-detail-tap.jsp");

    //     // 영화 + 관련 영화 + 리뷰
    //     model.addAttribute("movie", movie);
    //     model.addAttribute("relatedMovies", movieService.getRelatedByGenre(movie_id));
    //     model.addAttribute("reviewList", reviewService.getReviews(movie_id));

    //     // 북마크 여부 확인
    //     LoginVO uservo = (LoginVO) session.getAttribute("user");
    //     if (uservo != null) {
    //         String u_id = uservo.getU_id();
    //         boolean existsBookmark = userBookMServiceT.existsBookmark(u_id, movie_id);
    //         model.addAttribute("existsBookmark", existsBookmark);
    //     } else {
    //         model.addAttribute("existsBookmark", false);
    //     }

    //     return "movieDetailView";
    // }

    // ✅ 리뷰 작성
    @PostMapping("/reviews")
    public String writeReview(@ModelAttribute ReviewVO review, HttpSession session) {
        LoginVO user = (LoginVO) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login"; // 로그인 페이지로
        }

        review.setU_id(user.getU_id());
        reviewService.writeReview(review);

        return "redirect:/oneMovieDetail?movie_id=" + review.getMovie_id();
    }

    @PostMapping("/reviews/delete")
    public String deleteReview(@RequestParam("r_id") int r_id,
                               @RequestParam("movie_id") int movie_id,
                               HttpSession session) {
        LoginVO user = (LoginVO) session.getAttribute("user");
        if (user == null) return "redirect:/login";

        reviewService.deleteReview(r_id, user.getU_id());

        return "redirect:/oneMovieDetail?movie_id=" + movie_id;
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
        // 영화 상세 정보
        movie = movieService.selectOneMovie(movie_id);
        model.addAttribute("movie", movie);

        // 관련 영화 (장르 겹치는 다른 영화들) 1개라도 겹치면 온다.
//        List<MovieVO> relatedMovies = movieService.getRelatedByGenre(movie_id);
//        model.addAttribute("relatedMovies", relatedMovies); //구 버젼
        List<MovieVO> relatedMovies = userBookMServiceT.getRelatedMovies(movie_id);
        model.addAttribute("relatedMovies", relatedMovies);
        System.out.println(relatedMovies);
        //리뷰용
        List<ReviewVO> reviewList = reviewService.getReviews(movie_id);
        model.addAttribute("reviewList", reviewList);


//        System.out.println(model.getAttribute("relatedMovies"));
        //-------------------------------------------------------
        //북마스 정보를 받아서 다시 페이지를 출력
        LoginVO uservo = (LoginVO) session.getAttribute("user");
        System.out.println(uservo + "뭐가나오나2");
        if (uservo != null) {
            String u_id = uservo.getU_id();
            boolean existsBookmark = userBookMServiceT.existsBookmark(u_id, movie_id);
            model.addAttribute("existsBookmark", existsBookmark);
            System.out.println("existsBookmark = 별색칠//" + existsBookmark);
        }else {
            model.addAttribute("existsBookmark", false);
            System.out.println("existsBookmark = 빈별");
        }

        return "movieDetailView";
    }


    // @PostMapping("/movies/filter")
    // public String filterMovies(@RequestBody Map<String, Object> payload, Model model) {
    //     String title = (String) payload.get("title");
    //     String status = (String) payload.get("status"); // ✅ 추가
    //     @SuppressWarnings("unchecked")
    //     List<Integer> tagIds = (List<Integer>) payload.get("tagIds");

    //     List<MovieVO> filteredMovies;

    //     if ((tagIds == null || tagIds.isEmpty()) && (title == null || title.isBlank())) {
    //         filteredMovies = movieService.getMoviesByStatus(status); // ✅ 탭 필터만 적용
    //     } else if (tagIds != null && !tagIds.isEmpty() && title != null && !title.isBlank()) {
    //         filteredMovies = movieService.findMoviesByTagsTitleAndStatus(tagIds, title, status); // ✅ 전체 필터
    //     } else if (tagIds != null && !tagIds.isEmpty()) {
    //         filteredMovies = movieService.findMoviesByTagsAndStatus(tagIds, status); // ✅ 태그 + 탭
    //     } else {
    //         filteredMovies = movieService.findMoviesBySearchAndStatus(title, status); // ✅ 검색어 + 탭
    //     }
    //     // 🎯 필터된 결과 내에서 user_critic 내림차순 정렬 + ranking 부여
    //     filteredMovies = movieService.applyRanking(filteredMovies);

    //     model.addAttribute("movies", filteredMovies);
    //     return "movie/movie-fragment";
    // }
}
