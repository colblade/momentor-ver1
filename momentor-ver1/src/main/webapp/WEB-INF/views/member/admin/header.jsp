<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <script type="text/javascript">
    	$(document).ready(function(){
    		$("#findForm").submit(function(){
    			if($("#searchBox").val() == ""){
    				alert("검색어를 입력하세요!");
    				return false;
    			}
    		});
    	});
    </script>
    
    <nav class="navbar navbar-default navbar-fixed-top">
     <div class="container">
  <!--       <div class="navbar-header col-md-3">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
        </div> -->
        
        <div id="navbar" class="navbar-collapse collapse col-md-2">
          <ul class="nav navbar-nav navbar-left">
           <li class="dropdown"><a href="${initParam.root }#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">회원<span class="caret"></span></a>
            <ul class="dropdown-menu" role="menu">
             <li><a href="${initParam.root }#">회원관리1</a></li>
             <li><a href="${initParam.root }#">회원관리2</a></li>
             <li><a href="${initParam.root }#">회원관리3</a></li>
             </ul>
             </li>
           <li class="dropdown"><a href="${initParam.root }#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">공지사항<span class="caret"></span></a>
            <ul class="dropdown-menu" role="menu">
             <li><a href="${initParam.root }admin_getAllNoticeList.do">공지사항목록</a></li>
             <li><a href="${initParam.root }admin_noticemgr_writeNoticeByAdminForm.do">공지사항글작성</a></li>
             <li><a href="${initParam.root }#">공지사항3</a></li>
             </ul>
             </li>
           <li class="dropdown"><a href="${initParam.root }#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">운동게시판<span class="caret"></span></a>
            <ul class="dropdown-menu" role="menu">
             <li><a href="${initParam.root }admin_exerciseBoard.do?pageNo=1">운동게시판목록</a></li>
             <li><a href="${initParam.root }admin_contentmgr_writeView.do">운동게시판글작성</a></li>
             <li><a href="${initParam.root }#">운동게시판관리3</a></li>
             </ul>
             </li>
           <li class="dropdown"><a href="${initParam.root }#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">회원게시판<span class="caret"></span></a>
            <ul class="dropdown-menu" role="menu">
             <li><a href="${initParam.root }admin_showCommunityList.do?pageNo=1">회원게시판목록</a></li>
             <li><a href="${initParam.root }#">회원게시판관리2</a></li>
             <li><a href="${initParam.root }#">회원게시판관리3</a></li>
             </ul>
             </li>
           <li class="dropdown"><a href="${initParam.root }#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">FAQ<span class="caret"></span></a>
            <ul class="dropdown-menu" role="menu">
             <li><a href="${initParam.root }#">FAQ관리1</a></li>
             <li><a href="${initParam.root }#">FAQ관리2</a></li>
             <li><a href="${initParam.root }#">FAQ관리3</a></li>
             </ul>
             </li>
           <li class="dropdown"><a href="${initParam.root }#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">Q&A<span class="caret"></span></a>
            <ul class="dropdown-menu" role="menu">
             <li><a href="${initParam.root }#">Q&A관리1</a></li>
             <li><a href="${initParam.root }#">Q&A관리2</a></li>
             <li><a href="${initParam.root }#">Q&A관리3</a></li>
             </ul>
             </li>
           <li class="dropdown"><a href="${initParam.root }#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">신고내역<span class="caret"></span></a>
            <ul class="dropdown-menu" role="menu">
             <li><a href="${initParam.root }#">신고내역관리1</a></li>
             <li><a href="${initParam.root }#">신고내역관리2</a></li>
             <li><a href="${initParam.root }#">신고내역관리3</a></li>
             </ul>
             </li>
		 <li>
		 <c:choose>
		 	<c:when test="${sessionScope.pnvo.momentorMemberVO.auth==1 }">
			 <form class="navbar-form navbar-right" role="search" id="findForm" action="admin_findResult.do">
	            <div class="form-group">
	              <input type="text" class="form-control" placeholder="Search" id="searchBox" name="word">
	            </div>
	            <button type="submit" class="btn btn-default">검색</button>
	          </form>
		 	</c:when>
		 	<c:otherwise>
			 <form class="navbar-form navbar-right" role="search" id="findForm" action="member_findResult.do">
	            <div class="form-group">
	              <input type="text" class="form-control" placeholder="Search" id="searchBox" name="word">
	            </div>
	            <button type="submit" class="btn btn-default">검색</button>
	          </form>
		 	</c:otherwise>
		 </c:choose>
		 </li>
            <li>
     			<a href="${initParam.root}admin_home.do"><img src="${initParam.root}image/momentor.jpg"></a>
     		</li>
		</ul>
     </div><!--/.nav-collapse -->
  </div>
</nav>
