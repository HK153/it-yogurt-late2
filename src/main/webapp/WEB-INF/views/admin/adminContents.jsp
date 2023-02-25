<%@ include file="../common/tag.jsp"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<!DOCTYPE html>
<html>
<head>
 <meta charset="UTF-8">
 	<script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
    <link href="/css/header.css" rel="stylesheet">
    <link href="/css/footer.css" rel="stylesheet">
    <link href="/css/container.css" rel="stylesheet">
    <link href="/css/admin.css" rel="stylesheet">
    <link href="/css/user/signup.css" rel="stylesheet">
    <!-- <script src="/js/user/signup.js"></script> -->
    <script src="/js/util/ajax.js"></script>
    <!-- <script src="/js/util/util.js"></script> -->
<title>관리자 | 문제 관리</title>
</head>
<style>
	#content-form {
		margin-top: 20%;
	}
</style>
<%@include file="../common/nav.jsp" %>
<body>

<div class="container mt-5" style="margin-top:100px;">
	<c:choose>
			<c:when test="${sessionScope.user_seq eq 1 || sessionScope.user_seq eq 2}">
	
	

	<div class="form" id="content-form">
		<button id="" onclick="location.href='/admin/user'">회원관리</button>
		<button onclick="location.href='/admin/contents'">컨텐츠 관리</button>
	</div>
		
	<form class="form" id="form">
		<div>
        	<!-- <label for="main"><h4>카테고리</h4></label><br>
            
            <select name="main" id="main">
            </select>
            <select name="middle" id="middle">
            </select>
            <select name="sub" id="sub">
            </select> -->
            
            <div class="input-group mb-3">
            <div>
	            <!-- <label for="main"><h2>카테고리</h2></label> -->
	        </div>
	        <br>
	        <!--  <label for="main">대분류</label> -->
<!--             	<input type="text" name="main" id="main" class="form-control">
              <label for="middle">중분류</label>
            	<input type="text" name="middle" id="middle" class="form-control">
              <label for="sub">소분류</label>
            	<input type="text" name="sub" id="sub" class="form-control">
              <label for="detail">상세분류</label>
            	<input type="text" name="detail" id="detail" class="form-control"> -->
			</div>
		</div>
		
		<!-- 임시 -->
					<input type="hidden" name ="categorySeq" value="2" >
					<input type="hidden" name ="userSeq" value="${sessionScope.user_seq }" >
		<!--  -->			
		<div>
			<h3>정보글 등록 </h3>
		</div>
		<div>
			<p>제목<p>
			<div class="input-group mb-3">
				<input type="text" id="title" name="title" class="form-control" >
			</div>
			<p>내용 등록 </p>
			<textarea rows="8" cols="50" id="content" name="content"></textarea>
		</div>
		<div>
			<h3>퀴즈 등록</h3>
			
			
		
		<c:forEach var = "cnt"  begin="1" end="3">
			<div class="row">
			
			<div class="col-xl col-md-6">
			<div class="flex-fill card">
				<div class=" py-4 card-body">
					<div class="d-flex align-items-start">
						<div class="flex-grow-1">
							<h5 class="mb-2">제목</h5>
							<p> <input type="text" id="question" name="question" class="flex-grow-1"></p>
							<div class="mb-0">
								<h5 class="mb-2">보기 문항 </h5>
								<p>
								1. <input type="text" id="choice1" name="choice1" ><br>
								2. <input type="text" id="choice2" name="choice2"><br>
								3. <input type="text" id="choice3" name="choice3"><br>
								4. <input type="text" id="choice4" name="choice4"><br>
								</p>
							</div>
							<div class="mb-0">
								<h5 class="mb-2">정답</h5>
								<input type="number" min="1" max="4" id="answer" name="answer" ><br>
								<h5 class="mb-2">해설</h5>
								<textarea rows="3" cols="50" id="commentary" name="commentary"></textarea>
							</div>
						<input type="hidden" id="knowSeq" name="knowSeq" value=${knowSeq }>
						</div>
						<div class="d-inline-block ms-3">
						<i class="fa-light fa-${cnt }"></i>
						</div>
					</div>
				</div>
			</div>
		</div>
			</div>
		</c:forEach>	
						
		<input id="submitBtn" type="submit" value="등록">
		
	</form>
	
	
	</c:when>
			<c:otherwise>
			<div class="container mt-5" style="margin-top:200px;">
				<p> 관리자 로그인을 해주세요! </p>
			</div>
			</c:otherwise>
		</c:choose>
	
</div>
</body>

<script>
/* $(document).ready(function () {
	// 카테고리 가져오기
	  window.ajax.request("/category", {}, CategorySetting, category_error)
	// 카테고리 변경 시
  $("select").on("change", function (event) {
    let type = $(this).attr("id");
    let type_value = $(this).val();
    window.ajax.request(`/category/${type}`,
        {data: {type: "GET", type_value: type_value}}, CategoryTypeSuccess,
        category_error)
  })
  
})
let error = (request) => {
  alert(request.responseJSON.errorMessage);
} */

$("#submitBtn").on("click", function(){
	
//let formData = new FormData($('#form')[0]);

let formData = $('form').serializeArray();
//formData.append(JSON.stringify(formDataArray));
console.log(JSON.stringify(formData));
$.ajax({
    url: '/admin/contents',
    enctype: 'multipart/form-data',
    type: 'POST',
    dataType:'text',
    contentType: 'application/json; charset=utf-8',
    data: JSON.stringify(formData),
    success: function(response) {
    	alert(formData);
    	window.location.href='/admin/page';
        // 성공적으로 처리된 경우 실행될 코드
    },
    error: function(error) {
    	alert("에러");
        // 오류 발생 시 실행될 코드
    }
});
	
})



</script>
<%@include file="../common/footer.jsp" %>
</html>