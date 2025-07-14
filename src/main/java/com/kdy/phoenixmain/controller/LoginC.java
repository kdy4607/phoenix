package com.kdy.phoenixmain.controller;

import com.kdy.phoenixmain.mapper.ReservationMapper;
import com.kdy.phoenixmain.mapper.TagMapper;
import com.kdy.phoenixmain.service.LoginService;
import com.kdy.phoenixmain.vo.LoginVO;
import com.kdy.phoenixmain.vo.TagVO;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class LoginC {

    @Autowired
    private LoginService loginService;

    @Autowired
    private TagMapper tagMapper;

    // ===== 로그인 관련 =====

    @GetMapping("/login")
    public String loginForm(@RequestParam(required = false) String returnUrl, Model model) {
        System.out.println("🔐 로그인 폼 요청 - returnUrl: " + returnUrl);
        model.addAttribute("returnUrl", returnUrl);
        return "login/login";
    }

    @PostMapping("/login")
    public String login(@RequestParam("u_id") String u_id,
                        @RequestParam("u_pw") String u_pw,
                        @RequestParam(required = false) String returnUrl,
                        HttpSession session,
                        Model model) {

        try {
            System.out.println("🔐 로그인 시도 - ID: " + u_id);

            // 사용자 인증
            LoginVO user = loginService.login(u_id, u_pw);

            if (user != null) {
                // 로그인 성공
                session.setAttribute("user", user);
                System.out.println("✅ 로그인 성공 - 사용자: " + user.getU_name());

                // 리턴 URL이 있으면 해당 페이지로, 없으면 메인 페이지로
                if (returnUrl != null && !returnUrl.isEmpty()) {
                    return "redirect:" + returnUrl;
                } else {
                    return "redirect:/";
                }

            } else {
                // 로그인 실패
                System.out.println("❌ 로그인 실패 - 잘못된 인증 정보");
                model.addAttribute("errorMessage", "Account does not exist, <br> or entered the wrong ID or password");
                model.addAttribute("returnUrl", returnUrl);
                return "login/login";
            }

        } catch (Exception e) {
            System.err.println("❌ 로그인 처리 오류: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("errorMessage", "Your can't log-in with a temporary error. <br> Please try again later.");
            model.addAttribute("returnUrl", returnUrl);
            return "login/login";
        }
    }

    // 로그아웃 (GET과 POST 둘 다 지원)
    @GetMapping("/logout")
    public String logoutGet(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }

    @PostMapping("/logout")
    public String logoutPost(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }

    // ===== 마이페이지 관련 =====

    @GetMapping("/mypage")
    public String myPageGet(HttpSession session, Model model) {

        LoginVO user = (LoginVO) session.getAttribute("user");

        if (user == null) {
            return "redirect:/login";
        }

        String homeName = user.getU_name().substring(0,  Math.min(user.getU_name().length(), 3));
        model.addAttribute("homeName", homeName);

        List<TagVO> tagList = tagMapper.selectAllTag();
        model.addAttribute("tagList", tagList);

        model.addAttribute("user", user);
        model.addAttribute("content", "myPageHome.jsp");
        return "myPage/myPageMain";
    }

    @PostMapping("/mypage")
    public String myPagePost(@RequestParam("u_id") String u_id,
                             @RequestParam("u_pw") String u_pw,
                             HttpSession session,
                             Model model,
                             RedirectAttributes redirectAttributes) {

        if (u_id.isEmpty() || u_pw.isEmpty()) {
            redirectAttributes.addFlashAttribute("errorMessage", "Please enter both your ID and Password.");
            return "redirect:/login";
        }

        LoginVO user = loginService.findById(u_id); // 올바른 메서드 사용

        if (user != null && user.getU_pw().equals(u_pw)) {
            session.setAttribute("user", user);
            model.addAttribute("user", user);
            model.addAttribute("content", "myPageHome.jsp");
            return "myPage/myPageMain";
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Account does not exist, or entered the wrong ID or password");
            return "redirect:/login";
        }
    }

    // ===== 마이페이지 프로필 관련 =====

    @GetMapping("/mypage/profile")
    public String profile(@RequestParam(value = "u_id", required = false) String u_id,
                          HttpSession session,
                          RedirectAttributes redirectAttributes,
                          Model model) {

        LoginVO user = (LoginVO) session.getAttribute("user");

        if (user == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "You are logged out.");
            return "redirect:/login";
        }

        if (u_id == null || u_id.isEmpty() || !user.getU_id().equals(u_id)) {
            redirectAttributes.addFlashAttribute("errorMessage", "Invalid access.");
            return "redirect:/login";
        }

        model.addAttribute("user", user);
        model.addAttribute("content", "myPageProfile.jsp");
        return "myPage/myPageMain";
    }

    @PostMapping("/mypage/general-info")
    public String generalInfo(@RequestParam("u_pw") String u_pw,
                              @RequestParam("u_id") String u_id,
                              RedirectAttributes redirectAttributes,
                              HttpSession session,
                              Model model) {

        LoginVO user = (LoginVO) session.getAttribute("user");

        if (user == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "You are logged out.");
            return "redirect:/login";
        }

        if (user.getU_pw().equals(u_pw)) {
            model.addAttribute("user", user);
            model.addAttribute("content", "myPageGeneralInfo.jsp");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Password is not valid");
            return "redirect:/mypage/profile?u_id=" + u_id;
        }

        return "myPage/myPageMain";
    }


    // ===== 마이페이지 극장 관련 =====

    @GetMapping("/mypage/theatres")
    public String theatres(@RequestParam("u_id") String u_id,
                           HttpSession session,
                           Model model) {

        LoginVO user = (LoginVO) session.getAttribute("user");

        if (user == null) {
            return "redirect:/login";
        } else {
            if (u_id.equals(user.getU_id())) {
                model.addAttribute("content", "myPageTheatres.jsp");
            }
            return "myPage/myPageMain";
        }

//        model.addAttribute("content", "myPageTheatres.jsp");
//        return "myPage/myPageMain";
    }

    // ===== 마이페이지 관람 이력 관련 =====

    @GetMapping("/mypage/history")
    public String history(@RequestParam("u_id") String u_id,
                          HttpSession session,
                          Model model) {

        LoginVO user = (LoginVO) session.getAttribute("user");

        if (user == null) {
            return "redirect:/login";
        } else {
            if (u_id.equals(user.getU_id())) {
                model.addAttribute("content", "myPageHistory.jsp");
            }
            return "myPage/myPageMain";
        }

//        model.addAttribute("content", "myPageHistory.jsp");
//        return "myPage/myPageMain";
    }

    // ===== 마이페이지 리워드 관련 =====

    @GetMapping("/mypage/reward")
    public String reward(@RequestParam("u_id") String u_id,
                         HttpSession session,
                         Model model) {
        LoginVO user = (LoginVO) session.getAttribute("user");

        if (user == null) {
            return "redirect:/login";
        } else {
            if (u_id.equals(user.getU_id())) {
                model.addAttribute("pointContent", "myPagePoint.jsp");
                model.addAttribute("couponContent", "myPageCoupon.jsp");
                model.addAttribute("content", "myPageReward.jsp");
            }
            return "myPage/myPageMain";
        }

//        model.addAttribute("pointContent", "myPagePoint.jsp");
//        model.addAttribute("couponContent", "myPageCoupon.jsp");
//        model.addAttribute("content", "myPageReward.jsp");
//        return "myPage/myPageMain";
    }

    @GetMapping("/mypage/reward/point")
    public String point(@RequestParam("u_id") String u_id,
                        HttpSession session,
                        Model model) {

        LoginVO user = (LoginVO) session.getAttribute("user");

        if (user == null) {
            return "redirect:/login";
        } else {
            if (u_id.equals(user.getU_id())) {
                model.addAttribute("content", "myPagePoint.jsp");
            }
            return "myPage/myPageMain";
        }

//        model.addAttribute("content", "myPagePoint.jsp");
//        return "myPage/myPageMain";

    }

    @GetMapping("/mypage/reward/coupon")
    public String coupon(@RequestParam("u_id") String u_id,
                         HttpSession session,
                         Model model) {

        LoginVO user = (LoginVO) session.getAttribute("user");

        if (user == null) {
            return "redirect:/login";
        } else {
            if (u_id.equals(user.getU_id())) {
                model.addAttribute("content", "myPageCoupon.jsp");
            }
            return "myPage/myPageMain";
        }

//        model.addAttribute("content", "myPageCoupon.jsp");
//        return "myPage/myPageMain";

    }

    // ===== 마이페이지 리마인더 관련 =====

    @GetMapping("/mypage/reminder")
    public String reminder(@RequestParam("u_id") String u_id,
                           HttpSession session,
                           Model model) {

        LoginVO user = (LoginVO) session.getAttribute("user");

        if (user == null) {
            return "redirect:/login";
        } else {
            if (u_id.equals(user.getU_id())) {
                model.addAttribute("content", "myPageReward.jsp");
            }
            return "myPage/myPageMain";
        }

//        model.addAttribute("content", "myPageReminder.jsp");
//        return "myPage/myPageMain";
    }

    @GetMapping("/mypage/wishlist")
    public String wishlist(@RequestParam("u_id") String u_id,
                           HttpSession session,
                           Model model) {

        LoginVO user = (LoginVO) session.getAttribute("user");

        if (user == null) {
            return "redirect:/login";
        } else {
            if (u_id.equals(user.getU_id())) {
                model.addAttribute("content", "myPageReward.jsp");
            }
            return "myPage/myPageMain";
        }

//        model.addAttribute("content", "myPageWishlist.jsp");
//        return "myPage/myPageMain";
    }


    // ===== 회원정보 수정 관련 =====

    @PostMapping("/mypage/general-info/update")
    public String generalInfoUpdate(HttpSession session, Model model) {
        LoginVO user = (LoginVO) session.getAttribute("user");

        if (user == null) {
            return "redirect:/login";
        }

        model.addAttribute("user", user);
        model.addAttribute("content", "myPageUpdate.jsp");
        return "myPage/myPageMain";
    }

    @PostMapping("/mypage/general-info/update/submit")
    public String generalInfoUpdateSubmit(@ModelAttribute("user") LoginVO userForm,
                                          @RequestParam("u_id") String u_id,
                                          @RequestParam("u_pw") String u_pw,
                                          @RequestParam("u_name") String u_name,
                                          @RequestParam(value = "u_birth", required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") Date u_birth,
                                          @RequestParam("u_address") String u_address,
                                          RedirectAttributes redirectAttributes,
                                          HttpSession session,
                                          Model model) {

        LoginVO sessionUser = (LoginVO) session.getAttribute("user");

        if (sessionUser == null) {
            return "redirect:/login";
        }

        if (u_pw == null || u_pw.isEmpty()) {
            redirectAttributes.addFlashAttribute("errorMessage", "Please fill the password");
            return "redirect:/mypage/general-info/update";
        }

        if (u_address != null && u_address.length() > 500) {
            redirectAttributes.addFlashAttribute("errorMessage", "Address must be less than 500 characters");
            return "redirect:/mypage/general-info/update";
        }

        try {
            // 업데이트할 사용자 정보 설정
            LoginVO updateUser = new LoginVO();
            updateUser.setU_id(sessionUser.getU_id()); // 세션의 ID 사용 (보안)
            updateUser.setU_pw(u_pw);
            updateUser.setU_name(u_name);
            updateUser.setU_birth(u_birth);
            updateUser.setU_address(u_address);

            // 회원 정보 업데이트
            loginService.updateLogin(updateUser); // 올바른 메서드 사용

            // 세션 정보 업데이트
            session.setAttribute("user", updateUser);

            model.addAttribute("user", updateUser);
            model.addAttribute("content", "myPageCheck.jsp");
            // JSP 내에서 안내 중이므로 삭제함.
            //model.addAttribute("message", "Successfully updated !");

        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Could not update information. <br> Please try again");
            return "redirect:/mypage/general-info/update";
        }

        return "myPage/myPageMain";
    }

    // ===== 회원탈퇴 관련 =====

    @GetMapping("/mypage/deleteAccount")
    public String deleteAccount(@RequestParam("u_id") String u_id,
                                HttpSession session,
                                Model model) {


        LoginVO user = (LoginVO) session.getAttribute("user");

        if (user == null || !user.getU_id().equals(u_id)) {
            return "redirect:/login";
        }

        model.addAttribute("content", "myPageDelete.jsp");
        model.addAttribute("user", user);
        return "myPage/myPageMain";
    }

    @PostMapping("/mypage/deleteAccount")
    public String deleteAccountSubmit(@RequestParam("u_pw") String u_pw,
                                      RedirectAttributes redirectAttributes,
                                      HttpSession session) {

        LoginVO user = (LoginVO) session.getAttribute("user");

        if (user == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "You are logged out.");
            return "redirect:/login";
        }

        if (user.getU_pw().equals(u_pw)) {
            try {
                loginService.deleteLogin(user.getU_id());
                session.invalidate();
                return "login/deleteComplete";
            } catch (Exception e) {
                redirectAttributes.addFlashAttribute("errorMessage", "Could not delete your account. <br> Please try again. <br><br> If you have a reservation left, you can't withdraw.  ");
                return "redirect:/mypage/deleteAccount?u_id=" + user.getU_id();
            }
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Passwords do not match");
            return "redirect:/mypage/deleteAccount?u_id=" + user.getU_id();
        }
    }

    // ===== 회원가입 관련 =====

    @GetMapping("/join/step1")
    public String joinStep1(Model model) {
        model.addAttribute("fontColor", "#FB4357");
        model.addAttribute("color", "#C8E465");
        model.addAttribute("content", "joinFirstPage.jsp");
        return "join/joinMain";
    }

    @GetMapping("/join/step2")
    public String joinStep2(HttpSession session, Model model) {
        LoginVO loginVO = (LoginVO) session.getAttribute("loginVO");
        model.addAttribute("loginVO", loginVO);
        model.addAttribute("content", "joinSecondPage.jsp");
        return "join/joinMain";
    }

    @PostMapping("/join/step2")
    public String joinStep2Post(@ModelAttribute("loginVO") LoginVO loginVO,
                                @RequestParam("u_ReEntered_pw") String u_ReEntered_pw,
                                RedirectAttributes redirectAttributes,
                                HttpSession session,
                                Model model) {

        if (u_ReEntered_pw == null || u_ReEntered_pw.isEmpty() || !u_ReEntered_pw.equals(loginVO.getU_pw())) {
            redirectAttributes.addFlashAttribute("errorMessage", "Passwords do not match");
            return "redirect:/join/step1";
        }

        if (loginVO.getU_id() == null || loginVO.getU_id().isEmpty()
                || loginVO.getU_pw() == null || loginVO.getU_pw().isEmpty()) {
            return "redirect:/join/step1";
        }

        // 아이디 중복 체크
        try {
            LoginVO existingUser = loginService.findById(loginVO.getU_id());
            if (existingUser != null) {
                redirectAttributes.addFlashAttribute("errorMessage", "This ID is already in use.");
                return "redirect:/join/step1";
            }
        } catch (Exception e) {
            // 사용자가 없으면 정상 (가입 가능)
        }

        session.setAttribute("loginVO", loginVO);
        model.addAttribute("loginVO", loginVO);
        model.addAttribute("fontColor", "#FB4357");
        model.addAttribute("color", "#C8E465");
        model.addAttribute("content", "joinSecondPage.jsp");
        return "join/joinMain";
    }

    @PostMapping("/join/step3")
    public String joinStep3(@ModelAttribute("loginVO") LoginVO loginVO,
                            RedirectAttributes redirectAttributes,
                            HttpSession session,
                            Model model) {

        if (loginVO.getU_address() != null && loginVO.getU_address().length() > 500) {
            redirectAttributes.addFlashAttribute("errorMessage", "Address Must be less than 500 characters.");
            session.setAttribute("loginVO", loginVO);
            return "redirect:/join/step2";
        }

        if (loginVO.getU_name() == null || loginVO.getU_name().isEmpty()) {
            redirectAttributes.addFlashAttribute("errorMessage", "Please enter your name.");
            session.setAttribute("loginVO", loginVO);
            return "redirect:/join/step2";
        }

        session.setAttribute("loginVO", loginVO);
        model.addAttribute("loginVO", loginVO);
        model.addAttribute("fontColor", "#FB4357");
        model.addAttribute("color", "#C8E465");
        model.addAttribute("content", "joinThirdPage.jsp");
        return "join/joinMain";
    }

    @PostMapping("/join/complete")
    public String joinComplete(@ModelAttribute("loginVO") LoginVO user,
                               HttpSession session,
                               RedirectAttributes redirectAttributes,
                               Model model) {

        // 주소가 빈 문자열인 경우 null로 설정
        if (user.getU_address() != null && user.getU_address().isEmpty()) {
            user.setU_address(null);
        }

        try {
            loginService.insertLogin(user);
            session.setAttribute("user", user);
            model.addAttribute("content", "joinCompletePage.jsp");
            return "join/joinMain";

        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("errorMessage", "Failed to register");
            return "redirect:/join/step1";
        }
    }

    // ===== 유틸리티 메서드 =====

    /**
     * 현재 로그인 사용자 정보 조회 (AJAX용)
     */
    @GetMapping("/user/current")
    @ResponseBody
    public Map<String, Object> getCurrentUser(HttpSession session) {
        Map<String, Object> response = new HashMap<>();

        LoginVO user = (LoginVO) session.getAttribute("user");

        if (user != null) {
            response.put("success", true);
            response.put("user", Map.of(
                    "id", user.getU_id(),
                    "name", user.getU_name(),
                    "loginId", user.getU_id()
            ));
        } else {
            response.put("success", false);
            response.put("message", "You are logged out.");
        }

        return response;
    }

    /**
     * 로그인 상태 확인 (AJAX용)
     */
    @GetMapping("/user/check")
    @ResponseBody
    public Map<String, Object> checkLoginStatus(HttpSession session) {
        Map<String, Object> response = new HashMap<>();

        LoginVO user = (LoginVO) session.getAttribute("user");

        response.put("isLoggedIn", user != null);
        if (user != null) {
            response.put("userName", user.getU_name());
            response.put("userId", user.getU_id());
        }

        return response;
    }

    // ===== 디버깅용 메서드 =====

    /**
     * 로그인 폼 테스트 (개발용)
     */
    @GetMapping("/login/test")
    public String loginTest(Model model) {
        System.out.println("🧪 로그인 테스트 페이지 접근");
        model.addAttribute("message", "This is the login test page.");
        return "login/login";
    }

    /**
     * 매핑 확인용 (개발용)
     */
    @RequestMapping(value = "/login/debug", method = {RequestMethod.GET, RequestMethod.POST})
    @ResponseBody
    public Map<String, Object> debugLogin(HttpServletRequest request) {
        Map<String, Object> response = new HashMap<>();
        response.put("method", request.getMethod());
        response.put("url", request.getRequestURL().toString());
        response.put("mapping", "OK");
        response.put("timestamp", System.currentTimeMillis());
        System.out.println("🐛 디버깅 - 메서드: " + request.getMethod() + ", URL: " + request.getRequestURL());
        return response;
    }
}