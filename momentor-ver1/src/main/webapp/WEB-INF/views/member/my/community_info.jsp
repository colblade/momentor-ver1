<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="info" value="${requestScope.info }" />
<script type="text/javascript">
$(document).ready(function(){
    /*  게시글 삭제 버튼 클릭시 */
    $("#deleteBtn").click(function(){
       var checkFormMess="<div class='row'><div class='col-xs-3'><input type='password' class='form-control' placeholder='비밀번호' id='passCheck'></div>";
       checkFormMess+="<input type='submit'class='btn btn-default' value='확인'></div>";
       checkFormMess+="<input type='hidden' value='${info.boardNo}' name='boardNo'>";
       $("#passCheckForm").html(checkFormMess);
       $("#passCheck").focus();
    });
    /* 목록 버튼 클릭시 */
    $("#listBtn").click(function(){
       location.href="showCommunityList.do";
    });
    /*게시글 수정 버튼 클릭시*/
    $("#modifyBtn").click(function(){
       location.href="my_updateCommunityForm.do?boardNo="+${info.boardNo};
    });
    /* 비밀번호 검증 */
    $("#passCheckForm").submit(function(){
       if($("#passCheck").val()==$("#memberPassword").val()){
          if(confirm("정말 삭제하시겠습니까?")){
          }else{
             $("#passCheck").val("");
              $("#passCheck").focus();
             return false;
          }
       }else{
          alert("비밀번호가 일치하지 않습니다");
          $("#passCheck").val("");
          $("#passCheck").focus();
          return false;
       }
    });
    
  //버튼을 통한 댓글 보여주기
    $("#replyView").hide();             
    $("#replyBtn").click(function(){
       $("#replyView").toggle(function(){
          if($("#replyView").css("display")=="none"){
             $("#replyBtn").val("댓글보기▼");
          }else{
       	   $.ajax({
       		  type:"get",
       		  url:"my_getReplyList.do?boardNo=${info.boardNo}",
       		  success:function(result){
       			  showReplyList(result);
       		  }//success
       	   });//ajax
             $("#replyBtn").val("접기▲");
          }//else
       });//toggle
    });//click           
    //덧글 등록시
    $("#registReply").click(function(){
   	 if($("[name=content]").val()==""){
   		 alert("내용을 입력해주세요");
   		 return false;
   	 }else{
   		 $.ajax({
   			 type:"post",
   			 url:"my_registReply.do",
   			 data:"momentorMemberVO.memberId=${sessionScope.pnvo.momentorMemberVO.memberId}&communityBoardVO.momentorMemberVO.memberId=${info.momentorMemberVO.memberId}&communityBoardVO.boardNo=${info.boardNo}&content="+$('[name=content]').val(),
   			 success:function(result){
   				 $("#replyView").show();
          			  showReplyList(result);
          			  $("[name=content]").val("");
          			$("#replyBtn").val("접기▲");
          		  }//success
   		 });//ajax
   	 }//else
    });
    
  //추천
 	$("#recommendImg").on("click", "#recImg", function(){
 	
 	
 	$.ajax({
 		type:"post",
 		url:"${initParam.root}my_updateRecommendInfo.do",
 		data:"memberId="+$("#memberId").val()+"&boardNo="+$("#boardNo").val()+"&recommend="+$("#recommend").val(),
 		success: function(data){
 		var recommend = data.RECOMMEND;
 	
 			if(recommend =="Y"){
 				$("#recommendImg").html("<input type = 'hidden' value = 'N' id = 'recommend'><img src='${initParam.root }image/recommend.png' width='20' height='20' id = 'recImg'>");
 			}else{
 				$("#recommendImg").html("<input type = 'hidden' value = 'Y' id = 'recommend'><img src='${initParam.root }image/notRecommend.png' width='20' height='20' id = 'recImg'>");
 			}
 			
 			$("#recommendCount").html(data.recommendCount);
 			
 		}//success
 	});//ajax
 	});//on
 	
 			
 	//비추천
 	$("#notRecommendImg").on("click", "#notRecImg", function(){
 		
 	
 	$.ajax({
 		type:"post",
 		url:"${initParam.root}my_updateRecommendInfo.do",
 		data:"memberId="+$("#memberId").val()+"&boardNo="+$("#boardNo").val()+"&notRecommend="+$("#notRecommend").val(),
 		success: function(data){
 			var notrecommend = data.NOTRECOMMEND;
 			
 			if(notrecommend =="Y"){
 			
 			$("#notRecommendImg").html("<input type = 'hidden' value = 'N' id = 'notRecommend'><img src='${initParam.root }image/recommend.png' width='20' height='20' id = 'notRecImg'>");
 		}else{
 			$("#notRecommendImg").html("<input type = 'hidden' value = 'Y' id = 'notRecommend'><img src='${initParam.root }image/notRecommend.png' width='20' height='20' id = 'notRecImg'>");				
 		}
 				$("#notRecommendCount").html(data.notRecommendCount);
 		}//success
 	});//ajax
 	});//on
    
 });
/* 댓글 삭제 */
function deleteReply(replyNo){
  	 if(confirm("삭제하시겠습니까?")){
  		 $.ajax({
	   		 type:"get",
	   		 url:"my_deleteReply.do?boardNo=${info.boardNo}&replyNo="+replyNo,
	   		 success:function(result){
				 $("#replyView").show();
      			  showReplyList(result);
      		  }//success	
  		});
  	 }else{
  		 return false;
  	 }
}
/* 댓글 받아와 폼 변경 */
function updateReply(replyNo){
  var replyContent="";
  var mess="";
  if(confirm("수정하시겠습니까?")){//수정하기 클릭시 폼 변경
	   $.ajax({
		  type:"get",
		  url:"my_getReplyList.do?boardNo=${info.boardNo}",
		  success:function(result){
			 var mess="<table>";
			  	$.each(result,function(index,replyList){
				 //덧글 리스트 만큼 돌린다
				 if(replyNo==replyList.replyNo){//돌리는 도중 클릭한 repNo와 each로 돌고있는 repNo가 일치하면 댓글 대신 수정공간 제공
					mess+="<tr><td><h5>"+replyList.momentorMemberVO.nickName+"</h5>";
   	   		mess+="<textarea style='resize:none' rows='3' cols='50' class='form-control' name='updateReplyContent' >"+replyList.content+"</textarea>";
   	   		mess+="<input type='button' id='updateBtn' value='수정' onclick='updateReplyFinal("+replyNo+")'></td></tr>";
				 }else{//일반 댓글 출력
				  mess+="<tr><td><h5>"+replyList.momentorMemberVO.nickName+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+replyList.replyDate;
				  var pnvo="${sessionScope.pnvo.momentorMemberVO.memberId}"
				  var pnvo2=replyList.momentorMemberVO.memberId
				  if(pnvo==pnvo2){
						  mess+="&nbsp;&nbsp;<input type='button' class='updateReply' value='수정' onclick='updateReply("+replyList.replyNo+")'>";
						  mess+="&nbsp;&nbsp;<input type='button' class='deleteReply' value='삭제' onclick='deleteReply("+replyList.replyNo+")'>";
					  }   //본인 댓글 비	교 if             				 
  				  mess+="</h5><pre>&nbsp;"+replyList.content+"</pre></td></tr>";       					       					 
					 }//else
				  });//each
				  mess+="</table>";
				 $("#replyView").html(mess);
 			}//success   			
 		});
  }else{
	   return false;
  }
}
/* 디비에서 댓글 수정 */
function updateReplyFinal(replyNo){
	var content = $("[name=updateReplyContent]").val();
  $.ajax({
	  type:"get",
	  url:"my_updateReply.do",
	  data:"boardNo=${info.boardNo}&replyNo="+replyNo+"&updateReplyContent="+content,
	  success:function(result){
		  $("#replyView").show();
			  showReplyList(result);
			$("#replyBtn").val("접기▲");
	  }
  });
}
/* 목록 출력 공통 사항 */
function showReplyList(result){
  var mess="<table>";
	  $.each(result,function(index,replyList){
		 // alert(replyList); 리턴 받는 값은 replyVO
		  mess+="<td id='rep_"+replyList.replyNo+"'><h5>"+replyList.momentorMemberVO.nickName+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+replyList.replyDate;
		  var pnvo="${sessionScope.pnvo.momentorMemberVO.memberId}"
		  var pnvo2=replyList.momentorMemberVO.memberId
		  if(pnvo==pnvo2){
			  mess+="&nbsp;&nbsp;<input type='button' class='updateReply' value='수정' onclick='updateReply("+replyList.replyNo+")'>";
			  mess+="&nbsp;&nbsp;<input type='button' class='deleteReply' value='삭제' onclick='deleteReply("+replyList.replyNo+")'>";
		  }                				 
		  mess+="</h5><pre>&nbsp;"+replyList.content+"</pre></td></table>";
	  });
	  $("#replyView").html(mess);//html로 mess를 넣을때 jQuery형식으로 넘겨주면 인식 불가 -> undefined 출력된다
	  											// -> onclick으로 메서드가 넘어간 상태에서 textarea의 val을 받아온다
 }
</script>
<div class="container">

   <div class="row">

      <div class="col-sm-8 blog-main">

         <div class="blog-post">
            <br><br>
            <h2 class="blog-post-title">${info.boardTitle }</h2>
            <hr>
            <p class="blog-post-meta">${info.boardWdate }
               by <a href="#">${info.momentorMemberVO.nickName}</a>
                  
            </p>

            <pre>${info.boardContent }</pre>
            <br><br><br>
            <hr>
            <p>
            <input class="btn btn-default" type="button" value="댓글보기▼" id="replyBtn">
               <c:set value="${requestScope.recommendInfo }" var = "recInfo"/>
           
             	조회수 : ${info.memberHits}&nbsp; | 추천수 : <span id="recommendCount">${info.recommend }</span>&nbsp;
             	<span id="recommendImg">
               <c:choose>
               <c:when test="${'Y' eq recInfo.RECOMMEND}">
               
               <input type = "hidden" value = "N" id = "recommend">
               <img src="${initParam.root }image/recommend.png" width="20" height="20" id = "recImg" >
               </c:when>
                <c:otherwise>
               <input type = "hidden" value = "Y" id = "recommend">
               <img src="${initParam.root }image/notRecommend.png" width="20" height="20" id = "recImg" >
                </c:otherwise>
                </c:choose></span>
              | 비추천수 : <span id = "notRecommendCount">  ${info.notRecommend }
                </span>
				<span id="notRecommendImg">
                <c:choose>
                <c:when test="${recInfo.NOTRECOMMEND eq 'Y'}">
               <input type = "hidden" value = "N" id = "notRecommend">
               <img src="${initParam.root }image/recommend.png" width="20" height="20" id = "notRecImg">
               </c:when>
               <c:otherwise>
                    <input type = "hidden" value = "Y" id = "notRecommend">
                    <img src="${initParam.root }image/notRecommend.png" width="20" height="20" id = "notRecImg">
               </c:otherwise>
                 </c:choose>
                 </span>
                 <br>
       <input type ="hidden" value = "${sessionScope.pnvo.momentorMemberVO.memberId }" id = "memberId">
        <input type='hidden' value='${info.boardNo}' name='boardNo' id = "boardNo">
            </p>
             <div class="row marketing">
               <div class="col-lg-6" id="replyView">
               </div>
               <textarea style="resize:none" rows="3" cols="50" class="form-control" name="content"></textarea>
	                  <input type="button" id="registReply" value="확인">
	                  <hr>
	           </div>
	           <div class="row marketing">
	           <input type="hidden" value="${sessionScope.pnvo.momentorMemberVO.memberPassword}"  id="memberPassword">
               <p align="left">
               <c:if   test="${sessionScope.pnvo.momentorMemberVO.memberId==info.momentorMemberVO.memberId }">               
                  <input class="btn btn-default" type="button" value="삭제하기" id="deleteBtn">
                  <input class="btn btn-default" type="button" value="수정하기" id="modifyBtn">               
               </c:if>
               </p>
               <p align="right"><input class="btn btn-default" type="button" value="목록으로" id="listBtn"></p>
               <form id="passCheckForm" action="my_deleteCommunity.do"></form>
            </div>
         </div>
      </div>
      <!-- /.blog-sidebar -->
   </div>
   <!-- /.row -->
</div>
<!-- /.container -->