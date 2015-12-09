<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
	$(document).ready(function(){
		$("#writeBtn").click(function(){   
    		$("#writeNoticeForm").submit();
    	});
	});
</script>    
<body>
<p class="noticeInform">글쓰기</p>
<form action="${initParam.root}admin_noticemgr_writeNoticeByAdmin.do" method="post" id="writeNoticeForm">
	<div id="noticeContentsWriteArea">
   <table id="noticeWriteTable" class="noticeWriteTableByAdmin">
    <tr>
     <td>제목</td>
     <td colspan="3">
     <input type="text" name="boardTitle" size="48" id="boardTitle">
     </td>
    </tr>
    <tr>
     <td>이름</td>
     <td>${requestScope.pnvo.momentorMemberVO.memberName}</td>
    </tr>
    <tr>
     <td>내용</td>
     <td colspan="3" align="left">
     		<textarea cols="53" rows="15" name="boardContent" id="boardContent"></textarea>
     </td>
    </tr> 
    <tr>
     <td colspan="4" align="center" >
     	<input type="button" value="글쓰기" id="writeBtn">
     </td>  
    </tr>
   </table>
</div>
  </form>
</body>