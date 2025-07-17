package com.kdy.phoenixmain.controller;

import com.kdy.phoenixmain.mapper.ReviewMapper;
import com.kdy.phoenixmain.mapper.TagMapper;
import com.kdy.phoenixmain.service.MovieService;
import com.kdy.phoenixmain.service.ReviewService;
import com.kdy.phoenixmain.service.TagService;
import com.kdy.phoenixmain.service.UserBookMServiceT;
import com.kdy.phoenixmain.vo.LoginVO;
import com.kdy.phoenixmain.vo.MovieVO;
import com.kdy.phoenixmain.vo.ReviewVO;
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
    @Autowired
    private UserBookMServiceT userBookMServiceT;
    @Autowired
    private ReviewService reviewService;

    // 전체 영화 목록 or 검색어 기반 목록 출력
    @GetMapping("/movie-all")
    public String movieAll(
            @RequestParam(defaultValue = "showing") String status,
            Model model
    ) {
        // status 값: all / now / upcoming
        List<MovieVO> movies = movieService.getMoviesByStatus(status);

        model.addAttribute("movies", movies);
        model.addAttribute("tagList", tagMapper.selectAllTag());
        model.addAttribute("status", status); // 탭 활성화 표시용
        return "movie/movie";
    }

    @PostMapping("/reviews")
    public String writeReview(@ModelAttribute ReviewVO review, HttpSession session) {
        // 로그인 확인 및 사용자 정보 보정 (보안상 중요)
        LoginVO user = (LoginVO) session.getAttribute("user");
        if (user == null) {
            return "redirect:/login"; // 로그인 페이지로
        }
        review.setU_id(user.getU_id());

        reviewService.writeReview(review);

        // 리뷰 작성 후 다시 해당 영화 상세 페이지로 리디렉션
        return "redirect:/oneMovieDetail?movie_id=" + review.getMovie_id();
    }

    @PostMapping("/reviews/update")
    public String updateReview(@ModelAttribute ReviewVO review, HttpSession session) {
        LoginVO user = (LoginVO) session.getAttribute("user");
        if (user == null) return "redirect:/login";

        review.setU_id(user.getU_id());
        reviewService.updateReview(review);

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


//        List<TagVO> tagList = movieService.getTagsByMovieId(movie_id);
//        List<Integer> tagIds = tagList.stream()
//                .map(TagVO::getTag_id)
//                .toList();
//        List<MovieVO> relatedMovies = movieService.selectMoviesByAnyTag(tagIds, movie_id); // 자기 자신 제외
//        model.addAttribute("relatedMovies", relatedMovies);
        // tap 중에서 뭐더라 그 음... 추천영화..
        // 영화 상세 정보
        movie = movieService.selectOneMovie(movie_id);
        model.addAttribute("movie", movie);

        // 관련 영화 (장르 겹치는 다른 영화들)
        List<MovieVO> relatedMovies = movieService.getRelatedByGenre(movie_id);
        model.addAttribute("relatedMovies", relatedMovies);

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


    @PostMapping("/movies/filter")
    public String filterMovies(@RequestBody Map<String, Object> payload, Model model) {
        String title = (String) payload.get("title");
        String status = (String) payload.get("status"); // ✅ 추가
        @SuppressWarnings("unchecked")
        List<Integer> tagIds = (List<Integer>) payload.get("tagIds");

        List<MovieVO> filteredMovies;

        if ((tagIds == null || tagIds.isEmpty()) && (title == null || title.isBlank())) {
            filteredMovies = movieService.getMoviesByStatus(status); // ✅ 탭 필터만 적용
        } else if (tagIds != null && !tagIds.isEmpty() && title != null && !title.isBlank()) {
            filteredMovies = movieService.findMoviesByTagsTitleAndStatus(tagIds, title, status); // ✅ 전체 필터
        } else if (tagIds != null && !tagIds.isEmpty()) {
            filteredMovies = movieService.findMoviesByTagsAndStatus(tagIds, status); // ✅ 태그 + 탭
        } else {
            filteredMovies = movieService.findMoviesBySearchAndStatus(title, status); // ✅ 검색어 + 탭
        }
        // 🎯 필터된 결과 내에서 user_critic 내림차순 정렬 + ranking 부여
        filteredMovies = movieService.applyRanking(filteredMovies);

        model.addAttribute("movies", filteredMovies);
        return "movie/movie-fragment";
    }
}
