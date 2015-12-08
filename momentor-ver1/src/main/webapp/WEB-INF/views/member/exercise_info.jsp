<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
$(function(){
	
	$("#delBtn").click(function(){
		if(confirm("이 운동 게시물을 삭제하시겠습니까?")){
			location.href = "${initParam.root }admin_deleteExerciseByAdmin.do?eboardNo="+$("#boardNo").text()
					+"&exerciseName="+$("#exerciseName").text();	
		}else{
			return;
		}
	});//click
	
	// 찜하기 버튼을 클릭하면 모달창이 열림과 동시에 카트에 담긴 운동 리스트를 출력한다.
	$("#regInCartModal").click(function(){
		$.ajax({
			type:"get",
			url:"${initParam.root }my_getCartList.do",
			data:"momentorMemberVO.memberId=${sessionScope.pnvo.momentorMemberVO.memberId}",
			success:function(cartList){
				var exNameInCart = "찜 된 운동이 없습니다.";
				if(cartList.length != 0){
					exNameInCart = "<p>[ 찜 바구니 목록 ]</p>";
					$.each(cartList, function(index, list){
						exNameInCart += "<p>" + list.exerciseBoardVO.exerciseVO.exerciseName + "</p>";
					});
				}
				$("#showCartList").html(exNameInCart);
			}
		});
		$("#regInCart").modal();
	});
	// 띄워진 모달창에서 담기 버튼을 클릭하면 카트에 담긴다.
	$("#regInCartBtn").click(function(){
		// 카트에 이미 담겨있는 운동인지 확인
		var checkExName = $("#showCartList p").filter(":contains('" + $("#exerciseName").text() + "')");
		if(checkExName.length == 1){
			alert("이미 등록된 운동입니다.");
			return;
		}
		$.ajax({
			type:"post",
			url:"${initParam.root }my_registerExerciseInCart.do?",
			data:"momentorMemberVO.memberId=${sessionScope.pnvo.momentorMemberVO.memberId}" + 
					"&exerciseBoardVO.exerciseVO.exerciseName=" + $("#exerciseName").text(),
			success:function(cartList){
				var exNameInCart = "찜 된 운동이 없습니다.";
				if(cartList.length != 0){
					exNameInCart = "<p>[ 찜 바구니 목록 ]</p>";
					$.each(cartList, function(index, list){
						exNameInCart += "<p>" + list.exerciseBoardVO.exerciseVO.exerciseName + "</p>";
					});
				}
				$("#showCartList").html(exNameInCart);
			}
		});
	});
	$("#movePlannerBtn").click(function(){
		var now = new Date();
		var year= now.getFullYear();
		var mon = (now.getMonth()+1)>9 ? ''+(now.getMonth()+1) : '0'+(now.getMonth()+1);
		var day = now.getDate()>9 ? ''+now.getDate() : '0'+now.getDate();
		var todayVal = year + '-' + mon + '-' + day;
		location.href="my_planner.do?momentorMemberVO.memberId=${sessionScope.pnvo.momentorMemberVO.memberId}&plannerDate=" + todayVal;
	});
	
});

</script>

<br>
<c:set value="${requestScope.exerciseInfo}" var = "info"></c:set>

<div class="container">


      <div class="row">

        <div class="col-sm-8 blog-main">

          <div class="blog-post">
          <br><br><span id ="boardNo">${info.boardNo }</span>
            <h2 class="blog-post-title">제목&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;&nbsp; ${info.boardTitle }</h2>
            <h3 class = "blog-post-title" >운동이름&nbsp;&nbsp; |&nbsp;&nbsp;&nbsp;&nbsp; <span id="exerciseName">${info.exerciseVO.exerciseName }</span></h3>
            
            <hr>
            <p class="blog-post-meta">${info.boardWdate } by <a href="#">관리자</a></p>
			
                        <pre>${info.boardContent }</pre>
            <br><br><br>
            <hr>
       
          </div>
        </div><!-- /.blog-sidebar -->

      </div><!-- /.row -->
		 <nav>
	   <ul class="pager">
	   <c:if test="${sessionScope.pnvo.momentorMemberVO.auth==1 }">	
	   <li><a href = "${initParam.root }admin_updateViewForAdmin.do?eboardNo=${info.boardNo }">수정하기</a></li>
	   <li id = "delBtn"><a href="#">삭제하기</a></li>
	   </c:if>
	   <li><a href = "${initParam.root }member_exerciseBoard.do?pageNo=${param.pageNo}">뒤로가기</a></li>
	   <!-- Button trigger modal -->
	   <li><a href="#" id="regInCartModal" >찜하기</a> </li>
	   </ul>
	   </nav>
    </div><!-- /.container -->

	<!-- Modal -->
	<div class="modal fade" id="regInCart" tabindex="-1" role="dialog" aria-labelledby="regInCartLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="idFindCheck">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
						<h4 class="modal-title" id="regInCartLabel">찜하기</h4>
					</div>
					<div class="modal-body">
						<span id="showCartList"></span>
						<div class="modal-footer">
							<button type="button" class="btn btn-primary" id="regInCartBtn">담기</button>
							<button type="button" class="btn btn-primary" id="movePlannerBtn">플래너로 이동</button>
							<button type="button" class="btn btn-default" data-dismiss="modal" id="closeBtn">닫기</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>