package com.starters.ityogurt.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.starters.ityogurt.dao.KnowledgeDAO;
import com.starters.ityogurt.dto.CategoryDTO;
import com.starters.ityogurt.dto.KnowledgeDTO;
import com.starters.ityogurt.service.CategoryService;
import com.starters.ityogurt.service.KnowledgeService;
import com.starters.ityogurt.util.Criteria;
import com.starters.ityogurt.util.Paging;

import jakarta.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/knowledge")
public class KnowledgeController {

	@Autowired
	KnowledgeDAO dao;
	@Autowired
	@Qualifier("knowledgeservice")
	KnowledgeService service;
	
	@Autowired
	@Qualifier("categoryservice")
	CategoryService categoryService;

	// 게시판 리스트 화면
	@GetMapping("/list")
	public ModelAndView boardList(@RequestParam("category") String category, Criteria cri, HttpServletRequest request) throws Exception {
		ModelAndView mv = new ModelAndView();
		Paging paging = new Paging();
		int userSeq = 2;
		int limit = (cri.getPage() - 1) * 9;
		System.out.println("limit" + limit);
		paging.setCri(cri); // 현재 페이지, 페이지당 보여줄 게시글의 개수
		
		int categoryCnt = service.getCategoryCnt(category);
		int maxPage = (int) ((double) categoryCnt / cri.getPerPageNum() + 0.9); // 전체 페이지 수
		paging.setTotalCount(categoryCnt);

		Map<Object, Object> map = new HashMap<>();
		map.put("category", category);
		map.put("limit", limit);
		List<KnowledgeDTO> knowledgeList = service.getList(map);

		mv.addObject("maxpage", maxPage);
		mv.addObject("paging", paging);
		mv.addObject("knowledgeList", knowledgeList);
		mv.setViewName("knowledge/list");
		return mv;

	}

	// 게시판 리스트 화면 ajax
	@GetMapping(value = { "/list/a" })
	@ResponseBody
	public JSONObject boardListAjax(Criteria cri, @RequestParam String category) throws Exception {
		Paging paging = new Paging();
		int userSeq = 2;
		int limit = (cri.getPage() - 1) * 9;
		JSONObject jsonObjBoard = new JSONObject();
		paging.setCri(cri); // 현재 페이지, 페이지당 보여줄 게시글의 개수
		int totalCnt = service.getTotalCnt(); // 전체 게시글 수
		int maxPage = (int) ((double) totalCnt / cri.getPerPageNum() + 0.9); // 전체 페이지 수
		paging.setTotalCount(totalCnt);
		Map<Object, Object> map = new HashMap<>();
		map.put("userSeq", userSeq);
		map.put("limit", limit);
		map.put("category", category);
		List<KnowledgeDTO> knowledgeList = service.getList(map);
		System.out.println(knowledgeList.size());
		jsonObjBoard.put("maxPage", maxPage);
		jsonObjBoard.put("paging", paging);
		jsonObjBoard.put("knowledgeList", knowledgeList);
		return jsonObjBoard;

	}

	@GetMapping("/detail/{knowSeq}") // 매일지식 폼 확인
	public ModelAndView detail(@PathVariable("knowSeq") int knowSeq) {
		ModelAndView mv = new ModelAndView();
		String title = service.getTitle(knowSeq);
		String contents = service.getContents(knowSeq);
		service.viewCnt(knowSeq);
		
		String categorySeq = String.valueOf(service.getCategorySeq(knowSeq));
		CategoryDTO categoryInfo = categoryService.getCategoryByCategorySeq(categorySeq);
		
		
		mv.addObject("categoryInfo", categoryInfo);
		mv.addObject("knowSeq", knowSeq);
		mv.addObject("title", title);
		mv.addObject("contents", contents);
		mv.setViewName("knowledge/detail");
		return mv;
	}


	@RequestMapping("searchResult")
	public ModelAndView searchResult(String keyword) {
		ModelAndView mv = new ModelAndView();
		List<KnowledgeDTO> list = service.getSearchList(keyword);

		mv.addObject("list", list);
		mv.setViewName("knowledge/searchResult");
		return mv;
	}

}
