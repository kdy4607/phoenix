package com.kdy.phoenixmain;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication(scanBasePackages = {"com.kdy.phoenixmain"})
public class PhoenixMainApplication {
    public static void main(String[] args) {
        SpringApplication.run(PhoenixMainApplication.class, args);
    }
}
