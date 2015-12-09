<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script>
	$(document).ready(function(){
		alert("공지 글이 삭제되었습니다");
		location.href="${initParam.root}admin_getAllNoticeList.do";
	});
</script>