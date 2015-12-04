<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<script type="text/javascript">
   $(document).ready(function() {
      $("#writeForm").submit(function() {
         if ($("input[name=boardTitle]").val() == "") {
            alert("제목을 입력해주세요")
            $("input[name=boardTitle]").focus();
            return false;
         }
         if ($("[name=boardContent]").val() == "") {
            alert("내용을 입력해주세요")
            $("[name=boardContent]").focus();
            return false;
         }
      });
   });
</script>
<form class="form-horizontal" action="my_postingCommunity.do"
   method="post" id="writeForm">
   <input type="hidden" name="momentorMemberVO.memberId" value="${sessionScope.pnvo.momentorMemberVO.memberId}">
   <div class="form-group">
      <label for="boardTitle" class="col-sm-2 control-label">제목 : </label>
      <div class="col-sm-10">
         <input type="text" class="form-control" name="boardTitle"
            placeholder="제목">
      </div>
   </div>
   <div class="form-group">
      <label class="col-sm-2 control-label">작성자 : </label>
      <div class="col-sm-10">
         ${sessionScope.pnvo.momentorMemberVO.nickName }<br>
      </div>
   </div>
   <div class="form-group">
      <label for="boardContent" class="col-sm-2 control-label">내용 :
      </label>
      <div class="col-sm-10">
         <textarea rows="7" cols="30" class="form-control" name="boardContent"></textarea>
      </div>
   </div>
   <div class="form-group">
      <div class="col-sm-offset-2 col-sm-10">
         <button type="submit" class="btn btn-default">글쓰기</button>
      </div>
   </div>
</form>