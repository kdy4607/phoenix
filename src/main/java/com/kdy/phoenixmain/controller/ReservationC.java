package com.kdy.phoenixmain.controller;

import com.kdy.phoenixmain.vo.*;
import com.kdy.phoenixmain.service.ReservationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@Controller
@SessionAttributes("reservation")
public class ReservationC {

    @Autowired
    ReservationService reservationService;



    @GetMapping("/step1")
    public String step1(Model model) {
    StepBarVO reservation = new StepBarVO();
        List<MovieVO> movies = reservationService.getAllMovies();
        model.addAttribute("movies", movies);

        reservation.setCurrentStep(1);
        model.addAttribute("reservation", reservation);
        return "step1_movie";
    }

    @PostMapping("/step2")
    public String step2(@RequestParam("movie_id") int movieId,
                        @RequestParam("title") String title, Model model) {
        StepBarVO reservation = new StepBarVO();
        reservation.setMovie_id(movieId);
        reservation.setTitle(title);
        reservation.setCurrentStep(2);

        reservation.setCurrentStep(2);
        model.addAttribute("reservation", reservation);
        return "step2_date";
    }

    @PostMapping("/step3")
    public String step3(@RequestParam("reservationDate") String reservationDate,
                        @RequestParam("movie_id") int movieId,
                        @RequestParam("title") String title,
                        Model model) {
        StepBarVO reservation = new StepBarVO();

        reservation.setMovie_id(movieId); // 🔥 이걸 추가해야 값이 유지돼
        reservation.setTitle(title);
        reservation.setReservationDate(reservationDate);
        reservation.setCurrentStep(3);

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
    public String step4(
            @RequestParam("schedule_id") int scheduleId,
            @RequestParam("movie_id") int movieId,
            @RequestParam("reservationDate") String reservationDate,
            Model model,
            // ✨ @ModelAttribute로 reservation 객체를 인자로 받음 (세션 또는 모델에서 자동 주입)
            // 이를 통해 기존 reservation 객체의 상태를 이어받을 수 있습니다.
            @ModelAttribute("reservation") StepBarVO reservation) {

        // ⏱️ schedule_id로 런타임 정보 조회 (room_name 포함)
        RuntimeVO runtime = reservationService.getRuntimeById(scheduleId);

        // movie_id와 title은 step2에서 이미 reservation 객체에 설정되었을 것으로 가정
        // 또는 hidden input으로 받아서 다시 설정
        reservation.setMovie_id(movieId);
        // reservation.setTitle(title); // title이 hidden input으로 넘어오지 않으면 이전 step에서 설정된 값 사용

        reservation.setScheduleId(scheduleId); // schedule_id로 설정
        reservation.setReservationDate(reservationDate); // 선택된 예약 날짜 설정

        reservation.setStart_time(runtime.getStart_time());
        reservation.setPrice(runtime.getPrice());
        reservation.setAvailable_seats(runtime.getAvailable_seats());
        reservation.setRoom_id(runtime.getRoom_id());

        // ✨ runtime 객체에 이미 room_name이 있다면 바로 사용
        // 만약 selectRuntimeById 쿼리에 room_name이 없으면, 아래 로직으로 RoomVO를 따로 조회
        if (runtime.getRoom_name() != null) {
            reservation.setTheaterName(runtime.getRoom_name());
        } else {
            // RuntimeVO에 room_name이 직접 포함되지 않았다면, RoomVO를 별도로 조회
            RoomVO room = reservationService.getRoomById(runtime.getRoom_id());
            if (room != null) {
                reservation.setTheaterName(room.getRoom_name());
            } else {
                // 상영관 정보를 찾을 수 없을 경우 처리
                reservation.setTheaterName("알 수 없음");
            }
        }

        reservation.setCurrentStep(4);

        // ✨ 좌석 목록 불러오기
        List<SeatVO> seatList = reservationService.getSeatsByRoomId(runtime.getRoom_id());
        model.addAttribute("seatList", seatList);
        model.addAttribute("reservation", reservation); // 업데이트된 reservation 객체를 모델에 추가

        return "step4_seats";
    }

    @PostMapping("/step5")
    public String step5(@RequestParam("selectedSeats") List<String> selectedSeats,
                        @ModelAttribute("reservation") StepBarVO reservation,
                        Model model) {

        List<ReservationSeatVO> reservationSeatList = new ArrayList<>();

        for (String seatStr : selectedSeats) {
            if (seatStr == null || seatStr.length() < 2) continue;

            String row = seatStr.substring(0, 1); // 'A'
            int number = Integer.parseInt(seatStr.substring(1)); // '1'

            // seat_id 조회
            SeatVO seat = reservationService.getSeatByRoomRowNumber(reservation.getRoom_id(), row, number);
            if (seat != null) {
                ReservationSeatVO resSeat = new ReservationSeatVO();
                resSeat.setSeat_id(seat.getSeat_id());
                resSeat.setSeat_row(seat.getSeat_row());
                resSeat.setSeat_number(seat.getSeat_number());
                resSeat.setSeat_label(seat.getSeat_row() + seat.getSeat_number());

                reservationSeatList.add(resSeat);
            }
        }

        int totalPrice = reservation.getPrice() * reservationSeatList.size();

        model.addAttribute("selectedSeats", reservationSeatList);
        model.addAttribute("selectedSeatCount", reservationSeatList.size());
        model.addAttribute("totalPrice", totalPrice);
        model.addAttribute("reservation", reservation);

        return "step5_payment";
    }





}
