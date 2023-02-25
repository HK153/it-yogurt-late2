package com.starters.ityogurt.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.ModelAndView;

import com.starters.ityogurt.dao.QuizDAO;
import com.starters.ityogurt.dto.CategoryDTO;
import com.starters.ityogurt.dto.LearnRecordDTO;
import com.starters.ityogurt.dto.QuizDTO;
import com.starters.ityogurt.service.CategoryService;
import com.starters.ityogurt.service.KnowledgeService;
import com.starters.ityogurt.service.LearnRecordService;
import com.starters.ityogurt.service.QuizService;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class QuizController {

	@Autowired
	QuizDAO dao;
	@Autowired
	@Qualifier("quizservice")
	QuizService service;
	
	@Autowired
	@Qualifier("learnrecordservice")
	LearnRecordService learnRecordService;
	
	@Autowired
	@Qualifier("knowledgeservice")
	KnowledgeService knowledgeService;
	
	@Autowired
	@Qualifier("categoryservice")
	CategoryService categoryService;
	
	@GetMapping("/quiz/{knowSeq}") //매일지식 폼 확인
	public ModelAndView quiz(@PathVariable("knowSeq") int knowSeq) {
		ModelAndView mv = new ModelAndView();
		List<QuizDTO> quizList = service.getQuiz(knowSeq);
		String knowledgeTitle = knowledgeService.getKnowledgeTitle(knowSeq);
		String categorySeq = String.valueOf(knowledgeService.getCategorySeq(knowSeq));
		CategoryDTO categoryInfo = categoryService.getCategoryByCategorySeq(categorySeq);
		
		mv.addObject("categoryInfo", categoryInfo);
		mv.addObject("title", knowledgeTitle);
		mv.addObject("quizList", quizList);
		mv.setViewName("quiz/list");		
		return mv;
	}
	
	//정답 페이지 보여주기(insert 관련)
	@PostMapping("/answer") 
	public String answer(int knowSeq, HttpServletRequest request, int radio1, int radio2, int radio3) {
		ModelAndView mv = new ModelAndView();
		int userSeq = Integer.parseInt(request.getParameter("userSeq"));
		//quiz번호들 저장하기
		String[] s1 = request.getParameterValues("quizSeq");
		int[] quizSeq = new int[s1.length]; 
		for(int i = 0;i<quizSeq.length;i++) {
			quizSeq[i]=Integer.parseInt(s1[i]);
		}
		
		//정답 가져오기
		int[] userChoice = {radio1,radio2,radio3}; //유저가 선택한 답 1, 2, 3번 
		int[] answer = new int[3];
		for(int i=0;i<userChoice.length;i++) {
			answer[i] = service.getAnswer(quizSeq[i]);	// 퀴즈 답 가져와서 배열에 넣기		
		}
		
		//user 입력 답이랑 정답 비교해서 정답이면 1, 오답이면 0
		int[] isRight = new int[3];
		for(int i=0;i<isRight.length;i++) {
			if(userChoice[i] == answer[i]) {
				isRight[i] = 1;						
			}else {
				isRight[i] = 0;
			}
		}
		
		int quizSeq1=quizSeq[0];
		int quizSeq2=quizSeq[1];
		int quizSeq3=quizSeq[2];
		
		//로그인한 유저일경우(db 저장 필요)
		if(userSeq != 0) {
			//이미 insert된 내용이 있는지 확인하기
			int choiceRecord = 0;
					choiceRecord = learnRecordService.getUserChoice(userSeq, quizSeq[0], quizSeq[1], quizSeq[2]); //해당 유저 번호의 총 갯수 가져오기			
					
			// 0보다 크면 update 진행, 아니면 insert 진행
			if(choiceRecord == 0) {//insert
				for(int i=0;i<userChoice.length;i++) { 
					learnRecordService.learnData(userChoice[i], isRight[i], userSeq, quizSeq[i]);
				}			
			}else {//update
				for(int i=0;i<userChoice.length;i++) { 
					learnRecordService.updateLearnData(userChoice[i], isRight[i], userSeq, quizSeq[i]);
				}
			}
			
			// 새로운 페이지로 redirect, 대신 필요한 값들 모두 url에 전달해주기
			return "redirect:/answerResult/"+quizSeq1+"/"+quizSeq2+"/"+quizSeq3+"/"+knowSeq+"/"+userSeq;
		
		}else{ //비로그인 유저인 경우(db저장 불필요)
			int userChoice1=userChoice[0];
			int userChoice2=userChoice[1];
			int userChoice3=userChoice[2];
			int isRight1=isRight[0];
			int isRight2=isRight[1];
			int isRight3=isRight[2];
			
			return "redirect:/answerResult2/"+quizSeq1+"/"+quizSeq2+"/"+quizSeq3+"/"+userChoice1+"/"+userChoice2+"/"+userChoice3+"/"+isRight1+"/"+isRight2+"/"+isRight3+"/"+knowSeq;
		}

	}

	//로그인 유저 정답 보여주기(가져와서 보여주기)
	@GetMapping("/answerResult/{quizSeq1}/{quizSeq2}/{quizSeq3}/{knowSeq}/{userSeq}")
	public ModelAndView answerResult(@PathVariable("quizSeq1") int quizSeq1, @PathVariable("quizSeq2") int quizSeq2,
			@PathVariable("quizSeq3") int quizSeq3, @PathVariable("knowSeq") int knowSeq, @PathVariable("userSeq") int userSeq, HttpServletRequest request) {
		
		ModelAndView mv = new ModelAndView();
		int userAnswerCnt = 0;
		//정답 갯수 가져오기
		
		//체크한 답 보여줘야 하니 learn_record 불러오기
		List<LearnRecordDTO> learnList = learnRecordService.getLearn(quizSeq1,quizSeq2,quizSeq3);
		
		for(LearnRecordDTO l : learnList) {
			userAnswerCnt += l.getIsRight();
		}
		
		//퀴즈 내용 불러와야 하니까 리스트 가져옴
		List<QuizDTO> quizList = service.getQuiz(knowSeq);
		mv.addObject("quizList", quizList);
		mv.addObject("learnList", learnList);
		mv.addObject("userSeq", userSeq);
		mv.addObject("userAnswerCnt", userAnswerCnt);
		mv.setViewName("quiz/answer");
		return mv;
	}
	
	//비로그인 유저 정답 보여주기
		@GetMapping("/answerResult2/{quizSeq1}/{quizSeq2}/{quizSeq3}/{userChoice1}/{userChoice2}/{userChoice3}/{isRight1}/{isRight2}/{isRight3}/{knowSeq}")
		public ModelAndView answerResult2(@PathVariable("quizSeq1") int quizSeq1, @PathVariable("quizSeq2") int quizSeq2, @PathVariable("quizSeq3") int quizSeq3, 
				@PathVariable("userChoice1") int userChoice1, @PathVariable("userChoice2") int userChoice2, @PathVariable("userChoice3") int userChoice3, 
				@PathVariable("isRight1") int isRight1, @PathVariable("isRight2") int isRight2, @PathVariable("isRight3") int isRight3, @PathVariable("knowSeq") int knowSeq, HttpServletRequest request) {
			
			ModelAndView mv = new ModelAndView();
			
			//정답 갯수 가져오기
			
			int userSeq = 0; //비로그인 유저니까 임시로 값 0 넣어줌
			int[] userChoice = {userChoice1, userChoice2, userChoice3};
			int[] isRight = {isRight1, isRight2, isRight3};
			int userAnswerCnt = 0;
			for(int i=0;i<isRight.length;i++) {
				if(isRight[i] == 1) {
					userAnswerCnt+=1;
				}
			}
			
			//체크한 답 보여줘야 하니 learn_record 불러오기
			List<LearnRecordDTO> learnList = learnRecordService.getLearn(quizSeq1,quizSeq2,quizSeq3);
				
			List<QuizDTO> quizList = service.getQuiz(knowSeq);
			mv.addObject("userChoice",userChoice);
			mv.addObject("isRight", isRight);
			mv.addObject("quizList", quizList);
			mv.addObject("userSeq", userSeq);
			mv.addObject("userAnswerCnt",userAnswerCnt);
			mv.setViewName("quiz/answer");
			return mv;
		}
	
	
}
