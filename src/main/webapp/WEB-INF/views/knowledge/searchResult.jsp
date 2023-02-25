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
</style>
<%@include file="../common/nav.jsp"%>
<body>
	<div class="container">
		<div class="content">
			<div id="tblDiv">
			
			<h3 style="text-align: center;">검색결과 목록</h3>
			<form action="<%=request.getContextPath()%>/knowledge/searchResult">
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
			<table id="listTbl">
				
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성일자</th>
					<th>조회수</th>
					<th>작성자</th>
					<th>퀴즈풀러가기</th>
				</tr>
				<tbody>
						<c:choose>
								<c:when test="${fn:length(list) == 0}">
									<tr><td colspan="6"><br>검색된 내용이 없습니다.</td></tr>
								</c:when>
								
								<c:otherwise>
								<c:forEach items="${list }" var="list">
									<tr id="ajaxTr">
										<td>${list.knowSeq}</td>
										<td><a href="<%=request.getContextPath()%>/knowledge/detail/${list.knowSeq}">${list.title}</a></td>
										<td>${list.insertDate }</td>
										<td>${list.viewcount }</td>
										<td>관리자</td>	
										<td><input type="button" id="quizBtn" value="퀴즈 풀러가기" onClick="location.href='<%=request.getContextPath()%>/quiz/${list.knowSeq}'"></td>
									</tr>
								</c:forEach>
								</c:otherwise>
								
						</c:choose>
				</tbody>
			</table>
			</form>
		</div>
		</div>
	</div>
</body>
<%@include file="../common/footer.jsp"%>
</html>