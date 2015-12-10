<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<h2 class="sub-header"><font color="blue">${requestScope.word}</font>에 대한 Momentor Guide 검색결과</h2>
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
<c:forEach items="${requestScope.list.list}" var="list">
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
</div>
<div align="center">
<nav>
<c:set var="pb" value="${requestScope.list.pagingBean}"></c:set>
	  <ul class="pagination">	  
	  <c:if test="${pb.previousPageGroup}">	
	    <li>
			<a href="member_showSearchExercise.do?pageNo=${pb.startPageOfPageGroup-1}&word=${requestScope.word}"
			aria-label="Previous"><span aria-hidden="true">&laquo;</span>
			</a>	
	    </li>
	  </c:if>
	  <c:forEach var="i" begin="${pb.startPageOfPageGroup}" end="${pb.endPageOfPageGroup}">
			<c:choose>
				<c:when test="${pb.nowPage!=i}">
				<li>
					<a href="member_showSearchExercise.do?pageNo=${i}&word=${requestScope.word}">${i}</a>
				</li> 
				</c:when>
				<c:otherwise>
				<li class="active">
      				<span>${i}</span>
    			</li>
				</c:otherwise>
			</c:choose>		    
		</c:forEach>
    	<c:if test="${pb.nextPageGroup}">
	    <li>
			<a href="member_showSearchExercise.do?pageNo=${pb.endPageOfPageGroup+1}&word=${requestScope.word}"
			aria-label="Next">
				<span aria-hidden="true">&raquo;</span>
			</a>
	    </li>
		</c:if>
	  </ul>
	</nav>
</div>