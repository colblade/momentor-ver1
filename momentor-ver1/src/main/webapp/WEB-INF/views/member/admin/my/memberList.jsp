<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
          <script>
$(function (){
		   $(".sideview").tooltip("hide"); 
   $("#searchMenuForm").submit(function(){
	  if($("#search").val()==""){
		  alert("검색어를 입력하세요!");
		  return false;
	  }
   });
});

</script>
     <h3>전체 회원 목록</h3>
 <table class="table table-striped">
  <tr>
    <th>아이디</th>
    <th>이름</th>
    <th>키</th>
    <th>몸무게</th>
    <th>나이</th>
    <th>별명</th>
    <th>성별</th>
    <th>주소</th>
    <th>회원강퇴</th>
  </tr>
<c:forEach items="${requestScope.list.list}" var="memberList">
   <tr>
     <c:choose>
         <c:when test="${sessionScope.pnvo==null }">
            <td>${memberList.momentorMemberVO.memberId}</td>
         </c:when>
          <c:otherwise><td><a class="sideview"  data-placement="right"  style="cursor:pointer" data-container="body" data-toggle="tooltip" data-html="true" title="회원 상세 정보<br>아이디 : ${memberList.momentorMemberVO.memberId}<br>비밀번호 : ${memberList.momentorMemberVO.memberPassword}<br>이름 : ${memberList.momentorMemberVO.memberName}<br>생년월일 :  ${memberList.momentorMemberVO.birthYear}/ ${memberList.momentorMemberVO.birthMonth}/ ${memberList.momentorMemberVO.birthDay}<br>나이 : ${memberList.age}<br>별명 : ${memberList.momentorMemberVO.nickName}<br>이메일 : ${memberList.momentorMemberVO.memberEmail}<br>성별 : ${memberList.momentorMemberVO.gender}<br>주소 : ${memberList.momentorMemberVO.memberAddress}<br>키 : ${memberList.memberHeight}<br>몸무게 : ${memberList.memberWeight}<br>bmi : ${memberList.bmi}<br>"  id="test">${memberList.momentorMemberVO.memberId}</a></td></c:otherwise>
      </c:choose>
      <td>${memberList.momentorMemberVO.memberName }</td>
      <td>${memberList.memberHeight}</td>
      <td>${memberList.memberWeight}</td>
      <td>${memberList.age}</td>
      <td>${memberList.momentorMemberVO.nickName}</td>
      <td>${memberList.momentorMemberVO.gender }</td>
      <td>${memberList.momentorMemberVO. memberAddress}</td>
            <td><form method="post" action="deleteMemberByAdmin.do?memberId=${memberList.momentorMemberVO.memberId}" id="">
	<input type="submit" value="회원강퇴" class="btn btn-primary" >   
	</form>
   </tr>
</c:forEach>
</table>
<form>
</form>
<br><br>	
<p class="paging">
	<c:set var="pb" value="${requestScope.list.pagingBean}"></c:set>
	<c:if test="${pb.previousPageGroup}">
	<a href="admin_my_meberList.do?pageNo=${pb.startPageOfPageGroup-1}">
	◀&nbsp; </a>	
	</c:if>
	<c:forEach var="i" begin="${pb.startPageOfPageGroup}" 
	end="${pb.endPageOfPageGroup}">
	<c:choose>
	<c:when test="${pb.nowPage!=i}">
	<a href="admin_my_meberList.do?pageNo=${i}">${i}</a> 
	</c:when>
	<c:otherwise>
	${i}
	</c:otherwise>
	</c:choose>
	&nbsp;
	</c:forEach>	 
	<c:if test="${pb.nextPageGroup}">
	<a href="admin_my_meberList.do?pageNo=${pb.endPageOfPageGroup+1}">
	▶</a>
	</c:if>
	</p>
<center> 	<form method="get" action="admin_my_managerFindBy.do" id="searchMenuForm">
	    <select name="searchMenu"  id="searchId">
               <option value="id" >아이디</option>
               <option value="name" >이름</option>
               <option value="nickName" >닉네임</option>
        </select>   
         <input type="text"  name="search" id="search" size="15" >
      	 <input type="submit" value="검색" class="btn btn-default" > 
               </form>
  </center>