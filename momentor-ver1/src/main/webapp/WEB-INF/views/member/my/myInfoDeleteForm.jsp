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

<form method="post" name="myInfo" id="myInfo" action="my_myInfoDelete.do">
패스워드를 입력해야 탈퇴가능 합니다 <input type="password" name="memberPasswordCheck" id="memberPasswordCheck">
<span id="memberPasswordCheckView"></span>
<br><br>
<table border="1" class="tableForm">
	<tr><td><input type="hidden" name="id" value="${pnvo.momentorMemberVO.memberId}"></td></tr>
	<tr><td>탈퇴사유를 입력하시오</td><td><input type="text" name="DeleteReason" id="DeleteReason"></td></tr>
<!--  	<tr><td colspan="2">패스워드 확인</td></tr>
 	<tr>
 	<td><input type="password" name="memberPasswordCheck" id="memberPasswordCheck"></td>
 	<td><span id="memberPasswordCheckView"></span></td>
 	</tr> -->
	<tr><td colspan="2"><input type="submit" value="탈퇴완료" id="myInfoDelete"></td></tr>
	</table>
</form>