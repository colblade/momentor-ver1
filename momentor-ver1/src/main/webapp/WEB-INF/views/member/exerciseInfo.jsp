<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
$(function(){
	
	$("#delBtn").click(function(){
		
		if(confirm("이 운동 게시물을 삭제하시겠습니까?")){
			location.href = "${initParam.root }admin_deleteExerciseByAdmin.do?eboardNo="+$("#boardNo").text()
					+"&exerciseName="+$("#exerciseName").text();
			
		}else{
			return;
		}
		
		
	});//click
	
	
});

</script>

<br>
<c:set value="${requestScope.exerciseInfo}" var = "info"></c:set>

<div class="container">


      <div class="row">

        <div class="col-sm-8 blog-main">

          <div class="blog-post">
          <br><br><span id ="boardNo">${info.boardNo }</span>
            <h2 class="blog-post-title">제목&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;&nbsp; ${info.boardTitle }</h2>
            <h3 class = "blog-post-title" >운동이름&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp; <span id="exerciseName">${info.exerciseVO.exerciseName }</span></h3>
            
            <hr>
            <p class="blog-post-meta">${info.boardWdate } by <a href="#">관리자</a></p>
			
                        <pre>${info.boardContent }</pre>
            <br><br><br>
            <hr>
       
          </div>
        </div><!-- /.blog-sidebar -->

      </div><!-- /.row -->
		 <nav>
	   <ul class="pager">
	   <c:if test="${sessionScope.pnvo.momentorMemberVO.auth==1 }">	
	   <li><a href = "${initParam.root }admin_updateViewForAdmin.do?eboardNo=${info.boardNo }">수정하기</a></li>
	   <li id = "delBtn"><a href="#">삭제하기</a></li>
	   </c:if>
	   <c:choose>
	   	<c:when test="${sessionScope.pnvo.momentorMemberVO.auth==1 }">
	   		<li><a href = "${initParam.root }admin_exerciseBoard.do?pageNo=${param.pageNo}">뒤로가기</a></li>
	   	</c:when>
	   	<c:otherwise>
	   		<li><a href = "${initParam.root }member_exerciseBoard.do?pageNo=${param.pageNo}">뒤로가기</a></li>	   	
	   	</c:otherwise>
	   </c:choose>
	   </ul>
	   </nav>
    </div><!-- /.container -->