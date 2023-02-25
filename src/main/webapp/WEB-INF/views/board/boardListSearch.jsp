<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../common/tag.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html>
<html>
<head>
 <meta charset="UTF-8">
    <link href="/css/header.css" rel="stylesheet">
    <link href="/css/footer.css" rel="stylesheet">
    <link href="/css/container.css" rel="stylesheet">
     <link href="/css/admin.css" rel="stylesheet">
     <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css"
		    rel="stylesheet"/>
<title> 커뮤니티 | 게시판 </title>

<style>

</style>
</head>
<body>
<%@include file="../common/nav.jsp"%>
<div class="container">
     <div class="form">
		<h3 id="main" > 게시판 </h3> <br>
		<table class="table">
		<thead>
			<tr>
				<th> 번호 </th>
				<th> 카테고리 </th>
				<th> 제목 </th>
				<th> 작성자 </th>
				<th> 조회수 </th>
			</tr>
		</thead>			
			<tbody class="listData">
			<c:forEach items="${boardList }" var="list">
			<tr class="tableList" onClick="location.href='/board/${list.boardSeq}'">
				<td id ="boardSeq">${list.boardSeq }</td>
				<td>
				<span class="badge bg-secondary text-decoration-none link-light"> ${list.sub }</span>
				</td>
				<td style="text-align: left;">${list.title }</td>
				<td>${list.nickname }</td>
				<td>${list.viewcount }</td>
			</tr>
			</c:forEach>
			</tbody>
			</table>
			
	<div class="paging">
	<nav aria-label="Page navigation example" style="margin: 10px;">
			
		<ul class="pagination justify-content-center">
		<!-- 페이지 처음으로 가기 -->
	        <li class="page-item">
	        	<a href='javascript:void(0);' onclick="go_page(1); return false;" class="page-link">
	        		<i class="fas fa-angle-double-left"></i>
	        	</a>
	        </li>
	    <%-- <c:if test="${paging.prev}"> --%>
	        <li class="page-item">
	        	<a href='javascript:void(0);' onclick="go_page(${paging.startPage-1});" class="page-link">
		        	<i class="fas fa-angle-left"></i>
		        </a>
	        </li>
	   <%--  </c:if> --%>
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
	    <%-- <c:if test="${paging.next && paging.endPage>0}"> --%>

	        <li class="page-item">
	        	<a href='javascript:void(0);' onclick="go_page(${paging.endPage+1});return false;" class="page-link">
	        		<i class="fas fa-angle-right"></i>
	        	</a>
	        </li>
		 <%--</c:if> --%>
	        <li class="page-item">
	        	<a href='javascript:void(0);' onclick="go_page(${maxpage});return false;" class="page-link">
	        		<i class="fas fa-angle-double-right"></i>
	        	</a>
	        </li>
		</ul>

	</nav>
	</div>
	
<div class="d-grid gap-2 d-sm-flex justify-content-sm-end">

<c:choose>
	<c:when test="${ not empty sessionScope.user_seq}">
  		<button class="btn btn-primary" style="background-color: #91ACCC; font-size: 15px; width: 80px;" type="button" onClick="location.href='/board/form'">글쓰기</button>
	</c:when>
	<c:otherwise>
  		<button class="btn btn-primary" disabled="disabled" style="background-color: #91ACCC; font-size: 15px; width: 80px;" type="button" onClick="location.href='/board/form'">글쓰기</button>
	</c:otherwise>
</c:choose>
</div>
	</div>

</div>
</body>

<script>
function go_page(pageNum){

	$.ajax({
		url: "${pageContext.request.contextPath}/board/list/a?page="+pageNum,
		type: "GET",
		dataType: "json",
		success: function(result){
			let list = result.boardList;
			let content = '';
			for(let i=0;i<list.length;i++){
				content += '<tr class="tableList" onClick="window.location=\'/board/'+list[i].boardSeq+'\'">';
				content += '<td id ="boardSeq">' + list[i].boardSeq +'</td>';
				content += '<td><span class="badge bg-secondary text-decoration-none link-light"> '+ list[i].sub +'</span></td>';
				content +=	'<td style="text-align: left;">'+ list[i].title+ '</td>';
				content +=	'<td>'+ list[i].nickname + '</td>';
				content += '<td>' + list[i].viewcount + '</td>';
				content += '</tr>';
			}
			$('.listData').html(content);	
			
			let paging = result.paging;
			let content2 = '';
			
				
				content2 += '<nav aria-label="Page navigation example" style="margin: 10px;">';
				content2 += '<ul class="pagination justify-content-center">';
				content2 += '<li class="page-item"><a href=\'javascript:void(0);\' onclick="go_page(1); return false;" class="page-link"><i class="fas fa-angle-double-left"></i></a></li>';
								
				/* if(paging.prev){ */
					content2 += '<li class="page-item"><a href=\'javascript:void(0);\' onclick="go_page('+(Number(paging.startPage)-1)+');return false;" class="page-link"><i class="fas fa-angle-left"></i></a></li>';
				/* } */
				for (let num = Number(paging.startPage) ; num <=Number(paging.endPage); num++){
					if (num == Number(paging.cri.page)){
						content2 += '<li class="page-item active" style="pagination-bg: #91ACCC"><span><a href=\'javascript:void(0);\' onclick="go_page('+num+'); return false;" class="page-link">'+ num +'</a></span></li>';
						
					}
					else{
						content2 += '<li class="page-item" style="pagination-bg: #91ACCC"><span><a href=\'javascript:void(0);\' onclick="go_page('+num+'); return false;" class="page-link">'+ num +'</a></span></li>';
					}
				}
				if (paging.next && paging.endPage>0){

					content2 += '<li class="page-item"><a href=\'javascript:void(0);\' onclick="go_page('+ (Number(paging.endPage)+1)+');return false;" class="page-link"><i class="fas fa-angle-right"></i></a></li>';
				}
				content2 += '<li class="page-item"><a href=\'javascript:void(0);\' onclick="go_page('+ Number(result.maxPage) +');return false;" class="page-link"><i class="fas fa-angle-double-right"></i></a></li>';
				content2 += '</ul>';
				content2 += '</nav>';
			
			
				$('.paging').html(content2);	
		},
		error: function(){
			console.log('error');
		}
	})
}

</script>

<%@include file="../common/footer.jsp" %>
</html>