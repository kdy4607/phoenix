package com.kdy.phoenixmain.controller;

import com.kdy.phoenixmain.service.LoginService;
import com.kdy.phoenixmain.vo.LoginVO;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import jakarta.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Controller
public class LoginC {

    @Autowired
    private LoginService loginService;

    // ===== 로그인 관련 =====

    @GetMapping("/login")
    public String loginForm(@RequestParam(required = false) String returnUrl, Model model) {
        System.out.println("🔐 로그인 폼 요청 - returnUrl: " + returnUrl);
        model.addAttribute("returnUrl", returnUrl);
        return "login/login";  // login/login.jsp로 통일
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
                model.addAttribute("errorMessage", "아이디 또는 비밀번호가 올바르지 않습니다.");
                model.addAttribute("returnUrl", returnUrl);
                return "login/login";  // 실패 시에도 login/login.jsp로 통일
            }

        } catch (Exception e) {
            System.err.println("❌ 로그인 처리 오류: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("errorMessage", "로그인 중 오류가 발생했습니다.");
            model.addAttribute("returnUrl", returnUrl);
            return "login/login";  // 오류 시에도 login/login.jsp로 통일
        }
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/main";
    }

    // ===== 마이페이지 관련 =====

    @GetMapping("/mypage")
    public String myPageGet(HttpSession session,Model model) {

        LoginVO user = (LoginVO) session.getAttribute("user");

        if (user == null) {
            return "redirect:/login";
        }

        try {
            // 기존 사용자 ID 유지
            loginVO.setU_id(user.getU_id());

            // 사용자 정보 업데이트
            loginService.updateLogin(loginVO);

            // 세션 정보 업데이트
            session.setAttribute("user", loginVO);

            model.addAttribute("message", "회원 정보가 성공적으로 수정되었습니다.");
            model.addAttribute("content", "myPageHome.jsp");  // 수정 후 홈으로
            model.addAttribute("user", loginVO);

            System.out.println("✅ 회원 정보 수정 완료 - 사용자: " + loginVO.getU_name());

            return "myPage/myPageMain";
        } else {
            return "redirect:/login";
        }
    }


    @PostMapping("/mypage")
    public String myPagePost(@ModelAttribute(value = "user") LoginVO user,
                             @RequestParam("u_id") String u_id,
                             @RequestParam("u_pw") String u_pw,
                             HttpSession session,
                             Model model,
                             RedirectAttributes redirectAttributes) {

        System.out.println(u_id);
        System.out.println(u_pw);
        user = loginService.selectLoginById(u_id);

        if (u_id.isEmpty() || u_pw.isEmpty()) {
            redirectAttributes.addFlashAttribute("errorMessage", "Please enter <br> both your ID and Password.");
            return "redirect:/login";
        }

        if (user != null && user.getU_id() != null && user.getU_id().equals(u_id)
                && user.getU_pw() != null && user.getU_pw().equals(u_pw)) {
            session.setAttribute("user", user);
            model.addAttribute("user", user);
            return "myPage/myPageMain";
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Account does not exist, <br> Or entered the wrong ID or password");
            return "redirect:/login";
        }
    }

    @GetMapping("/mypage/profile")
    public String profile(@RequestParam(value = "u_id", required = false) String u_id,
                          HttpSession session,
                          RedirectAttributes redirectAttributes ,
                          Model model) {


        LoginVO user = (LoginVO) session.getAttribute("user");

        if (u_id == null || u_id.isEmpty()) {
            redirectAttributes.addFlashAttribute("errorMessage", "You are logged out.");
            return "redirect:/login";
        }

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
                              RedirectAttributes redirectAttributes,
                              HttpSession session,
                              Model model) {

        System.out.println(u_id);

        LoginVO user = (LoginVO) session.getAttribute("user");

        if (user == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "You are logged out.");
            return "redirect:/login";
        }

        session.setAttribute("user", user);

        if (user != null && user.getU_pw().equals(u_pw)) {
            model.addAttribute("content", "myPageGeneralInfo.jsp");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Password is not valid");
            model.addAttribute("content", "myPageProfile.jsp");
            return "redirect:/mypage/profile?u_id=" + u_id;
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

    @GetMapping("/mypage/general-info/update")
    public String generalInfoUpdate(HttpSession session,
                                    Model model) {
        LoginVO user = (LoginVO) session.getAttribute("user");
        model.addAttribute("content", "myPageUpdate.jsp");
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
                                   RedirectAttributes redirectAttributes,
                                   HttpSession session,
                                   Model model) {

        if (u_pw == null || u_pw.isEmpty()) {
            redirectAttributes.addFlashAttribute("errorMessage", "Please fill the password and name");
            model.addAttribute("user", user);
            return "redirect:/mypage/general-info/update";
        }

        if (u_address.length() > 500) {
            redirectAttributes.addFlashAttribute("errorMessage", "Address must be less than 500 characters");
            model.addAttribute("user", user);
            return "redirect:/mypage/general-info/update";
        }

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
            return "redirect:/mypage/general-info/update";
        }

        return "myPage/myPageMain";
    }

    @GetMapping("/mypage/deleteAccount")
    public String deleteAccount(@RequestParam("u_id") String u_id,
                                Model model) {
        model.addAttribute("content", "myPageDelete.jsp");
        model.addAttribute("user", user);
        return "myPage/myPageMain";
    }

    @PostMapping("/mypage/deleteAccount")
    public String deleted(@RequestParam("u_pw") String u_pw,
                          Model model,
                          RedirectAttributes redirectAttributes,
                          HttpSession session) {

        LoginVO user = (LoginVO) session.getAttribute("user");

        if (user == null) {
            redirectAttributes.addFlashAttribute("errorMessage", "You are logged out.");
            return "redirect:/login"; // 세션 없으면 로그인 페이지로
        }

        if (user.getU_pw().equals(u_pw)) {
            loginService.deleteLogin(user.getU_id());
            session.invalidate();
            return "login/deleteComplete";
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Passwords do not match");
            model.addAttribute("user", user);
            session.setAttribute("user", user);
            model.addAttribute("content", "myPageDelete.jsp");
            return "redirect:/mypage/deleteAccount?u_id=" + user.getU_id();
        }

    }

// JOIN //

    @GetMapping("/join/step1")
    public String joinStep1(Model model) {
        model.addAttribute("content", "joinFirstPage.jsp");
        return "join/joinMain";
    }

    @GetMapping("/join/step2")
    public String joinStep2(HttpSession session,
                            Model model) {
        LoginVO loginVO = (LoginVO) session.getAttribute("loginVO");
        model.addAttribute("loginVO", loginVO);
        model.addAttribute("content", "joinSecondPage.jsp");
        return "join/joinMain";
    }

    @PostMapping("/join/step2")
    public String joinStep2(@ModelAttribute("loginVO") LoginVO loginVO,
                            @RequestParam("u_ReEntered_pw") String u_ReEntered_pw,
                            RedirectAttributes redirectAttributes,
                            Model model) {

        if (u_ReEntered_pw == null || u_ReEntered_pw.isEmpty() || !u_ReEntered_pw.equals(loginVO.getU_pw())) {
            redirectAttributes.addFlashAttribute("errorMessage", "Passwords do not match");
            return "redirect:/join/step1";
        }

        if (loginVO.getU_id() == null || loginVO.getU_id().isEmpty()
                || loginVO.getU_pw() == null || loginVO.getU_pw().isEmpty()) {
            redirectAttributes.addFlashAttribute("errorMessage", "Please fill all the fields");
            model.addAttribute("content", "joinFirstPage.jsp");
            return "redirect:/join/step1";
        }

        // 아이디 중복 체크 (선택사항)
        try {
            LoginVO existingUser = loginService.findById(loginVO.getU_id());
            if (existingUser != null) {
                model.addAttribute("errorMessage", "이미 사용 중인 아이디입니다.");
                model.addAttribute("content", "joinFirstPage.jsp");
                return "join/joinMain";
            }
        } catch (Exception e) {
            // 사용자가 없으면 정상 (가입 가능)
        }

        model.addAttribute("loginVO", loginVO);
        model.addAttribute("content", "joinSecondPage.jsp");
        return "join/joinMain";
    }

    @PostMapping("join/step3")
    public String joinStep3(@ModelAttribute("loginVO") LoginVO loginVO,
                            HttpSession session,
                            Model model) {

        if (loginVO.getU_address().length() > 500) {
            model.addAttribute("content", "joinSecondPage.jsp");
            session.setAttribute("loginVO", loginVO);
            return "redirect:/join/step2";
        }

        if (loginVO.getU_name() == null || loginVO.getU_name().isEmpty()) {
            model.addAttribute("errorMessage", "성함을 입력해주세요.");
            model.addAttribute("content", "joinSecondPage.jsp");
            session.setAttribute("loginVO", loginVO);
            return "redirect:/join/step2";
        }

        model.addAttribute("loginVO", loginVO);
        model.addAttribute("content", "joinThirdPage.jsp");
        return "join/joinMain";
    }

    @PostMapping("join/complete")
    public String join(@ModelAttribute("loginVO") LoginVO user,
                       HttpSession session,
                       RedirectAttributes redirectAttributes,
                       Model model) {

        // 주소가 빈 문자열인 경우 null로 설정
        if (user.getU_address() != null && user.getU_address().isEmpty()) {
            user.setU_address(null);
        }

        if (user != null) {
            try {
                loginService.insertLogin(user);
                model.addAttribute("content", "joinCompletePage.jsp"); // 성공 페이지
                session.setAttribute("user", user);
                return "join/joinMain";

            } catch (Exception e) {
                e.printStackTrace(); // 콘솔에 오류 로그 출력
                redirectAttributes.addFlashAttribute("errorMessage", "Failed to register");
                return "redirect:/join/step1";
            }
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
            response.put("message", "로그인하지 않았습니다.");
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
        model.addAttribute("message", "로그인 테스트 페이지입니다.");
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