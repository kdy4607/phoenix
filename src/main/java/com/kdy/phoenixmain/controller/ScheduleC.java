package com.kdy.phoenixmain.controller;

import com.kdy.phoenixmain.service.ScheduleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class ScheduleC {

    @Autowired
    private ScheduleService scheduleService;

    @GetMapping("schedule")
    public String schedule(Model model) {
//        model.addAttribute("schedules",  scheduleService.getAllReview() );
        return "schedule/schedule";
    }
}
