package com.starters.ityogurt.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.starters.ityogurt.dto.UserDTO;
import com.starters.ityogurt.error.ApiException;
import com.starters.ityogurt.service.UserService;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Controller
public class UserController {

    @Autowired
    @Qualifier("userservice")
    UserService userService;

    // 로그인 페이지
    @GetMapping("/user")
    public ModelAndView getLoginPage(HttpServletResponse response, HttpSession session,
        @RequestParam(defaultValue = "home", required = false) String access,
        @RequestParam(required = false) String knowSeq) {
        ModelAndView mv = new ModelAndView();

        if (session.getAttribute("user_seq") != null) {
            mv.setViewName("/index");
        } else {
            if (access.equals("mail")) {
                session.setAttribute("knowSeq",knowSeq);
            }
            else {
                session.removeAttribute("knowSeq");
            }
            mv.setViewName("/user/login");
        }

        return mv;
    }

    // 회원가입 페이지
    @GetMapping("/user/1")
    public String getSignUpPage(HttpSession session) {
        return "user/signUp";
    }

    @GetMapping("/user/check/{knowSeq}")
    public ModelAndView QuizLoginCheck(@PathVariable(value = "knowSeq") int knowSeq) {
        ModelAndView mv = new ModelAndView();
        mv.addObject("knowSeq", knowSeq);
        mv.setViewName("user/check");
        return mv;
    }

    // 이메일 인증 페이지
    @GetMapping("/user/verify/{user_seq}")
    public ModelAndView Verify(@PathVariable("user_seq") int userSeq) throws ApiException {
        ModelAndView mv = new ModelAndView();
        int result = userService.setIsPassByUserSeq(userSeq);
        String str = result == 1 ? "이메일 인증이 완료되었습니다." : "이메일 인증에 실패했습니다. 정보를 다시 확인해주세요";

        mv.addObject("result", str);
        mv.setViewName("user/verify");
        return mv;
    }

}
