package com.kdy.phoenixmain.controller;

import com.kdy.phoenixmain.service.UserBookMServiceT;
import com.kdy.phoenixmain.vo.BookMarkVO;
import com.kdy.phoenixmain.vo.UserVO;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
public class UserBookMarkTC {

    @Autowired
    private UserBookMServiceT userBookMServiceT;

    @PostMapping("/bookmark")
    public String toggleBookmark(BookMarkVO dto, HttpSession session, Model model) {
        System.out.println("북마크 컨트롤러 진입CONCON");

        String userId = (String) session.getAttribute("userId");
        System.out.println("세션 userId = " + userId);

//        if (userId == null || !userId.equals(dto.getU_id())) {
//            System.out.println("세션없음 세션아이디 = 폼아이디");
//            return "redirect:/oneMovieDetail?movie_id=" + dto.getMovie_id();
//
//        }
        //return "redirect;/login";

        //북마크존재 확인용 + 저장 삭제
        boolean existsBookmark = userBookMServiceT.existsBookmark(dto.getU_id(), dto.getMovie_id());
        if (existsBookmark != true) {
            userBookMServiceT.save(dto.getU_id(), dto.getMovie_id());
            System.out.println("북마크에 저장됨" + dto.getU_id() + dto.getMovie_id());
            return "redirect:/oneMovieDetail?movie_id=" + dto.getMovie_id();
        }else {
            userBookMServiceT.delete(dto.getU_id(), dto.getMovie_id());
            System.out.println("북마크에tj 삭제됨" + dto.getU_id() + dto.getMovie_id());
            return "redirect:/oneMovieDetail?movie_id=" + dto.getMovie_id();
        }

//        int isStarmark = 0; // 별 유지시켜주기위한 컨트롤러
//        if(userId != null) {
//            isStarmark = userBookMServiceT.isStarmark(userId, dto.getMovie_id());
//        }
//        model.addAttribute("isBookmarked", isStarmark);
//
//        return "redirect:/oneMovieDetail?movie_id=" + dto.getMovie_id();
    }


}
