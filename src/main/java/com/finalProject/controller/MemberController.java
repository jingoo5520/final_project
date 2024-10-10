package com.finalProject.controller;

import java.io.Console;
import java.io.IOException;
import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.finalProject.model.Code;
import com.finalProject.model.MemberDTO;
import com.finalProject.model.TestVO;
import com.finalProject.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/test")
public class MemberController {
	
	 @Inject
	 private MemberService mService;
	
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		log.info("Welcome home! The client locale is {}.", locale);
		
		return "register";
	}
	
	// 아이디 중복 검사
	@PostMapping("/idDuplicate")
	public ResponseEntity<Code> idDuplicate (@RequestParam("tmpUserId") String tmpUserId) {
		
		log.info("tmpUserID : " + tmpUserId + "가 중복?");
		System.out.println(tmpUserId);
		
		Code json = null;
		ResponseEntity<Code> result = null;
		
		try {
			if (mService.idIsDuplicate(tmpUserId)) {
				json = new Code(200, tmpUserId,"duplicate"); // 아이디 중복됨
			} else {
				json = new Code(400, tmpUserId, "not duplicate");
			}
			result = new ResponseEntity<Code>(json, HttpStatus.OK); 
		} catch (Exception e) {
			e.printStackTrace();
			result = new ResponseEntity<Code>(json, HttpStatus.CONFLICT);
		}
		
		return result;
	}
	
	// 회원삽입
	@PostMapping("/registerMember")
	public ResponseEntity<String> registerMember (@RequestBody MemberDTO registerMember) {

		System.out.println("회원가입 진행해 ㅡㅡㅡ " + registerMember.toString());
		System.out.println("Member ID: " + registerMember.getMember_id()); // 디버깅을 위해 추가
			try {
				if (mService.saveMember(registerMember)) { // DB에 저장
					return ResponseEntity.ok("success");
				}
				
			} catch (Exception e) {
				e.printStackTrace();
				
				if (e instanceof IOException) {
					// 회원가입한 유저의 회원가입 취소 처리 (service-dao)
					return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("fileFail");
				} else {
					return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("fail");
				}
			}
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("fail");
		}
	}
