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
     <link href="/css/styles.css" rel="stylesheet">
     <link href="/css/admin.css" rel="stylesheet">
<title> 커뮤니티 | 게시판 </title>
<style>
    .divCss {
        margin-top: 7%;
    }
</style>
</head>
<%@include file="../common/nav.jsp" %>
<body style="background-color: #F9F2ED">
<div class="container divCss">
        <!-- Page content-->
        <div class="container">
            <div class="row">
                <div class="col-lg-auto ">
                    <!-- Post content-->
                    <article>
                        <!-- Post header-->
                        <header class="mb-4">
                            <!-- Post title-->
                            <c:set value="${oneBoard }" var="oneboard"/>
                            <c:set value="${categoryInfo }" var="categoryInfo"/>
			                
                            <h1 class="fw-bolder mb-1">${oneboard.title }</h1>
                            <!-- Post meta content-->
                            <div class="text-muted fst-italic mb-2"> <table> <tr><td>작성시간 </td><td> | ${oneboard.insertDate }</td></tr><tr><td> 작성자  </td><td> | ${oneboard.nickname }</td></tr></table> </div>
                            <!-- Post categories-->
                            <a class="badge bg-secondary text-decoration-none link-light" href="#!">${categoryInfo.main }</a>
                            <a class="badge bg-secondary text-decoration-none link-light" href="#!">${categoryInfo.middle }</a>
                            <a class="badge bg-secondary text-decoration-none link-light" href="#!">${categoryInfo.sub }</a>
                        </header>
   
                        <section class="mb-5">
                            <p class="fs-5 mb-4">
                            	<div style="white-space:pre-wrap;"><c:out value="${oneboard.content }"/></div>
                            </p>
                        </section>
                    </article>
                    
                    <section class="mb-2">
                    <div class="d-md-flex justify-content-md-end" >
                    	<c:if test="${sessionScope.user_seq eq oneboard.userSeq || sessionScope.user_seq eq 1 }">
	  						<button class="btn me-md-2" style="background-color: #91ACCC;" type="button" onclick="location.href='/board/form/${oneboard.boardSeq}'">수정</button>
	  						<button class="btn me-md-2" style="background-color: #91ACCC;" type="button" onclick="delboard(${oneboard.boardSeq})">삭제</button>
  						</c:if>
  						<button class="btn me-md-2" style="background-color: #91ACCC;" type="button" onclick="location.href='/board/list'">목록</button>
					</div>
                    </section>
                    
                    <!-- Comments section-->
                    <section class="mb-5" id="comment">
                        <div class="card bg-light">
                            <div class="card-body">
                                <!-- Comment form-->
                                <form class="mb-4" action="/board/comment" method="post">
                                	<input type="hidden" name="boardSeq" value=${oneboard.boardSeq }>
                                	<input type="hidden" name="userSeq" value="${sessionScope.user_seq }">
                                	<textarea name="content" class="form-control" rows="3" placeholder="댓글을 쓰려면 로그인이 필요합니다!"></textarea>
			  						<button type="submit" class="btn me-md-2" style="background-color: #91ACCC;" >등록</button>
                                </form>
                                
                                <!-- Comment List -->
			                    <c:forEach items="${commentList }" var="List">
                                <div class="d-flex mb-4">
                                    <div class="flex-shrink-0"><img class="rounded-circle" src="https://dummyimage.com/50x50/ced4da/6c757d.jpg" alt="..." /></div>
                                    	<div class="ms-3">
			                				
			                				
			                				
			                				
			                	<div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                                    <h6 class="m-0 font-weight-bold">${List.nickname }</h6>
                                    <div class="dropdown no-arrow">
                                    <c:set var="boardSeq" value="${List.boardSeq}"/>
                                    <c:set var="commentSeq" value="${List.commentSeq}"/>
                                        <%-- <a style="font-size:small" href="/board/comment/${List.commentSeq}">수정</a>  --%>
                                        <c:choose>
											<c:when test="${sessionScope.user_seq eq 1 || sessionScope.user_seq eq List.userSeq}">
                                       			<a style="font-size:small; text-decoration: none;" href="/board/comment/${boardSeq }/${commentSeq}">삭제</a>
                                       		</c:when>
                                       		<c:otherwise>
                                       		</c:otherwise>
                                       	</c:choose>
                                    </div>
                                </div>
                                <div class="card-body">
                                    <div class="chart-area">
                                    	<div class="chartjs-size-monitor">
	                                    	<div class="chartjs-size-monitor-expand">
	                                    		<div class="">
	                                    		</div>
	                                    	</div>
                                    	<div class="chartjs-size-monitor-shrink">
                                    		<div class="">
                                    		</div>
                                    	</div>
                                    </div>
                                        <div style="white-space:pre-wrap;"><c:out value="${List.content}"/></div>
                                    </div>
                                </div>
			                				<p style="font-size:small">${List.insertDate}</p>
			                				
			                				
			                				
		
		 									</div>	
		 									</div>
		 								
			               				</c:forEach>
                            
                            
                            <!-- 예제 -->
                           <!--  <div class="card-body">
                            	<div class="d-flex">
                            	<img src="/static/media/avatar-5.b309bbe2.jpg" width="36" height="36" class="rounded-circle me-2" alt="Ashley Briggs">
                            		<div class="flex-grow-1">
                            			<small class="float-end text-navy">5m ago</small>
                            			<strong>Ashley Briggs</strong> started following <strong>Stacie Hall</strong><br>
                            			<small class="text-muted">Today 7:51 pm</small><br>
                            		</div>
                            	</div>
                            	<hr>
                            	<div class="d-flex">
                            	<img src="/static/media/avatar.42a86687.jpg" width="36" height="36" class="rounded-circle me-2" alt="Chris Wood">
                            		<div class="flex-grow-1">
                            		<small class="float-end text-navy">30m ago</small><strong>Chris Wood</strong> posted something on <strong>Stacie Hall</strong>'s timeline<br>
                            		<small class="text-muted">Today 7:21 pm</small>
                            			<div class="border text-sm text-muted p-2 mt-1">
                            				Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing...
                            			</div>
                            		</div>
                            	</div>
                            	<hr>
                            <div class="d-flex"><img src="/static/media/avatar-4.93166a0c.jpg" width="36" height="36" class="rounded-circle me-2" alt="Stacie Hall">
                            <div class="flex-grow-1">
                            	<small class="float-end text-navy">1h ago</small><strong>Stacie Hall</strong> posted a new blog<br>
                            	<small class="text-muted">Today 6:35 pm</small>
                            </div>
                           </div><hr>
                           <div class="d-grid">
                           <button type="button" class="btn btn-primary">Load more</button>
                          </div>
                          </div> -->
                            
                            
                            
                            
                            
                            
                                   
                                    </div>
                                </div>
                                
                   </section>
                          </div>
                        </div>
                </div>
               
        </div>  
      
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>





     <%-- <div class="form">
		<h3 id="main" > 게시판 </h3> <br>
		<button id= "black" onclick="location.href='/board/list'">목록</button>
		<table class="form" border=3 style="padding: 0px;">
		<c:set value="${oneBoard }" var="oneboard"/>
			<tr>
				<th> 작성자 </th>
				<td> ${oneboard.nickname } </td>
				<th> 작성 시간 </th>
				<td> ${oneboard.insertDate }</td>
				
			</tr>
			</table>
			<table class="form" border=3>
			<tr>
				<th> 제목 </th>
				<td> ${oneboard.title } </td>
				<th style="width:8%;"> 조회수 </th>
				<td style="width:5%;"> ${oneboard.viewcount }</td>
			</tr>
			<tr >
				<td colspan=6 style="text-align : left; padding: 15px;">${oneboard.content }<td>
			</tr>
			
		</table>
		
		
		
	</div>
		<div class="">
			<button id= "black" onclick="location.href=''">수정</button>
		</div> --%>
<%@include file="../common/footer.jsp" %>
</div>
</div>
</body>

<script>
function delboard(boardSeq){
	if (window.confirm("게시물을 삭제하시겠습니까? \n")){
		location.href="/board/d/"+boardSeq;
		alert("게시물 삭제 되었습니다.");		
	}
	else {
		alert("삭제가 취소되었습니다.");		
	}
}
//<br> => enter
var text = document.getElementById("textarea").value;
text = text.replaceAll("<br>", "\r\n");
</script>
</html>