<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="${initParam.root }css/broker.css" rel="stylesheet">

<script type="text/javascript">
$(document).ready(function(){
	$("#memberInfoUpdateBtn").click(function(){
		if(confirm("회원정보를 수정하시겠습니까?")){
    		location.href="my_myInfoUpdateForm.do?memberId=${pnvo.momentorMemberVO.memberId}";			
		}
	});

	$("#memberInfoDeleteBtn").click(function(){
		if(confirm("회원을 탈퇴하시겠습니까?")){
    		location.href="my_myInfoDeleteForm.do?memberId=${pnvo.momentorMemberVO.memberId}";			
		}
		
	}); 
});
</script>
<h2>나의 정보</h2>
<form method="post" name="myInfo" action="#">
<table border="1" class="tableForm">
	<tr><td>아이디</td><td>${pnvo.momentorMemberVO.memberId}</td></tr>
	<tr><td>패스워드</td><td>${pnvo.momentorMemberVO.memberPassword}</td></tr>	
	<tr><td>이름</td><td>${pnvo.momentorMemberVO.memberName}</td></tr>
	<tr><td>년</td><td>${pnvo.momentorMemberVO.birthYear}</td></tr>
	<tr><td>월</td><td>${pnvo.momentorMemberVO.birthMonth}</td></tr>
	<tr><td>일</td><td>${pnvo.momentorMemberVO.birthDay}</td></tr>
	<tr><td>별명</td><td>${pnvo.momentorMemberVO.nickName}</td></tr>
	<tr><td>이메일</td><td>${pnvo.momentorMemberVO.memberEmail}</td></tr>
	<tr><td>성별</td><td>${pnvo.momentorMemberVO.gender}</td></tr>
	<tr><td>주소</td><td>${pnvo.momentorMemberVO.memberAddress}</td></tr>
	<tr><td>키</td><td>${pnvo.memberWeight}</td></tr>
	<tr><td>몸무게</td><td>${pnvo.memberHeight}</td></tr>
	<tr><td>나이</td><td>${pnvo.age}</td></tr>
	<tr><td>bmi</td><td>${pnvo.bmi}</td></tr>
</table>
	<div id="btn">
	<input type="button" value="회원정보수정하기" id="memberInfoUpdateBtn">
	<input type="button" value="탈퇴하기" id="memberInfoDeleteBtn">
	</div>
</form>
