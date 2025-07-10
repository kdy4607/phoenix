package com.kdy.phoenixmain.controller;

import com.kdy.phoenixmain.service.LoginService;
import com.kdy.phoenixmain.vo.LoginVO;
import jakarta.servlet.http.HttpSession;
import org.apache.jasper.tagplugins.jstl.core.Redirect;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.support.SessionStatus;


import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

@Controller
public class LoginC {

    @ModelAttribute
    public LoginVO setLoginVO() {
        return new LoginVO();
    }

    @Autowired
    public LoginService loginService;

    // MAIN //

    @GetMapping("/main")
    public String main() {
        return "index";
    }

    @PostMapping("/main")
    public String getMain() {
        return "index";
    }

    // LOGIN //

    @GetMapping("/login")
    public String loginGet(Model model) {
        return "login/login";
    }

    @PostMapping("/login")
    public String loginPost(Model model) {
        return "login/login";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "index";
    }

    // MY PAGE //

    @GetMapping("/mypage")
    public String myPageGet(HttpSession session,
                            Model model) {
        LoginVO user = (LoginVO) session.getAttribute("user");

        if (user == null) {
            return "redirect:/login";
        } else if (user.getU_id() != null && !user.getU_id().isEmpty()) {
            session.setAttribute("user", user);
            model.addAttribute("user", user);
            model.addAttribute("content", "myPageHome.jsp");
            return "myPage/myPageMain";
        } else {
            return "login/login";
        }
    }


    @PostMapping("/mypage")
    public String myPagePost(@ModelAttribute(value = "user") LoginVO user,
                             @RequestParam("u_id") String u_id,
                             @RequestParam("u_pw") String u_pw,
                             HttpSession session,
                             Model model) {

        System.out.println(u_id);
        System.out.println(u_pw);
        user = loginService.selectLoginById(u_id);

        if (user != null && user.getU_id() != null && user.getU_id().equals(u_id)
                && user.getU_pw() != null && user.getU_pw().equals(u_pw)) {
            session.setAttribute("user", user);
            model.addAttribute("user", user);
            model.addAttribute("content", "myPageHome.jsp");
            return "myPage/myPageMain";
        } else {
            return "redirect:/login";
        }

    }

    @GetMapping("/mypage/profile")
    public String profile(@RequestParam("u_id") String u_id,
                          HttpSession session,
                          Model model) {


        LoginVO user = loginService.selectLoginByID(u_id);

        System.out.println(u_id);
        System.out.println(user.getU_id());

        if (user != null) {
            if (user.getU_id().equals(u_id)) {
                model.addAttribute("user", user);
                session.setAttribute("user", user);
                model.addAttribute("content", "myPageProfile.jsp");
            }
        } else {
            return "redirect:/login";
        }
        return "myPage/myPageMain";

    }

    @PostMapping("/mypage/general-info")
    public String generalInfo(@RequestParam("u_pw") String u_pw,
                              @RequestParam("u_id") String u_id,
                              HttpSession session,
                              Model model) {

        System.out.println(u_id);

        LoginVO user = (LoginVO) session.getAttribute("user");
        session.setAttribute("user", user);

        if (user != null && user.getU_pw().equals(u_pw)) {
            model.addAttribute("content", "myPageGeneralInfo.jsp");
        } else {
            model.addAttribute("content", "myPageProfile.jsp");
            return "myPage/myPageMain";
        }


        String trimmed_u_pw = (u_pw != null) ? user.getU_pw().trim() : null;
        if (trimmed_u_pw == null || trimmed_u_pw.isEmpty()) {
            model.addAttribute("user", user);
            model.addAttribute("content", "myPageProfile.jsp");
        } else {
            model.addAttribute("user", user);
            model.addAttribute("content", "myPageGeneralInfo.jsp");
        }

        return "myPage/myPageMain";

    }

    @PostMapping("/mypage/general-info/update")
    public String generalInfoUpdate(@ModelAttribute("user") LoginVO user, Model model) {
        model.addAttribute("content", "myPageUpdate.jsp");
        return "myPage/myPageMain";
    }

    @PostMapping("/mypage/general-info/update/submit")
    public String generalInfoCheck(@ModelAttribute("user") LoginVO user,
                                   @RequestParam("u_id") String u_id,
                                   @RequestParam("u_pw") String u_pw,
                                   @RequestParam("u_name") String u_name,
                                   @RequestParam("u_birth_before") String u_birth_before,
                                   @RequestParam(value = "u_birth", required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date u_birth,
                                   @RequestParam("u_address") String u_address,
                                   HttpSession session,
                                   Model model) {

        Date finalUBirth = null;
        if (u_birth != null) {
            finalUBirth = u_birth;
        } else if (u_birth == null && u_birth_before != null && u_birth_before.isEmpty()) {
            finalUBirth = null;
        } else {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            try {
                finalUBirth = sdf.parse(u_birth_before);
            } catch (ParseException e) {
                throw new RuntimeException(e);
            }
        }

        if (u_pw != null && !u_pw.isEmpty()
                && u_id != null && !u_id.isEmpty()
                && u_name != null && !u_name.isEmpty()
        ) {
            user.setU_pw(u_pw);
            user.setU_id(u_id);
            user.setU_name(u_name);
            user.setU_birth(finalUBirth);
            user.setU_address(u_address);
            loginService.updateLogins(user);
            session.setAttribute("user", user);
            model.addAttribute("user", user);
            model.addAttribute("content", "myPageCheck.jsp");
        } else {
            return "login/login";
        }

        return "myPage/myPageMain";
    }

    @GetMapping("/mypage/DeleteAccount")
    public String deleteAccount(@RequestParam("u_id") String u_id,
                                Model model) {
        model.addAttribute("content", "myPageDelete.jsp");
        return "myPage/myPageMain";
    }

    @PostMapping("/mypage/deleteeAccount")
    public String deleted(@RequestParam("u_pw") String u_pw,
                          Model model,
                          HttpSession session) {

        LoginVO user = (LoginVO) session.getAttribute("user");

        if (user != null && user.getU_pw().equals(u_pw)) {
            loginService.deleteLogin(user.getU_id());
            session.invalidate();
            return "login/deleteComplete";
        } else {
            model.addAttribute("content", "myPageDelete.jsp");
            model.addAttribute("user", user);
            return "myPage/myPageMain";
        }

    }

// JOIN //

    @GetMapping("/join/step1")
    public String joinStep1(Model model) {
        model.addAttribute("loginVO", new LoginVO());
        model.addAttribute("content", "joinFirstPage.jsp");
        return "join/joinMain";
    }

    @PostMapping("/join/step2")
    public String joinStep2(@ModelAttribute("loginVO") LoginVO loginVO, Model model) {
        if (loginVO.getU_id() == null || loginVO.getU_id().isEmpty()
                || loginVO.getU_pw() == null || loginVO.getU_pw().isEmpty()) {
            model.addAttribute("errorMessage", "아이디와 비밀번호는 필수 입력 사항입니다.");
            model.addAttribute("content", "joinFirstPage.jsp");
            return "join/joinMain";
        }
        model.addAttribute("loginVO", loginVO);
        model.addAttribute("content", "joinSecondPage.jsp");
        return "join/joinMain";

    }

    @PostMapping("join/step3")
    public String joinStep3(@ModelAttribute("loginVO") LoginVO loginVO, Model model) {

        if (loginVO.getU_name() == null || loginVO.getU_name().isEmpty()) {
            model.addAttribute("errorMessage", "성함을 입력해주세요.");
            model.addAttribute("content", "joinSecondPage.jsp");
            return "join/joinMain";
        }

        model.addAttribute("loginVO", loginVO);
        model.addAttribute("content", "joinThirdPage.jsp");
        return "join/joinMain";
    }

    @PostMapping("join/complete")
    public String join(@ModelAttribute("loginVO") LoginVO user,
                       HttpSession session, Model model) {

        if (user.getU_address() != null && user.getU_address().isEmpty()) {
            user.setU_address(null);
        }

        if (user != null) {
            try {
                loginService.insertLogin(user);
                model.addAttribute("message", "회원 가입이 성공적으로 완료되었습니다!");
                model.addAttribute("content", "joinCompletePage.jsp"); // 성공 페이지
                session.setAttribute("user", user);
                return "join/joinMain";

            } catch (Exception e) {
                e.printStackTrace(); // 콘솔에 오류 로그 출력
                model.addAttribute("errorMessage", "회원가입 중 오류가 발생했습니다. (이미 존재하는 아이디/닉네임 또는 기타 DB 문제)");
                return "redirect:/join/step1";
            }
        }
        return "redirect:/join/complete";
    }

}

