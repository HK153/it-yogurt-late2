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
<link href="/css/login.css" rel="stylesheet">
<link href="/css/knowledge.css" rel="stylesheet">

<title>매일지식 컨텐츠</title>
</head>
<body>
	<div class="container">
		<%@include file="../common/header.jsp"%>
		<div class="content">
			<div id="tblDiv">
			
			<h1 style="text-align: center;">매일지식 목록</h1>
			
			<table id="listTbl">
			
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>작성일자</th>
					<th>조회수</th>
					<th>작성자</th>
					<th>퀴즈풀러가기</th>
				</tr>

				<c:forEach items="${knowledgeList }" var="list">
					<tr id="id">
						<td>${list.knowSeq}</td>
						<td><a href="<%=request.getContextPath()%>/detail?knowSeq=${list.knowSeq}">${list.title}</a></td>
						<td>${list.insertDate }</td>
						<td>${list.viewcount }</td>
						<td>관리자</td>	
					</tr>
				</c:forEach>
				
			</table>
			
			<div id="page">
				<%
				int totalCnt = (int) request.getAttribute("totalCnt");
				int totalPage = 0;
				if (totalCnt % 9 == 0) {
					totalPage = totalCnt / 9;
				} else {
					totalPage = totalCnt / 9 + 1;
				}
				for (int i = 1; i <= totalPage; i++) {
				%>
				<a href="list?page=<%=i%>"><%=i%>페이지</a>
				<%
				}
				%>
			</div>
			
		</div>
		<%@include file="../common/footer.jsp"%>
		</div>
	</div>
</body>
</html>