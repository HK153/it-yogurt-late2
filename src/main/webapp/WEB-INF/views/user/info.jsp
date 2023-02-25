<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@include file="../common/tag.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="/css/header.css" rel="stylesheet">
<link href="/css/footer.css" rel="stylesheet">
<link href="/css/container.css" rel="stylesheet">
<!-- <link href="/css/login.css" rel="stylesheet"> -->
<link href="/css/quiz.css" rel="stylesheet">
<title>myPage</title>
<style type="text/css">
.myDiv{
height:80px;
border: 1px solid black;
margin: auto;
}
label {
    width: 180px;
    display: inline-block;
    margin-top: 23px;
    margin-left: 50px;
}
#infoBtn{
	width: 250px;
    height: 40px;
    border-style: solid;
    border-width: medium;
    margin: auto;
    border-color: #91ACCC;
    font-size: 20px;
}
#infoDiv{
	padding: 10% 30% 5% 30%;
}
</style>
</head>
<body>
	<div class="container">
		<%@include file="../common/header.jsp"%>
		<div class="content">
		<div style="display: block; width:100%;">
		<form action="<%=request.getContextPath()%>/mypage/newInfo/${userDto.userSeq}" method="post">
			<br>
			<p>당신의 새로운 정보를 입력해주세요!</p>
			<h1>${userDto.nickname}님!</h1><br><br>
			<b>유저정보</b>
			<div class="myDiv">
				<label>닉네임</label>
				<div style="display: inline;"> <input type="text" value="${userDto.nickname}" name="nickname"></div>
			</div>
			<div class="myDiv">
				<label>이메일</label>
				<div style="display: inline;"> ${userDto.email}</div>
			</div>
			<div class="myDiv">
				<label>phone</label>
				<div style="display: inline;"> <input type="text" value="${userDto.phone}" name="phone"></div>
			</div>
			<div class="myDiv">
				<label>가입일자</label>
				<div style="display: inline;"> ${userDto.insertDate}</div>
			</div>
			<div id="infoDiv">
				<input type="submit" value="수정하기" id="infoBtn">
			</div>	
			</form>
		</div>
		</div>
		<%@include file="../common/footer.jsp"%>
	</div>
</body>
</html>