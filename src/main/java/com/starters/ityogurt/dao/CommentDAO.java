package com.starters.ityogurt.dao;


import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.starters.ityogurt.dto.CommentDTO;


@Mapper
@Repository
public interface CommentDAO {
	
	void deleteComment (int userSeq);
	
	int countCommentByboardSeq(int boardSeq);
	
	void insertComment (CommentDTO dto);

	void updateComment(CommentDTO dto);

	List<Map<String,String>> getCommentList(int boardSeq);
	
	void deleteCommentByCommentSeq (int commentSeq);
	
	void deleteCommentByBoardSeq (int boardSeq);
}
