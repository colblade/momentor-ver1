<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<link rel="stylesheet" href="${initParam.root}dist/css/style.css">
<h2 class="sub-header"><font color="blue">${requestScope.word}</font>에 대한 커뮤니티 검색결과</h2>
 <div class="table-responsive">
 <table class="table table-striped">
  <tr>
    <th>글번호</th>
    <th>제목</th>
    <th>작성자</th>
    <th>작성시간</th>
    <th>조회수</th>
    <th>추천수</th>
  </tr>
<c:forEach items="${requestScope.list.list}" var="posting">
   <tr>
      <td>${posting.boardNo }</td>
      <c:choose>
         <c:when test="${sessionScope.pnvo==null }">
            <td>${posting.boardTitle}</td>
         </c:when>
         <c:otherwise><td><a href="member_getCommunityByNo.do?boardNo=${posting.boardNo}">${posting.boardTitle}</a></td></c:otherwise>
      </c:choose>
      <td>${pnvo.momentorMemberVO.nickName}</td>
      <td>${posting.boardWdate}</td>
      <td>${posting.memberHits}</td>
      <td>${posting.recommend}</td>
   </tr>
</c:forEach>
</table>
<p class="paging">
	<c:set var="pb" value="${requestScope.list.pagingBean}"></c:set>
	<c:if test="${pb.previousPageGroup}">	
	<a href="member_showSearchCommunity.do?pageNo=${pb.startPageOfPageGroup-1}&word=${requestScope.word}">
	◀&nbsp;</a>	
	</c:if>
	<c:forEach var="i" begin="${pb.startPageOfPageGroup}" 
	end="${pb.endPageOfPageGroup}">
	<c:choose>
	<c:when test="${pb.nowPage!=i}">
	<a href="member_showSearchCommunity.do?pageNo=${i}&word=${requestScope.word}">${i}</a> 
	</c:when>
	<c:otherwise>
	${i}
	</c:otherwise>
	</c:choose>
	&nbsp;&nbsp;
	</c:forEach>	 
	<c:if test="${pb.nextPageGroup}">
	<a href="member_showSearchCommunity.do?pageNo=${pb.endPageOfPageGroup+1}&word=${requestScope.word}">
	▶</a>
	</c:if>
	</p>   
	</div>