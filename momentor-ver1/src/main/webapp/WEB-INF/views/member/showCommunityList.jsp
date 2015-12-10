<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
    <script type="text/javascript">
       $(document).ready(function(){
             $("#writeBtn").click(function(){
                location.href="my_writeForm.do";
             });
          }
         );
    </script>
<h2 class="sub-header">Community</h2>
<div class="table-responsive">
 <table class="table table-striped">
  <thead>
  <tr>
    <th>No</th>
    <th>타이틀</th>
    <th>글쓴이</th>
    <th>작성일</th>
    <th>조회수</th>
    <th>추천수</th>
  </tr>
  </thead>
  <tbody>
<c:forEach items="${requestScope.list.list}" var="posting">
   <tr>
      <td>${posting.boardNo }</td>
      <c:choose>
         <c:when test="${sessionScope.pnvo==null }">
            <td>${posting.boardTitle}</td>
         </c:when>
         <c:otherwise><td><a href="member_getCommunityByNo.do?boardNo=${posting.boardNo}">${posting.boardTitle}</a></td></c:otherwise>
      </c:choose>
      <td>${posting.momentorMemberVO.nickName}</td>
      <td>${posting.boardWdate}</td>
      <td>${posting.memberHits}</td>
      <td>${posting.recommend}</td>
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
			<a href="showCommunityList.do?pageNo=${pb.startPageOfPageGroup-1}"
			aria-label="Previous"><span aria-hidden="true">&laquo;</span>
			</a>	
	    </li>
	  </c:if>
	  <c:forEach var="i" begin="${pb.startPageOfPageGroup}" end="${pb.endPageOfPageGroup}">
			<c:choose>
				<c:when test="${pb.nowPage!=i}">
				<li>
					<a href="showCommunityList.do?pageNo=${i}">${i}</a>
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
			<a href="showCommunityList.do?pageNo=${pb.endPageOfPageGroup+1}"
			aria-label="Next">
				<span aria-hidden="true">&raquo;</span>
			</a>
	    </li>
		</c:if>
	  </ul>
	</nav>
</div>
<nav>
  <ul class="pager">
    <c:if test="${sessionScope.pnvo != null}">	
    	<li class="next"><a href="${initParam.root}my_writeForm.do">WRITE</a></li>
	</c:if>	
  </ul>
</nav>
