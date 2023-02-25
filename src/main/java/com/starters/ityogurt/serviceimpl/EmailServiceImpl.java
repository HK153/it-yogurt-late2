package com.starters.ityogurt.serviceimpl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.Future;

import com.amazonaws.services.simpleemail.AmazonSimpleEmailServiceAsync;
import com.starters.ityogurt.dao.EmailDAO;
import com.starters.ityogurt.dto.EmailDTO;
import com.starters.ityogurt.dto.KnowledgeDTO;
import com.starters.ityogurt.dto.UserDTO;
import com.starters.ityogurt.service.CategoryService;
import com.starters.ityogurt.service.EmailService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.amazonaws.services.simpleemail.AmazonSimpleEmailService;
import com.amazonaws.services.simpleemail.model.SendEmailResult;

import lombok.RequiredArgsConstructor;

@Slf4j
@Service("emailservice")
// @AllArgsConstructor
public class EmailServiceImpl implements EmailService {

    @Autowired
    EmailDAO dao;

    @Autowired
    private AmazonSimpleEmailServiceAsync amazonSimpleEmailServiceAsync;

    //이메일 전송하기
    public void send(String subject, String content, List<String> receivers) {

        //이메일 정보를 담은 객체 생성
        EmailDTO emailSenderDto = new EmailDTO(receivers, subject, content);

        Future<SendEmailResult> sendEmailResultFuture = amazonSimpleEmailServiceAsync.sendEmailAsync(emailSenderDto.toSendRequestDto());

        System.out.println(sendEmailResultFuture);
    }

    @Override
    public List<String> getAllEmails() {
        return dao.getAllEmails();
    }

    @Override
    public List<String> getSendEmailsSubJava() {
        return dao.getSendEmailsSubJava();
    }

    @Override
    public void updateSendDate(int categorySeq) {
        dao.updateSendDate(categorySeq);
    }

    private void sendingResultMustSuccess(SendEmailResult sendEmailResult) {
        if (sendEmailResult.getSdkHttpMetadata().getHttpStatusCode() != 200) {
            log.error("{}", sendEmailResult.getSdkResponseMetadata().toString());
        }
    }

    // 추가
    // 유저의 이메일과 유저가 선택한 소분류를 map에 담은 것을 반환한다.
    @Override
    public List<Map<String, Object>> getEmailAndSub() {
        return dao.getEmailAndSub();
    }

    // 소분류에서 어떤 상세분류를 보낼 것인지를 map에 담아 반환한다.
    @Override
    public List<Map<String, Object>> getSendDetail(int count) {
        return dao.getSendDetail(count);
    }


    @Override
    public void sendVerificationEmail(UserDTO userDTO) {
        List<String> userDto = new ArrayList<>();
        userDto.add(userDTO.getEmail());

        String title = "It-Yogurt 인증 메일입니다.";
        String content = "<div style=\"text-align : center;\">\n" +
                "  <h1>IT-Yogurt!</h1>\n" +
                "  <br><br><hr><br><br>\n" +
                "  <h2>It-Yogurt 인증 메일입니다.</h2>\n" +
                "  <br>\n" +
                "	</div>\n" +
                "	<div style=\"text-align: center;\"><br>\n" +
                "  <a href='http://localhost:8818/user/verify/"+ userDTO.getUserSeq() +"'>\n" +
                "    <button class=\"btn\" style=\"width: 200px; background-color: #86b7fe; padding: 15px 30px;\n"
                +
                "                 border-radius: 5px; color:white; font-size: 18px; font-weight: bold; cursor: pointer;\" >이메일 인증하기</button>\n"
                +
                "  </a><br><br>\n" +
                "</div>\n" +
                "<div class=\"footer\" style=\"text-align : center; background-color: #F9F2ED\">\n" +
                "  <div class=\"info\" ><br>\n" +
                "    ItYogurt / 대표: 김민지<br>\n" +
                "    서울특별시 용산구 용산동2가 1 - 34<br><br><br><br>\n" +
                "  </div>\n" +
                "</div>";

        send(title, content, userDto);

    }

}