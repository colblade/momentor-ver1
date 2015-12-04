<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 

  <script type="text/javascript">
  $(function(){

$("#exerciseUpdateForm").submit(function(){
	if($("#exerciseBody").val==null||$("#exerciseBody").val()==""){
		
		alert("운동 부위를 선택하세요!");
		return false;
	}
})//submit


$("#getExerciseByNo").click(function(){
	
	location.href = "${initParam.root}member_getExerciseByNo.do?boardNo="+$("#boardNo").text();
});//click
  })
  
  </script>


	<c:set value="${requestScope.exerciseInfo }" var="info" />

	<div class="row">
		
			<form id="exerciseUpdateForm" method="post"
				action="${initParam.root }admin_updateExerciseByAdmin.do">
				<input type="hidden" name="momentorMemberVO.memberId"
					value="${sessionScope.pnvo.momentorMemberVO.memberId }">
					<input type = "hidden" name = "boardNo" value = "${info.boardNo }">
<div class="col-sm-8 blog-main" align="justify">
				<table>

					<tr>
						<td><p>
								<strong><span id="boardNo">${info.boardNo }</span></strong>
							</p></td>
					</tr>
					<tr>
						<td>
							<blockquote>
								<p>
									<input type="text" name="boardTitle"
										value="${info.boardTitle }" required="required" size="40"><hr>
									<input type="text" id="exerciseName" name="exerciseName"
										value="${info.exerciseVO.exerciseName }" required="required"
										size="40" readonly="readonly">
								</p>
							</blockquote>
						</td>
					</tr>
					<tr>
						<td>
							<p align="center">
								<select name="exerciseBody" id="exerciseBody">
									<option value="">--운동부위를 선택하세요--</option>
									<option value="상체">상체</option>
									<option value="하체">하체</option>
									<option value="상하체">상*하체</option>
								</select>
							</p>


						</td>
					</tr>
					<tr>
						<td><div class="col-sm-8 blog-main" align="justify">
						
								<pre>
									<textarea style="width: 500px; font-size: 15px" rows="20"
										wrap="hard" required="required" name="boardContent">${info.boardContent }</textarea>
								</pre>
							</div>
							</td>
					</tr>
					<tr>
						<td>
							<p align="center">
								<input type="submit" value="수정하기" class="btn btn-default">
								&nbsp;&nbsp; <input type="button" value="되돌아가기"
									id="getExerciseByNo" class="btn btn-default">
							</p>
						</td>
					</tr>
				</table></div>
			</form>
		</div>

	<!-- /row -->

<!-- /container -->