<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
	$(document).ready(function(){
		$("#writeBtn").click(function(){   
    		$("#writeNoticeForm").submit();
    	});
		$("#resetBtn").click(function(){
    		$("#writeNoticeForm").reset();
    	});
	});
</script>    
<form action="${initParam.root}admin_noticemgr_writeNoticeByAdmin.do" method="post" id="writeNoticeForm">
   <table class="inputForm">
    <caption>글쓰기</caption>
    <tr>
     <td>제목&nbsp;&nbsp;</td>
     <td colspan="3">
     <input type="text" name="boardTitle" size="48" id="boardTitle">
     </td>
    </tr>
    <tr>
     <td>이름&nbsp;&nbsp;</td>
     <td>${sessionScope.mvo.memberName}</td>     
    </tr>
    <tr>
     <td colspan="4" align="left">
     &nbsp;&nbsp;
     <textarea cols="53" rows="15" name="boardContent" id="boardContent"></textarea>
     </td>
    </tr> 
    <tr>
     <td colspan="4" align="center" >
     	<input type="button" value="글쓰기" id="writeBtn">
     	<input type="button" value="reset" id="resetBtn">
      <%-- <img id="writeBtn" class="action" src="${initParam.root}image/write_btn.jpg" alt="글입력" >
      <img id="resetBtn" class="action" src="${initParam.root}image/cancel.gif">   --%>    
     </td>  
    </tr>
   </table>
  </form>