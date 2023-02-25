package com.starters.ityogurt.serviceimpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.starters.ityogurt.dao.QuizDAO;
import com.starters.ityogurt.dto.QuizDTO;
import com.starters.ityogurt.service.QuizService;

@Service("quizservice")
public class QuizServiceImpl implements QuizService {

	@Autowired
	QuizDAO dao;
	
	@Override
	public void uploadQuiz(QuizDTO dto) {
		dao.uploadQuiz(dto);
		
	}
	@Override
	public List<QuizDTO> getQuiz(int knowSeq) {
		return dao.getQuiz(knowSeq);
	}
	
	@Override
	public int getAnswer(int quizSeq) {
		return dao.getAnswer(quizSeq);
	}

	@Override
	public List<QuizDTO> getWeakQuizListByUser(int weakCategorySeq, int start, int end) {
		return dao.getWeakQuizListByUser(weakCategorySeq, start, end);
	}
}
