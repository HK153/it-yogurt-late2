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
	<link href="/css/login.css" rel="stylesheet">
	<link href="/css/quiz.css" rel="stylesheet">
	<title>퀴즈 풀기</title>
</head>
<style>
	.content {
		margin-top: 20%;
	}
</style>
<%@include file="../common/nav.jsp"%>
<body>
<div class="container">
	<div class="content">
		<div id="quizListDiv">
			<form action="<%=request.getContextPath()%>" id="quizForm" method=post>
				<h4>${categoryInfo.main} > ${categoryInfo.middle} > ${categoryInfo.sub}</h4>
				<h1>${title}</h1>
				<c:forEach items="${quizList }" var="list">
					<c:set var="length" value="${fn:length(quizList) }" />
					<input type="hidden" value="${list.knowSeq}" name="knowSeq">
					<input type="hidden" value="${list.quizSeq}" name="quizSeq">
					<c:choose>
						<%--로그인했을때 --%>
						<c:when test="${sessionScope.user_seq ne null}">
							<input type="hidden" value="${sessionScope.user_seq}" name="userSeq">
						</c:when>
						<%-- 로그인 안했을때 --%>
						<c:otherwise>
							<input type="hidden" value="0" name="userSeq">
						</c:otherwise>
					</c:choose>
					<input type="hidden" value="${length}" name="length"><!-- 퀴즈 몇 개인지 -->
					<c:set var="i" value="${i+1}" />
					<table>
						<tr id="quizListTbl">
							<td id="num"><br> <br> <br> Q. ${i}번<br>
								<br> ${list.question}<br> <br></td>
						</tr>
						<!-- 보기화면 -->
						<div id="${i}">
							<tr>
								<td><input type="radio" value="1" id="radio1"
										   name="radio${i}" class="radio"> 1. ${list.choice1}</td>
							</tr>
							<tr>
								<td><input type="radio" value="2" id="radio2"
										   name="radio${i}" class="radio"> 2. ${list.choice2}</td>
							</tr>
							<tr>
								<td><input type="radio" value="3" id="radio3"
										   name="radio${i}" class="radio"> 3. ${list.choice3}</td>
							</tr>
							<tr>
								<td><input type="radio" value="4" id="radio4"
										   name="radio${i}" class="radio"> 4. ${list.choice4}</td>
							</tr>
						</div>
					</table>
				</c:forEach>
				<br> <input type="submit" value="정답 확인" class="a" >
				<input type="button" value="초기화" class="a" onclick="removeAll()">
			</form>
		</div><!-- 전체 div -->
	</div><!-- content -->
</div>
<script>
	//수정 필요
	$(document).ready(function() {
		//해설 n
		$("input:submit").click(function(e) {
			var length = $('input[name=length]').val(); //문제 길이 3
			var chk1 = $('input[name=radio1]:checked').val(); //1번 문제 체크된 값 가져오기
			var chk2 = $('input[name=radio2]:checked').val(); //2번 문제 체크된 값 가져오기
			var chk3 = $('input[name=radio3]:checked').val(); //3번 문제 체크된 값 가져오기
			var answer = 0;
			if(chk1 != undefined){ //1번 문제 체크되어있으면
				answer+=1; // +=1해주기
			}
			if(chk2 != undefined){
				answer+=1;
			}
			if(chk3 != undefined){
				answer+=1;
			}
			//문제 길이(3)와 체크된 값(answer) 길이가 동일하지 않으면 체크되지 않은 값이 있다는 것
			if(length != answer){
				alert('답을 체크하세요.');
				e.preventDefault();
			}else{
				$("form").attr("action","/answer");
			}
		});
	});
	function removeAll() {
		var obj = document.getElementsByClassName('radio');
		for (var i = 0; i < obj.length; i++) {
			obj[i].checked = false;
		}
	}
</script>
</body>
<%@include file="../common/footer.jsp"%>
</html>