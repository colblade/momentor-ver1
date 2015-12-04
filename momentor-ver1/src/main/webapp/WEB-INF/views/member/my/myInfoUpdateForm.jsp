<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="${initParam.root }css/mystyle.css" rel="stylesheet">
<script type="text/javascript">
$(document).ready(function(){
	var checkResultPassword = "";
	$("#memberPasswordCheck").keyup(function(){
		var memberPasswordCheck=$("#memberPasswordCheck").val().trim();
		if(memberPasswordCheck.length==0){
			$("#memberPasswordCheckView").html("수정하려면 패스워드를 입력하세요").css("color","orange");
			checkResultPassword="";
			return;
		}
		$.ajax({
			type:"POST",
			url:"my_passwordCheck.do",				
			//url:"passwordCheck.do",				
			//data:$("#myInfo").serialize()+"&memberId=${mpvo.momentorMemberVO.memberId}",	
			data:$("#myInfo").serialize(),	
			success:function(data){						
				if(data=="fail"){
				$("#memberPasswordCheckView").html("비밀번호 일치하지 않아 수정불가").css("color","red");
					checkResultPassword="";
					return false;
				}else{						
					$("#memberPasswordCheckView").html("수정가능!").css("color","green");		
					checkResultPassword=memberPasswordCheck;
				}					
			}//callback			
		});//ajax
	});//keyup
	
	$("#myInfoUpdate").click(function(){
		if($("#memberPassword").val()==null||$("#memberPassword").val()==""){
			alert("패스워드를 입력하시오");
			return false;
		}
		if($("#memberName").val()==null||$("#memberName").val()==""){
			alert("이름를 입력하시오");
			return false;
		}
		if($("#nickName").val()==null||$("#nickName").val()==""){
			alert("별명를 입력하시오");
			return false;
		}
		if($("#memberEmail").val()==null||$("#memberEmail").val()==""){
			alert("이메일을를 입력하시오");
			return false;
		}
		if($("#memberAddress").val()==null||$("#memberAddress").val()==""){
			alert("주소를 입력하시오");
			return false;
		}
		if($("#memberWeight").val()==null||$("#memberWeight").val()==""){
			alert("키를 입력하시오");
			return false;
		}
		if($("#memberHeight").val()==null||$("#memberHeight").val()==""){
			alert("몸무게를 입력하시오");
			return false;
		}
		if(checkResultPassword==null||checkResultPassword==""){
			alert("비밀번호를 정확하게 입력하지 않으면 수정 불가입니다.!");
			return false;
		}
		$("#myInfo").submit();
	});

});
</script>
<h2> 수정 테이블</h2>
<form method="post" name="myInfo" id="myInfo" action="my_myInfoUpdate.do">
패스워드를 입력해야 수정가능 합니다 <input type="password" name="memberPasswordCheck" id="memberPasswordCheck">
<span id="memberPasswordCheckView"></span>
<br><br>
<table border="1" class="tableForm">
	<tr><td><input type="hidden" name="id" value="${pnvo.momentorMemberVO.memberId}"></td></tr>
	<tr><td>아이디</td><td><input type="text" name="memberId" value="${pnvo.momentorMemberVO.memberId}" readonly="readonly"></td></tr>
	<tr><td>패스워드</td><td><input type="password" name="memberPassword" id="memberPassword"></td></tr>
	<tr><td>이름</td><td><input type="text" name="memberName" id="memberName"></td></tr>
	<tr><td>년</td><td><input type="text" name="birthYear" value="${pnvo.momentorMemberVO.birthYear}" readonly="readonly"></td></tr>
	<tr><td>월</td><td><input type="text" name="birthMonth" value="${pnvo.momentorMemberVO.birthMonth}" readonly="readonly"></td></tr>
	<tr><td>일</td><td><input type="text" name="birthDay" value="${pnvo.momentorMemberVO.birthDay}" readonly="readonly"></td></tr>
	<tr><td>별명</td><td><input type="text" name="nickName" id="nickName"></td></tr>
	<tr><td>이메일</td><td><input type="text" name="memberEmail" id="memberEmail"></td></tr>
	<tr><td>성별</td><td><input type="text" name="gender" value="${pnvo.momentorMemberVO.gender}" readonly="readonly"></td></tr>
	<tr><td>주소</td><td><input type="text" name="memberAddress" id="memberAddress"></td></tr>
	<tr><td>키</td><td><input type="text" name="memberWeight" value="${pnvo.memberWeight}" id="memberWeight"></td></tr>
	<tr><td>몸무게</td><td><input type="text" name="memberHeight" value="${pnvo.memberHeight}" id="memberHeight"></td></tr>
	<tr><td>나이</td><td><input type="text" name="age" value="${pnvo.age}" readonly="readonly"></td></tr>
	<tr><td>bmi</td><td><input type="text" name="bmi" value="${pnvo.bmi}" readonly="readonly"></td></tr>
<!--  	<tr><td colspan="2">패스워드 확인</td></tr>
 	<tr>
 	<td><input type="password" name="memberPasswordCheck" id="memberPasswordCheck"></td>
 	<td><span id="memberPasswordCheckView"></span></td>
 	</tr> -->
	<tr><td colspan="2"><input type="button" value="수정완료" id="myInfoUpdate"></td></tr>
</table>
</form>