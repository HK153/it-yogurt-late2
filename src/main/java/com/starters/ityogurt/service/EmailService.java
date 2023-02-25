package com.starters.ityogurt.service;

import com.starters.ityogurt.dto.KnowledgeDTO;
import com.starters.ityogurt.dto.UserDTO;

import java.util.List;
import java.util.Map;

public interface EmailService {

    void send(String subject, String content, List<String> receivers);
    List<String> getAllEmails();
    List<String> getSendEmailsSubJava();
    void updateSendDate(int categorySeq);

    // 추가
    List<Map<String, Object>> getEmailAndSub();
    List<Map<String, Object>> getSendDetail(int count);

    void sendVerificationEmail(UserDTO userdto);

}
