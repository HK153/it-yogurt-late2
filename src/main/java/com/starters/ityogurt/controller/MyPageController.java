package com.starters.ityogurt.controller;

import com.starters.ityogurt.dto.LearnRecordDTO;
import com.starters.ityogurt.dto.LearnRecordQuizDTO;
import com.starters.ityogurt.dto.UserDTO;
import com.starters.ityogurt.service.LearnRecordQuizService;
import com.starters.ityogurt.service.LearnRecordService;
import com.starters.ityogurt.service.QuizService;
import com.starters.ityogurt.service.UserService;
import com.starters.ityogurt.util.Criteria;
import com.starters.ityogurt.util.Paging;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.starters.ityogurt.dto.CategoryDTO;
import com.starters.ityogurt.dto.LearnRecordDTO;
import com.starters.ityogurt.dto.LearnRecordQuizDTO;
import com.starters.ityogurt.dto.UserDTO;
import com.starters.ityogurt.service.CategoryService;
import com.starters.ityogurt.service.LearnRecordQuizService;
import com.starters.ityogurt.service.LearnRecordService;
import com.starters.ityogurt.service.UserService;
import com.starters.ityogurt.util.Criteria;
import com.starters.ityogurt.util.Paging;

@Controller
public class MyPageController {

    @Autowired
    @Qualifier("userservice")
    UserService userService;
    
    @Autowired
    @Qualifier("categoryservice")
    CategoryService categoryService;

    @Autowired
    @Qualifier("recodequizservice")
    LearnRecordQuizService service;

    @Autowired
    LearnRecordService recodeservice;

    @Autowired
    QuizService quizservice;

    @GetMapping("/mypage/wrong/{user_seq}")
    public String moveWrongQuizPage(){
        return "/quiz/wrong";
    }

    @GetMapping("/mypage/{user_seq}")
    public ModelAndView myPage(@PathVariable("user_seq") String user_seq) {
        ModelAndView mv = new ModelAndView();
        int userSeq = Integer.parseInt(user_seq);
        System.out.println("유저번호"+userSeq);
        UserDTO userDto = userService.getUserInfo(userSeq);
        CategoryDTO categoryDto = categoryService.getCategoryByUserSeq(userSeq);
        mv.addObject("categoryDto", categoryDto);
        mv.addObject("userDto", userDto);
        mv.setViewName("user/myPage");
        return mv;
    }

    @PostMapping("/mypage/info/{user_seq}")
    public ModelAndView info(@PathVariable("user_seq") String user_seq) {
        ModelAndView mv = new ModelAndView();
        int userSeq = Integer.parseInt(user_seq);
        System.out.println("유저번호"+userSeq);
        UserDTO userDto = userService.getUserInfo(userSeq);
        CategoryDTO categoryDto = categoryService.getCategoryByUserSeq(userSeq);
        mv.addObject("categoryDto", categoryDto);
        mv.addObject("userDto", userDto);
        mv.setViewName("user/info");
        return mv;
    }

    @PostMapping("/mypage/newInfo/{user_seq}")
    public ModelAndView newInfo(@PathVariable("user_seq") String user_seq, UserDTO userDto) {
        ModelAndView mv = new ModelAndView();
        int userSeq = Integer.parseInt(user_seq);
        System.out.println("유저번호2"+userSeq);
        System.out.println(userDto.getNickname()+userDto.getEmail()+userDto.getPhone());
        Map<Object,Object> map = new HashMap<>();
        map.put("nickname", userDto.getNickname());
        map.put("phone", userDto.getPhone());
        map.put("userSeq", userSeq);
        userService.updateUserInfo(map);
        userDto = userService.getUserInfo(userSeq);
       
        mv.addObject("userDto", userDto);
        mv.setViewName("user/myPage");
        return mv;
    }
    
    @GetMapping("/mypage/cancel/{user_seq}")
    public ModelAndView cancel(@PathVariable("user_seq") String user_seq) {
    	ModelAndView mv = new ModelAndView();
    	int userSeq = Integer.parseInt(user_seq);
    	userService.deleteUser(userSeq);
    	
    	mv.setViewName("user/login");
    	return mv;
    }
    

    // 틀린 문제 개수 가져오기. limit 기본값 : 5
    @GetMapping("/mypage/wrong/{user_seq}/list")
    @ResponseBody
    public ModelMap getWrongQuiz(Criteria cri,
        @PathVariable("user_seq") int userSeq,
        @RequestParam(defaultValue = "5") String perPageNum) {
        ModelMap m = new ModelMap();

        Paging paging = new Paging();
        cri.setPerPageNum(Integer.parseInt(perPageNum));
        paging.setCri(cri);

        int totalBoardCnt = service.getWrongAnswerCountByUser(userSeq);
        int maxPage = (int) ((double) totalBoardCnt / cri.getPerPageNum() + 0.9);
        List<LearnRecordQuizDTO> list = service.getWrongAnswerByUser(userSeq, cri.getPageStart(),
            cri.getPerPageNum());
        paging.setTotalCount(totalBoardCnt);
        m.addAttribute("maxPage", maxPage);
        m.addAttribute("paging", paging);
        m.addAttribute("quizList", list);

        return m;
    }

    //오답문제 정보 갱신 시
    @PutMapping("/mypage/wrong/answer/1")
    @ResponseBody
    public void updateWrongQuiz(@RequestBody LearnRecordDTO data) {
        recodeservice.updateLearnData(Integer.parseInt(data.getUserChoice()), data.getIsRight(),
            data.getUserSeq(), data.getQuizSeq());
    }

    // 많이 틀린 문제 페이지
    @GetMapping("/mypage/weak/{user_seq}/list")
    public ModelMap getWeakQuiz(Criteria cri,
        @PathVariable("user_seq") int userSeq,
        @RequestParam(defaultValue = "5") String perPageNum) {
        ModelMap m = new ModelMap();

        Paging paging = new Paging();
        cri.setPerPageNum(Integer.parseInt(perPageNum));
        paging.setCri(cri);

//        int totalBoardCnt =  quizservice.getWeakByUser();
//        int maxPage = (int) ((double) totalBoardCnt / cri.getPerPageNum() + 0.9);
//        List<LearnRecordQuizDTO> list = service.getWrongAnswerByUser(userSeq, cri.getPageStart(),
//            cri.getPerPageNum());
//        paging.setTotalCount(totalBoardCnt);
//        m.addAttribute("maxPage", maxPage);
//        m.addAttribute("paging", paging);
//        m.addAttribute("quizList", list);

        return m;
    }

}
