<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>



<br>
    <h3><a href="my_myInfo.do">회원정보 보기</a></h3>
    
    <hr>
    <br>

<div class="table-responsive">
<h2 class="sub-header">
<a href="${initParam.root }my_getMyCommnunityBoardList.do?pageNo=1&memberId=${sessionScope.pnvo.momentorMemberVO.memberId}">나의 게시글 보기</a> | 나의 댓글 보기</h2>
 <table class="table table-striped">
 <thead>
                <tr>
                 
                  <th>게시글번호</th>
                  <th>내용</th>
                  <th>원문보기</th>
                  <th>작성일</th>
                  
                </tr>
              </thead>
<tbody>
<c:forEach items="${requestScope.replyList }" var="list">
				<tr>
					<td>${list.communityBoardVO.boardNo }</td>
					<td>${list.content }</td>
					<td><a
						href="${initParam.root }my_getCommunityByNo.do?boardNo=${list.communityBoardVO.boardNo}" title="${list.communityBoardVO.boardTitle }">
						원문보기</a>
						</td>
					<td>${list.replyDate }</td>


				</tr>

			</c:forEach>
</tbody>
</table>
</div>
<c:set var = "p" value = "${requestScope.pageObject }"></c:set>
	 <nav>
	   <ul class="pager">
		<c:if test="${p.isPreviousPageGroup()==true }">
		
			<li><a href="${initParam.root }my_getMyReplyList.do?memberId=${sessionScope.pnvo.momentorMemberVO.memberId}&pageNo=${p.getNowPage()-1 }">LEFT
			</a></li>
		
		</c:if>
		<c:forEach begin = "${p.getStartPageOfPageGroup() }" end = "${ p.getEndPageOfPageGroup()}" var = "count">
		
		<a href= "${initParam.root }my_getMyReplyList.do?memberId=${sessionScope.pnvo.momentorMemberVO.memberId}&pageNo=${count }">${count }</a>	
	
		</c:forEach>

		<c:if test="${p.isNextPageGroup()==true }">
		
			<li><a href="${initParam.root }my_getMyReplyList.do?memberId=${sessionScope.pnvo.momentorMemberVO.memberId}&pageNo=${p.getEndPageOfPageGroup()+1 }">
			RIGHT</a></li>
		</c:if>
		</ul>
		</nav>