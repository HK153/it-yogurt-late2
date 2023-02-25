<%@ page language="java" contentType="text/html;charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@include file="../common/tag.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="/css/header.css" rel="stylesheet">
<link href="/css/footer.css" rel="stylesheet">
<link href="/css/container.css" rel="stylesheet">
<link href="/css/knowledge.css" rel="stylesheet">
<script>
      $(document).ready(function () {
        $('#search').click(function (e) {
          if ($('#keyword').val() == "") {
            e.preventDefault()
            alert("검색어를 입력해주세요!")
            return false;
          }
        })
      });
    </script>
<title>매일지식 컨텐츠</title>
</head>
<style>
	#tblDiv {
		margin-top: 20%;
	}
	
	.tableList:hover {
	background-color: #91ACCC;
	color: white;
	cursor: pointer;
}
.page-link {
  color: #fff; 
  background-color: #91ACCC;
  border: 1px solid #ccc; 
}
.page-item.active .page-link {
 z-index: 1;
 color: #555;
 font-weight:bold;
 background-color: #f1f1f1;
 border-color: #ccc;
 
}
.page-link:focus, .page-link:hover {
  color: #000;
  background-color: #fafafa; 
  border-color: #ccc;
}
.fas {
line-height: inherit;
}
.form {
	margin-top: 20%;
}
/* th{ */
/* 	width: 150px; */
/* }	 */
	
	
</style>
<%@include file="../common/nav.jsp"%>
<body>
	<div class="container">
		<div class="content">
			<div id="tblDiv">
			<h3 style="text-align: center;">매일지식 목록</h3>
			<!-- 검색을 위한 form -->
			<form action="<%=request.getContextPath()%>/knowledge/searchResult" id="knowledgeForm">
			
			<!-- 카테고리 선택 -->
			<div id="categoryDiv">
			<select id="categoryChoice" onchange="changeCategory()">
				<option value="all" >전체</option>
				<option value="프로그래밍언어" >프로그래밍언어</option>
				<option value="데이터베이스" >데이터베이스</option>
			</select>
				<!-- 검색창 -->
				<input type="text" placeholder="검색어 입력" name="keyword" id="keyword">
                <button type="submit" id="search">검색</button>
			</div>
			<!-- 지식 목록 제목-->
			<table class="table">
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성일자</th>
					<th>조회수</th>
					<th>작성자</th>
					<th>퀴즈풀러가기</th>
				</tr>
				<!-- 지식 목록 내용 -->
				<tbody class="listData">
					<c:forEach items="${knowledgeList }" var="list">
					<c:set var="i" value="${i+1}"></c:set>
					<tr class="tableList">
						<td>${i}</td>
						<td><a href="<%=request.getContextPath()%>/knowledge/detail/${list.knowSeq}">${list.title}</a></td>
						<td>${list.insertDate }</td>
						<td>${list.viewcount }</td>
						<td>관리자</td>
						<td><input type="button" id="quizBtn" value="퀴즈 풀러가기" onClick="location.href='<%=request.getContextPath()%>/quiz/${list.knowSeq}'"></td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
			
<!-- 			<div id="searchDiv"> -->
			
<!-- 			</div> -->
			<!-- 페이징 -->
			<div class="paging">
				<nav aria-label="Page navigation example" style="margin: 10px;">
					<ul class="pagination justify-content-center">
			        <li class="page-item"><a href='javascript:void(0);' onclick="go_page(1); return false;" class="page-link">처음</a></li>

	   				 <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="num">
				    	<c:choose>
				    		<c:when test= "${num==1 }">
				        		<li class="page-item active" style="pagination-bg: #91ACCC"><span><a href='javascript:void(0);' onclick="go_page(${num}); return false;" class="page-link">${num}</a></span></li>
							</c:when>
							<c:otherwise>
				        		<li class="page-item" style="pagination-bg: #91ACCC"><span><a href='javascript:void(0);' onclick="go_page(${num}); return false;" class="page-link">${num}</a></span></li>
							</c:otherwise>
						</c:choose>
	    			 </c:forEach>
	       			 <li class="page-item"><a href='javascript:void(0);' onclick="go_page(${maxpage});return false;" class="page-link">끝</a></li>
					</ul>
				</nav>
			</div><!-- 페이징 div -->
			</form>
		</div>
		</div>
	</div>
<script>
let params = (new URL(document.location)).searchParams;
let currentCategory = params.get('category') || "";
let category_list = {"all" : "전체","프로그래밍언어":"프로그래밍언어","데이터베이스":"데이터베이스"}
$("#categoryChoice").val(currentCategory).prop("selected", true);

//검색
// $("#search").click(function(e){
//         $("form").attr("action","/knowledge/searchResult");
// });

// select태그 카테고리 변경시 발생하는 이벤트
function changeCategory(){
	var choice  = document.getElementById("categoryChoice");
	var category = (choice.value);
	location.href="${pageContext.request.contextPath}/knowledge/list?category="+category;

}

//페이징
function go_page(pageNum){
	console.log("click");
	var choice  = document.getElementById("categoryChoice");
	var category = (choice.value);

	$.ajax({
		url: "${pageContext.request.contextPath}/knowledge/list/a?category="+category+"&page="+pageNum,
		type: "GET",
		dataType: "json",
		success: function(result){
			let list = result.knowledgeList;
			let content = '';
			for(let i=0;i<list.length;i++){
				content += '<tr>';
				content +=	'<td>'+ (i+1) +'</td>';
				content += '<td><a href="${pageContext.request.contextPath}/knowledge/detail/'+list[i].knowSeq+'\">' + list[i].title +'</a></td>';
				content +=	'<td>'+ list[i].insertDate +'</td>';
				content +=	'<td>'+ list[i].viewcount +'</td>';
				content +=	'<td> 관리자 </td>';
				content +=	'<td><input type="button" id="quizBtn" value="퀴즈 풀러가기" onClick="location.href=\'/quiz/'+list[i].knowSeq+'\'"></td>';
				content += '</tr>';
			}
			console.log(content);
			$('.listData').html(content);

			let paging = result.paging;
			let content2 = '';


				content2 += '<nav aria-label="Page navigation example" style="margin: 10px;">';
				content2 += '<ul class="pagination justify-content-center">';
				content2 += '<li class="page-item"><a href=\'javascript:void(0);\' onclick="go_page(1); return false;" class="page-link">처음</a></li>';


				for (let num = Number(paging.startPage) ; num <=Number(paging.endPage); num++){
					if (num == Number(paging.cri.page)){
						content2 += '<li class="page-item active" style="pagination-bg: #91ACCC"><span><a href=\'javascript:void(0);\' onclick="go_page('+num+'); return false;" class="page-link">'+ num +'</a></span></li>';

					}
					else{
						content2 += '<li class="page-item" style="pagination-bg: #91ACCC"><span><a href=\'javascript:void(0);\' onclick="go_page('+num+'); return false;" class="page-link">'+ num +'</a></span></li>';
					}
				}
				if (paging.next && paging.endPage>0){
					content2 += '<li class="page-item"><a href=\'javascript:void(0);\' onclick="go_page('+ (Number(paging.endPage)+1)+');return false;" class="page-link">다음</a></li>';
				}
				content2 += '<li class="page-item"><a href=\'javascript:void(0);\' onclick="go_page('+ Number(result.maxPage) +');return false;" class="page-link">끝</a></li>';
				content2 += '</ul>';
				content2 += '</nav>';


				$('.paging').html(content2);
		},
		error: function(){
			console.log('error');
		}
	});
}

</script>
</body>
<%@include file="../common/footer.jsp"%>
</html>