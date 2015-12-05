<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<script type="text/javascript">
	$(document).ready(function(){
		// 플래너에 달성치 등록하기
		// select로 선택된 value(1~targetSet)를 achievement 에 담아야 한다.
		// 실시 button 클릭시 로그인한 사용자의 memberId, 해당 plannerDate, achievement, exerciseName를 담아 보내주어야 한다.
		$("#plannerListTable").on("click", ".achiveBtn", function(){
			var updateAchiveEx = $(this).parent().siblings().next().html();
			var achievementValue = $(this).parent().siblings().next().next().find(".exSelect").val();
			if(confirm("등록 후에는 수정/삭제가 불가능합니다.\n등록하시겠습니까?") == false){
				return;
			}
			$.ajax({
				type:"post",
				url:"my_updateAchievementInPlanner.do",
				data:"momentorMemberVO.memberId=${sessionScope.pnvo.momentorMemberVO.memberId}&plannerDate=${requestScope.selectDate}&exerciseVO.exerciseName="+updateAchiveEx+"&achievement="+achievementValue,
				success:function(resultList){
					plannerListFunc(resultList);
				}
			});
		});
		
		//---------------------------------------------------------------------------------------------------------------------------------------------------------------
		// 플래너에 등록된 운동 리스트에서 삭제하기
		$("#plannerListTable").on("click", "#deleteBtn", function(){
			var deleteCheckComp = $("#listBody :input[name='deleteCheck']:checked");
			if(deleteCheckComp.length == 0){
				alert("삭제할 운동을 선택하세요.");
				return;
			}
			if(confirm("삭제하시겠습니까?") == false){
				return;
			}
			var deleteCheckCompArray = "";
			for(var i=0; i<deleteCheckComp.length; i++){
				deleteCheckCompArray += "&exerciseVO.exerciseName="+$(deleteCheckComp[i]).val();
			}
			$.ajax({
				type:"post",
				url:"my_deleteExerciseInPlanner.do",
				data:"momentorMemberVO.memberId=${sessionScope.pnvo.momentorMemberVO.memberId}&plannerDate=${requestScope.selectDate}"+deleteCheckCompArray,
				success:function(resultList){
					plannerListFunc(resultList);
				}
			});
		});
		
		//---------------------------------------------------------------------------------------------------------------------------------------------------------------
		// 임시 목표 set에 숫자외의 문자를 입력시 공백으로 초기화
		//$("#tempTargetSet").keyup(function(){
		$("#cartListTable").on("keyup", "#tempTargetSet", function(){
				$(this).val($(this).val().replace(/[^0-9]/gi, ""));
		});
		// 찜 리스트에서 임시 등록란으로 올리기
		//$("#selectExerciseBtn").click(function(){
		$("#cartListTable").on("click", "#selectExerciseBtn", function(){
			var selectExercise = $(":input[name=tempExerciseName]:checked").val();
			var targetSet = $("#tempTargetSet");
			if(selectExercise == undefined){
				alert("운동을 선택하세요!");
				return;
			}
			if(targetSet.val() == ""){
				alert("목표 세트를 입력하세요!");
				targetSet.focus();
				return;
			}
			$("#exerciseName").val(selectExercise);
			$("#targetSet").val(targetSet.val());
		});
		
		//---------------------------------------------------------------------------------------------------------------------------------------------------------------
		// 찜 카트 내 운동 삭제하기
		$("#cartListTable").on("click", ".deleteInCartBtn", function(){
			var deleteExcerciseName = $(this).parent().siblings().eq(3).text();
			if(confirm("삭제하시겠습니까?") == false){
				return;
			}
			$.ajax({
				type:"get",
				url:"my_deleteExcerciseInCart.do",
				data:"momentorMemberVO.memberId=${sessionScope.pnvo.momentorMemberVO.memberId}&exerciseBoardVO.exerciseVO.exerciseName="+deleteExcerciseName,
				success:function(cartListResult){
					// 찜 카트가 비어있지 않을때만 table의 틀 출력
					var cartTableFrame = "찜 된 운동이 없습니다.";
					if(cartListResult.length != 0){
						cartTableFrame = "<table style='text-align: center' class='table table-hover'>" + 
												"<thead><tr><th>선택</th><th>번호</th><th colspan='2'>운동명</th><th>삭제</th></tr></thead>" + 
												"<tbody id='cartListBody'>";
						$.each(cartListResult, function(index, list){
							var exName = list.exerciseBoardVO.exerciseVO.exerciseName;
							cartTableFrame += "<tr><td><input type='radio' name='tempExerciseName' value=" + exName + "></td>" + 
																"<td>" + (index+1) + "</td><td>운동img</td><td>" + exName + "</td>" + 
																"<td><input type='button' class='deleteInCartBtn' value='삭제'></td></tr>";
						});
						cartTableFrame += "<tr><td colspan='5'>목표 set <input type='text' name='tempTargetSet' id='tempTargetSet' style='text-align: right'>" + 
													" <input type='button' id='selectExerciseBtn' value='선택'></td></tr>" + 
													"</tbody></table>";
					}
					$("#cartListTable").html(cartTableFrame);
				}
			});
		});
		
		//---------------------------------------------------------------------------------------------------------------------------------------------------------------
		// 목표 set에 숫자외의 문자를 입력시 공백으로 초기화
		$("#targetSet").keyup(function(){
			$(this).val($(this).val().replace(/[^0-9]/gi, ""));
		});
		// 임시등록란에서 플래너로 등록하기
		// 플래너에 이미 등록되어 있는지 여부는 DB를 거치지 않고 jQuery로 판단.
		$("#regPlannerBtn").click(function(){
			var regExName = $("#exerciseName").val();
			// 임시등록란이 비어있는지 확인
			if(regExName == ""){
				alert("임시등록된 운동이 없습니다.");
				return false;
			}
			// listBody의 자식(td)에 등록하려는 운동이 이미 있는지 확인한다.
			// 두번째 td에 선택한 운동이 포함되어 있는지 확인
			var checkExName = $("#listBody tr td:nth-child(2)").filter(":contains('"+regExName+"')");
			if(checkExName.length == 1){
				alert("이미 등록된 운동입니다.");
				$("#exerciseName").val("");
				$("#targetSet").val("");
				return false;
			}
			$.ajax({
				type:"post",
				url:"my_registerInPlanner.do",
				// data로 memberId, exerciseName, plannerDate, targetSet 를 보내주어야 함.
				data:"exerciseVO.exerciseName=" + $("#exerciseName").val() + "&targetSet=" + $("#targetSet").val() + "&momentorMemberVO.memberId=${sessionScope.pnvo.momentorMemberVO.memberId}&plannerDate=${requestScope.selectDate}",
				success:function(resultList){
					$("#exerciseName").val("");
					$("#targetSet").val("");
					plannerListFunc(resultList);
				}
			});
		});
		
		//---------------------------------------------------------------------------------------------------------------------------------------------------------------
		// 코멘트 textarea 영역 보이기/감추기 제어
		var compareComment = "";
		$("#commentView").hide();
		$("#commentBtn").click(function(){
			$("#commentView").toggle(function(){
				if(($("#commentView").css("display")=="none")){ // textarea가 보이지 않을때(닫힐때)
					$("#commentBtn").val("코멘트");
					var commentComp = encodeURIComponent($("#commentArea").val());
					// 코멘트 내용이 변경되지 않았을 경우에는 그냥 닫아준다.
					if($("#commentArea").val() == compareComment){
						return;
					}
					// 저장버튼 클릭시 코멘트 등록/수정
					$.ajax({
						type:"post",
						url:"my_updateCommentInPlanner.do",
						data:"momentorMemberVO.memberId=${sessionScope.pnvo.momentorMemberVO.memberId}&plannerDate=${requestScope.selectDate}&plannerContent="+commentComp,
						success:function(){
							alert("코멘트가 등록되었습니다.");
						}
					});
				} else { // textarea가 보일때(열릴때)
					$("#commentBtn").val("저장");
					// 코멘트버튼 클릭시 등록되어있는 코멘트 보여주기
					$.ajax({
						type:"post",
						url:"my_getPlannerContentByDate.do",
						data:"momentorMemberVO.memberId=${sessionScope.pnvo.momentorMemberVO.memberId}&plannerDate=${requestScope.selectDate}",
						success:function(result){
							var Ca = /\+/g;
							// jquery ajax 에서 controller로 부터 받을때 디코딩 처리
							var plannerContent = decodeURIComponent(result.replace(Ca, " ")); // 공백문자(" ")가 "+"로 출력되므로 replace를 통해 변환
							$("#commentArea").val(plannerContent);
							compareComment = plannerContent;
						}
					});
				}
			});
		});
		//---------------------------------------------------------------------------------------------------------------------------------------------------------------
	});
		
	// 임시등록 되어있는 운동이 있는데 페이지를 벗어나려 할 때 사용자에게 알림
	$(window).on("beforeunload", function(){
		if($("#exerciseName").val() != ""){
			return "임시등록 되어있는 운동이 있습니다.";
		}
	});
	
	// 플래너에 등록, 플래너에서 삭제, 달성 시 플래너 리스트를 출력하는 공통 function
	function plannerListFunc(resultList){
		var listTableFrame = "등록된 운동이 없습니다.";
		if(resultList.length != 0){
			listTableFrame = "<table border='1' cellpadding='5' style='text-align: center'>" + 
									"<thead><tr><th>선택</th><th>운동명</th><th>달성세트</th><th>목표세트</th><th>달성도</th><th>당일 달성도</th><th>당월 달성도</th>" + 
									"</tr></thead><tbody id='listBody'>";
				$.each(resultList, function(index, list){
					listTableFrame += "<tr>";
					listTableFrame += "<td><input type='checkbox' name='deleteCheck' value=" + list.exerciseVO.exerciseName + "></td>" + 
												"<td>" + list.exerciseVO.exerciseName + "</td>";
					if(list.achievement != 0){
						listTableFrame += "<td>" + list.achievement + "</td>";
					} else {
						var selectTable = "";
						for(var i=1; i<list.targetSet+1; i++){
							selectTable += "<option value=" + i + ">" + i + "</option>";
						}
						listTableFrame += "<td><select class='exSelect'>" + selectTable + "</select><input type='button' class='achiveBtn' value='달성'></td>";
					}
					listTableFrame += "<td>" + list.targetSet + "</td>" +
												"<td>" + list.achievementPercent + "%</td>";
					if(index == 0){
						listTableFrame += "<td rowspan=" + resultList.length + ">" + list.achievementPercentDay + "%</td>" + 
													"<td rowspan=" + resultList.length + ">" + list.achievementPercentMonth + "%</td>";
					}
					listTableFrame += "</tr>";
				});
				listTableFrame += "</tbody></table>" + 
											"<input type='button' id='deleteBtn' value='선택 삭제'>";
		}
		$("#plannerListTable").html(listTableFrame);
	}
</script>

<!-- 플래너에 등록된 운동 목록 -->
<h3>${requestScope.selectDate}</h3>
<span id="plannerListTable">
<c:choose>
	<c:when test="${requestScope.plannerListByDate.size() != 0}">
		<table border="1" cellpadding="5" style="text-align: center">
			<thead>
				<tr>
					<th>선택</th><th>운동명</th><th>달성세트</th><th>목표세트</th><th>달성도</th><th>당일 달성도</th><th>당월 달성도</th>
				</tr>
			</thead>
			<tbody id="listBody">
			<c:forEach items="${requestScope.plannerListByDate}" var="plist" varStatus="status1">
				<tr>
					<td><input type="checkbox" name="deleteCheck" value="${plist.exerciseVO.exerciseName}"></td>
					<td>${plist.exerciseVO.exerciseName}</td>
					<td>
					<c:choose>
						<c:when test="${plist.achievement != 0}">
							${plist.achievement}
						</c:when>
						<c:otherwise>
							<select class="exSelect">
								<c:forEach begin="1" end="${plist.targetSet}" varStatus="status2">
									<option value="${status2.count}">${status2.count}</option>
								</c:forEach>
							</select>
							<input type="button" class="achiveBtn" value="달성">
						</c:otherwise>
					</c:choose>
					</td>
					<td>${plist.targetSet}</td>
					<td>${plist.achievementPercent} %</td>
					<c:if test="${status1.count == 1}">
						<td rowspan="${requestScope.plannerListByDate.size()}">${plist.achievementPercentDay} %</td>
						<td rowspan="${requestScope.plannerListByDate.size()}">${plist.achievementPercentMonth} %</td>
					</c:if>
				</tr>
			</c:forEach>
			</tbody>
		</table>
		<input type="button" id="deleteBtn" value="선택 삭제">
	</c:when>
	<c:otherwise>
		등록된 운동이 없습니다.
	</c:otherwise>
</c:choose>
</span>

<input type="button" id="commentBtn" value="코멘트">
<br>
<span id="commentView">
	<textarea cols='53' rows='15' name='commentArea' id='commentArea'></textarea>
</span>
<hr>

<!-- 임시등록란 -->
<h3>선택 확인 / 등록</h3>
목표운동 <input type="text" name="exerciseVO.exerciseName" id="exerciseName" style="text-align: right" size="12" readonly ><br>
목표세트 <input type="text" name="targetSet" id="targetSet" style="text-align: right" size="12"> set<br>
<input type="button" id="regPlannerBtn" value="등록">
<hr>

<!-- 찜한 운동 리스트 -->
<h3>찜 바구니</h3>
<span id="cartListTable">
<c:choose>
	<c:when test="${requestScope.cartList.size() != 0}">
		<table style="text-align: center" class="table table-hover">
			<thead>
				<tr>
					<th>선택</th><th>번호</th><th colspan="2">운동명</th><th>삭제</th>
				</tr>
			</thead>
			<tbody id='cartListBody'>
				<c:forEach items="${requestScope.cartList}" var="clist">
				<tr>
					<td><input type="radio" name="tempExerciseName" value="${clist.exerciseBoardVO.exerciseVO.exerciseName}"></td>
					<td>1</td>
					<td>운동img</td>
					<td>${clist.exerciseBoardVO.exerciseVO.exerciseName}</td>
					<td><input type="button" class="deleteInCartBtn" value="삭제"></td>
				</tr>	
				</c:forEach>
				<tr>
					<td colspan='5'>목표 set <input type="text" name="tempTargetSet" id="tempTargetSet" style="text-align: right">
					<input type="button" id="selectExerciseBtn" value="선택"></td>
				</tr>
			</tbody>
		</table>
	</c:when>
	<c:otherwise>
		찜 된 운동이 없습니다.
	</c:otherwise>
</c:choose>
</span>