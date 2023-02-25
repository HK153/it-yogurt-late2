package com.starters.ityogurt.serviceimpl;


import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.starters.ityogurt.dao.CommentDAO;
import com.starters.ityogurt.dto.CommentDTO;
import com.starters.ityogurt.service.CommentService;

@Service("commentservice")
public class CommentServiceImpl implements CommentService {
	
	@Autowired
	CommentDAO dao;

	@Override
	public void deleteComment(int userSeq) {
		dao.deleteComment(userSeq);
	}

	@Override
	public int countCommentByboardSeq(int boardSeq) {
		return dao.countCommentByboardSeq(boardSeq);
	}

	@Override
	public void insertComment(CommentDTO dto) {
		dao.insertComment(dto);
	}

	@Override
	public void updateComment(CommentDTO dto) {
		dao.updateComment(dto);
	}

	@Override
	public List<Map<String,String>> getCommentList(int boardSeq) {
		return dao.getCommentList(boardSeq);
	}

	@Override
	public void deleteCommentByCommentSeq(int commentSeq) {
		dao.deleteCommentByCommentSeq(commentSeq);
	}

	@Override
	public void deleteCommentByBoardSeq(int boardSeq) {
		dao.deleteCommentByBoardSeq(boardSeq);
	}
	
}
