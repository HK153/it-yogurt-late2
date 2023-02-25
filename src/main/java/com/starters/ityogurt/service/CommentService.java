package com.starters.ityogurt.service;

import java.util.List;
import java.util.Map;

import com.starters.ityogurt.dto.CommentDTO;

public interface CommentService {
	
	void deleteComment (int userSeq);

	int countCommentByboardSeq(int boardSeq);

	void insertComment (CommentDTO dto);

	void updateComment(CommentDTO dto);

	List<Map<String,String>> getCommentList(int boardSeq);
	
	void deleteCommentByCommentSeq (int commentSeq);
	
	void deleteCommentByBoardSeq (int boardSeq);
}
