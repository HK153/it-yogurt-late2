package com.starters.ityogurt.service;

import java.util.List;

import com.starters.ityogurt.dto.QuizDTO;

public interface QuizService {

	List<QuizDTO> getQuiz(int knowSeq);

	void uploadQuiz (QuizDTO dto);

	int getAnswer(int quizSeq);

	List<QuizDTO> getWeakQuizListByUser(int userSeq, int start, int end);

}
