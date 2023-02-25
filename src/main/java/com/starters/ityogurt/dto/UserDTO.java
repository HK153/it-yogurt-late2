package com.starters.ityogurt.dto;

import java.util.Date;
import lombok.Getter;
import lombok.Setter;
import org.springframework.stereotype.Component;

public class UserDTO { 
	
	int userSeq, declaration, allQuizCount, attendance, categorySeq, weakCategorySeq, isPass;
	String email, nickname, insertDate, img;
	String admin, phone, lastloginDate, password;
	String accessToken, refreshToken;
	
	public int getUserSeq() {
		return userSeq;
	}
	public void setUserSeq(int userSeq) {
		this.userSeq = userSeq;
	}
	public int getDeclaration() {
		return declaration;
	}
	public void setDeclaration(int declaration) {
		this.declaration = declaration;
	}
	public int getAllQuizCount() {
		return allQuizCount;
	}
	public void setAllQuizCount(int allQuizCount) {
		this.allQuizCount = allQuizCount;
	}
	public int getAttendance() {
		return attendance;
	}
	public void setAttendance(int attendance) {
		this.attendance = attendance;
	}
	public int getCategorySeq() {
		return categorySeq;
	}
	public void setCategorySeq(int categorySeq) {
		this.categorySeq = categorySeq;
	}
	public int getIsPass() {
		return isPass;
	}
	public void setIsPass(int isPass) {
		this.isPass = isPass;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getInsertDate() {
		return insertDate;
	}
	public void setInsertDate(String insertDate) {
		this.insertDate = insertDate;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public String getAdmin() {
		return admin;
	}
	public void setAdmin(String admin) {
		this.admin = admin;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getLastloginDate() {
		return lastloginDate;
	}
	public void setLastloginDate(String lastloginDate) {
		this.lastloginDate = lastloginDate;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getAccessToken() {
		return accessToken;
	}
	public void setAccessToken(String accessToken) {
		this.accessToken = accessToken;
	}
	public String getRefreshToken() {
		return refreshToken;
	}
	public void setRefreshToken(String refreshToken) {
		this.refreshToken = refreshToken;
	}

	public int getWeakCategorySeq() {
		return weakCategorySeq;
	}

	public void setWeakCategorySeq(int weakCategorySeq) {
		this.weakCategorySeq = weakCategorySeq;
	}
}
