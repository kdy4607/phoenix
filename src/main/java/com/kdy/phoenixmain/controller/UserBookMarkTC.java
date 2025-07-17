package com.kdy.phoenixmain.controller;

import com.kdy.phoenixmain.service.UserBookMServiceT;
import com.kdy.phoenixmain.vo.BookMarkVO;
import com.kdy.phoenixmain.vo.LoginVO;
import com.kdy.phoenixmain.vo.MovieVO;
import com.kdy.phoenixmain.vo.UserVO;
import jakarta.servlet.http.HttpSession;
import jakarta.websocket.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
public class UserBookMarkTC {

    @Autowired
    private UserBookMServiceT userBookMServiceT;

    @PostMapping("/bookmark")
    public String toggleBookmark(BookMarkVO dto, HttpSession session, Model model) {
        System.out.println("북마크 컨트롤러 진입CONCON");
        LoginVO uservo = (LoginVO) session.getAttribute("user");
        System.out.println("uservo = 뭐가나오나?1" + uservo);
        String user = uservo.getU_id();
        System.out.println("세션 userId = " + user);

//        if (userId == null || !userId.equals(dto.getU_id())) {
//            System.out.println("세션없음 세션아이디 = 폼아이디");
//            return "redirect:/oneMovieDetail?movie_id=" + dto.getMovie_id();
//
//        }
        //보안용 기능이라고 하는데 잘 모르겠음.
        //return "redirect;/login";

        //북마크존재 확인용 + 저장 삭제
        boolean existsBookmark = userBookMServiceT.existsBookmark(dto.getU_id(), dto.getMovie_id());
        if (existsBookmark != true) {
            userBookMServiceT.save(dto.getU_id(), dto.getMovie_id());
            System.out.println("북마크에 저장됨" + dto.getU_id() + dto.getMovie_id());
            return "redirect:/oneMovieDetail?movie_id=" + dto.getMovie_id();
        }else {
            userBookMServiceT.delete(dto.getU_id(), dto.getMovie_id());
            System.out.println("북마크에서 삭제됨" + dto.getU_id() + dto.getMovie_id());
            return "redirect:/oneMovieDetail?movie_id=" + dto.getMovie_id();
        }
    }

    @GetMapping("/userBookMarks")//마이페이지에서 북마크한거 보여주는거에요
    public String userBookMarks(Model model, HttpSession session ) {
    String u_id = (String) session.getAttribute("userId");
        System.out.println("유저북마크 진입 확인용");
    List<MovieVO> Bookmarks = userBookMServiceT.getBookMarkWhidMovie(u_id);
        System.out.println("북마크 수 확인용: " + Bookmarks.size());
        System.out.println("u_id = " + u_id);
        for (MovieVO movie : Bookmarks) { //뭐야?
            System.out.println(">> 영화 ID: " + movie.getMovie_id());
            System.out.println(">> 제목: " + movie.getTitle());
            System.out.println(">> 포스터 URL: " + movie.getPoster_url());
        }
    model.addAttribute("bookmarks", Bookmarks);
        return "testbookMforUser";
    }

}
