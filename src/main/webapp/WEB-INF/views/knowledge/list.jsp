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
<body>
	<div class="container">
		<%@include file="../common/header.jsp"%>
		<div class="content">
			<div id="tblDiv">
			
			<h3 style="text-align: center;">매일지식 목록</h3>
			
			<form action="<%=request.getContextPath()%>">
			<div id="searchDiv">
			<input type="text" placeholder="검색어 입력" name="keyword" id="keyword">
                <button type="submit" id="search">검색</button>
			</div>	
			
			<select id="categoryChoice" onchange="changeFn()">
				<option value="-" >선택하세요.</option>
				<option value="all" >전체</option>
				<option value="프로그래밍언어" >프로그래밍언어</option>
				<option value="데이터베이스" >데이터베이스</option>
			</select>
			
			<table id="listTbl">
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성일자</th>
					<th>조회수</th>
					<th>작성자</th>
					<th>퀴즈풀러가기</th>
				</tr>
				
				<tbody class="listData">
					
					<c:forEach items="${knowledgeList }" var="list">
					<tr class="tableList">
						<td>${list.knowSeq}</td>
						<td><a href="<%=request.getContextPath()%>/knowledge/detail/${list.knowSeq}">${list.title}</a></td>
						<td>${list.insertDate }</td>
						<td>${list.viewcount }</td>
						<td>관리자</td>	
						<td><input type="button" id="quizBtn" value="퀴즈 풀러가기" onClick="location.href='<%=request.getContextPath()%>/quiz/${list.knowSeq}'"></td>
					</tr>
					</c:forEach>
					
				</tbody>
			</table>
			
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
	</div>
			</form>
		</div>
		<%@include file="../common/footer.jsp"%>
		</div>
	</div>
<script>
//검색
$("#search").click(function(e){
        $("form").attr("action","/knowledge/searchResult");	
});

function changeFn(){
	var choice  = document.getElementById("categoryChoice");
	var category = (choice.options[choice.selectedIndex].value);
	alert("value = "+category);
	location.href="${pageContext.request.contextPath}/knowledge/list/"+category;
}



function go_page(pageNum){
	console.log("click");
	
	$.ajax({
		url: "${pageContext.request.contextPath}/knowledge/list/category?page="+pageNum,
		type: "GET",
		dataType: "json",
		success: function(result){
			let list = result.knowledgeList;
			let content = '';
			for(let i=0;i<list.length;i++){
				content += '<tr>';
				content +=	'<td>'+ list[i].knowSeq +'</td>';
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
</html>