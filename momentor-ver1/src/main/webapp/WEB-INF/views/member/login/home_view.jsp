<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>




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
								href="${initParam.root }member_getExerciseByNo.do?boardNo=${list.boardNo}&pageNo=${param.pageNo}">${list.boardTitle }</a></td>
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
							<td><a
								href="${initParam.root }member_getCommunityByNo.do?boardNo=${list.boardNo}">${list.boardTitle }</a></td>
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








<!-- DatePicker(jQuery UI) -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.10.4/themes/smoothness/jquery-ui.css">

<!-- FullCalendar(jQuery API) -->
<link href='${initParam.root}fullcalendar/fullcalendar.css' rel='stylesheet' />
<script src='${initParam.root}fullcalendar/fullcalendar.js'></script>
<script>
   // FullCalnedar
   $(document).ready(function() {
      $('#calendar').fullCalendar({
         height: 400,
         editable: true,
         events: "json-events.jsp",
         eventDrop: function(event, delta) {
            alert(event.title + ' was moved ' + delta + ' days\n' +
               '(should probably update your database)');},
         loading: function(bool) {
            if (bool) $('#loading').show();
            else $('#loading').hide();
         }
      });
      
   // DatePicker
      $( ".datepicker" ).datepicker({
         dateFormat: 'yy-mm-dd' 
      });
   });

</script>
<style type="text/css">
#wrap{margin: 0 auto; padding: 20px;}
.calendar_body{width: 750px; float: center; margin-left: 100px;}

</style>
<title>FC+JSP+DB(MVC, No Framework)</title>
</head>
<body>
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
   <a href="${initParam.root}my_planner.do?plannerDate=2015-11-28">2015-11-28</a><br>
   <a href="${initParam.root}my_planner.do?plannerDate=2015-11-30">2015-11-30</a><br>
   <a href="${initParam.root}my_planner.do?plannerDate=2015-12-01">2015-12-01</a>