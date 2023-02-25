<%--<%@ include file="common/tag.jsp" %>--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <script src="/js/jquery-3.6.1.min.js"></script>
    <link href="/css/header.css" rel="stylesheet">
    <link href="/css/footer.css" rel="stylesheet">
    <link href="/css/container.css" rel="stylesheet">
    <link href="/css/user/signup.css" rel="stylesheet">
    <script src="/js/user/signup.js"></script>
    <script src="/js/util/ajax.js"></script>
    <script src="/js/util/util.js"></script>
    <title>Title</title>
</head>
<style>
    #signup_form {
        margin-top: 20%;
    }
</style>
<body>
<%@include file="../common/nav.jsp" %>
<div class="container">
    <%
        String email = (String) session.getAttribute("email");
        String isSNS = (String) session.getAttribute("isSNS");
        session.removeAttribute("email");
        session.removeAttribute("isSNS");
    %>
    <c:set var="email" value="<%=email%>"></c:set>
    <c:set var="isSNS" value="<%=isSNS%>"></c:set>

    <div class="content">
        <form id="signup_form" class="form" type="POST" href="/user/1" >
            <div class="form-input-email" style="margin-top:200px;">
                <label for="email">이메일</label>
                <input type="text" name="email" id="email" placeholder="이메일을 입력해주세요."
                       value=${email}>
            </div>
            <div class="form-input-password">
                <label for="password">비밀번호</label>
                <div class="input-info">숫자와 문자를 포함한 6~12자리</div>
                <input type="password" name="password" id="password" placeholder="비밀번호를 입력해주세요">
            </div>
            <div class="form-input-password-check">
                <label for="password_check">비밀번호 확인</label>
                <input type="password" name="password_check" id="password_check"
                       placeholder="비밀번호를 한번 더 입력해주세요">
            </div>
            <div class="form-input">
                <label for="nickname">닉네임</label>
                <input type="text" name="nickname" id="nickname" placeholder="닉네임을 입력해주세요.">
            </div>
            <div class="form-input">
                <label for="phone">전화번호</label>
                <input type="text" name="phone" id="phone"
                       placeholder="번호를 입력해주세요."></div>
            <div class="form-input">
                <label for="main">카테고리</label>
                <select name="main" id="main">

                </select>
                <select name="middle" id="middle">

                </select>
                <select name="sub" id="sub">

                </select>
            </div>
            <div class="form-input">
                <div class="subscribe">
                    <p>IT-Yogurt에서 제공하는 IT 지식을 메일로 받는데 동의합니다.</p>
                    <input type="checkbox" name="subscribe" id="subscribe" value="구독 동의">동의
                </div>
                <div class="signup_button">
                    <input type="submit" value="회원가입">
                </div>
            </div>
        </form>
    </div>
</div>
</body>
<%@include file="../common/footer.jsp" %>
<script> isSNSUser = <%=isSNS != null ? true : false %>; </script>
</html>
