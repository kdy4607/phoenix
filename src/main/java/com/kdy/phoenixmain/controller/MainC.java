package com.kdy.phoenixmain.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MainC {

    @GetMapping("/credits")
    public String credits() {
        return "credits";
    }

    @GetMapping("/events")
    public String eventsPage() {
        return "events/events";  // events.jsp로 이동
    }
}
