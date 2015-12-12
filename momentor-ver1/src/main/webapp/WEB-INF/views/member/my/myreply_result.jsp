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

<div align="center">
<nav>
<c:set var="p" value="${requestScope.pageObject}"></c:set>
     <ul class="pagination">     
     <c:if test="${p.isPreviousPageGroup()==true }">   
       <li>
         <a href="${initParam.root }my_getMyReplyList.do?memberId=${sessionScope.pnvo.momentorMemberVO.memberId}&pageNo=${p.getNowPage()-1 }"
         aria-label="Previous"><span aria-hidden="true">&laquo;</span>
         </a>   
       </li>
     </c:if>
     <c:forEach var="i" begin="${p.getStartPageOfPageGroup() }" end = "${ p.getEndPageOfPageGroup()}">
         <c:choose>
            <c:when test="${p.nowPage!=i}">
            <li>
               <a href="${initParam.root }my_getMyReplyList.do?memberId=${sessionScope.pnvo.momentorMemberVO.memberId}&pageNo=${i }">${i}</a>
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
         <a href="${initParam.root }my_getMyReplyList.do?memberId=${sessionScope.pnvo.momentorMemberVO.memberId}&pageNo=${p.getEndPageOfPageGroup()+1 }"
         aria-label="Next">
            <span aria-hidden="true">&raquo;</span>
         </a>
       </li>
      </c:if>
     </ul>
   </nav>
</div>