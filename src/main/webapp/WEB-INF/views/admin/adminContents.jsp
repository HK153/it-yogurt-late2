<%-- <%@ include file="../common/tag.jsp"%> --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<!DOCTYPE html>
<html>
<head>
 <meta charset="UTF-8">
 	<script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
    <link href="/css/header.css" rel="stylesheet">
    <link href="/css/footer.css" rel="stylesheet">
    <!-- <link href="/css/style.css" rel="stylesheet"> -->
    <link href="/css/container.css" rel="stylesheet">
    <link href="/css/user/signup.css" rel="stylesheet">
   <!--  <script src="/js/user/signup.js"></script> -->
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
<!-- 관리자 비로그인시 화면X  -->
<c:choose>
	<c:when test="${sessionScope.user_seq eq 1 || sessionScope.user_seq eq 2}">
	
<!-- 관리자 페이지 이동 버튼  -->
<div class="form" id="content-form">
	<button class="btn btn-primary px-5 py-2" onclick="location.href='/admin/user'"> 회원관리 </button>
	<button class="btn btn-primary px-5 py-2" onclick="location.href='/admin/contents'">컨텐츠 관리</button>
</div>
<br><br><br>
<form class="form" id="form" style="margin-top: 50px;">
	<label for="main"><h4>카테고리</i></i></h4></label><br>
            
            <!-- <select name="main" id="main">
            </select>
            <select name="middle" id="middle">
            </select>
            <select name="sub" id="sub">
            </select> -->
	<div class="row" >
		<div class="col-xl col-md-6">
			<div class="flex-fill card">
				<div class=" py-4 card-body">
					<div class="d-flex align-items-start">
						<div class="flex-grow-1">
            
				            <!-- <div class="mb-3">
				            <div>
					            <label for="main"><h2>카테고리</h2></label>
					        </div>
					        <br>
					        <div class="input-group mb-3" style="align-items:center;"> -->
	         				<label for="main">대분류</label>
					         <!-- <select name="main" id="main">
				            </select> -->
            				<br>
            				<input type="text" name="main" id="mainInput" value="it" class="form-control"><br>
              				<label for="middle">중분류</label> 
             				<!--  <select name="middle" id="middle">
            				</select> --> 
            				<br>
            				<input type="text" name="middle" id="middleInput" value="프로그래밍" class="form-control"><br>
              				<label for="sub">소분류</label>
              				<!-- <select name="sub" id="sub">
            				</select> -->
            				<br>
            				<input type="text" name="sub" id="subInput" class="form-control"><br>
              				<label for="detail">상세분류</label>
              				<br>
            				<input type="text" name="detail" id="detailInput" class="form-control"><br>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
		
		<!-- 입력없이 값 전달 -->
	<input type="hidden" name ="categorySeq" value="${categorySeq }" >
	<input type="hidden" name ="userSeq" value="${sessionScope.user_seq }" >
	<br>
	
	<!-- 컨텐츠 등록 (정보글)  -->
	<div>
		<h3>정보글 등록 </h3>
	</div>
	
	<div class="row">
		<div class="col-xl col-md-6">
			<div class="flex-fill card">
				<div class=" py-4 card-body">
					<div class="d-flex align-items-start">
						<div class="flex-grow-1">
							<label for="title">제목</label><br>
							<input type="text" id="title" name="title" class="form-control">
							<br>
							<p>내용 등록 </p>
							<textarea rows="8" cols="50" id="content" name="content" class="form-control"></textarea>
		
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<br>
	<!-- 컨텐츠 등록( 퀴즈 3개)  -->
	<div>
		<h3>퀴즈 등록</h3>
	</div>
	
	<c:forEach var = "cnt"  begin="1" end="3">
		<div class="row">
			<div class="col-xl col-md-6">
				<div class="flex-fill card">
					<div class=" py-4 card-body">
						<div class="d-flex align-items-start">
							<div class="flex-grow-1">
								<div class="d-inline-block ms-3">
									<i class="fa-solid fa-q"></i> <span></span><i class="fa-sharp fa-solid fa-${cnt }"></i>
								</div><br><br>
								<label for="title">제목</label><br>
								<input type="text" id="question" name="question" class="form-control">
								<br>
								<div class="mb-0">
									<label for="choice">보기 문항</label>
									<p>
									1. <input type="text" id="choice1" name="choice1" class="form-control" ><br>
									2. <input type="text" id="choice2" name="choice2" class="form-control"><br>
									3. <input type="text" id="choice3" name="choice3" class="form-control"><br>
									4. <input type="text" id="choice4" name="choice4" class="form-control"><br>
									</p>
								</div>
								<div class="mb-0">
									<label for="answer">정답</label>
									<input type="number" min="1" max="4" id="answer" name="answer" class="form-control"><br>
									<label for="commentary">해설</label>
									<textarea rows="3" cols="50" id="commentary" name="commentary" class="form-control"></textarea>
								</div>
								<input type="hidden" id="knowSeq" name="knowSeq" value=${knowSeq } >
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</c:forEach>	
<!-- form(전체 컨텐츠) submit 버튼  -->			
	<!-- <input id="submitBtn" type="submit" value="등록"> -->
	<div class="mb-3 text-center" style="margin-top:30px;"> 
	<button id="submitBtn" type="submit" class="btn btn-primary px-5 py-2">	등록 </button>
	</div>
</form>
	
<!-- 관리자 비로그인시 화면X  -->	
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
/* $(document).ready(function () { */
	/* // 카테고리 가져오기
	  window.ajax.request("/category", {}, CategorySetting, category_error)
       /* $("#mainInput").attr("value", $("#main").val());
       $("#middleInput").attr("value", $("#middle").val()); */
	// 카테고리 변경 시
  /*$("select").on("change", function (event) {
    let type = $(this).attr("id");
    let type_value = $(this).val();
    window.ajax.request(`/category/${type}`,
        {data: {type: "GET", type_value: type_value}}, CategoryTypeSuccess,
        category_error)
  })
  
})
let error = (request) => {
  alert(request.responseJSON.errorMessage);
}  */

// 컨텐츠 등록 버튼 클릭시
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
    	alert("등록되었습니다.");
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