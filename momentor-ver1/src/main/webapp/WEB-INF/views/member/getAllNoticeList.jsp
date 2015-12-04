<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" type="text/css" href="${initParam.root}css/mystyle.css">
<style>
	p{
		text-align: center;
	}
</style>
<h2>공지사항 게시판</h2>
 <table class="tableForm">
 <thead>
           <tr>
             <td>공지사항글번호</td>
             <td>제목</td>
             <td>작성일</td>
             <td>작성자</td>
             
           </tr>
</thead>
<tbody>
 <c:forEach items="${requestScope.noticeList.list }" var="noticeList">
	<tr>
		<td>${noticeList.boardNo }</td>
		<td><a href="${initParam.root}member_getNoticeByNo.do?boardNo=${noticeList.boardNo}">${noticeList.boardTitle }</a></td>
		<td>${noticeList.boardWdate }</td>
		<td>${noticeList.momentorMemberVO.memberId }</td>
	</tr>
</c:forEach>
</tbody>
</table>
<!-- &&sessionScope.mvo.Auth==1 -->
<c:if test="${sessionScope.mvo!=null&&sessionScope.mvo.auth==1}">
	<a href="${initParam.root}admin_noticemgr_writeNoticeByAdminForm.do"><img  src="${initParam.root}image/write_btn.jpg" border="0"></a>
</c:if>
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