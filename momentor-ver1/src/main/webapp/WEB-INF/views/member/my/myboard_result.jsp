<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <!-- Custom styles for this template -->
    
    
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
                  <td><a href="${initParam.root }member_getCommunityByNo.do?boardNo=${list.boardNo}">${list.boardTitle }</a></td>
                  <td>${list.memberHits }</td>
                  <td>${list.recommend }</td>
                  <td>${list.notRecommend }</td>
                   <td>${list.boardWdate }</td>
                </tr>

</c:forEach>
</tbody>
</table>
</div>
<c:set var = "p" value = "${requestScope.pageObject }"></c:set>
	 <nav>
	   <ul class="pager">
		<c:if test="${p.isPreviousPageGroup()==true }">
		
			<li><a href="${initParam.root }my_getMyCommnunityBoardList.do?memberId=${sessionScope.pnvo.momentorMemberVO.memberId}&pageNo=${p.getNowPage()-1 }">LEFT
			</a></li>
		
		</c:if>
		<c:forEach begin = "${p.getStartPageOfPageGroup() }" end = "${ p.getEndPageOfPageGroup()}" var = "count">
		
		<a href= "${initParam.root}my_getMyCommnunityBoardList.do?memberId=${sessionScope.pnvo.momentorMemberVO.memberId}&pageNo=${count }">${count }</a>	
	
		</c:forEach>

		<c:if test="${p.isNextPageGroup()==true }">
		
			<li><a href="${initParam.root }my_getMyCommnunityBoardList.do?memberId=${sessionScope.pnvo.momentorMemberVO.memberId}&pageNo=${p.getEndPageOfPageGroup()+1 }">
			RIGHT</a></li>
		</c:if>
		</ul>
		</nav>
