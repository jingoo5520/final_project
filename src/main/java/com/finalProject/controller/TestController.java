package com.finalProject.controller;

import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.bind.annotation.RequestMapping;

import com.finalProject.model.MemberDTO;
import com.finalProject.service.member.MemberService;

import org.springframework.stereotype.Controller;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping(value="/test")
public class TestController {

	@Inject
	private MemberService memberService;
	
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
	
	public void testInsert() {
		for(int i = 0; i < 300; i++) {
			String member_id = "TESTER-" + i;
			String email = "TESTEMAIL" + i + "@test.com";
			String member_pwd = "xptmxm12";
			String phone_number = "000-0000-0000";
			String birthday = "20000101";
			String address = "00000/테스트시 테스트구 테스트동/테스트호";
			String nickname = "테스터_" + i;
			String member_name = "테스트";
			MemberDTO mDTO = new MemberDTO();
			mDTO.setMember_id(member_id);
			mDTO.setEmail(email);
			mDTO.setMember_pwd(member_pwd);
			mDTO.setPhone_number(phone_number);
			mDTO.setBirthday(birthday);
			mDTO.setAddress(address);
			mDTO.setNickname(nickname);
			mDTO.setMember_name(member_name);
			try {
				memberService.tumpMemberData(mDTO);
				System.out.println("더미데이터 [" + member_id + "] insert");
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}	
		}
	}
}
