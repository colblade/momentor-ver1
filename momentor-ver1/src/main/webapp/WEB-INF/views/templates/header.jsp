<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <nav class="navbar navbar-default navbar-fixed-top">
     <div class="container">
        <div class="navbar-header col-md-3">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <c:choose>
          	<c:when test="${sessionScope.pnvo != null}">
          		<a class="navbar-brand-center" href="${initParam.root}login_home.do"><img src="${initParam.root}image/momentor.jpg"></a>
          	</c:when>
          	<c:otherwise>
          		<a class="navbar-brand-center" href="${initParam.root}home.do"><img src="${initParam.root}image/momentor.jpg"></a>
          	</c:otherwise>
          </c:choose> 
        </div>
        <div id="navbar" class="navbar-collapse collapse col-md-2">
          <ul class="nav navbar-nav navbar-left">
            <li><a href="${initParam.root }my_myPage.do">My Page</a></li>

            <li><a href="${initParam.root }member_exerciseBoard.do?pageNo=1">Momentor Guide</a></li>
             <li><a href="${initParam.root}showCommunityList.do?pageNo=1">커뮤니티</a></li>
            <li class="dropdown">
              <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">고객센터<span class="caret"></span></a>
              <ul class="dropdown-menu" role="menu">
               <li><a href="${initParam.root} member_getAllNoticeList.do">공지사항</a></li>
                <li class="divider"></li>
                <li><a href="#">FAQ</a></li>
                <li><a href="#">Q&A</a></li>
              </ul>
            </li>
          </ul>
          <form class="navbar-form navbar-right" role="search">
            <div class="form-group">
              <input type="text" class="form-control" placeholder="Search">
            </div>
            <button type="submit" class="btn btn-default">Submit</button>
          </form>
        </div><!--/.nav-collapse -->
        </div>
    </nav>
