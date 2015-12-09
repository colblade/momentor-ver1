<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
$(document).ready(function(){
	$("#noticeUpdateBtn").click(function(){
		if(confirm("공지사항을 수정하시겠습니까?")){
    		location.href="admin_noticemgr_noticeUpdateForm.do?noticeNo=${requestScope.nvo.boardNo}";			
		}
	});

	$("#noticeDeleteBtn").click(function(){
		if(confirm("공지사항을 삭제하시겠습니까?")){
    		location.href="admin_noticemgr_noticeDelete.do?noticeNo=${requestScope.nvo.boardNo}";			
		}
		
	}); 
});
</script>
<body>
<div id="noticeContentsArea">
<p class="noticeInform">공지글 상세 페이지</p>
<form method="post" name="noticeInfo" action="#" >
<table class="tableForm" id="noticeByNoTable" class="noticeByNo">
	<tbody>
	<tr><td class="noticeNum">공지글번호</td><td>${requestScope.nvo.boardNo}</td></tr>
	<tr><td class="noticeTitle">제목</td><td>${requestScope.nvo.boardTitle }</td></tr>
	<tr><td class="noticeDate">작성일</td><td>${requestScope.nvo.boardWdate}</td></tr>
	<tr><td class="noticeMemberId">작성자</td><td>${requestScope.nvo.momentorMemberVO.memberId }</td></tr>
	<tr><td class="noticeContent">내용</td><td>${requestScope.nvo.boardContent }</td></tr>
	</tbody>
</table>
<input type="hidden" name="memberName" value="${requestScope.nvo.momentorMemberVO.memberName }">
</form>
</div>

<c:choose>
	<c:when test="${sessionScope.pnvo!=null&&sessionScope.pnvo.momentorMemberVO.auth==1}">
		<p class="noticeBtn">
		<a id ="noticeUpdateBtn" href="#"><img  src="${initParam.root}image/modify_btn.jpg" border="0"></a>
		<a id="noticeDeleteBtn" href="#"><img  src="${initParam.root}image/delete_btn.jpg" border="0"></a>
		</p>

	</c:when>
</c:choose>
<br><br><br><br>
<p class="noticeLink">
<c:choose>
	<c:when test="${sessionScope.pnvo!=null&&sessionScope.pnvo.momentorMemberVO.auth==1}">
			<a href="${initParam.root}admin_home.do">홈으로</a><br>
			<a href="${initParam.root}admin_getAllNoticeList.do ">목록으로</a>
	</c:when>
		<c:otherwise>
			<a href="${initParam.root}login_home.do">홈으로</a><br>
			<a href="${initParam.root}member_getAllNoticeList.do ">목록으로</a>
		
		</c:otherwise>
</c:choose>
</p>
</body>