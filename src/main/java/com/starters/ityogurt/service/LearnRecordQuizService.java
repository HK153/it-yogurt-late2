package com.starters.ityogurt.service;

import com.starters.ityogurt.dto.LearnRecordQuizDTO;
import java.util.List;

public interface LearnRecordQuizService {

	List<LearnRecordQuizDTO> getWrongAnswerByUser(int userSeq, int start, int limit);
	int getWrongAnswerCountByUser(int userSeq);
}
