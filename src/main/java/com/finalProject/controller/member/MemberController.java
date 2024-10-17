package com.finalProject.controller.member;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.mail.MessagingException;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.finalProject.model.LoginDTO;
import com.finalProject.model.ResponseData;
import com.finalProject.model.SignUpDTO;
import com.finalProject.service.MemberService;
import com.finalProject.util.ReceiveMailPOP3;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/member")
public class MemberController {

	@Inject
	private MemberService memberService;

	@Inject
	private ReceiveMailPOP3 remail;

	@RequestMapping(value = "/viewLogin") // "/member/viewLogin" 로그인 페이지로 이동
	public String viewLogin() {
		System.out.println("로그인 페이지로 이동");
		return "/user/member/login";
	}

	@RequestMapping(value = "/login", method = RequestMethod.POST) // 로그인 요청시 동작
	public String login(LoginDTO loginDTO, RedirectAttributes rttr, Model model, HttpSession session) {
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
		// 로그인 성공 실패에 따른 페이지 이동은 인터셉터가 처리함.
		// 리턴 타입을 void로 login.jsp의 form태그 action에 설정된 경로의 jsp를 찾고, 해당 경로의 jsp는 없기때문에 실제하는 아무파일의 경로를 임의로 리턴해줌.
		return "/user/member/login";
	}

	@RequestMapping(value = "/viewSignUp") // "/member/viewSignUp/"
	public String viewSingUp() {
		System.out.println("회원가입 페이지로 이동");
		return "/user/member/signUp";
	}

	@RequestMapping(value = "/isDuplicate", method = RequestMethod.POST) // 회원가입 데이터 중복 체크 (ajax)
	public ResponseEntity<ResponseData> isDuplicate(@RequestParam("key") String key,
			@RequestParam("value") String value) {
		// key = 중복체크를 진행할 요소(id, email, phone)
		// value = 체크할 값
		Map<String, Object> map = new HashMap<String, Object>();
		System.out.println("key : " + key);
		System.out.println("value : " + value);
		// 휴대폰번호가 11자인경우(01012345678)
		if(key.equals("phone") && value.length()==11) {
			// 010-1234-5678 로 만듦
			value = value.substring(0, 3) + "-" + value.substring(3, 7) + "-" + value.substring(7, 11);
		}
		map.put("key", key);
		map.put("value", value);
		System.out.println(map.toString());

		ResponseData json = null;
		ResponseEntity<ResponseData> result = null;

		try {
			// map에 key와 value를 담아서 쿼리문을 실행
			// key = where절에 들어갈 컬럼을 결정
			// value = 찾을 값
			if (!memberService.autoDuplicate(map)) {
				json = new ResponseData("notDuplicate", value);
			} else {
				json = new ResponseData("Duplicate", value);
			}
			result = new ResponseEntity<ResponseData>(json, HttpStatus.OK);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			result = new ResponseEntity<>(HttpStatus.CONFLICT);
		}

		return result;
	}

	@RequestMapping(value = "/signUp", method = RequestMethod.POST) // 회원가입 처리
	public String signUp(SignUpDTO signUpDTO, RedirectAttributes rttr) {
		System.out.println("회원가입 요청");
		System.out.println(signUpDTO.toString());
		String result = "redirect:/viewSignUp";
		// 입력받은 생일 형식을 DB에 저장될 형식으로 변경
		String birtday = signUpDTO.getBirthday().replace("-", "");
		signUpDTO.setBirthday(birtday);

		// 입력받은 폰번호 형식을 DB에 저장될 형식으로 변경
		// 01012345678 의 형식(-가 없는 형식이 경우)
		if (signUpDTO.getPhone_number().length() == 11) {
			String phone = signUpDTO.getPhone_number().substring(0, 3) + "-"
					+ signUpDTO.getPhone_number().substring(3, 7) + "-" + signUpDTO.getPhone_number().substring(7, 11);
			signUpDTO.setPhone_number(phone);
		}

		// 입력받은 주소+상세주소
		// 우편번호/주소/상세주소
		signUpDTO.setAddress(signUpDTO.getAddress() + "/" + signUpDTO.getAddress2());

		// 성별 미선택시 null로 들어오는 데이터 처리
		if (signUpDTO.getGender() == null) {
			signUpDTO.setGender("N");
		}

		try {
			if (memberService.signUp(signUpDTO) == 1) {
				System.out.println("insert성공");
				result = "redirect:/";
			} else {
				System.out.println("insert실패");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("insert예외");
		}

		return result;
	}

	@RequestMapping(value = "/verifyCheck", method = RequestMethod.POST) // 휴대폰 인증 메일 확인 (ajax)
	public ResponseEntity<ResponseData> verifyCheck(@RequestParam("phone") String phone) {
		System.out.println(phone);
		// 010-1234-5678 형식의(길이가13) 번호인 경우
		if(phone.length()==13) {
			phone = phone.replace("-", ""); // 01012345678 형식으로 (길이 11)로 변환
		}
		
		ResponseEntity<ResponseData> result = null;
		try {
			remail.receiveMailPOP3(phone);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (MessagingException e) {
			e.printStackTrace();
		}
		return result;
	}

}
