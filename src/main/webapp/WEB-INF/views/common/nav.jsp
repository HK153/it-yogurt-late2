<%--<%@ include file="common/tag.jsp" %>--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <script src="/js/jquery-3.6.1.min.js"></script>
    <title>It-Yogurt</title>
    <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
    <script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
    <link href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css" />
    <link href="/css/styles.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<!-- Navigation-->
<nav class="navbar navbar-expand-lg bg-secondary text-uppercase fixed-top" id="mainNav" style="word-break: keep-all;">
    <div class="container">
        <a href="/"><img src="/image/logo_white.png" style="width: 50px; height: 50px"></a> &nbsp;
        <a class="navbar-brand" href="/">It-Yogurt </a>
        <button class="navbar-toggler text-uppercase font-weight-bold text-white rounded" type="button" data-bs-toggle="collapse" data-bs-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
            Menu
            <i class="fas fa-bars"></i>
        </button>
        <div class="collapse navbar-collapse" id="navbarResponsive">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="<%=request.getContextPath()%>/knowledge/list?category=all">매일지식</a></li>

                <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="<%=request.getContextPath()%>/board/list">커뮤니티</a></li>
                <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="<%=request.getContextPath()%>/ranking/">랭킹</a></li>
                <c:choose>

					<c:when test="${ sessionScope.user_seq eq 1 || sessionScope.user_seq eq 2}">	
                    	<li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="<%=request.getContextPath()%>/admin/page">회원관리</a></li>
                	</c:when>
					<c:otherwise>
                    <c:if test="${not empty sessionScope.user_seq}">
                            <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="<%=request.getContextPath()%>/mypage/${sessionScope.user_seq}">MyPage</a></li>
                     </c:if>
					</c:otherwise>
				</c:choose>
                <c:choose>
					<c:when test="${ not empty sessionScope.user_seq}">	
                		<li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="<%=request.getContextPath()%>/user/o" ><i class="fa-solid fa-right-from-bracket"></i></a></li>
					</c:when>
					<c:otherwise>
                		<li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded" href="<%=request.getContextPath()%>/user" ><i class="fa-solid fa-right-to-bracket"></i></a></li>
            		</c:otherwise>
				</c:choose>

            </ul>
        </div>
    </div>
</body>
</nav>
</body>
</html>
