<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id="resultView"></div>
		<form method="post" id="registerForm" action="member_register_result.do">
		아이디 : <input type="text" name="memberId" id="id" ><span id="checkResult"></span>	
		<br>패스워드 : <input type="text" name="memberPassword" >		
		<br>이름 : <input type="text" name="memberName" >	
		<br>년도 : <input type="text" name="birthYear" >	
		<br>월 : <input type="text" name="birthMonth" >	
		<br>일 : <input type="text" name="birthDay" >	
		<br>별명 : <input type="text" name="nickName" >	
		<br>이메일 : <input type="text" name="memberEmail" >	
		<br>성별 : <select name="gender" >
		<option value ="M"> 남자</option>
		<option value ="F" > 여자</option>
		</select>
		<br>키 : <input type="text" name="memberWeight" >	
		<br>몸무게 : <input type="text" name="memberHeight" >
		<br><input type="submit" value="회원가입">
</form>