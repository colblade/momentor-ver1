<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
	$(document).ready(function(){
		$("#writeBtn").click(function(){   
    		$("#writeNoticeForm").submit();
    	});
	});
</script>    
<form action="${initParam.root}admin_noticemgr_writeNoticeByAdmin.do" method="post" id="writeNoticeForm" class="form-horizontal">
   <div class="form-group">
   <label for="boardTitle" class="col-sm-2 control-label">제목 : </label>
	<div class="col-sm-10">
     <input type="text" class="form-control" name="boardTitle" id="boardTitle" placeholder="제목">
      </div>
   </div>
   <div class="form-group">
      <label class="col-sm-2 control-label">이름 : </label>
   <div class="col-sm-10">
    	${requestScope.pnvo.momentorMemberVO.memberName}
      </div>
   </div>
   <div class="form-group">
      <label for="boardContent" class="col-sm-2 control-label">내용 :
      </label>
      <div class="col-sm-10">
     		<textarea style="resize:none" cols="30" rows="7" class="form-control" name="boardContent" id="boardContent"></textarea>
      </div>
   </div>
      <div class="form-group" align="right">
     <div class="col-sm-offset-2 col-sm-10">
     	<input type="button" value="글쓰기" id="writeBtn">
       </div>
   </div>
  </form>