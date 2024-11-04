package com.finalProject.util;

import javax.servlet.http.HttpServletRequest;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class RememberPath {

	private String rememberPath;
	
	
	public void rememberPath(HttpServletRequest request) {
		
		// 요청한 페이지의 uri를 저장
		String rememberPath = request.getRequestURI()+"";
		System.out.println("rememberPath 동작 : " + rememberPath);
		request.getSession().setAttribute("rememberPath", rememberPath);
	}
}
