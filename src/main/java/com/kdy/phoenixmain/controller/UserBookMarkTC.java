package com.kdy.phoenixmain.controller;

import com.kdy.phoenixmain.service.UserBookMServiceT;
import com.kdy.phoenixmain.vo.UserVO;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class UserBookMarkTC {

    @Autowired
    private UserBookMServiceT userBookMServiceT;

    // ✅ [로그인 폼 GET 요청] → 로그인 페이지를 보여줌
    @GetMapping("/login")
    public String loginForm() {
        return "/test/loginPageTest"; // loginPageTest.jsp (JSP 경로)
    }

    // ✅ [로그인 POST 요청] → 유저 정보 확인 후 세션 저장
    @PostMapping("/login")
    public String findByUsername(@RequestParam("username") String username, HttpSession session) {
        UserVO userVo = userBookMServiceT.findByUsername(username);

        if (userVo != null) {
            session.setAttribute("userId", userVo.getU_id());
            session.setAttribute("username", userVo.getU_name()); // ✅ 사용자 이름 저장
            return "redirect:/main";
        } else {
            return "redirect:/login?error";
        }
    }

    // ✅ [메인 페이지 GET 요청]
    @GetMapping("/main")
    public String mainPage() {
        return "/test/Main+logStatusTest"; // main.jsp
    }

    // 로그아웃
    @PostMapping("/logout")
    public String logout(HttpSession session) {
        Integer movieId = (Integer) session.getAttribute("lastMovieId");
        session.invalidate();
        if (movieId != null) {
            return "redirect:/oneMovieDetail?MOVIE_ID=" + movieId;
        } else {
            return "redirect:/main"; // 없을 경우 메인으로
        }
    }

    @GetMapping("/countinue") //북마크할수있도록 로그인상태로 페이지 넘김.
    public String showMovieDetailPage(HttpSession session) {
        Integer movieId = (Integer) session.getAttribute("lastMovieId");
        return "redirect:/oneMovieDetail?MOVIE_ID=" + movieId; // movieDetailView.jsp
    }

}
