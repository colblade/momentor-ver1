<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="${initParam.root}css/file.css">

    
  <script type="text/javascript">
 
$(function(){
	/* $(window).on("beforeunload", function(){
	      if($("#exerciseName").val() != ""){
	         return "내용이 변경되었습니다. 이 페이지에서 벗어나시겠습니까?";
2차 구현 꺄꺆꺄꺄꺄꺆꺄꺄
	      }
	   });
	   */
	  
	  
	  $("#exerciseName").keyup(function(){
	if($(this).val()==""){
		$("#result").html("운동을 입력하세요").css("background","pink");
		return false;
	}
	
	
	$.ajax({
		type:"get",
		url:"checkExerciseName.do?exerciseName="+$("#exerciseName").val(),
		success:function(data){
			if(data=="false"){
				$("#result").html(data).css("background","pink");
				return false;
			}else{
			$("#result").html(data).css("background","yellow");}
		}//success
				
	});//ajax
	
})//keyup
$("#exerciseForm").submit(function(){
	if($("#exerciseBody").val==null||$("#exerciseBody").val()==""){
		
		alert("운동 부위를 선택하세요!");
		$(this).focus();
		return false;
	}
	if($("#result").text()=="false"){
		return false;
	}
})//submit


$("#getExerciseBoardList").click(function(){
	
	location.href = "${initParam.root}member_exerciseBoard.do?pageNo=1"
});//click
  var count =1;
  
  $("#addFileBtn").click(function(){
	  if(count>4){
		  
		 alert("사진은 5개까지 추가할 수 있습니다.");
		 $(this).attr("readonly","readonly");
		  return;
	  }
	  $("#fileSpan").append("<input type = 'file' name = 'file["+count+"]'>");
	  count++;
  })
  
  
  })
    </script>


		<div class="col-md-6" >
			<form id="exerciseForm" method="post"
				action="${initParam.root }admin_postingExerciseByAdmin.do"
				enctype="multipart/form-data" class="form-horizontal">
				<input type="hidden" name="momentorMemberVO.memberId"
					value="${sessionScope.pnvo.momentorMemberVO.memberId }">
				 <div class="form-group">
				  <label for="boardTitle" class="col-sm-2 control-label"> 제목 : </label>
								<div class="col-sm-10">
									<input type="text" name="boardTitle" placeholder="제목을 입력하세요."
										required="required" size="40" class="form-control">
										
										</div>
					</div>		
					
					<div class="form-group">
				  <label for="exerciseName" class="col-sm-2 control-label"> 운동명 : </label>
								<div class="col-sm-10">
										<input
										type="text" id="exerciseName" name="exerciseName"
										placeholder="운동이름을 입력하세요." required="required" size="40" class="form-control">

								
								<span id="result"></span>
							</div>
					</div>
					<div class="form-group">
					<label for="exerciseContent" class="col-sm-2 control-label"></label>
					 <div class="col-sm-10">		
						<input type="file" name="file[0]" ><span id="fileSpan"></span> <input type="button"
							value="사진추가하기" id="addFileBtn" class="btn btn-default">
					
								<select name="exerciseBody" id="exerciseBody" class="form-control">
									<option value="">운동부위를 선택하세요</option>
									<option value="상체">상체</option>
									<option value="하체">하체</option>
									<option value="상하체">상*하체</option>
								</select>
							

			</div>
   </div>
							
					<div class="form-group">
<label for="boardContent" class="col-sm-2 control-label">내용 :</label>
			<div class="col-sm-10">				
							<textarea style="width: 500px; font-size: 15px" rows="20"
									wrap="hard" placeholder="내용을 입력하세요." required="required"
									name="boardContent" class="form-control"></textarea>
							
</div>
   </div>

						<div class="form-group">
      <div class="col-sm-offset-2 col-sm-10">	
								<input type="submit" value="등록하기" class="btn btn-default">
								&nbsp;&nbsp; <input type="button" value="되돌아가기"
									id="getExerciseBoardList" class="btn btn-default" >
							
			
			</div>
   </div>
			</form>
		</div>


