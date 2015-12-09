<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
    <link rel="stylesheet" href="${initParam.root}dist/css/style.css">
    <script type="text/javascript">
       $(document).ready(function(){
             $("#writeBtn").click(function(){
                location.href="my_writeForm.do";
             });
          }
         );
    </script>
<div class="table-responsive">
 <table class="table table-striped">
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
      <td>${posting.momentorMemberVO.nickName}</td>
      <td>${posting.boardWdate}</td>
      <td>${posting.memberHits}</td>
      <td>${posting.recommend}</td>
   </tr>
</c:forEach>
</table>
<p class="paging" align="center">
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
	</div>
	<form>
	<select>
		<option value="">검색 구분</option>
		<option value="">아이디</option>
		<option value="">제목</option>
	</select> <input type="text" id="communitySearch"> <input type="submit"
		value="검색">
</form>
<c:if test="${sessionScope.pnvo!=null }">
	<div align="right">
		<input class="btn btn-default" type="button" value="글쓰기" id="writeBtn">
	</div>
</c:if>