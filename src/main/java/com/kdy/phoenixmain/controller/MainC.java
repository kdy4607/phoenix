package com.kdy.phoenixmain.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MainC {
    // src/main/java/com/kdy/phoenixmain/controller/MainController.java 에 추가할 메서드

    @GetMapping("/credits")
    public String credits() {
        return "credits";
    }
}
