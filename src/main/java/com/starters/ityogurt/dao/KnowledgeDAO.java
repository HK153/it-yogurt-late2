package com.starters.ityogurt.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.starters.ityogurt.dto.KnowledgeDTO;
import com.starters.ityogurt.util.Criteria;

@Mapper
@Repository
public interface KnowledgeDAO {

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
