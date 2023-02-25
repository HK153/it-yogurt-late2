package com.starters.ityogurt.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.starters.ityogurt.dto.UserDTO;
import com.starters.ityogurt.util.Criteria;

@Mapper
@Repository
public interface UserDAO {
	
	List<UserDTO> getAllUserlist();
	
	List<UserDTO> getAllUserlistLimit(Criteria cri);

	int countAllUser();
	
	void deleteUser(int userSeq);
  
	int insertUser(UserDTO dto);

	UserDTO getUserByUserEmail(String email);

	Integer setIsPassByUserSeq(int userSeq);

	int setAttendanceByUserSeq(int userSeq, int attendance);

	int setLastLoginDateByUserSeq(int userSeq);

	UserDTO getUserByUserSeq(int userSeq);

	UserDTO getUserInfo(int userSeq);

	void updateUserInfo(Map<Object, Object> map);
	
	void updateUserDeclaration(int user_seq);

	int setWeakCategoryByUser(UserDTO userdto);

}

