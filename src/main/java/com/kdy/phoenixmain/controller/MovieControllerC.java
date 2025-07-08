package com.kdy.phoenixmain.controller;

import com.kdy.phoenixmain.service.MovieService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class MovieControllerC {
    @Autowired
    MovieService movieService;

    @GetMapping("/selectMovies")
    public String movieDetailAllPage(Model model) { //맨 처음에 볼거.
        model.addAttribute("movieDetail", "temp.jsp");
        return "movieDetailView";
    }

    @GetMapping("/oneMovieDetail")
    public String movieDetailOne(@RequestParam("MOVIE_ID") int MOVIE_ID, Model model) {
        System.out.println(MOVIE_ID);
        model.addAttribute("movieDetail", "movie-detail.jsp");
        model.addAttribute("movieDetail2", movieService.selectOneMovie(MOVIE_ID));
        System.out.println(model.getAttribute("movieDetail"));
        return "movieDetailView";
    }

}
