<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <!-- Custom styles for this template -->
    
<br>
    <h3><a href="my_myInfo.do">회원정보 보기</a></h3>
    
    <hr>
    <br>
<h2 class="sub-header">나의 게시글 보기 | <a href="${initParam.root }my_getMyReplyList.do?pageNo=1&memberId=${sessionScope.pnvo.momentorMemberVO.memberId}">나의 댓글 보기</a></h2>
 <div class="table-responsive">
 <table class="table table-striped">
 <thead>
                <tr>
                  <th>No</th>
                  <th>타이틀</th>
                  <th>조회수</th>
                  <th>추천수</th>
                  <th>비추천수</th>
                    <th>작성일</th>
                </tr>
              </thead>
<tbody>
<c:forEach items="${requestScope.boardList }" var="list">
  <tr>
                  <td>${list.boardNo }</td>
                  <td><a href="${initParam.root }my_getCommunityByNo.do?boardNo=${list.boardNo}">${list.boardTitle }</a></td>
                  <td>${list.memberHits }</td>
                  <td>${list.recommend }</td>
                  <td>${list.notRecommend }</td>
                   <td>${list.boardWdate }</td>
                </tr>

</c:forEach>
</tbody>
</table>
</div>
<div align="center">
<nav>
<c:set var="p" value="${requestScope.pageObject}"></c:set>
	  <ul class="pagination">	  
	  <c:if test="${p.isPreviousPageGroup()==true }">	
	    <li>
			<a href="${initParam.root }my_getMyCommnunityBoardList.do?memberId=${sessionScope.pnvo.momentorMemberVO.memberId}&pageNo=${p.getNowPage()-1 }"
			aria-label="Previous"><span aria-hidden="true">&laquo;</span>
			</a>	
	    </li>
	  </c:if>
	  <c:forEach var="i" begin="${p.getStartPageOfPageGroup() }" end = "${ p.getEndPageOfPageGroup()}">
			<c:choose>
				<c:when test="${p.nowPage!=i}">
				<li>
					<a href="${initParam.root}my_getMyCommnunityBoardList.do?memberId=${sessionScope.pnvo.momentorMemberVO.memberId}&pageNo=${i}">${i}</a>
				</li> 
				</c:when>
				<c:otherwise>
				<li class="active">
      				<span>${i}</span>
    			</li>
				</c:otherwise>
			</c:choose>		    
		</c:forEach>
    	<c:if test="${p.isNextPageGroup()==true }">
	    <li>
			<a href="${initParam.root }my_getMyCommnunityBoardList.do?memberId=${sessionScope.pnvo.momentorMemberVO.memberId}&pageNo=${p.getEndPageOfPageGroup()+1 }"
			aria-label="Next">
				<span aria-hidden="true">&raquo;</span>
			</a>
	    </li>
		</c:if>
	  </ul>
	</nav>
</div>