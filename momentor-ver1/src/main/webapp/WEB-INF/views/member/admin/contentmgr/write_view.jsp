<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <script type="text/javascript">
  $(function(){
$("#exerciseName").keyup(function(){
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
  })
  
  </script>
<div class="container">
 <div class="row">
 <div class="col-sm-8 blog-main" align="justify">
      <form id= "exerciseForm" method="post" action="${initParam.root }admin_postingExerciseByAdmin.do">
      <input type = "hidden" name = "momentorMemberVO.memberId" value = "${sessionScope.pnvo.momentorMemberVO.memberId }"> 
      <table>
      <tr>
      <td>
	<blockquote>
	<p>
	<input type="text" name="boardTitle" placeholder="제목을 입력하세요." required="required" size = "40">
				<input type = "text"  id = "exerciseName" name="exerciseName"
					 placeholder="운동이름을 입력하세요." required="required" size = "40">
					
				</p>
				<span id = "result"></span>
				</blockquote>
				</td>
				</tr>
					<tr><td>
					<p>
					<select name = "exerciseBody" id = "exerciseBody">
					 <option value="">--운동부위를 선택하세요--</option>
					 <option value="상체">상체</option>
					 <option value="하체">하체</option>
					 <option value="상하체">상*하체</option>
					 </select></p>
					
			
			</td>	
				</tr>	
		<tr><td>	<p align="justify"><textarea style="width: 500px; font-size:15px" rows="20" wrap="hard" placeholder="내용을 입력하세요." required="required" name="boardContent"></textarea>
			</p>
	</td></tr>
	<tr><td>
	
<p align="center">		<input type = "submit" value= "등록하기"  class="btn btn-default" > &nbsp;&nbsp; <input type = "button" value= "되돌아가기" id="getExerciseBoardList" class="btn btn-default">
	</p>		</td>	
				</tr>	</table>
		</form>
		</div>
		
		
	</div><!-- /row -->	
    </div> <!-- /container -->
