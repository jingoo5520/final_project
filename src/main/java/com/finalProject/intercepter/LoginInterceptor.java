package com.finalProject.intercepter;

import java.io.IOException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.finalProject.model.MemberDTO;


import lombok.extern.slf4j.Slf4j;
@Slf4j
public class LoginInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {
		System.out.println("Login preHandle 호출");
		log.info("preHandle()");
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
	        ModelAndView modelAndView) throws IOException {
	    System.out.println("Login postHandle 호출");

	    HttpSession ses = request.getSession();

	    if (request.getMethod().toUpperCase().equals("POST")) {
	        Map<String, Object> model = modelAndView.getModel();
	        MemberDTO loginMember = (MemberDTO) model.get("loginMember");
	        if (loginMember != null) {
	            ses.setAttribute("loginMember", loginMember);
	            System.out.println(loginMember.getMember_name() + "님 로그인");
	            
	            if (!response.isCommitted()) {
	            	System.out.println("1234");
                    response.sendRedirect("/");
                }
	      
	        } else {
	            System.out.println("아이디 또는 비밀번호가 일치하지 않습니다.");
	            if (!response.isCommitted()) {
	            	response.sendRedirect("/member/viewLogin/?status=fail");
                }
	           
	        }
	    }
	}

}
