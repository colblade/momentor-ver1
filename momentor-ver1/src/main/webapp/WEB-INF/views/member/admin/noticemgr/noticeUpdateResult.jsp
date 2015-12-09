<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
  <p class="noticeInform"> 수정완료 </p>
   <div id="noticeContentsUpdateResultArea">
   <table id="noticeUpdateResult" class="noticeUpdateResultByAdmin">
   	<tr><td>번호<td><td>${requestScope.nvo.boardNo }</td></tr>
   	<tr><td>제목<td><td>${requestScope.nvo.boardTitle }</td></tr>
   	<tr><td>내용<td><td><pre>${requestScope.nvo.boardContent }</pre></td></tr>
   	
   </table>
   </div>
   <p class="noticeLink">
  	 <a href="${initParam.root}admin_home.do">홈으로</a><br>
	 <a href="${initParam.root}admin_getAllNoticeList.do ">목록으로</a>
   </p>