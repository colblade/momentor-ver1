<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!-- DatePicker(jQuery UI) -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">

<!-- FullCalendar(jQuery API) -->
<link href='${initParam.root}fullcalendar/fullcalendar.css' rel='stylesheet' />
<script src='${initParam.root}fullcalendar/fullcalendar.js'></script>

<script>
   // FullCalnedar
   $(document).ready(function() {
      $('#calendar').fullCalendar({
         height: 500,
         dayClick: function(date) { // 날짜 클릭시 알럿.
        	$('#planModal').modal();   
        	var calendarDay = "";				
            if(date.getDate() < 10){
            	calendarDay = "0" + date.getDate()
            } else{
            	calendarDay = date.getDate();
            }
            $("#selectDay").val(date.getFullYear() + "-" + (date.getMonth()+1) + "-" + calendarDay);
         },
         events: function(date){
        	$('#planModal').on('shown.bs.modal', function(){
        		$.ajax({
               		type:"get",
        			url:"my_getPlannerListByDate.do?momentorMemberVO.memberId=${sessionScope.pnvo.momentorMemberVO.memberId}&plannerDate=" + $("#selectDay").val(),
        			dataType:"json",
        			success:function(data){
        				var txt = "";
        				$("#showList").html("");
        				for(var i = 0; i < data.length; i++){
        					txt += "<br>" + data[i].exerciseVO.exerciseName;
	        				$("#showList").html(txt);
        					$("#closePlan").click(function(){
            					$("#showList").html("");        						
        					});
        				}
        				if($("#showList").html() == ""){
    						if(confirm("등록된 운동이 없습니다. 홈으로 가시겠습니까?")){
        						location.href="login_home.do";
        					}
    					}       
        			}
               	}); 
        	});   
        	$.ajax({
           		type:"get",
    			url:"my_getPlannerList.do?momentorMemberVO.memberId=${sessionScope.pnvo.momentorMemberVO.memberId}",
    			dataType:"json",
    			success:function(data){	    
    				var d = $('#calendar').fullCalendar("getDate"); 
    	        	var calDay = "";     
    				for(var j = 0; j < 42; j++){
    					var str = "";
    					for(var i = 0; i < data.length; i++){
    						if($("td").children().children().siblings().eq(2*j).text() < 10){
    	    					calDay = "0" + $("td").children().children().siblings().eq(2*j).text();
    	    				} else{
    	    					calDay = $("td").children().children().siblings().eq(2*j).text();
    	    				}
							if(parseInt(calDay) < 15 && parseInt(calDay) >= 1 && j > 28){
	    						$("td").children().children().children().eq(j).html("");
	    					} else if(parseInt(calDay) <= 31 && parseInt(calDay) > 20 && j < 6){
	    						$("td").children().children().children().eq(j).html("");
	    					}
        					if(d.getFullYear() == data[i].plannerDate.substring(0,4)
        					&& (d.getMonth()+1) == data[i].plannerDate.substring(5,7)
        					&& calDay == data[i].plannerDate.substring(8,10)){
        						str += data[i].exerciseVO.exerciseName + "<br>";
        						$("td").children().children().children().eq(j).html(str);
        					}
        				}
    				}
    			}
           	}); 
         }
      });    
      $("#detailPlanForm").submit(function(){
    	  if($("#showList").html() == ""){
    		  alert("운동을 먼저 등록하세요!");
    		  return false;
    	  }
    	  if(confirm("상세보기로 넘어가시겠습니까?")){
    		  location.href="my_planner.do";
    	  }
      });
   });
</script>
<style type="text/css">
#wrap{margin: 0 auto; padding: 20px;}
.calendar_body{width: 650px; float: center; margin-left: 100px;}
</style>
<body>
<div class="row marketing">
	<div class="col-lg-6">
		<h4>운동 게시판 조회수 TOP5!</h4>
		<div class="table-responsive">
			<table class="table table-striped">
				<thead>
					<tr>

						<th colspan="3" align="center">타이틀</th>

						<th>작성자</th>
						<th>작성일</th>
						<th>조회</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${requestScope.exerciseTop5List }" var="list">
						<tr>
							<td>${list.ranking }</td>
							<td><a
								href="${initParam.root }member_getExerciseByNo.do?boardNo=${list.boardNo}&pageNo=${param.pageNo}">${fn:substring(list.boardTitle,0,4)}..</a></td>
							<td>${list.exerciseVO.exerciseName }</td>
							<td>관리자</td>
							<td>${list.boardWdate }</td>
							<td>${list.exerciseHits }</td>
						</tr>

					</c:forEach>
				</tbody>
			</table>
		</div>
		

	</div>
	<div class="col-lg-6">
		<h4>커뮤니티 게시판 추천수 TOP5!</h4>
		<div class="table-responsive">

			<p>
			<table class="table table-striped">
				<thead>
					<tr>

						<th colspan="2">제목</th>
						<th>작성자</th>
						<th>조회수</th>
						<th>추천수</th>
						<th>비추천수</th>
						<th>작성일</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${requestScope.communityTop5List }" var="list">
						<tr>
							<td>${list.ranking }</td>
							<td>${fn:substring(list.boardTitle,0,4)}..</td>
							<td>${list.momentorMemberVO.nickName }</td>
							<td>${list.memberHits }</td>
							<td>${list.recommend }</td>
							<td>${list.notRecommend }</td>
							<td>${list.boardWdate }</td>
						</tr>

					</c:forEach>
				</tbody>
			</table>
		</div>
	
	</div>

</div>
   <div id="wrap">
      <!-- FullCalendar body -->
      <div class="calendar_body">
         <div id="calendar"></div>
      </div>
      
      <!-- Input/Output Form -->
      <div class="cal_input_table">
         <form action="./CalendarAdd.cl" method="post">
            <table border="1">
            </table>

         </form>
         <form action="./CalendarDel.cl" method="post">
            <table border="1">
            
            </table>
         </form>
      </div>   
   </div>
   <!-- Button trigger modal -->

<!-- Modal -->
<div class="modal fade" id="planModal" tabindex="-1" role="dialog" aria-labelledby="planModalLabel" aria-hidden="true">
  <div class="modal-dialog">
  <div class="idFindCheck">
    <div class="modal-content">   
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="planModalLabel">플래너</h4>
      </div>
      <form action="my_planner.do" id="detailPlanForm">
		   <div class="modal-body">	   	 
		       선택날짜 : <input type="text" class="form-control" name="plannerDate" id="selectDay"><br>
		       운동목록 : <span id="showList"></span>	      	   
		   <div class="modal-footer">
		      <button type="button" class="btn btn-default" data-dismiss="modal" id="closePlan">Close</button>
		      <input type="submit" class="btn btn-primary" id="detailPlan" value="상세보기">
		   </div>
	      </div>
      </form>
    </div>
    </div>
  </div>
</div>
</body>