package org.kosta.momentor.member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

/**
 * DispatcherServlet <---> HandlerInterceptor <---> Controller(Handler)
 * 
 * 요청 url이 auth_로 시작되는 컨트롤러 요청을 가로채서 회원인증여부를 확인한 후 비인증상태이면
 * 컨트롤러를 수행하지 않고 로그인 페이지(index)로 redirect 시키도록 한다.
 * @author kosta
 *
 */
public class LoginCheckInterceptor extends HandlerInterceptorAdapter{
   //컨트롤러 로직 수행 전 동작된다.
   //이 오버라이딩 메서드가 리턴값이 true이면
   //컨트롤러 메서드가 수행되고
   //false 이면 동작되지 않는다.
   //비 인증 상태이면 index.jsp로 redirect 시키고 false를 리턴해
   //컨트롤러 메서드 수앻시키지 않는다.
   @Override
   public boolean preHandle(HttpServletRequest request,
         HttpServletResponse response, Object handler) throws Exception {
      HttpSession session = request.getSession(false);
      if(session==null||session.getAttribute("pnvo")==null){
         //로그인 안 된 놈들\
         System.out.println("비로그인 상태이므로 서비스 불가.");
         response.sendRedirect("home.do");
         return false;//컨트롤러 메서드 수행하지 않게 한다.
      }
      System.out.println("handler"+handler);
      return true;
   }

}
