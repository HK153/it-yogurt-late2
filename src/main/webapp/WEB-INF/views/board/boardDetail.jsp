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
     <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/css/all.min.css" integrity="sha512-SzlrxWUlpfuzQ+pcUCosxcglQRNAq/DZjVsC0lE40xsADsfeQoEypE+enwcOiGjk/bSuGGKHEyjSoQ1zVisanQ==" crossorigin="anonymous" referrerpolicy="no-referrer" />
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
						<c:if test="${not empty sessionScope.user_seq }">  						
	  						<button class="btn me-md-2" style="background-color: #fab46e;" type="button" onclick="reportboard(${oneboard.userSeq})">신고</button>
						</c:if>
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
			  						<c:choose>
			  							<c:when test="${not empty sessionScope.user_seq }">
					  						<button type="submit" class="btn me-md-2" style="background-color: #91ACCC;" >등록</button>
			  							</c:when>
			  							<c:otherwise>
					  						<button type="submit" class="btn me-md-2" disabled="disabled" style="background-color: #91ACCC;" >등록</button>
			  							</c:otherwise>
			  						</c:choose>
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
                                        <c:choose>
											<c:when test="${sessionScope.user_seq eq 1 || sessionScope.user_seq eq List.userSeq}">
											<input type="hidden" value="${List.content }" id="content">
                                        		<a style="font-size:small; text-decoration: none;" href='javascript:void(0);' onclick="editComment(${List.commentSeq},'${List.content }');">수정</a> 
                                       			<a style="font-size:small; text-decoration: none;" href="/board/comment/${boardSeq }/${commentSeq}">삭제</a>
                                       		</c:when>
                                       		<c:when test="${not empty sessionScope.user_seq }">
                                       			<a style="font-size:small; text-decoration: none; color: #fab46e;" href='javascript:void(0);' onclick="reportcomment(${List.userSeq })">신고</a>                                       		
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
                                       	<div id="edit">
                                        <div style="white-space:pre-wrap;"><c:out value="${List.content}"/></div>
                                       		
                                       	</div>
                                    </div>
                                </div>
			                				<p style="font-size:small">${List.insertDate}</p>
			                				
			                				
			                				
		
		 									</div>	
		 									</div>
		 								
			               				</c:forEach>
                             
                                    </div>
                                </div>
                                
                   </section>
                          </div>
                        </div>
                </div>
               
        </div>  
      
        <!-- Bootstrap core JS-->
        <!-- <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script> -->
        <!-- Core theme JS-->
        <!-- <script src="js/scripts.js"></script> -->





   
<%@include file="../common/footer.jsp" %>


</body>

<script>
/* // 개행 => <br>
var text = document.getElementById("content").value;
text = text.replace(/(?:\r\n|\r|\n)/g, '<br>');
//<br> => enter
var text = document.getElementById("content").value;
text = text.replaceAll("<br>", "\r\n"); */


function delboard(boardSeq){
	if (window.confirm("게시물을 삭제하시겠습니까?\n")){
		location.href="/board/d/"+boardSeq;
		alert("게시물 삭제 되었습니다.");		
	}
	else {
		alert("삭제가 취소되었습니다.");		
	}
}

function reportboard(userSeq){
	if (window.confirm(" 게시글을 신고하시겠습니까?\n \n 한번 한 신고는 취소되지 않습니다. \n")){
		location.href="/board/r/"+userSeq;
		alert("신고되었습니다.");		
	}
	
}
function reportcomment(commentSeq){
	if (window.confirm(" 댓글을 신고하시겠습니까?\n \n 한번 한 신고는 취소되지 않습니다. \n")){
		location.href="/board/comment/r/"+commentSeq;
		alert("신고되었습니다.");		
	}
	else {
				
	}
}

function editComment(commentSeq, commentContent){
		let content = $("#content").val();
		let commentBox ="";
		let comment= "";
			
			commentBox= `<form class="mb-4" action="/board/comment/${commentSeq}" method="post">
		    	<input type="hidden" name="boardSeq" value=${oneboard.boardSeq }>
		    	<input type="hidden" name="userSeq" value=${sessionScope.user_seq }>
		    	<textarea name="content" class="form-control" rows="3" >\${content}</textarea>
					<button type="submit" class="btn me-md-2" id="commentEdit" style="background-color: #91ACCC;" >수정</button>
					<button type="reset" class="btn me-md-2" id="commentEdit" style="background-color: #91ACCC;" >취소</button>
		    </form> `;
		    
	$("#edit").html(commentBox);
}
	
	

/* "/board/comment/${List.commentSeq}" */
</script>
</html>