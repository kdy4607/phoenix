package com.kdy.phoenixmain.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MainC {

    @GetMapping("/")
    public String index() {
        return "index";
    }


    @GetMapping("/credits")
    public String credits() {
        return "credits";
    }
}
