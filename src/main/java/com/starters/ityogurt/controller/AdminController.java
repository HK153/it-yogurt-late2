package com.starters.ityogurt.controller;

import java.util.List;
import java.util.Map;
import java.util.Optional;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.starters.ityogurt.dto.KnowledgeDTO;
import com.starters.ityogurt.dto.QuizDTO;
import com.starters.ityogurt.dto.UserDTO;
import com.starters.ityogurt.service.BlacklistService;
import com.starters.ityogurt.service.BoardService;
import com.starters.ityogurt.service.CommentService;
import com.starters.ityogurt.service.KnowledgeService;
import com.starters.ityogurt.service.LearnRecordService;
import com.starters.ityogurt.service.QuizService;
import com.starters.ityogurt.service.UserService;
import com.starters.ityogurt.util.Criteria;
import com.starters.ityogurt.util.Paging;


@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	@Qualifier("quizservice")
	QuizService quizService;
	
	@Autowired
	@Qualifier("knowledgeservice")
	KnowledgeService knowledgeService;
	
	@Autowired
	@Qualifier("userservice")
	UserService userService;

	@Autowired
	@Qualifier("blacklistservice")
	BlacklistService blacklistService;
	
	@Autowired
	@Qualifier("boardservice")
	BoardService boardService;
	
	@Autowired
	@Qualifier("commentservice")
	CommentService commentService;
	
	@Autowired
	@Qualifier("learnrecordservice")
	LearnRecordService learnRecordService;
	
	

	//관리자 마이페이지
	 @GetMapping("/page")
	    public String admin() {
	        return "admin/adminPage";
	    }

	 // 관리자 회원 조회
	 @GetMapping("/user")
	 public ModelAndView adminUser(Criteria cri) {
		 ModelAndView mv = new ModelAndView();
		 Paging paging = new Paging();
		 paging.setCri(cri); // 현재 페이지, 페이지당 보여줄 게시글의 개수
		 int totalUserCnt = userService.countAllUser();
		 int maxPage = (int)((double)totalUserCnt / cri.getPerPageNum() + 0.9); // 전체 페이지 수
		 paging.setTotalCount(totalUserCnt);
		 List<UserDTO> userList = userService.getAllUserlistLimit(cri);
		 
		 mv.addObject("maxPage", maxPage);
		 mv.addObject("paging", paging);
		 
		 mv.addObject("totalUserCnt", totalUserCnt);
		 mv.addObject("userList", userList);
		 mv.setViewName("admin/adminUser");
		 return mv;
	 }
	 // 관리자 회원 조회 ajax
	 @GetMapping(value ={"/user/a"})
	 @ResponseBody
	 public JSONObject adminUserAjax(Criteria cri) {
		 Paging paging = new Paging();
		 JSONObject jsonObjUser = new JSONObject();
		 paging.setCri(cri); // 현재 페이지, 페이지당 보여줄 게시글의 개수
		 int totalUserCnt = userService.countAllUser();
		 int maxPage = (int)((double)totalUserCnt / cri.getPerPageNum() + 0.9); // 전체 페이지 수
		 paging.setTotalCount(totalUserCnt);
		 List<UserDTO> userList = userService.getAllUserlistLimit(cri);
		 
		 jsonObjUser.put("maxPage", maxPage);
		 jsonObjUser.put("paging", paging);
		 
		 jsonObjUser.put("totalUserCnt", totalUserCnt);
		 jsonObjUser.put("userList", userList);
		 return jsonObjUser;
	 }

	 //관리자가 유저 탈퇴 시키기
	 @GetMapping("/user/manage/{userseq}")
	 public String deleteUser(@PathVariable("userseq") int userSeq) {
		 commentService.deleteComment(userSeq);
		 boardService.deleteBoard(userSeq);
		 learnRecordService.deleteLearnData(userSeq);
		 userService.deleteUser(userSeq);
		 return "redirect:/admin/user";
	 }

	 //관리자가 유저 블랙
	 @GetMapping("/user/manage/{userseq}/{email}")
	 public String blackUser(@PathVariable("userseq") int userSeq, @PathVariable("email") String email) {
		 blacklistService.insertBlackUser(email);
		 commentService.deleteComment(userSeq);
		 boardService.deleteBoard(userSeq);
		 learnRecordService.deleteLearnData(userSeq);
		 userService.deleteUser(userSeq);
		 return "redirect:/admin/user";
	 }



	 //컨텐츠 업로드 화면
	 @GetMapping("/contents")
	    public ModelAndView adminContents() {
		 	ModelAndView mv = new ModelAndView();
		 	int knowSeq = knowledgeService.getTotalCnt() + 1;
		 	mv.addObject("knowSeq", knowSeq);
		 	mv.setViewName("admin/adminContents");
	        return mv; 
	    }

	 //컨텐츠 업로드
   @PostMapping("/contents")
   @ResponseBody
	  	public void UploadContents(@RequestBody String data) {
	   		
	   		JSONParser jsonParser = new JSONParser();
			JSONArray insertParam = null;
			try {
				insertParam = (JSONArray) jsonParser.parse(data);
			} catch (ParseException e) {
				e.printStackTrace();
			}
			JSONObject insertData = new JSONObject();
			
			KnowledgeDTO knowledgeDto = new KnowledgeDTO();
			QuizDTO quizDto = new QuizDTO();
			String [] knowledgeData = new String [4]; 
			String [] quizData = new String[28]; 
			for(int i=0; i<4; i++){
				insertData = (JSONObject) insertParam.get(i);
				String value = (String) insertData.get("value");
				knowledgeData[i]= value;
				
			}
			knowledgeDto.setCategorySeq(Integer.parseInt(knowledgeData[0]));
			knowledgeDto.setUserSeq(Integer.parseInt(knowledgeData[1]));
			knowledgeDto.setTitle(knowledgeData[2]);
			knowledgeDto.setContent(knowledgeData[3]);
			knowledgeService.uploadKnowledge(knowledgeDto);

			
			for(int i=4; i<12; i++){
				insertData = (JSONObject) insertParam.get(i);
				String value = (String) insertData.get("value");
				quizData[i]= value;
				
			}
			quizDto.setQuestion(quizData[4]);
			quizDto.setChoice1(quizData[5]);
			quizDto.setChoice2(quizData[6]);
			quizDto.setChoice3(quizData[7]);
			quizDto.setChoice4(quizData[8]);
			quizDto.setAnswer(Integer.parseInt(quizData[9]));
			quizDto.setCommentary(quizData[10]);
			quizDto.setKnowSeq(Integer.parseInt(quizData[11]));
			quizService.uploadQuiz(quizDto);
			for(int i=12; i<20; i++){
				insertData = (JSONObject) insertParam.get(i);
				String value = (String) insertData.get("value");
				quizData[i]= value;
				
			}
			quizDto.setQuestion(quizData[12]);
			quizDto.setChoice1(quizData[13]);
			quizDto.setChoice2(quizData[14]);
			quizDto.setChoice3(quizData[15]);
			quizDto.setChoice4(quizData[16]);
			quizDto.setAnswer(Integer.parseInt(quizData[17]));
			quizDto.setCommentary(quizData[18]);
			quizDto.setKnowSeq(Integer.parseInt(quizData[19]));
			quizService.uploadQuiz(quizDto);
			for(int i=20; i<insertParam.size(); i++){
				insertData = (JSONObject) insertParam.get(i);
				String value = (String) insertData.get("value");
				quizData[i]= value;
				
			}
			quizDto.setQuestion(quizData[20]);
			quizDto.setChoice1(quizData[21]);
			quizDto.setChoice2(quizData[22]);
			quizDto.setChoice3(quizData[23]);
			quizDto.setChoice4(quizData[24]);
			quizDto.setAnswer(Integer.parseInt(quizData[25]));
			quizDto.setCommentary(quizData[26]);
			quizDto.setKnowSeq(Integer.parseInt(quizData[27]));
			quizService.uploadQuiz(quizDto);
			
   		}
	 
	}
