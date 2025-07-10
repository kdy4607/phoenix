package com.kdy.phoenixmain.controller;

import com.kdy.phoenixmain.service.LoginService;
import com.kdy.phoenixmain.vo.LoginVO;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

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

    @PostMapping("/logout")
    @ResponseBody
    public Map<String, Object> logout(HttpSession session) {
        Map<String, Object> response = new HashMap<>();

        try {
            LoginVO user = (LoginVO) session.getAttribute("user");
            if (user != null) {
                System.out.println("🚪 로그아웃 처리 - 사용자: " + user.getU_name());
            }

            // 세션 무효화
            session.invalidate();

            response.put("success", true);
            response.put("message", "로그아웃이 완료되었습니다.");
            System.out.println("✅ 로그아웃 완료");

        } catch (Exception e) {
            System.err.println("❌ 로그아웃 오류: " + e.getMessage());
            e.printStackTrace();
            response.put("success", false);
            response.put("message", "로그아웃 중 오류가 발생했습니다.");
        }

        return response;
    }

    // ===== 마이페이지 관련 =====

    @GetMapping("/mypage")
    public String myPage(HttpSession session, Model model) {
        LoginVO user = (LoginVO) session.getAttribute("user");

        if (user == null) {
            return "redirect:/login?returnUrl=/mypage";
        }

        model.addAttribute("content", "myPageMain.jsp");
        model.addAttribute("user", user);
        return "myPage/myPageMain";
    }

    @GetMapping("/mypage/edit")
    public String myPageEdit(HttpSession session, Model model) {
        LoginVO user = (LoginVO) session.getAttribute("user");

        if (user == null) {
            return "redirect:/login?returnUrl=/mypage/edit";
        }

        model.addAttribute("content", "myPageEdit.jsp");
        model.addAttribute("user", user);
        return "myPage/myPageMain";
    }

    @PostMapping("/mypage/update")
    public String updateUser(@ModelAttribute("loginVO") LoginVO loginVO,
                             HttpSession session,
                             Model model) {

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
            model.addAttribute("content", "myPageMain.jsp");
            model.addAttribute("user", loginVO);

            System.out.println("✅ 회원 정보 수정 완료 - 사용자: " + loginVO.getU_name());

            return "myPage/myPageMain";

        } catch (Exception e) {
            System.err.println("❌ 회원 정보 수정 오류: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("errorMessage", "회원 정보 수정 중 오류가 발생했습니다.");
            model.addAttribute("content", "myPageEdit.jsp");
            model.addAttribute("user", user);
            return "myPage/myPageMain";
        }
    }

    @GetMapping("/mypage/delete")
    public String myPageDelete(HttpSession session, Model model) {
        LoginVO user = (LoginVO) session.getAttribute("user");

        if (user == null) {
            return "redirect:/login";
        }

        model.addAttribute("content", "myPageDelete.jsp");
        model.addAttribute("user", user);
        return "myPage/myPageMain";
    }

    @PostMapping("/mypage/deleteAccount")
    public String deleteAccount(@RequestParam("u_pw") String u_pw,
                                HttpSession session,
                                Model model) {

        LoginVO user = (LoginVO) session.getAttribute("user");

        if (user == null) {
            return "redirect:/login";
        }

        try {
            // 비밀번호 확인
            if (user.getU_pw().equals(u_pw)) {
                // 계정 삭제
                loginService.deleteLogin(user.getU_id());

                // 세션 무효화
                session.invalidate();

                System.out.println("✅ 계정 삭제 완료 - 사용자: " + user.getU_name());
                return "login/deleteComplete";

            } else {
                // 비밀번호 불일치
                model.addAttribute("errorMessage", "비밀번호가 일치하지 않습니다.");
                model.addAttribute("content", "myPageDelete.jsp");
                model.addAttribute("user", user);
                return "myPage/myPageMain";
            }

        } catch (Exception e) {
            System.err.println("❌ 계정 삭제 오류: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("errorMessage", "계정 삭제 중 오류가 발생했습니다.");
            model.addAttribute("content", "myPageDelete.jsp");
            model.addAttribute("user", user);
            return "myPage/myPageMain";
        }
    }

    // ===== 회원가입 관련 =====

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

    @PostMapping("/join/step3")
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

    @PostMapping("/join/complete")
    public String joinComplete(@ModelAttribute("loginVO") LoginVO user,
                               HttpSession session,
                               Model model) {

        // 주소가 빈 문자열인 경우 null로 설정
        if (user.getU_address() != null && user.getU_address().isEmpty()) {
            user.setU_address(null);
        }

        try {
            System.out.println("🆕 회원가입 시도 - ID: " + user.getU_id() + ", 이름: " + user.getU_name());

            // 회원 정보 저장
            loginService.insertLogin(user);

            // 회원가입 성공 시 자동 로그인
            session.setAttribute("user", user);

            model.addAttribute("message", "회원 가입이 성공적으로 완료되었습니다!");
            model.addAttribute("content", "joinCompletePage.jsp");

            System.out.println("✅ 회원가입 완료 - 사용자: " + user.getU_name());

            return "join/joinMain";

        } catch (Exception e) {
            System.err.println("❌ 회원가입 오류: " + e.getMessage());
            e.printStackTrace();
            model.addAttribute("errorMessage", "회원가입 중 오류가 발생했습니다. (이미 존재하는 아이디/닉네임 또는 기타 DB 문제)");
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