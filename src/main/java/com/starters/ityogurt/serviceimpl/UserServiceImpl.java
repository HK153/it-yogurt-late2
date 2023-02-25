package com.starters.ityogurt.serviceimpl;

import com.starters.ityogurt.util.DateUtil;

import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Date;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.starters.ityogurt.service.EmailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.starters.ityogurt.dao.UserDAO;
import com.starters.ityogurt.dto.UserDTO;
import com.starters.ityogurt.service.UserService;
import com.starters.ityogurt.util.Criteria;
import org.springframework.web.bind.annotation.RequestParam;

@Service("userservice")
public class UserServiceImpl implements UserService {

    @Autowired
    UserDAO dao;


	  @Autowired
	  EmailServiceImpl emailService;

 	  @Override
	  public List<UserDTO> getAllUserlist(){
		  return dao.getAllUserlist();
	  }
    
	  @Override
	  public List<UserDTO> getAllUserlistLimit(Criteria cri){
		  return dao.getAllUserlistLimit(cri);
	  }

	  @Override
	  public int countAllUser(){
		  return dao.countAllUser();
	  }

	  @Override
	  public void deleteUser(int userSeq) {
		  dao.deleteUser(userSeq);
	  }

    @Override
    public int insertUser(UserDTO dto) {
        return dao.insertUser(dto);
    }

    @Override
    public UserDTO getUserByUserSeq(int userSeq) {
        return dao.getUserByUserSeq(userSeq);
    }

	  @Override
	  public UserDTO getUserByUserEmail(String email) {
		  return dao.getUserByUserEmail(email);
	  }
    
    @Override
    public int setIsPassByUserSeq(int userSeq) {
        return dao.setIsPassByUserSeq(userSeq);
    }

    @Override
    public int setLastLoginDateByUserSeq(int userSeq) {
        return dao.setLastLoginDateByUserSeq(userSeq);
    }

    @Override
    public void AfterLoginProcess(UserDTO result, HttpSession session) {
        setAttendanceByUserSeq(result);
        setLastLoginDateByUserSeq(result.getUserSeq());
        session.setAttribute("user_seq", result.getUserSeq());
    }

    @Override
    public int setAttendanceByUserSeq(UserDTO user) {
        DateUtil diff = new DateUtil();
        try {
            String afterDay = diff.afterOneDay(user.getLastloginDate(), 1);
            Boolean current = afterDay.split(" ")[0].equals(user.getLastloginDate().split(" ")[0]);
            int attendance = current ? user.getAttendance() + 1 : 0;

            return dao.setAttendanceByUserSeq(user.getUserSeq(), attendance);

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

	@Override
	public UserDTO getUserInfo(int userSeq) {
		return dao.getUserInfo(userSeq);
	}


	@Override
	public void updateUserInfo(Map<Object, Object> map) {
		dao.updateUserInfo(map);
		
	}

}
