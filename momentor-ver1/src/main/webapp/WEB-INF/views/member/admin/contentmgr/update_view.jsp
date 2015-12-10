<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
 <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

  <script type="text/javascript">
  $(function(){
	  $('#exerciseBody').val($("#exerciseBodyComp").val()).attr('selected', 'selected');

$("#exerciseUpdateForm").submit(function(){
	if($("#exerciseBody").val==null||$("#exerciseBody").val()==""){
		
		alert("운동 부위를 선택하세요!");
		return false;
	}
});//submit


$("#getExerciseByNo").click(function(){
	location.href = "${initParam.root}member_getExerciseByNo.do?boardNo="+$("#boardNo").text();
});//click
  
  

	
	
	$("#imgList").on("click","img",function(){
		if(confirm("삭제하시겠습니까? 삭제된 파일은 복구할 수 없습니다. 그래도 삭제하시겠습니까?")){
		var id = $(this).attr("id");
		var imgName = $("#"+id).attr("title");
		
		$.ajax({
			
			type:"get",
			url:"${initParam.root}admin_deleteExerciseImgFileByImgName.do?exerciseName="+$.trim($("#exerciseName").val())+"&imgName="+$.trim(imgName),
			success:function(data){
				
				var txt = "";
			
				$.each(data,function(i){
					txt+= "<img id= 'image_"+i+"' src='${initParam.root}/upload/"+data[i].EXERCISENAME+"_"+data[i].IMGNAME+"' title = '"+data[i].IMGNAME+"'>";
				})//each
			if(data.length<5){
				
				for(var i =0;i<(5-data.length);i++)
				txt+="<input type='file' name='file["+i+"]' >";
			}
			$("#imgList").html(txt);
			}
		});//ajax
		}//confirm
	});//on

	
	
  })//document
  

  </script>


	<c:set value="${requestScope.exerciseInfo }" var="info" />

<div class="col-md-6" >
<form id="exerciseUpdateForm" method="post"
	action="${initParam.root }admin_updateExerciseByAdmin.do"
	enctype="multipart/form-data" class="form-horizontal">
		<input type="hidden" name="momentorMemberVO.memberId"
		value="${sessionScope.pnvo.momentorMemberVO.memberId }">
		<input type="hidden" id="exerciseName" name="exerciseName"
		value="${info.exerciseVO.exerciseName }" required="required" size="40"
		readonly="readonly">
		<input type="hidden" name="boardNo" value="${info.boardNo }">
		 <input type="hidden" value="${info.exerciseVO.exerciseBody }" id="exerciseBodyComp">


	<div class="form-group">
		<label for="boardNo" class="col-sm-2 control-label"> 글번호 : </label>
		<div class="col-sm-10">
			<strong><span id="boardNo">${info.boardNo }</span></strong>

		</div>
	</div>

	<div class="form-group">
		<label for="boardTitle" class="col-sm-2 control-label"> 제목 : </label>
		<div class="col-sm-10">
			<input type="text" name="boardTitle" value="${info.boardTitle }"
				required="required" size="40" class="form-control">

		</div>
	</div>

	<div class="form-group">
		<label for="exerciseName" class="col-sm-2 control-label"> 운동명
			: </label>
		<div class="col-sm-10">${info.exerciseVO.exerciseName }</div>
	</div>

	<div class="form-group">
		<label for="exerciseContent" class="col-sm-2 control-label"></label>
		<div class="col-sm-10">
			<select name="exerciseBody" id="exerciseBody" class="form-control">
				<option value="">--운동부위를 선택하세요--</option>
				<option value="상체">상체</option>
				<option value="하체">하체</option>
				<option value="상하체">상*하체</option>
			</select>


			<c:choose>
				<c:when test="${empty requestScope.nameList }">

					<c:forEach begin="0" end="4" varStatus="cvs">
						<input type="file" name="file[${cvs.index }]">
					</c:forEach>


				</c:when>
				<c:otherwise>

					<span id="imgList"> <c:forEach
							items="${requestScope.nameList }" var="fileName" varStatus="vs">

							<img id="image_${vs.index }"
								src="${initParam.root}upload/${fileName.EXERCISENAME}_${fileName.IMGNAME}"
								title=" ${fileName.IMGNAME }">

						</c:forEach> <c:if test="${fn:length(requestScope.nameList)<5 }">
							<c:forEach begin="0" end="${4-fn:length(requestScope.nameList)}"
								varStatus="cvs">
								<input type="file" name="file[${cvs.index }]">

							</c:forEach>
						</c:if>
					</span>
				</c:otherwise>
			</c:choose>
		</div>
	</div>

	<div class="form-group">
		<label for="boardContent" class="col-sm-2 control-label">내용 :</label>
		<div class="col-sm-10">
			<pre>
				<textarea style="font-size: 15px" required="required"
					name="boardContent" class="form-control" rows="20">${info.boardContent }</textarea>
			</pre>
		</div>
	</div>

	<div class="form-group">
		<div class="col-sm-offset-2 col-sm-10">
			<input type="submit" value="수정하기" class="btn btn-default">
			&nbsp;&nbsp; <input type="button" value="되돌아가기" id="getExerciseByNo"
				class="btn btn-default">

		</div>
	</div>
</form>
</div>