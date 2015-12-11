<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions"%>

<div align="center" class="table-responsive">
<table border="1" class="table table-striped, table-hover" style="width: 50%">
	<tr><td class="text-center">아이디</td><td class="text-center">${requestScope.pnvo.momentorMemberVO.memberId}</td></tr>
	
	<tr><td class="text-center">패스워드</td>
		<td class="text-center">
			<c:forEach begin="0" end="${fn:length(requestScope.pnvo.momentorMemberVO.memberPassword)}">
				*
			</c:forEach>
		</td>
	</tr>	
	<tr><td class="text-center">이름</td><td class="text-center">${requestScope.pnvo.momentorMemberVO.memberName}</td></tr>
	<tr><td class="text-center">생년월일</td><td class="text-center">${requestScope.pnvo.momentorMemberVO.birthYear}년 ${requestScope.pnvo.momentorMemberVO.birthMonth}월 ${requestScope.pnvo.momentorMemberVO.birthDay}일</td></tr>
	<tr><td class="text-center">별명</td><td class="text-center">${requestScope.pnvo.momentorMemberVO.nickName}</td></tr>
	<tr><td class="text-center">이메일</td><td class="text-center">${requestScope.pnvo.momentorMemberVO.memberEmail}</td></tr>
	<tr><td class="text-center">성별</td><td class="text-center">${requestScope.pnvo.momentorMemberVO.gender}</td></tr>
	<tr><td class="text-center">주소</td><td class="text-center">${requestScope.pnvo.momentorMemberVO.memberAddress }</td></tr>
	<tr><td class="text-center">몸무게</td><td class="text-center">${requestScope.pnvo.memberWeight} kg</td></tr>
	<tr><td class="text-center">키</td><td class="text-center">${requestScope.pnvo.memberHeight} cm</td></tr>
	<tr><td class="text-center">bmi</td><td class="text-center">${requestScope.pnvo.bmi }</td></tr>
	<tr><td class="text-center">나이</td><td class="text-center">${requestScope.pnvo.age} 세</td></tr>
</table>
</div>
<br><br>
<a href="login_home.do">홈으로</a>

