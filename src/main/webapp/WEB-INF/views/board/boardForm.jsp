<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../common/tag.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <script src="/js/jquery-3.6.1.min.js"></script>
    <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
    <script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
    <link href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css" />
    <link href="/css/styles.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
 <!-- <meta charset="UTF-8">
    <link href="/css/header.css" rel="stylesheet">
    <link href="/css/footer.css" rel="stylesheet">
    <link href="/css/container.css" rel="stylesheet">
     <link href="/css/admin.css" rel="stylesheet"> -->
<title> 커뮤니티 | 게시판 | 글쓰기 </title>
<style>
.tableList:hover {
	background-color: #91ACCC;
	color: white;
	cursor: pointer;
}
</style>
</head>
<%@include file="../common/nav.jsp" %>
<body>



<div class="container mt-5" style="margin-top: 80px; max-width: fit-content;">
            <div class="row">
                <div class="col-lg-auto">
                    <!-- Post content-->
                            <form action="form" method="post">
                    <article>
                        <!-- Post header-->
                        <header class="masthead bg-self" style="background-color: #F9F2ED; max-width:none;" >
    						<div class="mb-4">
    							<h2> 게시글 작성 </h2>
	                            <!-- Post title-->
	                            <p>제목</p>
	                            <h4 class="fw-bolder mb-1"><input type="text" class="fw-bolder mb-1" name="title"></h4>
	                            <!-- Post meta content-->
	                            <div class="text-muted fst-italic mb-2"> <table> <tr><td> 작성자  </td><td> | ${sessionUserInfo.nickname }</td></tr></table> </div>
	                            <!-- Post categories-->
	                     		
    						</div>
						</header>
                        <%-- <header class="mb-4">
                            <!-- Post title-->
                            <p>제목</p>
                            <h1 class="fw-bolder mb-1"><input type="text" class="fw-bolder mb-1" name="title"></h1>
                            <!-- Post meta content-->
                            <div class="text-muted fst-italic mb-2"> <table> <tr><td> 작성자  </td><td> | ${sessionUserInfo.nickname }</td></tr></table> </div>
                            <!-- Post categories-->
   
                        </header> --%>
                       
                        <section class="mb-5">
                            <p class="fs-5 mb-4"> 내용</p>
                            
                           <textarea  class="form-control" id="content" name="content" rows=10></textarea>
                      			
                      			<input type="hidden" name="userSeq" value=${sessionScope.user_seq }>
								<input type="hidden" name="categorySeq" value="18">
                        
                        </section>
                    </article>
                    	<button type="submit" class="btn me-md-2" style="background-color: #91ACCC;">등록</button>
                        </form>
                    <section class="mb-2">
                    <div class="d-md-flex justify-content-md-end" >
  						<button class="btn me-md-2" style="background-color: #91ACCC;" type="button" onclick="location.href='/board/list'">목록</button>
					</div>
                    </section>
                    </div>
                    </div>
                    
     <!-- <div class="form">
		<h3 id="main" > 게시판 </h3> <br>
		<button id= "black" onclick="location.href='/board/list'">목록</button>
     		<form action="form" method="post">
				<div class="mb-3">
				  <label for="title" class="form-label">제목</label>
				  <input type="text" class="form-control" id="title" name ="title" placeholder="제목">
				</div>
				<div class="mb-3">
				  <label for="content" class="form-label">내용</label>
				  <textarea class="form-control" id="content" rows="3" name="content"></textarea>
				</div>
				<input type="hidden" name="userSeq" value="5">
				<input type="hidden" name="categorySeq" value="5">
				<button type="submit" class="btn btn-primary" style="background-color: #91ACCC;">등록</button>
			</form> -->
	</div>

</body>
<script type="text/javascript">
//enter => <br>
var text = document.getElementById("content").value;
text = text.replace(/(?:\r\n|\r|\n)/g, '<br>');

</script>
<%@include file="../common/footer.jsp" %>
</html>