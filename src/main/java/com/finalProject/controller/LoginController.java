package com.finalProject.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.finalProject.model.LoginDTO;
import com.finalProject.model.MemberDTO;
import com.finalProject.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/member")
public class LoginController {
	
	@Inject
	private MemberService memberService;
	
	
	@RequestMapping(value="/") // "/test/login"
	public String testLogin() {
		
		return "testLogin";
	}
	
	@RequestMapping("/login")
	public void loginGET() {
		System.out.println("로그인 시도");
	}

	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public void login(LoginDTO loginDTO, RedirectAttributes rttr, Model model, HttpSession session) {
		System.out.println(loginDTO + "로 로그인 요청");
		
		try {
			MemberDTO loginMember = memberService.login(loginDTO); // 입력한 member_id, member_pwd를 loginDTO로 받아서 db에 조회한다.
			if(loginMember != null) {
				System.out.println("로그인 성공");
				model.addAttribute("loginMember", loginMember); // 모델객체에 로그인 정보 저장
				session.setAttribute("loginMember", loginMember); // 세션에 로그인 정보 저장
			} else {
				System.out.println("로그인 실패");
			}
			
		} catch (Exception e) {
			
			e.printStackTrace();
			
		}
	}
	
	
}
