<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
     <script type="text/javascript">
    $(document).ready(function(){
       $("#logout").click(function(){
          if(confirm("로그아웃하시겠습니까?")){
             location.href="${initParam.root}/logout.do";
          }
       });
    });   
</script>
<c:choose>
             <c:when test="${sessionScope.pnvo== null}">
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
</c:when>
<c:otherwise>
    ${sessionScope.pnvo.momentorMemberVO.memberName}님|<a href="#" id="logout">로그아웃</a><br>
   ${sessionScope.pnvo.age}세 <br>
키 : ${sessionScope.pnvo.memberHeight}cm <br>
몸무게 : ${sessionScope.pnvo.memberWeight}kg  <br>
bmi : ${sessionScope.pnvo.bmi}<br>
</c:otherwise>
</c:choose>