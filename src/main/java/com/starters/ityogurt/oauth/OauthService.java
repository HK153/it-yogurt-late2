package com.starters.ityogurt.oauth;

import com.starters.ityogurt.dto.UserDTO;
import com.starters.ityogurt.service.UserService;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;


@Component
public class OauthService {

    @Autowired
    @Qualifier("googleOauth")
    GoogleOauth googleOauth;

    @Autowired
    @Qualifier("kakaoOauth")
    KakaoOauth kakaoOauth;


    @Autowired
    NaverOauth naverOauth;

    @Autowired
    UserService UserService;

    public void request(SocialLoginType socialLoginType, HttpServletResponse response) {

        String redirectURL;
        switch (socialLoginType) {
            case GOOGLE: {
                redirectURL = googleOauth.getOauthRedirectURL();
                break;
            }
            case NAVER: {
                redirectURL = naverOauth.getOauthRedirectURL();
                break;
            }
            case KAKAO: {
                redirectURL = kakaoOauth.getOauthRedirectURL();
                break;
            }
            default: {
                throw new IllegalArgumentException("알 수 없는 소셜 로그인 형식입니다.");
            }
        }
        try {
            response.sendRedirect(redirectURL);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public String requestAccessToken(SocialLoginType socialLoginType, String code) {
        String access_token = "";
        String email = "";
        switch (socialLoginType) {
            case GOOGLE: {
                access_token = googleOauth.requestAccessToken(code);
                email = googleOauth.createUser(access_token);
                break;
            }
            case KAKAO: {
                access_token = kakaoOauth.requestAccessToken(code);
                email = kakaoOauth.createUser(access_token);
                break;
            }
            case NAVER: {
                access_token = naverOauth.requestAccessToken(code);
                email = naverOauth.createUser(access_token);
                break;
            }
            default: {
                throw new IllegalArgumentException("알 수 없는 소셜 로그인 형식입니다.");
            }
        }
        System.out.println(email);

        return email;
    }

    public String requestAccessTokenUsingURL(String code) {
        return googleOauth.requestAccessTokenUsingURL(code);
    }


}
