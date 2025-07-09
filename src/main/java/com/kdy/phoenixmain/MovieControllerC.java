package com.kdy.phoenixmain;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MovieControllerC {
    @Autowired
    MovieDAOS movieDAOS;

    @GetMapping("/")
    public String movieDetailAllPage(Model model) { //맨 처음에 볼거.
        model.addAttribute("movieDetail", "movie-detail.jsp");
        //temp
        return "movieDetailView";
    }

    @GetMapping("/oneMovieDetail")
    public String movieDetailOne(@RequestParam("MOVIE_ID") int MOVIE_ID, Model model) {
        System.out.println(MOVIE_ID);
        model.addAttribute("movieDetail", "movie-detail.jsp");
        model.addAttribute("movieDetail2", movieDAOS.selectOneMovie(MOVIE_ID));
        System.out.println(model.getAttribute("movieDetail"));
        return "movieDetailView";
    }

    @GetMapping("/all-movie") //모든 영화를 보기 위한것. -> 1개선택해서 상세로
    public String allMovie(Model model) {
        model.addAttribute("Allmovie", movieDAOS.getAllMovies());
        return "testMovieAll";

    }
}
