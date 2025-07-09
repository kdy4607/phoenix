package com.kdy.phoenixmain.controller;

import com.kdy.phoenixmain.vo.MovieVO;
import com.kdy.phoenixmain.vo.StepBarVO;
import com.kdy.phoenixmain.service.ReservationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class ReservationC {

    @Autowired
    ReservationService reservationService;

    @GetMapping("/step1")
    public String step1(Model model) {
        StepBarVO reservation = new StepBarVO();
        reservation.setCurrentStep(1);

        model.addAttribute("reservation", reservation);
        List<MovieVO> movies = reservationService.getAllMovies();
        model.addAttribute("movies", movies);
        return "step1_movie";

    }


}
