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
<div class="table-responsive" class="text-center" align="center">
<form method="post" name="noticeInfo" action="#" >
<table class="table table-striped" style="width: 50%" >
	<tbody>
	<tr><td class="text-center">NO</td><td>${requestScope.nvo.boardNo}</td></tr>
	<tr><td class="text-center">제목</td><td>${requestScope.nvo.boardTitle }</td></tr>
	<tr><td class="text-center">작성일</td><td>${requestScope.nvo.boardWdate}</td></tr>
	<tr><td class="text-center">작성자</td><td>${requestScope.nvo.momentorMemberVO.memberId }</td></tr>
	<tr><td class="text-center">내용</td><td><pre style="border: none; background-color: #f9f9f9;">${requestScope.nvo.boardContent }</pre></td></tr>
	</tbody>
</table>
<input type="hidden" name="memberName" value="${requestScope.nvo.momentorMemberVO.memberName }">
</form>
</div>

<c:choose>
	<c:when test="${sessionScope.pnvo!=null&&sessionScope.pnvo.momentorMemberVO.auth==1}">
		<p align="center">
		<input type="button" class="btn btn-default" id="noticeUpdateBtn" value="수정하기">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" class="btn btn-default" id="noticeDeleteBtn" value="삭제하기">
		</p>

	</c:when>
</c:choose>
<br><br><br><br>
<div align="left">
	<a href="${initParam.root}login_home.do">홈으로</a><br>
	<a href="${initParam.root}member_getAllNoticeList.do ">목록으로</a>
</div>
</body>