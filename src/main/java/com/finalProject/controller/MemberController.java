package com.finalProject.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.finalProject.model.LoginDTO;
import com.finalProject.model.LoginMemberDTO;
import com.finalProject.model.ResponseData;
import com.finalProject.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/member")
public class MemberController {

	@Inject
	private MemberService memberService;

	@RequestMapping(value = "/viewLogin") // "/member/viewLogin" 로그인 페이지로 이동
	public String viewLogin() {
		System.out.println("로그인 페이지로 이동");
		return "/member/login";
	}

	@RequestMapping(value = "/login", method = RequestMethod.POST) // 로그인 요청시 동작
	public void login(LoginDTO loginDTO, RedirectAttributes rttr, Model model, HttpSession session) {
		System.out.println(loginDTO + "로 로그인 요청");
		log.info("postLogin");
		try {
			LoginDTO loginMember = memberService.login(loginDTO); // 입력한 member_id, member_pwd를 loginDTO로 받아서 db에 조회한다.
			if (loginMember != null) { // 입력한 아이디 비밀번호에 해당하는 member가 없다면 null
				model.addAttribute("loginMember", loginMember); // 모델객체에 로그인 정보 저장
			}

		} catch (Exception e) {

			e.printStackTrace();

		}
	}

	@RequestMapping(value = "/viewSignUp") // "/member/viewSignUp/"
	public String viewSingUp() {
		System.out.println("회원가입 페이지로 이동");
		return "/member/signUp";
	}

	@RequestMapping(value = "/isDuplicate", method = RequestMethod.POST) // 회원가입 데이터 중복 체크 (ajax)
	public ResponseEntity<ResponseData> isDuplicate(@RequestParam("key") String key,
			@RequestParam("value") String value) {
		System.out.println("key : " + key);
		System.out.println("value : " + value);
		ResponseData json = null;
		ResponseEntity<ResponseData> result = null;

		if (key.equals("id")) {
			// id 중복 체크
			try {
				if (!memberService.idDuplicate(value)) {
					json = new ResponseData("notDuplicate", value);
				} else {
					json = new ResponseData("Duplicate", value);
				}
				result = new ResponseEntity<ResponseData>(json, HttpStatus.OK);
			} catch (Exception e) {
				e.printStackTrace();
				result = new ResponseEntity<>(HttpStatus.CONFLICT);
			}
		} else if (key.equals("email")) {
			// email 중복 체크
			try {
				if (!memberService.emailDuplicate(value)) {
					json = new ResponseData("notDuplicate", value);
				} else {
					json = new ResponseData("Duplicate", value);
				}
				result = new ResponseEntity<ResponseData>(json, HttpStatus.OK);
			} catch (Exception e) {
				e.printStackTrace();
				result = new ResponseEntity<>(HttpStatus.CONFLICT);
			}
		} else if (key.equals("phone")) {
			// phone_number 중복 체크
			try {
				if (memberService.phoneDuplicate(value)) {
					json = new ResponseData("notDuplicate", value);
				} else {
					json = new ResponseData("Duplicate", value);
				}
				result = new ResponseEntity<ResponseData>(json, HttpStatus.OK);
			} catch (Exception e) {
				e.printStackTrace();
				result = new ResponseEntity<>(HttpStatus.CONFLICT);
			}
		}
		return result;
	}

}
