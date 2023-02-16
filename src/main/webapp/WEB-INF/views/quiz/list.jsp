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
<title>퀴즈 풀기</title>
<style type="text/css">
#hideDiv {
	display: none;
}

#num {
	height: 90px;
}
</style>
<script>
	$(document).ready(function() {
		//해설
		$("input:submit").click(function(e) {
			//답이 모두 체크되었을때
			if ($("#hideDiv").css("display") == "none") {
				e.preventDefault();
				$("#hideDiv").show();
				
				$("#checkAnswer").hide();
				$("#radio1").hide();
				$("#radio2").hide();
				$("#radio3").hide();
				$("#radio4").hide();
			}

		});

	});
</script>
</head>
<body>
	<div class="container">
		<%@include file="../common/header.jsp"%>
		<div class="content">
			<div>
				<div>
					<h2>퀴즈풀기</h2>
				</div>
				<form
					action="<%=request.getContextPath()%>/answer?knowSeq=${knowSeq}">
					<table>
						<c:forEach items="${quizList }" var="list">
							<input type="hidden" value="${list.knowSeq}" name="knowSeq">
							<input type="hidden" value="${list.quizSeq}" name="quizSeq">
							<div>
								<c:set var="i" value="${i+1}" />
							<tr>
								<td id="num"><br>
								<br>
								<br> Q. ${i}번<br>
								<br> ${list.question}<br>
								<br></td>
							</tr>
							<!-- 보기화면 -->
							<div id="${i}">
								<tr>
									<td><input type="radio" value="1" id="radio1"
										name="radio${i}"> 1. ${list.choice1}</td>
								</tr>
								<tr>
									<td><input type="radio" value="2" id="radio2"
										name="radio${i}"> 2. ${list.choice2}</td>
								</tr>
								<c:if test="${list.choice3 ne '' }">
									<tr>
										<td><input type="radio" value="3" id="radio3"
											name="radio${i}"> 3. ${list.choice3}</td>
									</tr>
								</c:if>
								<c:if test="${list.choice4 ne '' }">	
									<tr>
										<td><input type="radio" value="4" id="radio4"
											name="radio${i}"> 4. ${list.choice4}</td>
									</tr>
								</c:if>
							</div>
							<!-- 정답 및 해설 -->
							<tr>
								<td>
									<div id="hideDiv" >
										<br>정답입니다<br> 왜냐하면 어쩌구 저쩌구라서 입니당 ${list.commentary }
										<br>
									</div>
								</td>
							</tr>
						</c:forEach>
					</table>
					<div>
						<br>
						<input type="submit" id="checkAnswer" value="정답 확인">
					</div>
				</form>
			</div>
		</div>
		<%@include file="../common/footer.jsp"%>
	</div>
</body>
</html>