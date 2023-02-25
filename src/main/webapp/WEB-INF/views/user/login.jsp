<%--<%@ include file="common/tag.jsp" %>--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <link href="/css/header.css" rel="stylesheet">
    <link href="/css/footer.css" rel="stylesheet">
    <link href="/css/container.css" rel="stylesheet">
    <link href="/css/user/login.css" rel="stylesheet">
    <script src="/js/jquery-3.6.1.min.js"></script>
    <script src="/js/user/login.js"></script>
    <script src="/js/util/ajax.js"></script>
    <script src="/js/util/util.js"></script>
    <title>Title</title>
</head>
<style>
  #login_form {
    margin-top: 20%;
  }
</style>
<body>
<%@include file="../common/nav.jsp" %>
<div class="container">
    <div class="content">
        <form id="login_form">
            <div class="login" type="POST" href="/user" style="margin-top:200px;">
                <label for="email">이메일</label>
                <input type="text" name="email" id="email" placeholder="이메일을 입력해주세요.">
                <br>
                <label for="password">비밀번호</label>
                <input type="password" name="password" id="password" placeholder="비밀번호를 입력해주세요">
                <br>
                <div class="login_button">
                    <input type="submit" value="로그인">
                </div>
                <div class="sign_up">회원가입</div>
            </div>
        </form>
        <div class="sns_login">
            <div id="kakao" class="sns_login_btn">
                <img src="/image/kakao.png">
            </div>
            <div id="naver" class="sns_login_btn">
                <img src="/image/naver.png">
            </div>
            <div id="google" class="sns_login_btn">
                <img src="/image/google.png">
            </div>
        </div>
    </div>
</div>
<%@include file="../common/footer.jsp" %>
</body>
</html>