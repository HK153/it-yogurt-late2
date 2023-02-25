<%--<%@ include file="common/tag.jsp" %>--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <script src="/js/jquery-3.6.1.min.js"></script>
    <script src="/js/util/ajax.js"></script>
    <script src="/js/util/util.js"></script>
    <title>It-Yogurt</title>
    <!-- Favicon-->
    <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
    <!-- Font Awesome icons (free version)-->
    <script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
    <!-- Google fonts-->
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
    <link href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css" />
    <!-- Core theme CSS (includes Bootstrap)-->
    <link href="/css/styles.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<style>
    #btn-login {
        cursor: pointer;
        width: 30%;
        height: 60px;
        border-style: solid;
        border-width: thick;
        border-color: #2c3e50;
        border-radius: 8px;
        font-size: 30px;
        font-weight: bold;
        color: #2c3e50;
        background-color: #E9F0FF;
    }

</style>
<body id="page-top">
<%@include file="common/nav.jsp"%>
<!-- Masthead-->
<header class="masthead bg-self text-white text-center" style="background-color: #F9F2ED">
    <div class="container d-flex align-items-center flex-column">
        <!-- Masthead Avatar Image-->
        <img class="masthead-avatar mb-5" src="/image/logo-dark-text.png" alt="logo" />
        <!-- Masthead Heading-->
        <h2 style="color: #2c3e50" class="pb-2">바쁜 당신에게,</h2>
        <h1 class="masthead-heading text-uppercase mb-0" style="color: #2c3e50">💫 떠먹여주는 it 지식 💫</h1>
        <c:choose>
            <c:when test="${ not empty sessionScope.user_seq}">
                <button type="button" class="button btn-login mt-5 mb-5" id="btn-login" onclick="window.location.href='/user'">Logout!</button>
            </c:when>
            <c:otherwise>
                <button type="button" class="button btn-login mt-5 mb-5" id="btn-login" onclick="window.location.href='/user'">JOIN US!</button>
            </c:otherwise>
        </c:choose>
    </div>
</header>
</body>
<%@include file="common/footer.jsp" %>
</html>
