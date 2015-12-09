<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
	$(document).ready(function(){
		$("#updateBtn").click(function(){
			if($("#boardTitle").val()==null||$("#boardTitle").val()==""){
				alert("제목을 입력하시오");
				return false;
			}
			if($("#boardContent").val()==null||$("#boardContent").val()==""){
				alert("내용을 입력하시오");
				return false;
			}
			$("#noticeUpdateForm").submit();
		});
	});
</script>
<body>
<p class="noticeInform">공지사항 수정</p>
<form method="post" name="noticeUpdateForm" id="noticeUpdateForm" action="${initParam.root} admin_noticemgr_noticeUpdate.do">
	<input type="hidden" name="memberId" value="${sessionScope.mvo.memberId}">
	<input type="hidden" name="boardNo" value="${requestScope.nvo.boardNo }">
<table id="noticeUpdateTable" class="noticeUpdateTableByAdmin">
	<tr><td>제목<td><td colspan="4"><input type="text" size="52" name="boardTitle" id="boardTitle" value="${requestScope.nvo.boardTitle}"></td></tr>
	<tr><td>내용</td><td colspan="4" align="left"><pre><textarea rows="15" cols="53" name="boardContent" id="boardContent" >${requestScope.nvo.boardContent }</textarea></pre></td></tr>
	<tr>
     <td colspan="5" align="center">
     <input type="button" value="수정하기" id="updateBtn">
     </td>
     </tr>
</table>
</form>
</body>