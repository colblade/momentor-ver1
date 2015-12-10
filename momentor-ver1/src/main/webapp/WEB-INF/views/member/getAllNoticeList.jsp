<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div id="noticeContentsArea">
<p class="noticeInform">공지사항 게시판</p>
 <table id="noticeAllListTable" class="noticeAllList">
 <caption>공지사항 게시판 리스트 목록</caption>
 <thead>
           <tr>
             <th>공지사항글번호</th>
             <th>제목</th>
             <th>작성일</th>
             <th>작성자</th>
             
           </tr>
</thead>
<tbody>
 <c:forEach items="${requestScope.noticeList.list }" var="noticeList">
	<tr>
		<td class="noticeNum">${noticeList.boardNo }</td>
		<td class="noticeTitle">
			<c:choose>
				<c:when test="${sessionScope.pnvo!=null&&sessionScope.pnvo.momentorMemberVO.auth==1 }">
					<a href="${initParam.root}admin_getNoticeByNo.do?boardNo=${noticeList.boardNo}">${noticeList.boardTitle }</a>
				</c:when>
				<c:otherwise>
					<a href="${initParam.root}member_getNoticeByNo.do?boardNo=${noticeList.boardNo}">${noticeList.boardTitle }</a>
				</c:otherwise>
			</c:choose>
		</td>
		<td class="noticeDate">${noticeList.boardWdate }</td>
		<td class="noticeMemberId">${noticeList.momentorMemberVO.memberId }</td>
	</tr>
</c:forEach>
</tbody>
</table>
<!-- &&sessionScope.mvo.Auth==1 -->
<c:if test="${sessionScope.pnvo!=null&&sessionScope.pnvo.momentorMemberVO.auth==1}">
	<p class="noticeWriteBtn"> <a href="${initParam.root}admin_noticemgr_writeNoticeByAdminForm.do"><img  src="${initParam.root}image/write_btn.jpg" border="0"></a></p>
</c:if>

</div>
<br><br>	
<div align="center">
<nav> 
<c:set var="pb" value="${requestScope.noticeList.pagingBean}"></c:set>
	  <ul class="pagination">  
	  <c:if test="${pb.previousPageGroup}">		    
	    <c:choose>
		<c:when test="${sessionScope.pnvo.momentorMemberVO.auth==1 }">
		    <li>
				<a href="admin_getAllNoticeList.do?pageNo=${pb.startPageOfPageGroup-1}"
				aria-label="Previous"><span aria-hidden="true">&laquo;</span>
				</a>
			</li>
		</c:when>
		<c:otherwise>
			<li>
				<a href="member_getAllNoticeList.do?pageNo=${pb.startPageOfPageGroup-1}"
				aria-label="Previous"><span aria-hidden="true">&laquo;</span>
				</a>
			</li>
		</c:otherwise>
		</c:choose>
	  </c:if>
	  <c:forEach var="i" begin="${pb.startPageOfPageGroup}" end="${pb.endPageOfPageGroup}">
		  	<c:choose>
				<c:when test="${sessionScope.pnvo.momentorMemberVO.auth==1 }">
				<li>
					<a href="admin_getAllNoticeList.do?pageNo=${i}">${i}</a>
				</li> 	
				</c:when>				
				<c:when test="${pb.nowPage!=i}">
				<li>
					<a href="member_getAllNoticeList.do?pageNo=${i}">${i}</a>
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
	    <c:choose>
		<c:when test="${sessionScope.pnvo.momentorMemberVO.auth==1 }">
		    <li>
				<a href="showCommunityList.do?pageNo=${pb.endPageOfPageGroup+1}"
				aria-label="Next">
				<span aria-hidden="true">&raquo;</span>
			</a>
			</li>
		</c:when>
		<c:otherwise>
			<li>
				<a href="member_getAllNoticeList.do?pageNo=${pb.endPageOfPageGroup+1}"
				aria-label="Next">
				<span aria-hidden="true">&raquo;</span>
				</a>
			</li>
		</c:otherwise>
		</c:choose>
		</c:if>
	  </ul>
	</nav>
</div>