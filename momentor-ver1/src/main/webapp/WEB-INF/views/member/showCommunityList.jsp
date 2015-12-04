<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
    <script type="text/javascript">
       $(document).ready(function(){
             $("#writeBtn").click(function(){
                location.href="my_writeForm.do";
             });
          }
         );
    </script>
 <table border="1" >
  <tr>
    <th>글번호</th>
    <th>제목</th>
    <th>작성자</th>
    <th>작성시간</th>
    <th>조회수</th>
    <th>추천수</th>
  </tr>
<c:forEach items="${requestScope.list.list}" var="posting">
   <tr>
      <td>${posting.boardNo }</td>
      <c:choose>
         <c:when test="${sessionScope.pnvo==null }">
            <td>${posting.boardTitle}</td>
         </c:when>
         <c:otherwise><td><a href="member_getCommunityByNo.do?boardNo=${posting.boardNo}">${posting.boardTitle}</a></td></c:otherwise>
      </c:choose>
      <td>${pnvo.momentorMemberVO.nickName}</td>
      <td>${posting.boardWdate}</td>
      <td>${posting.memberHits}</td>
      <td>${posting.recommend}</td>
   </tr>
</c:forEach>
</table>
<form>
   <textarea rows="3" cols="40">
      ${sessionScope.pnvo}
   </textarea>
</form>
<c:if test="${sessionScope.pnvo!=null }">
   <img src="${initParam.root}image/write_btn.jpg" id="writeBtn">
</c:if><br><br>	
<p class="paging">
	<c:set var="pb" value="${requestScope.list.pagingBean}"></c:set>
	<c:if test="${pb.previousPageGroup}">
	<a href="showCommunityList.do?pageNo=${pb.startPageOfPageGroup-1}">
	◀&nbsp; </a>	
	</c:if>
	<c:forEach var="i" begin="${pb.startPageOfPageGroup}" 
	end="${pb.endPageOfPageGroup}">
	<c:choose>
	<c:when test="${pb.nowPage!=i}">
	<a href="showCommunityList.do?pageNo=${i}">${i}</a> 
	</c:when>
	<c:otherwise>
	${i}
	</c:otherwise>
	</c:choose>
	&nbsp;
	</c:forEach>	 
	<c:if test="${pb.nextPageGroup}">
	<a href="showCommunityList.do?pageNo=${pb.endPageOfPageGroup+1}">
	▶</a>
	</c:if>
	</p>