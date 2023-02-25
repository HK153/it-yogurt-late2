<%@ page language="java" contentType="text/html;charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@include file="../common/tag.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link href="/css/header.css" rel="stylesheet">
    <link href="/css/footer.css" rel="stylesheet">
    <link href="/css/container.css" rel="stylesheet">
    <link href="/css/quiz/wrong.css" rel="stylesheet">
    <script src="/js/util/ajax.js"></script>
    <script src="/js/quiz/wrong.js"></script>

    <title>퀴즈 풀기</title>
</head>
<%@include file="../common/nav.jsp" %>
<body>
<div class="container">
    <div class="content">
        <h3 id="main"> 오답 노트 </h3>
        <div>
            <div class="filter">
                <select class="quiz-filter">
                    <option value="5">5개씩 보기</option>
                    <option value="10">10개씩 보기</option>
                    <option value="20">20개씩 보기</option>
                </select>
            </div>
            <form action="<%=request.getContextPath()%>" id="quizForm" method=post>
            </form>
        </div>
    </div>
    <div class="paging">
    </div>
</div>
</body>
<%@include file="../common/footer.jsp" %>
</html>
