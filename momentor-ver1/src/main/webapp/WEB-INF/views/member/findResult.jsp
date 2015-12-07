<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
+검색 결과+ <hr>
<c:choose>
	<c:when test="${fn:length(requestScope.ebList)==0}">
		<h3>'${requestScope.word}'에 대한 Momentor Guide 검색결과 없음</h3>	
	</c:when>
	<c:when test="${fn:length(requestScope.ebList)>0 && fn:length(requestScope.ebList)<5}">
		<h3>'${requestScope.word}'에 대한 Momentor Guide <font color="red">${fn:length(requestScope.totalEbList)}개</font> 검색</h3><br>
		 <div class="table-responsive">
		<table class="table table-striped">
		<thead>
		<tr><th>NO</th><th>TITLE</th><th>글쓴이</th><th>작성일</th><th>조회수</th></tr>
		</thead>
		<tbody>
			<c:forEach items="${requestScope.ebList}" var="list">
				<tr>
					<td>${list.boardNo }</td>
				    <td><a href="${initParam.root }member_getExerciseByNo.do?boardNo=${list.boardNo}">${list.boardTitle }</a></td>
				    <td>${list.momentorMemberVO.memberName}</td>
				    <td>${list.boardWdate }</td>
				    <td>${list.exerciseHits }</td>
				</tr>
			</c:forEach>
		</tbody>
		</table>
		</div>
	</c:when>
	<c:otherwise>
		<h3>'${requestScope.word}'에 대한 Momentor Guide <font color="red">${fn:length(requestScope.totalEbList)}개</font> 검색</h3><br>
		<div class="table-responsive">
		<table class="table table-striped">
		<thead>
		<tr><th>NO</th><th>TITLE</th><th>글쓴이</th><th>작성일</th><th>조회수</th></tr>
		</thead>
		<tbody>
			<c:forEach items="${requestScope.ebList}" var="list">
				<tr>
					<td>${list.boardNo }</td>
				    <td><a href="${initParam.root }member_getExerciseByNo.do?boardNo=${list.boardNo}">${list.boardTitle }</a></td>
				    <td>${list.momentorMemberVO.memberName}</td>
				    <td>${list.boardWdate }</td>
				    <td>${list.exerciseHits }</td>
				</tr>
			</c:forEach>
		</tbody>
		</table>
		<a href="member_showSearchExercise.do?word=${requestScope.word}">Momentor Guide 더 보기</a>
		</div>
	</c:otherwise>
</c:choose>
<hr>
<c:choose>
	<c:when test="${fn:length(requestScope.cbList)==0}">
		<h3>'${requestScope.word}'에 대한 커뮤니티 검색결과 없음</h3>	
	</c:when>
	<c:when test="${fn:length(requestScope.cbList)>0 && fn:length(requestScope.cbList)<5}">
		<h3>'${requestScope.word}'에 대한 커뮤니티 <font color="red">${fn:length(requestScope.totalCbList)}개</font> 검색</h3><br>
		<div class="table-responsive">
		<table class="table table-striped">
		<thead>
			<tr><th>NO</th><th>TITLE</th><th>글쓴이</th><th>작성일</th><th>조회수</th></tr>
		</thead>
		<tbody>
			<c:forEach items="${requestScope.cbList}" var="cbList">
				<tr>
					<td>${cbList.boardNo }</td>
				    <c:choose>
				       <c:when test="${sessionScope.pnvo==null }">
				          <td>${cbList.boardTitle}</td>
				       </c:when>
				       <c:otherwise><td><a href="member_getCommunityByNo.do?boardNo=${cbList.boardNo}">${cbList.boardTitle}</a></td>
				       </c:otherwise>
				    </c:choose>
				    <td>${cbList.momentorMemberVO.nickName}</td>
				    <td>${cbList.boardWdate }</td>
				    <td>${cbList.memberHits }</td>
				</tr>
			</c:forEach>
		</tbody>
		</table>
		</div>
	</c:when>
	<c:otherwise>
		<h3>'${requestScope.word}'에 대한 커뮤니티 <font color="red">${fn:length(requestScope.totalCbList)}개</font> 검색</h3><br>
		<div class="table-responsive">
		<table class="table table-striped">
		<thead>
			<tr><th>NO</th><th>TITLE</th><th>글쓴이</th><th>작성일</th><th>조회수</th></tr>
		</thead>
		<tbody>
			<c:forEach items="${requestScope.cbList}" var="cbList">
				<tr>
					<td>${cbList.boardNo}</td>
				    <c:choose>
				       <c:when test="${sessionScope.pnvo==null }">
				          <td>${cbList.boardTitle}</td>
				       </c:when>
				       <c:otherwise><td><a href="member_getCommunityByNo.do?boardNo=${cbList.boardNo}">${cbList.boardTitle}</a></td>
				       </c:otherwise>
				    </c:choose>
				    <td>${cbList.momentorMemberVO.nickName}</td>
				    <td>${cbList.boardWdate }</td>
				    <td>${cbList.memberHits }</td>
				</tr>
			</c:forEach>
		</tbody>
		</table>
		<a href="member_showSearchCommunity.do?word=${requestScope.word}">커뮤니티 더 보기</a>
		</div>		
	</c:otherwise>
</c:choose>