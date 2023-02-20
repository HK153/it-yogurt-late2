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
<body>
	<div class="container">
		<%@include file="../common/header.jsp"%>
		<div class="content">
				<div>
				<form action="<%=request.getContextPath()%>" id="quizForm" method=post>
					<c:forEach items="${quizList }" var="list">
						<c:set var="length" value="${fn:length(quizList) }" />
							<input type="hidden" value="${list.knowSeq}" name="knowSeq">
							<input type="hidden" value="${list.quizSeq}" name="quizSeq">
							<input type="hidden" value="1" name="userSeq">
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
						<br> <input type="submit" id="checkAnswer" value="정답 확인" >
				</form>
					</div><!-- 전체 div -->
		</div><!-- content -->
		<%@include file="../common/footer.jsp"%>
	</div>
	
<script>
	$(document).ready(function() {
		//해설  n
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
</script>
</body>
</html>