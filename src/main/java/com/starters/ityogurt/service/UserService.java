package com.starters.ityogurt.service;

import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

import com.starters.ityogurt.dto.UserDTO;
import com.starters.ityogurt.util.Criteria;

public interface UserService {
	
	List<UserDTO> getAllUserlist();
	
	List<UserDTO> getAllUserlistLimit(Criteria cri);
	
	int countAllUser();
  
	int insertUser(UserDTO dto);

	void deleteUser(int userSeq);

	UserDTO getUserByUserEmail(String email);

	UserDTO getUserByUserSeq(int userSeq);

	int setIsPassByUserSeq(int userSeq);

	int setAttendanceByUserSeq(UserDTO user) throws Exception;
  
	int setLastLoginDateByUserSeq(int userSeq);

	void AfterLoginProcess(UserDTO result, HttpSession session);

	UserDTO getUserInfo(int userSeq);

	void updateUserInfo(Map<Object, Object> map);

	int setWeakCategoryByUser(UserDTO userdto);
	
	void updateUserDeclaration(int user_seq);

}
