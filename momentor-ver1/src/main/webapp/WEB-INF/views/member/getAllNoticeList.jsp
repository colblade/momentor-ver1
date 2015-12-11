<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<body>
<div class="table-responsive">
 <table class="table table-striped, table-hover">
 <thead>
           <tr>
             <th class="text-left">NO</th>
             <th class="text-center">제목</th>
             <th class="text-center">작성일</th>
             <th class="text-center">작성자</th>
             
           </tr>
</thead>
<tbody>
 <c:forEach items="${requestScope.noticeList.list }" var="noticeList">
	<tr>
		<td class="text-left">${noticeList.boardNo }</td>
		<td class="text-left">
			<a href="${initParam.root}member_getNoticeByNo.do?boardNo=${noticeList.boardNo}">${noticeList.boardTitle }</a>
		</td>
		<td class="text-center">${noticeList.boardWdate }</td>
		<td class="text-center">${noticeList.momentorMemberVO.memberId }</td>
	</tr>
</c:forEach>
</tbody>
</table>
<!-- &&sessionScope.mvo.Auth==1 -->
<c:if test="${sessionScope.pnvo!=null&&sessionScope.pnvo.momentorMemberVO.auth==1}">
	<nav>
	   <ul class="pager">
			<li><a href="${initParam.root}admin_noticemgr_writeNoticeByAdminForm.do">WRITE</a>
	   </ul>
    </nav>
</c:if>

</div>
<br><br>	
<p class="paging">
	<%-- 코드를 줄이기 위해 pb 변수에 pagingBean을 담는다. --%>
	<c:set var="pb" value="${requestScope.noticeList.pagingBean}"></c:set>
	<!-- 
			step2 1) 이전 페이지 그룹이 있으면 이미지 보여준다. (img/left_arrow_btn.gif)
				   		페이징빈의 previousPageGroup 이용 
				   2)  이미지에 이전 그룹의 마지막 페이지번호를 링크한다. 
				   	    hint)   startPageOfPageGroup-1 하면 됨 		 
	 -->      
	<c:if test="${pb.previousPageGroup}">
		<a href="member_getAllNoticeList.do?pageNo=${pb.startPageOfPageGroup-1}">
		<!-- <img src="img/left_arrow_btn.gif"> -->
		◀&nbsp; </a>				
	</c:if>
	<!-- step1. 1)현 페이지 그룹의 startPage부터 endPage까지 forEach 를 이용해 출력한다
				   2) 현 페이지가 아니면 링크를 걸어서 서버에 요청할 수 있도록 한다.
				      현 페이지이면 링크를 처리하지 않는다.  
				      PagingBean의 nowPage
				      jstl choose 를 이용  
				      예) <a href="list.do?pageNo=...">				   
	 -->		
	<c:forEach var="i" begin="${pb.startPageOfPageGroup}" 
	end="${pb.endPageOfPageGroup}">
	<c:choose>
		<c:when test="${pb.nowPage!=i}">
			<a href="member_getAllNoticeList.do?pageNo=${i}">${i}</a> 
		</c:when>
		<c:otherwise>
		${i}
		</c:otherwise>
	</c:choose>
	&nbsp;
	</c:forEach>	 
	<!-- 
			step3 1) 다음 페이지 그룹이 있으면 이미지(img/right_arrow_btn.gif) 보여준다. 
				   		페이징빈의 nextPageGroup 이용 
				   2)  이미지에 이전 그룹의 마지막 페이지번호를 링크한다. 
				   	    hint)   endPageOfPageGroup+1 하면 됨 		 
	 -->   
	<c:if test="${pb.nextPageGroup}">
		<a href="member_getAllNoticeList.do?pageNo=${pb.endPageOfPageGroup+1}">
		▶<!-- <img src="img/right_arrow_btn.gif"> --></a>			
	</c:if>
	</p>
</body>