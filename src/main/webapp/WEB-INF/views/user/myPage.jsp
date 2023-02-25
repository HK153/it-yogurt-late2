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
		.myBtn{
			width: 250px;
			height: 40px;
			border-style: solid;
			border-width: medium;
			margin: auto;
			border-color: #91ACCC;
			font-size: 20px;
		}

		#myBtnDiv{
			padding: 10% 10% 5% 10%;
		}
		#deleteInfo{/* 태그 색상 변경 */
			float: right;
			color: black;
			text-decoration: underline;
		}

	</style>
</head>
<body>
<div class="container">
	<%@include file="../common/header.jsp"%>
	<div class="content">
		<div style="display: block; width:100%;">
<!--     	<h3>마이페이지</h3><br> -->
		<form action="<%=request.getContextPath()%>/mypage/info/${userDto.userSeq}" method="post">
			<br>
			<p>오늘의 지식과 퀴즈를 확인해보셨나요?</p>
			<h1>${userDto.nickname}님!</h1><br><br>
			<b>유저정보</b>
			<div class="myDiv">
				<label>닉네임</label>
				<div style="display: inline;"> ${userDto.nickname}</div>
			</div>
			<div class="myDiv">
				<label>이메일</label>
				<div style="display: inline;"> ${userDto.email}</div>
			</div>
			<div class="myDiv">
				<label>연락처</label>
				<div style="display: inline;"> ${userDto.phone}</div>
			</div>
			<div class="myDiv">
				<label>카테고리</label>
				<div style="display: inline;" id="category"> ${categoryDto.main} > ${categoryDto.middle} > ${categoryDto.sub}</div>
			</div>
			<div class="myDiv">
				<label>가입일자</label>
				<div style="display: inline;"> ${userDto.insertDate}</div>
			</div>
			<p id="deleteInfo"onclick="goDelete()">회원탈퇴</p>
			<div id="myBtnDiv">
				<input type="submit" value="정보수정하기" class="myBtn">
				<input type="button" value="오답노트" class="myBtn"  onclick="window.location.href='/mypage/wrong/${sessionScope.user_seq}'">
			</div>
			</form>
		</div>
	</div>
	<%@include file="../common/footer.jsp"%>
</div>
<script type="text/javascript">
	function goDelete(e){
		let con = confirm('정말 IT-Yogurt를 떠나시겠어요...?');
		if(con == true){
			alert('탈퇴되었습니다. 나중에 또 공부하러 오세요!');
			location.href="${pageContext.request.contextPath}/mypage/cancel/${sessionScope.user_seq}";
		}else{
			e.preventDefalut();

		}
	}
</script>
</body>
</html>