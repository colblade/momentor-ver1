<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
$(document).ready(function(){
	var checkResultPassword = "";
	var checkResultNickName = "";
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
	
	$("#nickName").keyup(function(){
		var nickName=$("#nickName").val().trim();
		if(nickName.length==0){
			$("#checkResultNickNameView").html("닉네임을 입력하세요").css("color","orange");
			checkResultNickName="";
			return;
		}
		$.ajax({
			type:"POST",
			url:"nickNameCheck.do",
			data:"nickName="+$("#nickName").val(),
			success:function(data){						
				if(data=="fail"){
				$("#checkResultNickNameView").html("닉네임 사용 불가").css("color","red");
				checkResultNickName="";
					return false;
				}else{						
					$("#checkResultNickNameView").html("닉네임 사용 가능!").css("color","green");		
					checkResultNickName=nickName;
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
			alert("이메일을 입력하시오");
			return false;
		}
		if($("#memberAddress").val()==null||$("#memberAddress").val()==""){
			alert("주소를 입력하시오");
			return false;
		}
		if($("#memberWeight").val()==null||$("#memberWeight").val()==""){
			alert("몸무게를 입력하시오");
			return false;
		}
		if(isNaN($("#memberWeight").val())){
			alert("몸무게를 숫자로 입력하시오");
			return false;
		}
		if($("#memberHeight").val()==null||$("#memberHeight").val()==""){
			alert("키를 입력하시오");
			return false;
		}
		if(isNaN($("#memberHeight").val())){
			alert("키를 숫자로 입력하시오");
			return false;
		}
		if(checkResultPassword==null||checkResultPassword==""){
			alert("비밀번호를 정확하게 입력하지 않으면 수정 불가입니다.!");
			return false;
		}
		if(checkResultNickName==null||checkResultNickName==""){
			alert("닉네임은 사용 불가 입니다. 다시 입력해 주세요!");
			return false;
		}
		$("#myInfo").submit();
	});

});
</script>
<div class="container, text-center" style="width: 100%" align="center">
<form method="post" name="myInfo" id="myInfo" action="my_myInfoUpdate.do">
패스워드를 입력해야 수정가능 합니다 <input type="password" name="memberPasswordCheck" id="memberPasswordCheck">
<span id="memberPasswordCheckView"></span>
<hr>
<input type="hidden" name="auth" value="${requestScope.pnvo.momentorMemberVO.auth}">
<input type="hidden" name="bmi" value="${requestScope.pnvo.bmi}">
	<input type="hidden" name="id" value="${requestScope.pnvo.momentorMemberVO.memberId}">
	<p class="blog-post-meta">아이디 : <input type="text" name="memberId" value="${requestScope.pnvo.momentorMemberVO.memberId}" readonly="readonly" style="color: red"></p>
	<hr>
	<p class="blog-post-meta">패스워드 : <input type="password" name="memberPassword" id="memberPassword" value=${requestScope.pnvo.momentorMemberVO.memberPassword }></p>
	<hr>
	<p class="blog-post-meta">이름 : <input type="text" name="memberName" id="memberName" value="${requestScope.pnvo.momentorMemberVO.memberName }"></p>
	<hr>
    <p class="blog-post-meta">생년월일 : <input type="text" class="datepicker" name="myBirthDate" id="myBirthDate"class="form-control"></p>     
	<hr>
	<p class="blog-post-meta">별명 : <input type="text" name="nickName" id="nickName">
	<span id="checkResultNickNameView"></span>
	</p>
	<hr>
	<p class="blog-post-meta">이메일 : <input type="email" name="memberEmail" id="memberEmail" value="${requestScope.pnvo.momentorMemberVO.memberEmail }"></p>
	<hr>
	<p class="blog-post-meta">성별 : 	<select name="gender" ><option value ="M" selected="selected"> 남자</option><option value ="F" > 여자</option></select>	
	<hr>
	<p class="blog-post-meta">주소 : <input type="text" name="memberAddress" id="memberAddress" value="${requestScope.pnvo.momentorMemberVO.memberAddress }"></p>
	<hr>
	<p class="blog-post-meta">몸무게 : <input type="text" name="memberWeight" value="${requestScope.pnvo.memberWeight}" id="memberWeight"></p>
	<hr>
	<p class="blog-post-meta">키 : <input type="text" name="memberHeight" value="${requestScope.pnvo.memberHeight}" id="memberHeight"></p>
	<hr>
	<div align="center"><input class="btn btn-default" type="button" value="수정완료" id="myInfoUpdate"></div>
</form>
</div>