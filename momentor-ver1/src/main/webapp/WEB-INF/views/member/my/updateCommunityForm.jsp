<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
 <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<script type="text/javascript">
       $(document).ready(function(){
          $("#updateForm").submit(function(){
             if($("input[name=boardTitle]").val()==""){
                alert("제목을 입력해주세요")
                $("input[name=boardTitle]").focus();
                return false;
             }
             if($("[name=boardContent]").val()==""){
                alert("내용을 입력해주세요")
                $("[name=boardContent]").focus();
                return false;
             }
          });
       
       
          $("#imgList").on("click","img",function(){
        		if(confirm("삭제하시겠습니까? 삭제된 파일은 복구할 수 없습니다. 그래도 삭제하시겠습니까?")){
        		var id = $(this).attr("id");
        		var imgName = $("#"+id).attr("title");
        		alert(imgName);
        		$.ajax({
        			
        			type:"get",
        			url:"${initParam.root}my_deleteCommunityImgFileByImgName.do?boardNo="+$("#boardNo").val()+"&imgName="+$.trim(imgName),
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

        	
       
       
       });
    </script>
<form class="form-horizontal" action="my_updateCommunity.do"   method="post" id="updateForm" enctype="multipart/form-data">
<input type="hidden" id="boardNo"   name="boardNo" value="${requestScope.cvo.boardNo }">
<input type="hidden" name="momentorMemberVO.memberId" value="${sessionScope.pnvo.momentorMemberVO.memberId}">
   <div class="form-group">
      <label for="boardTitle" class="col-sm-2 control-label">제목 : </label>
      <div class="col-sm-10">
         <input type="text" class="form-control" name="boardTitle"
            value="${requestScope.cvo.boardTitle }" placeholder="제목">
      </div>
   </div>
   <div class="form-group">
      <label class="col-sm-2 control-label">작성자 : </label>
      <div class="col-sm-10">
         ${sessionScope.pnvo.momentorMemberVO.nickName }<br>
      </div>
   </div>
   
   <div class="form-group">
      <label for="boardImg" class="col-sm-2 control-label"></label>
      <div class="col-sm-10">
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
								src="${initParam.root}communityimg/${fileName.BOARDNO}_${fileName.IMGNAME}"
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
      <label for="boardContent" class="col-sm-2 control-label">내용 :
      </label>
      <div class="col-sm-10">
         <textarea rows="7" cols="30" class="form-control" name="boardContent">${requestScope.cvo.boardContent}</textarea>
      </div>
   </div>
   <div class="form-group" align="right">
      <div class="col-sm-offset-2 col-sm-10">
         <button type="submit" class="btn btn-default">수정하기</button>
      </div>
   </div>
</form>