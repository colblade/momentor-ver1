<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="${initParam.root }css/mystyle.css" rel="stylesheet">
<script type="text/javascript">
$(document).ready(function(){
	var checkResultPassword = "";
	$("#memberPasswordCheck").keyup(function(){
		var memberPasswordCheck=$("#memberPasswordCheck").val().trim();
		if(memberPasswordCheck.length==0){
			$("#memberPasswordCheckView").html("탈퇴하려면 패스워드를 입력하세요").css("color","orange");
			checkResultPassword="";
			return;
		}
		$.ajax({
			type:"POST",
			url:"my_passwordCheck.do",				
			data:$("#myInfo").serialize(),	
			success:function(data){						
				if(data=="fail"){
				$("#memberPasswordCheckView").html("비밀번호 일치하지 않아 탈퇴불가").css("color","red");
					checkResultPassword="";
				}else{						
					$("#memberPasswordCheckView").html("탈퇴가능!").css("color","green");		
					checkResultPassword=memberPasswordCheck;
				}					
			}//callback			
		});//ajax
	});//keyup
	
	$("#myInfoDelete").click(function(){
		if($("#DeleteReason").val()==null||$("#DeleteReason").val()==""){
			alert("탈퇴 사유를 입력해 주세요.");
			return false;
		}
		if(checkResultPassword==null||checkResultPassword==""){
			alert("비밀번호를 정확하게 입력하지 않으면 삭제 불가입니다.!");
			return false;
		}
		$("#myInfo").submit();
	});
});
</script>
<div class="container, text-center">
<form method="post" name="myInfo" id="myInfo" action="my_myInfoDelete.do">
패스워드를 입력해야 탈퇴가능 합니다 <input type="password" name="memberPasswordCheck" id="memberPasswordCheck">
<span id="memberPasswordCheckView"></span>
<br><br>
<input type="hidden" name="auth" value="${requestScope.pnvo.momentorMemberVO.auth}">
<table align="center" class="table-hover">
	<tr><td class="text-center"><input type="hidden" name="id" value="${requestScope.pnvo.momentorMemberVO.memberId}"></td></tr>
	<tr><td class="text-center">탈퇴사유를 입력하시오</td><td class="text-center"><input type="text" name="DeleteReason" id="DeleteReason"></td></tr>
	
	<tr align="center"><td colspan="2" class="text-center"><br><br><input type="submit" value="탈퇴완료" id="myInfoDelete"></td></tr>
	</table>
</form>
</div>