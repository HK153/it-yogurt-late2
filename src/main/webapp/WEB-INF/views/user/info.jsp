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

.myDiv2{
height:80px;
border: 1px solid black;
margin: auto;
}

label, #blank {
    width: 180px;
    display: inline-block;
    margin-top: 23px;
    margin-left: 50px;
}
#infoBtn, #back{
	width: 49.3%;
    height: 70px;
    border-style: solid;
    border-width: medium;
    margin-top: 90px;
    border-color: #91ACCC;
    font-size: 20px;
}
#infoDiv{
width: 100%;
/* 	padding: 10% 30% 5% 30%; */
/* 	display: inline; */
}

#hide{
	margin-left: 235px;
}

#a{
	text-decoration: underline;
	cursor: pointer;
}
</style>
</head>
<body>
	<div class="container">
		<%@include file="../common/header.jsp"%>
		<div class="content">
		<div style="display: block; width:100%;">
		<form action="<%=request.getContextPath()%>" method="post" >
			<br>
			<p>당신의 새로운 정보를 입력해주세요!</p>
			<h1>${userDto.nickname}님!</h1><br><br>
			<b>유저정보</b>
			<div class="myDiv">
				<label>닉네임</label>
				<div style="display: inline;"> <input type="text" value="${userDto.nickname}" name="nickname" required="required"></div>
			</div>
			<div class="myDiv">
				<label>이메일</label>
				<div style="display: inline;"> ${userDto.email}</div>
			</div>
			<div class="myDiv">
				<label>연락처</label>
				<div style="display: inline;"> <input type="text" value="${userDto.phone}" name="phone" required></div>
			</div>
			<div class="myDiv">
				<label>카테고리</label>
				<div style="display: inline;" id="category"> ${categoryDto.main} > ${categoryDto.middle} > ${categoryDto.sub}</div>
			</div>
			<div class="myDiv">
				<label>가입일자</label>
				<div style="display: inline;"> ${userDto.insertDate}</div>
			</div>
			<div class="myDiv2">
				<label>비밀번호</label> 
				<div style="display: inline;">
					<a id="a1" onclick="openPass()">수정하기</a>
					<a id="a2" onclick="closePass()">닫기</a>
					<div id="hide" style="display: none;">
						<input type="password" placeholder="수정할 비밀번호 입력" id="newPass" name="newPass" class="pw" <%-- value="${userDto.password} --%>"><br>
						<input type="password" placeholder="비밀번호 확인" id="newPassCheck" name="newPassCheck" class="pw" <%-- value="${userDto.password}" --%>><br>
						<span id="alert-form" style="display: none; color: red;">형식 불일치(영문,숫자 6~12자)</span>
	<!-- 					<span id="alert-fail" style="display: none; color: red;">형식 불일치. 다시 입력하세요.</span> -->
						<span id="alert-success" style="display: none; color: blue;">비밀번호 일치</span>
						<span id="alert-fail" style="display: none; color: red;">비밀번호 불일치. 다시 입력하세요.</span>
					</div>				
				</div><br>
			</div>
			<div id="infoDiv">
				<input type="submit" value="수정하기" id="infoBtn" onclick="goSubmit()">
				<input type="button" value="뒤로가기" id="back" onclick="backInfo()">
			</div>	
			</form>
		</div>
		</div>
		<%@include file="../common/footer.jsp"%>
	</div>
<script type="text/javascript">


function backInfo(){
	location.href="${pageContext.request.contextPath}/mypage/${sessionScope.user_seq}";
}


	//비밀번호 수정하기 클릭하면 비밀번호 수정 공간 확인, 다시 클릭하면 사라짐
	function openPass(){
// 		$("#a1").css("display","hide");
// 		$("#a2").css("display","show");
		$("#hide").show();
// 		$("#hide").css("display","show");
		$(".myDiv2").css("height","200px");
		
	}
	
	function closePass(){
// 		$("#a2").css("display","hide");
// 		$("#a1").css("display","show");
		$("#hide").hide();
// 		$("#hide").css("display","none");
		$(".myDiv2").css("height","80px");
		
	}
	
	//비밀번호 입력시 일치, 불일치 확인 가능
	$(".pw").keyup(function(){
		let pattern = /^(?=.*[a-zA-Z])(?=.*[0-9]).{6,12}$/;//6자 이상 12자 이하/ 1개의 문자,숫자 포함
		let pwd1=$("#newPass").val();
		let pwd2=$("#newPassCheck").val();
		//형식체크
		if(pattern.test(pwd1) == true){
			$("#alert-form").hide();
			if(pwd1 == pwd2){
				$("#alert-success").show();
				$("#alert-fail").hide();
			}else{
				$("#alert-fail").show();
				$("#alert-success").hide();
			}			
		}else{
			$("#alert-form").show();
			$("#alert-fail").hide();
			$("#alert-success").hide();
		}
		
		
	});
	
	//submit클릭시
	function goSubmit(e){
		let pwd1=$("#newPass").val();
		let pwd2=$("#newPassCheck").val();
		let pattern = /^(?=.*[a-zA-Z])(?=.*[0-9]).{6,12}$/;//6자 이상 12자 이하/ 1개의 문자,숫자 포함
		
		
		let check = confirm('정보를 수정하시겠습니까?');
	

// 			if(pattern.test(pwd1) == true){
// 				if(check == true){
// 					if(pwd1 == pwd2){
// 						alert('수정되었습니다.');
// 						$("form").attr("action","/mypage/newInfo/"+${sessionScope.user_seq});
// 					}else{
// 						alert('비밀번호 재확인하세요.');
// 						e.preventDefault();
// 					}
// 				}
// 			}else{
// 					alert('비밀번호 재확인하세요.');
// 					e.preventDefault();
// 			}
			
		if(check == true){//수정하시겠습니까? 예.
// 			if($("#newPass").val() ){ //비밀번호 수정 열려있을때
				if(pattern.test(pwd1) == true){
					if(pwd1 == pwd2){
						alert('수정되었습니다.');
						$("form").attr("action","/mypage/newInfo/"+${sessionScope.user_seq});
					}else{
						alert('비밀번호 재확인하세요.');
						e.preventDefault();
					}
				}else{
					alert('비밀번호 재확인하세요.');
					e.preventDefault();
				}
// 			}else{// 수정 닫혀있을때
// 				alert('수정되었습니다.');
// 				$("form").attr("action","/mypage/newInfo/"+${sessionScope.user_seq})
// 			}
		
		}else{ //수정 아직 안해요
			e.preventDefalut();
		}
		
	}
	
</script>	

</body>
</html>