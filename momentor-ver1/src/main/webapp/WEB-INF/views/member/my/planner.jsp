<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<script src="${initParam.root}dist/js/jquery.easy-pie-chart.js"></script>
<link href="${initParam.root}dist/css/jquery.easy-pie-chart.css" rel="stylesheet" media="screen">

<script type="text/javascript">
	$(document).ready(function(){
		// Easy pie charts
        $('.chart').easyPieChart({animate: 1000});
		
		// 플래너에 달성치 등록하기
		// select로 선택된 value(1~targetSet)를 achievement 에 담아야 한다.
		// 실시 button 클릭시 로그인한 사용자의 memberId, 해당 plannerDate, achievement, exerciseName를 담아 보내주어야 한다.
		$("#plannerListTable").on("click", ".achiveBtn", function(){
			//alert($(this).parent().siblings().next().eq(0).text().trim()); // 수정보완 기간에 text값에 trim붙여서 글자만 추출하도록 수정할 예정.
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
		// 플래너에 등록된 운동 목표세트 수정하기
		var targetSetVal = "";
		$("#plannerListTable").on("click", ".updateBtn", function(){
			// 버튼이 '수정' 일때 클릭하면, 목표세트를 text 상자로 만들어 준 후 버튼을 '저장'으로 바꿔준다.
			if($(this).val() == "수정"){
				targetSetVal = $(this).parent().prev().text().trim();
				var updateInput = "<input type='text' class='updateTargetVal' size='2' style='text-align: right' value=" + targetSetVal + ">";
				$(this).parent().prev().html(updateInput);
				$(this).val("저장");
			} else if($(this).val() == "저장") {
				// 버튼이 '저장' 일때 클릭하면, text 상자의 값으로 update 해준 후 버튼을 '수정'으로 바꿔준다.
				var updateTargetVal = $(this).parent().prev().find(".updateTargetVal").val();
				var updateTargetEx = $(this).parent().siblings().eq(1).text().trim();
				if(updateTargetVal == "" || updateTargetVal == 0){
					alert("목표 세트는 1 이상의 숫자로 입력해주세요.");
					$(this).parent().prev().find(".updateTargetVal").val("");
					$(this).parent().prev().find(".updateTargetVal").focus();
					return;
				}
				// 기존의 목표세트에서 값이 수정되었을때만 업데이트 해준다.
				if(targetSetVal != updateTargetVal){
					$.ajax({
						type:"post",
						url:"my_updateTargetSetInPlanner.do",
						data:"momentorMemberVO.memberId=${sessionScope.pnvo.momentorMemberVO.memberId}&plannerDate=${requestScope.selectDate}&exerciseVO.exerciseName="+updateTargetEx+"&targetSet="+updateTargetVal,
						success:function(resultList){
							plannerListFunc(resultList);
						}
					});
					alert("수정되었습니다.");
				} else {
					$(this).parent().prev().html(targetSetVal);
				}
				$(this).val("수정");
			}
		});
		// 목표세트 수정에서 숫자외의 문자를 입력시 공백으로 초기화
		$("#plannerListTable").on("keyup", ".updateTargetVal", function(){
			$(this).val($(this).val().replace(/[^0-9]/gi, ""));
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
		$("#cartListTable").on("keyup", "#tempTargetSet", function(){
				$(this).val($(this).val().replace(/[^0-9]/gi, ""));
		});
		// 찜 리스트에서 임시 등록란으로 올리기
		$("#cartListTable").on("click", "#selectExerciseBtn", function(){
			var selectExercise = $(":input[name=tempExerciseName]:checked").val();
			var targetSet = $("#tempTargetSet");
			if(selectExercise == undefined){
				alert("운동을 선택하세요.");
				return;
			}
			if(targetSet.val() == "" || targetSet.val() == 0){
				alert("목표 세트는 1 이상의 숫자로 입력해주세요.");
				targetSet.val("");
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
						cartTableFrame = "<table class='table table-hover'>" + 
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
				return;
			}
			if($("#targetSet").val() == "" || $("#targetSet").val() == 0){
				alert("목표 세트는 1 이상의 숫자로 입력해주세요.");
				$("#targetSet").val("");
				$("#targetSet").focus();
				return;
			}
			// 선택일이 오늘보다 이전일 경우 플래너에 등록이 불가능하도록 한다.
			if(parseInt($(".panel-heading").text().substring(0, 10).replace(/-/g, "")) < parseInt(todayVal.replace(/-/g, ""))){
				alert("지나간 날은 등록할 수 없습니다.");
				$("#exerciseName").val("");
				$("#targetSet").val("");
				return;
			}
			// listBody의 자식(td)에 등록하려는 운동이 이미 있는지 확인한다.
			// 두번째 td에 선택한 운동이 포함되어 있는지 확인
			var checkExName = $("#listBody tr td:nth-child(2)").filter(":contains('"+regExName+"')");
			if(checkExName.length == 1){
				alert("이미 등록된 운동입니다.");
				$("#exerciseName").val("");
				$("#targetSet").val("");
				return;
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
					$("#commentIcon").html("<i class='glyphicon glyphicon-resize-full' aria-hidden='true'></i>");
					// 특수문자도 입력이 가능하도록 encoding 한다.
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
					$("#commentIcon").html("<i class='glyphicon glyphicon-resize-small' aria-hidden='true'></i>");
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
		
		// 플래너 리스트의 전체선택 체크박스
		$("#plannerListTable").on("change", ":input[name=allCheck]", function(){
			var flag = $(this).prop("checked");
			$(":input[name=deleteCheck]").prop("checked", flag);
		});
		
		// 운동 상세보기 modal
		$(".exViewModal").click(function(){
			$("#exView").modal();
		});
	});
		
	// 임시등록 되어있는 운동이 있는데 페이지를 벗어나려 할 때 사용자에게 알림
	$(window).on("beforeunload", function(){
		if($("#exerciseName").val() != ""){
			return "임시등록 되어있는 운동이 있습니다.";
		}
	});
	
	// 오늘의 년월일 구하기
	var now = new Date();
	var year= now.getFullYear();
	var mon = (now.getMonth()+1)>9 ? ''+(now.getMonth()+1) : '0'+(now.getMonth()+1);
	var day = now.getDate()>9 ? ''+now.getDate() : '0'+now.getDate();
	var todayVal = year + '-' + mon + '-' + day;
	
	// 플래너에 등록, 플래너에서 삭제, 달성 시 플래너 리스트를 출력하는 공통 function
	function plannerListFunc(resultList){
		var listTableFrame = "<div class='panel panel-primary'>" + 
										"<div class='panel-heading'><h4>" + todayVal + "</h4></div>" + 
										"<div class='panel-body'>등록된 운동이 없습니다.</div></div>";
		if(resultList.length != 0){
			listTableFrame = "<div class='panel panel-primary'>" + 
									"<div class='panel-heading'><h4>" + todayVal + "</h4></div>" + 
									"<div class='panel-body'>" + 
									"<table class='table table-bordered plannerTable'>" + 
									"<thead><tr><th><input type='checkbox' name='allCheck'></th><th>운동명</th><th>달성세트</th><th colspan='2'>목표세트</th><th>달성도</th><th>당일 달성도</th><th>당월 달성도</th>" + 
									"</tr></thead><tbody id='listBody'>";
				$.each(resultList, function(index, list){
					listTableFrame += "<tr>";
					listTableFrame += "<td><input type='checkbox' name='deleteCheck' value=" + list.exerciseVO.exerciseName + "></td>" + 
												"<td>" + list.exerciseVO.exerciseName + "</td>";
					if(list.achievement != 0){
						listTableFrame += "<td>" + list.achievement + "</td>";
					} else {
						// 선택한 날짜와 오늘을 비교하여 오늘일때만 달성버튼 활성화
						if(todayVal == list.plannerDate){
							var selectTable = "";
							for(var i=1; i<list.targetSet+1; i++){
								selectTable += "<option value=" + i + ">" + i + "</option>";
							}
							listTableFrame += "<td><select class='exSelect'>" + selectTable + "</select><input type='button' class='achiveBtn' value='달성'></td>";
						} else {
							listTableFrame += "<td>" + list.achievement + "</td>";
						}
					}
					// 선택한 날짜와 오늘을 비교하여 오늘보다 이후일때만 수정버튼 활성화
					// 기존 yyyy-MM-dd 형태의 날짜에서 '-' 를 제거한 후 숫자형으로 변환
					if(parseInt(list.plannerDate.replace(/-/g, "")) > parseInt(todayVal.replace(/-/g, ""))){
						listTableFrame += "<td>" + list.targetSet + "</td><td><input type='button' class='updateBtn' value='수정'></td>";
					} else {
						listTableFrame += "<td colspan='2'>" + list.targetSet + "</td>";
					}
					listTableFrame += "<td><center><div class='chart' data-percent='" + list.achievementPercent + "'>" + list.achievementPercent + "%</div></center></td>";
					if(index == 0){
						listTableFrame += "<td style='vertical-align: middle' rowspan=" + resultList.length + ">" + "<center><div class='chart' data-percent='" + list.achievementPercentDay + "'>" + list.achievementPercentDay + "%</div></center></td>" + 
													"<td style='vertical-align: middle' rowspan=" + resultList.length + ">" + "<center><div class='chart' data-percent='" + list.achievementPercentMonth +  "'>" + list.achievementPercentMonth + "%</div></center></td>";
					}
					listTableFrame += "</tr>";
				});
				listTableFrame += "</tbody></table></div></div>" + 
											"<input type='button' id='deleteBtn' value='선택 삭제'>";
		}
		$("#plannerListTable").html(listTableFrame);
		
		// Easy pie charts
        $('.chart').easyPieChart({animate: 1000});
	}
	

</script>

<!-- 플래너에 등록된 운동 목록 -->

<span id="plannerListTable">
<c:choose>
	<c:when test="${requestScope.plannerListByDate.size() != 0}">
	<div class="panel panel-primary">
	<div class="panel-heading"><h4>${requestScope.selectDate}</h4></div>
	<div class="panel-body">
		<table class="table table-bordered plannerTable">
			<thead>
				<tr>
					<th><input type="checkbox" name="allCheck"></th>
					<th>운동명</th><th>달성세트</th><th colspan="2">목표세트</th><th>달성도</th><th>당일 달성도</th><th>당월 달성도</th>
				</tr>
			</thead>
			<tbody id="listBody">
			<c:forEach items="${requestScope.plannerListByDate}" var="plist" varStatus="status1">
				<tr>
					<td><input type="checkbox" name="deleteCheck" value="${plist.exerciseVO.exerciseName}"></td>
					<td><a href="#" class="exViewModal" >${plist.exerciseVO.exerciseName}</a></td>
					<td>
					<c:choose>
						<c:when test="${plist.achievement != 0}">
							${plist.achievement}
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${requestScope.today == requestScope.selectDate}">
									<select class="exSelect">
										<c:forEach begin="1" end="${plist.targetSet}" varStatus="status2">
											<option value="${status2.count}">${status2.count}</option>
										</c:forEach>
									</select>
									<input type="button" class="achiveBtn" value="달성">
								</c:when>
								<c:otherwise>
									${plist.achievement}
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose>
					</td>
					<c:choose>
						<c:when test="${requestScope.intTypeSelectDate > requestScope.intTypeToday}">
							<td>${plist.targetSet}</td><td><input type="button" class="updateBtn" value="수정"></td>
						</c:when>
						<c:otherwise>
							<td colspan="2">${plist.targetSet}</td>
						</c:otherwise>
					</c:choose>
					<td><center><div class="chart" data-percent="${plist.achievementPercent}">${plist.achievementPercent}%</div></center></td>
					<c:if test="${status1.count == 1}">
						<td style="vertical-align: middle" rowspan="${requestScope.plannerListByDate.size()}"><center><div class="chart" data-percent="${plist.achievementPercentDay}">${plist.achievementPercentDay}%</div></center></td>
						<td style="vertical-align: middle" rowspan="${requestScope.plannerListByDate.size()}"><center><div class="chart" data-percent="${plist.achievementPercentMonth}">${plist.achievementPercentMonth}%</div></center></td>
					</c:if>
				</tr>
			</c:forEach>
			</tbody>
		</table></div></div>
		<input type="button" id="deleteBtn" value="선택 삭제">
	</c:when>
	<c:otherwise>
	<div class="panel panel-primary">
	<div class="panel-heading"><h4>${requestScope.selectDate}</h4></div>
	<div class="panel-body">
		등록된 운동이 없습니다.
	</div></div>
	</c:otherwise>
</c:choose>
</span>

<input type="button" id="commentBtn" value="코멘트">
<span id="commentIcon"><i class="glyphicon glyphicon-resize-full" aria-hidden="true"></i></span>
<br>
<span id="commentView">
	<textarea cols='100' rows='10' name='commentArea' id='commentArea'></textarea>
</span>
<br><hr><br>

<!-- 임시등록란 -->

<div class="panel panel-primary">
<div class="panel-heading"><h4>선택 확인 / 등록</h4></div>
<div class="panel-body">
목표운동 <input type="text" name="exerciseVO.exerciseName" id="exerciseName" style="text-align: right" size="22" readonly ><br>
목표세트 <input type="text" name="targetSet" id="targetSet" style="text-align: right" size="12"> set
<input type="button" id="regPlannerBtn" value="등록">
</div></div> 
<br><hr><br>

<!-- 찜한 운동 리스트 -->
<span id="cartListTable">
<c:choose>
	<c:when test="${requestScope.cartList.size() != 0}">
	<div class="panel panel-primary">
	<div class="panel-heading"><h4>찜 바구니</h4></div>
	<div class="panel-body">
		<table class="table table-hover">
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
		</table></div></div>
	</c:when>
	<c:otherwise>
		찜 된 운동이 없습니다.
	</c:otherwise>
</c:choose>
</span>

<!-- Modal -->
<div class="modal fade" id="exView" tabindex="-1" role="dialog" aria-labelledby="exViewModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="exViewModalLabel">상세보기</h4>
      </div>
      <div class="modal-body">
          운동 내용 넣어야 함
      </div>
      <div class="modal-footer">
         <button type="button" class="btn btn-default" data-dismiss="modal" id="closePass">Close</button>
      </div>
    </div>
  </div>
</div>