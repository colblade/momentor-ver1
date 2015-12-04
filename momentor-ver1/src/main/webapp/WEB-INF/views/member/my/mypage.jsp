<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<hr>
<table class="table table-striped">
	<tr>
	
		<td><a href="${initParam.root }my_getMyCommnunityBoardList.do?memberId=${sessionScope.pnvo.momentorMemberVO.memberId}">나의 게시글 보기 </a></td>
		<td><a href="${initParam.root }my_getMyReplyList.do?memberId=${sessionScope.pnvo.momentorMemberVO.memberId}">나의 댓글 보기</a></td>
	</tr>
	<tr>
		<td colspan="2"><a href="my_myInfo.do">회원정보 보기</a></td>
	</tr>
</table>

<hr>

<p>
<a class="btn btn-default" href="${initParam.root }my_getMyCommnunityBoardList.do?pageNo=1&memberId=${sessionScope.pnvo.momentorMemberVO.memberId}" role="button">
 나의 게시글 보기  &raquo;</a>
<a class="btn btn-default" href="${initParam.root }my_getMyReplyList.do?pageNo=1&memberId=${sessionScope.pnvo.momentorMemberVO.memberId}" role="button">나의 댓글 보기 &raquo;</a></p>