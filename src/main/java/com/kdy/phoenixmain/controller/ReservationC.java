package com.kdy.phoenixmain.controller;

import com.kdy.phoenixmain.vo.MovieVO;
import com.kdy.phoenixmain.vo.RoomVO;
import com.kdy.phoenixmain.vo.RuntimeVO;
import com.kdy.phoenixmain.vo.StepBarVO;
import com.kdy.phoenixmain.service.ReservationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class ReservationC {

    @Autowired
    ReservationService reservationService;


    StepBarVO reservation = new StepBarVO();

    @GetMapping("/step1")
    public String step1(Model model) {
        List<MovieVO> movies = reservationService.getAllMovies();
        model.addAttribute("movies", movies);

        reservation.setCurrentStep(1);
        model.addAttribute("reservation", reservation);
        return "step1_movie";
    }

    @PostMapping("/step2")
    public String step2(@RequestParam("movie_id") int movieId,
                        @RequestParam("title") String title, Model model) {
        reservation.setMovie_id(movieId);
        reservation.setTitle(title);
        reservation.setCurrentStep(2);

        reservation.setCurrentStep(2);
        model.addAttribute("reservation", reservation);
        return "step2_date";
    }

    @PostMapping("/step3")
    public String step3(@RequestParam("reservationDate") String reservationDate,
                        Model model) {

        // 선택된 날짜 저장
        reservation.setReservationDate(reservationDate);
        reservation.setCurrentStep(3);

        // 영화관 목록 가져오기
        List<RoomVO> rooms = reservationService.getAllRooms();
        model.addAttribute("rooms", rooms);
        model.addAttribute("reservation", reservation);

        return "step3_schedule";
    }

    @GetMapping("/step3/runtime")
    public String runtime(@RequestParam("room_id") int roomId,
                          @RequestParam("reservationDate") String reservationDate,
                          Model model) {

        List<RuntimeVO> runtimes = reservationService.getRuntimeByRoomAndDate(roomId, reservationDate);
        model.addAttribute("runtimes", runtimes);
        return "runtime_table"; // 이건 Ajax 등으로 불러올 수 있게 분리
    }

    @PostMapping("/step4")
    public String step4(@RequestParam("schedule_id") int scheduleId,
                        @RequestParam("movie_id") int movieId, // step3_schedule에서 hidden input으로 전달
                        @RequestParam("reservationDate") String reservationDate, // step3_schedule에서 hidden input으로 전달
                        Model model) {
        reservation.setCurrentStep(4);

        model.addAttribute("reservation", reservation);
        // 다음 단계(좌석 선택 등)를 위해 예약 객체를 전달합니다.
        return "step4_seats"; // 좌석 선택을 위한 JSP
    }


}
