<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="${initParam.root}css/mystyle.css">
<h2>공지글 상세 페이지</h2>

<table class="tableForm">
	<tr><td>공지글번호</td><td>${requestScope.nvo.boardNo}</td></tr>
	<tr><td>제목</td><td>${requestScope.nvo.boardTitle }</td></tr>
	<tr><td>작성일</td><td>${requestScope.nvo.boardWdate}</td></tr>
	<tr><td>작성자</td><td>${requestScope.nvo.momentorMemberVO.memberId }</td></tr>
	<tr><td>내용</td><td>${requestScope.nvo.boardContent }</td></tr>
</table>

<a href="login_home.do">홈으로</a>