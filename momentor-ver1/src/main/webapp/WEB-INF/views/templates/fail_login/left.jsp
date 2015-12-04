<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
$(document).ready(function(){
	$("#register").click(function(){
		location.href="member_register.do";
	});
});
</script>
<div class="loginForm">
	<form class="form-signin" action="${initParam.root}login_login.do" method="post">
		<label for="inputID" class="sr-only">ID</label>
		<input type="text" id="inputId" name="memberId" class="form-control" placeholder="ID" required autofocus>
		<label for="inputPassword" class="sr-only">Password</label>
		<input type="password" id="inputPassword" name="memberPassword" class="form-control" placeholder="Password" required>
		<!-- <div class="checkbox">
	        <label>
	        	<input type="checkbox" value="remember-me"> 아이디저장
	        </label>
        </div> -->
        <button class="btn btn-sm btn-primary btn-block" type="submit">Login</button>
	</form>
	<button class="btn btn-sm btn-primary btn-block" type="submit" id="register">회원가입</button>
</div>