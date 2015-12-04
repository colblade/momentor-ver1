<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<h2 class="sub-header">Momentor Guide</h2>
 <div class="table-responsive">
 <table class="table table-striped">
 <thead>
			<tr>
				<th>No</th>
				<th>타이틀</th>
				<th>운동</th>
				<th>글쓴이</th>
				<th>작성일</th>
				<th>조회수</th>
			</tr>
		</thead>
<tbody>
<c:forEach items="${requestScope.exerciseList }" var="list">
  <tr>
                  <td>${list.boardNo }</td>
                  <td><a href="${initParam.root }member_getExerciseByNo.do?boardNo=${list.boardNo}&pageNo=${param.pageNo}">${list.boardTitle }</a></td>
                  <td>${list.exerciseVO.exerciseName }</td>
                  <td>${list.momentorMemberVO.memberName }</td>
                   <td>${list.boardWdate }</td>
                   <td>${list.exerciseHits }</td>
                </tr>

</c:forEach>
</tbody>
</table>
	<c:set var = "p" value = "${requestScope.pageObject }"></c:set>
	 <nav>
	   <ul class="pager">
		<c:if test="${p.isPreviousPageGroup()==true }">
		
			<li><a href="${initParam.root}member_exerciseBoard.do?pageNo=${p.getNowPage()-1 }">LEFT
			</a></li>
		
		</c:if>
		<c:forEach begin = "${p.getStartPageOfPageGroup() }" end = "${ p.getEndPageOfPageGroup()}" var = "count">
		
		<a href= "${initParam.root}member_exerciseBoard.do?pageNo=${count }">${count }</a>	
	
		</c:forEach>

		<c:if test="${p.isNextPageGroup()==true }">
		
			<li><a href="${initParam.root}member_exerciseBoard.do?pageNo=${p.getEndPageOfPageGroup()+1 }">
			RIGHT</a></li>
		</c:if>
		
   
    
    
    
    
    
    
	<c:if test="${sessionScope.pnvo.momentorMemberVO.auth==1 }">		 
	<br><br>
				<li><a href="${initParam.root}admin_contentmgr_writeView.do">WRITE</a></li>

		<br><br>
	</c:if>	
	 </ul>
    </nav>
    
</div>

