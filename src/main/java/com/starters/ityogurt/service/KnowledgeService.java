package com.starters.ityogurt.service;

import java.util.List;
import java.util.Map;

import com.starters.ityogurt.dto.KnowledgeDTO;
import com.starters.ityogurt.dto.QuizDTO;
import com.starters.ityogurt.util.Criteria;

public interface KnowledgeService {

	List<KnowledgeDTO> getList(Map<Object, Object> map);

	int getTotalCnt();

	String getContents(int knowSeq);

	String getTitle(int knowSeq);

	void uploadKnowledge(KnowledgeDTO dto);

	void viewCnt(int knowSeq);

	List<KnowledgeDTO> getSearchList(String keyword);
  
	KnowledgeDTO getKnowledgeByCategorySeq(int categorySeq);

	int getCategoryCnt(String category);

	String getKnowledgeTitle(int knowSeq);

	int getCategorySeq(int knowSeq);




}
