<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="${initParam.root }css/broker.css" rel="stylesheet">
<h2>회원정보 업데이트 완료</h2>

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
	<tr><td>주소</td><td>${pnvo.momentorMemberVO.memberAddress }</td></tr>
	<tr><td>키</td><td>${pnvo.memberWeight}</td></tr>
	<tr><td>몸무게</td><td>${pnvo.memberHeight}</td></tr>
	<tr><td>나이</td><td>${pnvo.age}</td></tr>
	<tr><td>bmi</td><td>${pnvo.bmi}</td></tr>
</table>
<a href="login_home.do">홈으로</a>

