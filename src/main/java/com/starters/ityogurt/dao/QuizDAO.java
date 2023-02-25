package com.starters.ityogurt.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.starters.ityogurt.dto.QuizDTO;

@Mapper
@Repository
public interface QuizDAO {

	List<QuizDTO> getQuiz(int knowSeq);

	void uploadQuiz(QuizDTO dto);

	int getAnswer(int quizSeq);

	List<QuizDTO> getWeakQuizListByUser(int weakCategorySeq, int start, int end);
}
