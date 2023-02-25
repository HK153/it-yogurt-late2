package com.starters.ityogurt.controller;

import com.starters.ityogurt.dto.CategoryDTO;
import com.starters.ityogurt.dto.UserDTO;
import com.starters.ityogurt.error.ApiException;
import com.starters.ityogurt.service.CategoryService;
import com.starters.ityogurt.service.EmailService;
import com.starters.ityogurt.service.UserService;
import com.starters.ityogurt.util.DateUtil;
import com.starters.ityogurt.util.Encrypt;
import com.starters.ityogurt.error.ErrorCode;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Date;
import org.hamcrest.number.IsNaN;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
public class UserRestController {

    @Autowired
    @Qualifier("userservice")
    UserService userService;
    @Autowired
    @Qualifier("categoryservice")
    CategoryService categoryService;

    @Autowired
    EmailService emailService;

    // 회원가입
    @PostMapping("/user/1")
    public Object SignUp(UserDTO userDTO, CategoryDTO categoryDTO) throws Exception, ApiException {
        UserDTO isEmailValid = userService.getUserByUserEmail(userDTO.getEmail());
        if (isEmailValid != null) {
            throw new ApiException(ErrorCode.SIGNUP_INVALID_EMAIL);
        }
        CategoryDTO selectedCategory = categoryService.getCategoryByAllType(
            categoryDTO);

        if (userDTO.getPassword().equals("")) {
            userDTO.setPassword(null);
        }
        else {
            userDTO.setPassword(ConvertPassword(userDTO.getPassword()));
        }

        userDTO.setCategorySeq(selectedCategory.getCategorySeq());
        int result = userService.insertUser(userDTO);

        UserDTO newUser =userService.getUserByUserEmail(userDTO.getEmail());
        emailService.sendVerificationEmail(newUser);

        return true;
    }

    // 로그인
    @PostMapping("/user")
    public String Login(String knowSeq, UserDTO dto, HttpServletRequest request, HttpServletResponse response
    ) throws Exception {
        UserDTO result = userService.getUserByUserEmail(dto.getEmail());

        if (result == null) {
            throw new ApiException(ErrorCode.SIGNIN_INVALID_EMAIL);
        } else if (result.getPassword() == null || result.getPassword().equals("")) {
            throw new ApiException(ErrorCode.SIGNIN_INVALID_OAUTHUSER);
        } else {
            String pw = ConvertPassword(dto.getPassword());
            if (pw.equals(result.getPassword())) {
                HttpSession session = request.getSession();
                session.setAttribute("user_seq", result.getUserSeq());
            } else {
                throw new ApiException(ErrorCode.SIGNIN_INVALID_PASSWORD);
            }
        }

        userService.AfterLoginProcess(result,request.getSession());

        if(!isStringEmpty(knowSeq))
        {
            return "/quiz/"+knowSeq;
        }

        return "/";
    }

    // 로그아웃 임시(작동은 하나 오류남)
    @GetMapping("/user/o")
    public ModelAndView logout(HttpServletRequest request) {
        HttpSession session = request.getSession();
        ModelAndView mv = new ModelAndView();
        session.invalidate();
        mv.setViewName("/");
        return mv;
    }


    // 비밀번호 암호화
    String ConvertPassword(String pw) throws Exception {
        Encrypt crypto = new Encrypt();
        pw = crypto.encryptAES256(pw);
        return pw;
    }
    //endregion

    boolean isStringEmpty(String str) {
        return str == null || str.isEmpty() ;
    }
}
