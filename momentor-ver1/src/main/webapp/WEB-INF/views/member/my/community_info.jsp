<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="info" value="${requestScope.info }" />
<script type="text/javascript">
       $(document).ready(function(){
             /* 삭제 버튼 클릭시 */
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
             /*수정 버튼 클릭시*/
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
             });//비밀번호 검증
             $("#replyView").hide();
             
             $("#replyBtn").click(function(){
                $("#replyView").toggle();
             });
             
             /* $("#replyBtn").click(function(){
                $("#replyView").toggle(0,function(){
                   if($("#replyView").css("display")=="none"){
                      $("#replyBtn").value("댓글보기▼");
                   }else{
                      $("#replyBtn").value("접기▲");
                   }
                });
             });//replyBtn */
          }
         );
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

            <p>${info.boardContent }</p>
            <br><br><br>
            <hr>
            <p>
            <input class="btn btn-default" type="button" value="댓글보기▼" id="replyBtn">
               조회수 : ${info.memberHits}&nbsp;추천수 : ${info.recommend }&nbsp;비추천수 : ${info.notRecommend }<br>
            </p>
            <div id="replyView"><hr>Hello<hr></div>      
            <div class="row marketing">
               <div class="col-lg-6">
                  <c:forEach items="${requestScope.replyList }" var="replyList">
                     <h5>${replyList.momentorMemberVO.memberId }&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${replyList.replyDate}</h5>
                     <p>${replyList.content}</p>
                  </c:forEach>         
               </div>
               <input type="hidden" value="${sessionScope.pnvo.momentorMemberVO.memberPassword}"   id="memberPassword">
               
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