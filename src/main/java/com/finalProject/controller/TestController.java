package com.finalProject.controller;

import java.util.List;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.stereotype.Controller;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping(value="/test")
public class TestController {

	@RequestMapping(value = "/uuid")
	public String uuid() {
		UUID randomuuid = UUID.randomUUID();
		System.out.println(randomuuid);
		System.out.println(randomuuid.toString().length());
		System.out.println(randomuuid.toString().substring(0, 8));
		return "/user/pages/testIndex";
	}
	
	@RequestMapping(value = "/session")
	public String session(HttpServletResponse response, HttpServletRequest request) {
		HttpSession ses = request.getSession();
		log.info("test session");
		System.out.println(ses.getAttribute("loginMember"));

		return "/user/pages/testIndex";
	}
	
	@RequestMapping(value = "/")
	public String index() {
		return "/user/pages/testIndex";
	}
	
	@RequestMapping(value = "/signUp")
	public String signUp() {
		return "/user/member/signUp2";
	}
	
	@RequestMapping(value = "/getUri")
	public String getUri(HttpServletRequest request) {
		String uri = request.getRequestURI()+"";
		System.out.println(uri);
		return "/user/pages/testIndex";
	}
	
	@RequestMapping(value = "/auth")
	public String auth() {
		return "/user/pages/testIndex";
	}
	
	@RequestMapping(value = "/jsp")
	public String testjsp() {
		return "/user/pages/member/testbar";
	}
	
	@RequestMapping(value = "/kakao")
	public String kakao() {
		return "/user/pages/member/kakaoLogin";
	}
}
