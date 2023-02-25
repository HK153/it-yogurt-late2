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
<title>정답 보기</title>

</head>
<%@include file="../common/nav.jsp"%>
<body>
<div class="container">
		<div class="content">
			<div>
				<table id="quizTbl">
					<c:set var="length" value="${fn:length(quizList) }" />
					<div style="margin-top: 400px;">
						<b>정답수 : ${userAnswerCnt}/3</b><br>
					</div>
					<div>
					<c:forEach items="${quizList }" var="list">
					
						<!-- 퀴즈번호 기재하기 위한 변수 선언 -->
						<c:set var="i" value="${i+1}" />
							<tr>
								<td id="num"><br> <br> <br> 
								Q. ${i}번<br><br>
								문제: ${list.question}<br> <br></td>
							</tr>
							
								<!-- 보기화면 -->
								<div id="${i}">
									<tr><td> 1. ${list.choice1}</td></tr>
									<tr><td> 2. ${list.choice2}</td></tr>
									<tr><td> 3. ${list.choice3}</td></tr>
									<tr><td> 4. ${list.choice4}</td></tr>
								</div>
								
								<!-- 정답 및 해설 -->
									<%-- 로그인sss --%>
									<c:if test="${userSeq ne 0}">
									<tr style="margin-top:200px;">
										<td>
											<div class="hideDiv">
											<br><b>정답: ${list.answer }</b><br>
											<c:forEach items="${learnList}" var="learn" begin="${i-1}" end="${i-1}">
													
													
													<!-- isRight가 1이면 정답 0이면 오답 -->
													<c:choose>
														<c:when test="${learn.isRight == 1}">
															<br>내가 입력한 답: <b style="color:blue;">${learn.userChoice}<br>
															<br>정답입니다.</b><br>
														</c:when>
														<c:otherwise>
															<br>내가 입력한 답: <b style="color:red;">${learn.userChoice}<br>
															<br>틀렸습니다.</b><br>
														</c:otherwise>
													</c:choose>
												</c:forEach>
												
													${list.commentary }
												
												</div>
											</td>
									</tr>
									</c:if>
									<%-- 비로그인 --%>
									
									<c:if test="${userSeq eq 0 }">
										<tr>
										<td>
											<div class="hideDiv">
											<br><b>정답: ${list.answer }</b><br>
											<c:forEach items="${isRight}" var="isRight" begin="${i-1}" end="${i-1}">
													<c:forEach items="${userChoice}" var="userChoice" begin="${i-1}" end="${i-1}">
													
<!-- 													isRight가 1이면 정답 0이면 오답 -->
													<c:choose>
														<c:when test="${isRight == 1}">
															<br>내가 입력한 답: <b style="color:blue;">${userChoice}<br>
															<br>정답입니다.</b><br>
														</c:when>
														<c:otherwise>
															<br>내가 입력한 답: <b style="color:red;">${userChoice}<br>
															<br>틀렸습니다.</b><br>
														</c:otherwise>
													</c:choose>
													</c:forEach>
												</c:forEach>
												
													${list.commentary }
												
												</div>
											</td>
									</tr>
									</c:if>
								</c:forEach>
								</div>
							</table>
					</div><!-- 전체 div -->
		</div><!-- content -->
	</div>
</body>
<%@include file="../common/footer.jsp"%>
</html>