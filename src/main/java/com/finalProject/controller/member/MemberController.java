package com.finalProject.controller.member;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;
import java.util.UUID;

import javax.inject.Inject;
import javax.mail.MessagingException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.util.WebUtils;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.finalProject.model.LoginDTO;
import com.finalProject.model.ResponseData;
import com.finalProject.model.MemberDTO;
import com.finalProject.service.member.MemberService;
import com.finalProject.util.KakaoUtil;
import com.finalProject.util.ReceiveMailPOP3;
import com.finalProject.util.RememberPath;
import com.finalProject.util.SendMailUtil;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/member")
public class MemberController {

	@Inject
	private MemberService memberService;

	@Inject
	private SendMailUtil sendMail;

	@Inject
	private ReceiveMailPOP3 remail;

	@Inject
	private KakaoUtil kakao;

	@RequestMapping(value = "/viewLogin") // "/member/viewLogin" 로그인 페이지로 이동
	public String viewLogin() {
		System.out.println("로그인 페이지로 이동");
		return "/user/pages/member/login";
	}

	@RequestMapping(value = "/login", method = RequestMethod.POST) // 로그인 요청시 동작
	public String login(LoginDTO loginDTO, RedirectAttributes rttr, Model model, HttpSession session,
			@RequestParam(value = "autologin_code", required = false) boolean autologin) {
		System.out.println(loginDTO + "로 로그인 요청");
		System.out.println("자동로그인 : " + autologin);
		log.info("postLogin");
		try {
			LoginDTO loginMember = memberService.login(loginDTO); // 입력한 member_id, member_pwd를 loginDTO로 받아서 db에 조회한다.
			if (loginMember != null) { // 입력한 아이디 비밀번호에 해당하는 member가 없다면 null
				model.addAttribute("loginMember", loginMember); // 모델객체에 로그인 정보 저장
				if (autologin) { // 자동로그인 체크했을경우
					model.addAttribute("autologin", autologin); // 모델객체에 자동로그인 저장
				}
			}
		} catch (Exception e) {

			e.printStackTrace();

		}
		// 로그인 성공 실패에 따른 페이지 이동은 인터셉터가 처리함.
		// 리턴 타입을 void로 login.jsp의 form태그 action에 설정된 경로의 jsp를 찾고, 해당 경로의 jsp는 없기때문에
		// 실제하는 아무파일의 경로를 임의로 리턴해줌.
		return "/user/pages/member/login";
	}

	@RequestMapping(value = "/viewSignUp") // "/member/viewSignUp/"
	public String viewSingUp() {
		System.out.println("회원가입 페이지로 이동");
		return "/user/pages/member/signUp";
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
		if (key.equals("phone") && value.length() == 11) {
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

	// 회원가입 처리
	@RequestMapping(value = "/signUp", method = RequestMethod.POST)
	public String signUp(MemberDTO memberDTO, RedirectAttributes rttr,
			@RequestParam(value = "basicAddress", required = false) String basicAddress,
			@RequestParam(value = "addressName", required = false) String addressName) {
		System.out.println("회원가입 요청");
		System.out.println(memberDTO.toString());
		String result = "redirect:/viewSignUp";
		// 입력받은 생일 형식을 DB에 저장될 형식으로 변경
		String birtday = memberDTO.getBirthday().replace("-", "");
		memberDTO.setBirthday(birtday);

		// 입력받은 폰번호 형식을 DB에 저장될 형식으로 변경
		// 01012345678 의 형식(-가 없는 형식이 경우)
		if (memberDTO.getPhone_number().length() == 11) {
			String phone = memberDTO.getPhone_number().substring(0, 3) + "-"
					+ memberDTO.getPhone_number().substring(3, 7) + "-" + memberDTO.getPhone_number().substring(7, 11);
			memberDTO.setPhone_number(phone);
		}

		// 별명(nickname)을 입력하지 않았을 경우
		if (memberDTO.getNickname().equals("")) {
			UUID randomuuid = UUID.randomUUID();
			// member_name + 무작위 8글자로 닉네임 저장
			// ex : 홍길동_44a9d39b
			memberDTO.setNickname(memberDTO.getMember_name() + "_" + randomuuid.toString().substring(0, 8));
		}

		// 우편번호/주소/상세주소
		memberDTO.setAddress(memberDTO.getZipCode() + "/" + memberDTO.getAddress() + "/" + memberDTO.getAddress2());

		// 성별 미선택시 null로 들어오는 데이터 처리
		if (memberDTO.getGender() == null) {
			memberDTO.setGender("N");
		}

		try {
			if (memberService.signUp(memberDTO) == 1) {
				System.out.println("insert성공");
				// 기본 주소 체크 여부 확인
				if (basicAddress != null) {
					try {
						memberService.saveAdddress(memberDTO, addressName);
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
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
		if (phone.length() == 13) {
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

	// 로그아웃
	@RequestMapping(value = "/logout")
	public String logout(HttpServletRequest request) {
		HttpSession ses = request.getSession();
		kakao.kakaoLogout((String)ses.getAttribute("accessToken"));
		ses.removeAttribute("loginMember");
		ses.removeAttribute("rememberPath");
		ses.removeAttribute("auth");
		System.out.println("로그아웃");
		return "redirect:/";
	}

	// 마이페이지 (내정보수정 페이지)
	@RequestMapping(value = "/myPage/modiInfo")
	public String myPage(HttpServletRequest request) {
		System.out.println("마이페이지로 이동");
		new RememberPath().rememberPath(request); // 호출한 페이지 주소 저장.
		return "/user/pages/member/myPage_modiInfo";
	}

	// 마이페이지 (비밀번호 변경 페이지)
	@RequestMapping(value = "/myPage/modiPwd")
	public String myPage_pwd(HttpServletRequest request) {
		System.out.println("마이페이지로 이동");
		new RememberPath().rememberPath(request); // 호출한 페이지 주소 저장.
		return "/user/pages/member/myPage_modiPwd";
	}

	// 마이페이지 (회원 탈퇴)
	@RequestMapping(value = "/myPage/withdraw")
	public String myPage_withdraw(HttpServletRequest request) {
		System.out.println("마이페이지로 이동");
		new RememberPath().rememberPath(request); // 호출한 페이지 주소 저장.
		return "/user/pages/member/myPage_withdraw";
	}

	// 마이페이지 (구매 내역)
	@RequestMapping(value = "/myPage/history")
	public String myPage_history(HttpServletRequest request) {
		System.out.println("마이페이지로 이동");
		new RememberPath().rememberPath(request); // 호출한 페이지 주소 저장.
		return "/user/pages/member/myPage_history";
	}

	// 마이페이지 인증(정보 수정시 비밀번호를 확인함.)
	@RequestMapping(value = "/auth", method = RequestMethod.POST)
	public String auth(HttpServletRequest request, @RequestParam("pwd") String member_pwd) {
		HttpSession ses = request.getSession();
		LoginDTO loginMember = (LoginDTO) ses.getAttribute("loginMember");
		String member_id = loginMember.getMember_id(); // 세션에 저장된 member_id 저장
		String rememberPath = ses.getAttribute("rememberPath") + "";
		try {
			// 로그인된 아이디와 입력한 비밀번호가 일치하는지 DB조회
			if (memberService.auth(member_id, member_pwd)) {
				System.out.println("인증 성공");
				ses.setAttribute("auth", member_id); // 인증 세션 생성
			} else {
				System.out.println("인증 실패");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:" + rememberPath; // 임의로 지정한 반환페이지, 실제로 반환되는 view는 authInterceptor에서 결정됨
	}

	// 회원 정보 받아오기(마이페이지 ajax)
	@RequestMapping(value = "/getDTO")
	public void getDTO(HttpServletRequest request, HttpServletResponse response) {
		HttpSession ses = request.getSession(); // 세션 받아오기
		String member_id = ses.getAttribute("auth") + "";

		try {
			MemberDTO memberDTO = memberService.getMember(member_id);
			System.out.println(memberDTO);
			ObjectMapper objectMapper = new ObjectMapper(); // jackson 메서드
			if (memberDTO != null) {
				String address[] = memberDTO.getAddress().split("/");
				memberDTO.setZipCode(address[0]);
				memberDTO.setAddress(address[1]);
				memberDTO.setAddress2(address[2]);
				String result = objectMapper.writeValueAsString(memberDTO);
				response.getWriter().write(result);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 회원 정보 수정하기
	@RequestMapping(value = "/modiInfo", method = RequestMethod.POST)
	public ResponseEntity<ResponseData> modiInfo(MemberDTO memberDTO, HttpServletRequest request) {
		ResponseEntity<ResponseData> result = null;
		ResponseData json = null;
		HttpSession ses = request.getSession(); // 세션 받아오기
		String member_id = ses.getAttribute("auth") + "";
		memberDTO.setMember_id(member_id);

		// 입력받은 폰번호 형식을 DB에 저장될 형식으로 변경
		// 01012345678 의 형식(-가 없는 형식이 경우)
		if (memberDTO.getPhone_number().length() == 11) {
			String phone = memberDTO.getPhone_number().substring(0, 3) + "-"
					+ memberDTO.getPhone_number().substring(3, 7) + "-" + memberDTO.getPhone_number().substring(7, 11);
			memberDTO.setPhone_number(phone);
		}

		// 별명(nickname)을 입력하지 않았을 경우
		if (memberDTO.getNickname().equals("")) {
			UUID randomuuid = UUID.randomUUID();
			// member_name + 무작위 8글자로 닉네임 저장
			// ex : 홍길동_44a9d39b
			memberDTO.setNickname(memberDTO.getMember_name() + "_" + randomuuid.toString().substring(0, 8));
		}

		// 입력받은 우편번호+주소+상세주소
		// 우편번호/주소/상세주소
		memberDTO.setAddress(memberDTO.getZipCode() + "/" + memberDTO.getAddress() + "/" + memberDTO.getAddress2());
		System.out.println(memberDTO.toString());
		try {
			// update가 정상적으로 됬다면
			if (memberService.updateMember(memberDTO)) {
				System.out.println("변경 완료");
				json = new ResponseData("success", "변경 성공");
			} else {
				System.out.println("변경 실패");
				json = new ResponseData("fail", "변경 실패");
			}
			result = new ResponseEntity<ResponseData>(json, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			json = new ResponseData("fail", "예외 발생");
			result = new ResponseEntity<>(HttpStatus.CONFLICT);
		}
		return result;
	}

	// 비밀번호 변경하기
	@RequestMapping(value = "/modiPwd", method = RequestMethod.POST)
	public ResponseEntity<ResponseData> modiInfo(@RequestParam("member_pwd") String member_pwd,
			HttpServletRequest request) {
		ResponseEntity<ResponseData> result = null;
		ResponseData json = null;
		HttpSession ses = request.getSession();
		String member_id = ses.getAttribute("auth") + "";
		Map<String, String> map = new HashMap<String, String>();
		map.put("member_id", member_id);
		map.put("member_pwd", member_pwd);
		try {
			// 비밀번호 변경 update문이 정상적으로 동작했다면
			if (memberService.updateMemberPwd(map)) {
				System.out.println("변경 완료");
				json = new ResponseData("success", "변경 성공");
			} else {
				System.out.println("변경 실패");
				json = new ResponseData("fail", "변경 실패");
			}
			result = new ResponseEntity<ResponseData>(json, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			json = new ResponseData("fail", "예외 발생");
			result = new ResponseEntity<>(HttpStatus.CONFLICT);
		}
		System.out.println(member_pwd);
		return result;
	}

	// 회원탈퇴
	@RequestMapping(value = "/withdraw", method = RequestMethod.POST)
	public ResponseEntity<ResponseData> withdraw(HttpServletRequest request, HttpServletResponse response) {
		ResponseEntity<ResponseData> result = null;
		ResponseData json = null;
		HttpSession ses = request.getSession();
		String member_id = ses.getAttribute("auth") + "";
		try {
			// 회원 탈퇴 성공시
			if (memberService.withDrawMember(member_id)) {
				json = new ResponseData("success", "탈퇴 완료");
				Cookie cookie = new Cookie("al", ""); // 쿠키객체 생성
				cookie.setMaxAge(0); // 쿠키 유효기간 설정(삭제를 위해 0초로 설정)
				cookie.setPath("/"); // 모든 경로에서 사용 가능
				response.addCookie(cookie); // 쿠키 저장(삭제)
				kakao.kakaoLogout((String)ses.getAttribute("accessToken"));
			} else {
				json = new ResponseData("fail", "탈퇴 실패");
			}
			result = new ResponseEntity<ResponseData>(json, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			json = new ResponseData("fail", "예외 발생");
			result = new ResponseEntity<>(HttpStatus.CONFLICT);
		}
		return result;
	}

	// 인증메일 요청
	@RequestMapping(value = "/mailRequest")
	public ResponseEntity<ResponseData> mailRequest(HttpServletRequest request, @RequestParam("email") String email) {
		ResponseEntity<ResponseData> result = null;
		ResponseData json = null;
		Random random = new Random();
		String authCode = random.nextInt(10) + "" + random.nextInt(10) + random.nextInt(10) + random.nextInt(10)
				+ random.nextInt(10) + random.nextInt(10); // 0~9 사이의 숫자 6자리
		long authTime = System.currentTimeMillis() + 180000; // 현재 시간 + 3분 (180000 밀리초)
		System.out.println("인증코드 : " + authCode);
		HttpSession ses = request.getSession();
		ses.setAttribute("authCode", authCode);
		ses.setAttribute("authTime", authTime);
		try {
			sendMail.sendMail(email, "ELOLIA 인증코드입니다", authCode);
			json = new ResponseData("success", "메일 전송 성공");
			result = new ResponseEntity<ResponseData>(json, HttpStatus.OK);
		} catch (IOException e) {
			e.printStackTrace();
			json = new ResponseData("fail", "입출력 오류");
			result = new ResponseEntity<>(HttpStatus.CONFLICT);
		} catch (MessagingException e) {
			e.printStackTrace();
			json = new ResponseData("fail", "이메일 전송 오류");
			result = new ResponseEntity<>(HttpStatus.CONFLICT);
		}

		return result;
	}

	// 인증요청
	@RequestMapping(value = "/mailAuth")
	public ResponseEntity<ResponseData> mailAuth(HttpServletRequest request,
			@RequestParam("inputAuthCode") String inputAuthCode) {
		ResponseEntity<ResponseData> result = null;
		ResponseData json = null;
		HttpSession ses = request.getSession();
		String authCode = ses.getAttribute("authCode") + "";
		long authTime = (long) ses.getAttribute("authTime"); // 세션에 저장했던 시간
		long now = System.currentTimeMillis(); // 현재 시간
		if (authCode == null) { // 세션이 있는지 확인(인증메일을 발송하고 30분이 지나면 세션자체가 사라져서 nullpoint에러 발생
			json = new ResponseData("fail", "세션 만료");
			result = new ResponseEntity<ResponseData>(json, HttpStatus.OK);
		} else {
			if (authTime < now) { // 인증 메일을 보낸지 3분이 지난경우
				System.out.println("세션이 만료되었습니다.");
				json = new ResponseData("fail", "세션 만료");
				result = new ResponseEntity<ResponseData>(json, HttpStatus.OK);
			} else {
				if (inputAuthCode.equals(authCode)) {
					System.out.println("인증 성공");
					json = new ResponseData("success", "인증 성공");
					result = new ResponseEntity<ResponseData>(json, HttpStatus.OK);
				} else {
					System.out.println("인증 실패");
					json = new ResponseData("fail", "코드 불일치");
					result = new ResponseEntity<ResponseData>(json, HttpStatus.OK);
				}
			}
		}
		return result;
	}

	// 아이디 찾기 페이지로 이동
	@RequestMapping(value = "/find_id")
	public String find_id() {
		return "/user/pages/member/find_id";
	}

	// 비밀번호 찾기 페이지로 이동
	@RequestMapping(value = "/find_pwd")
	public String find_pwd() {
		return "/user/pages/member/find_pwd";
	}

	// 아이디 찾기(이메일)
	@RequestMapping(value = "/find/id")
	public ResponseEntity<ResponseData> findMemberId(@RequestParam("email") String email) {
		ResponseEntity<ResponseData> result = null;
		ResponseData json = null;
		LoginDTO member_id = null;
		try {
			member_id = memberService.findIdbyEmail(email);
			if (member_id != null) {
				sendMail.sendMail(email, "ELOLIA 아이디 찾기 요청", "id : " + member_id.getMember_id());
				json = new ResponseData("success", "메일 전송 완료");
				result = new ResponseEntity<ResponseData>(json, HttpStatus.OK);
			} else {
				json = new ResponseData("fail", "없는 이메일");
				result = new ResponseEntity<ResponseData>(json, HttpStatus.OK);
			}
		} catch (Exception e) {
			e.printStackTrace();
			json = new ResponseData("fail", "예외 발생");
			result = new ResponseEntity<>(HttpStatus.CONFLICT);
		}

		return result;
	}

	// 비밀번호 찾기(아이디, 이메일)
	@RequestMapping(value = "/find/pwd")
	public ResponseEntity<ResponseData> findMemberPwd(@RequestParam("email") String email,
			@RequestParam("member_id") String member_id) {
		ResponseEntity<ResponseData> result = null;
		ResponseData json = null;
		Random random = new Random();
		UUID uuid = UUID.randomUUID();
		String member_pwd = random.nextInt(10000) + uuid.toString().substring(0, 7);

		try {
			if (memberService.findPwd(email, member_id, member_pwd)) {
				sendMail.sendMail(email, "ELOLIA 임시 비밀번호", "pwd : " + member_pwd);
				json = new ResponseData("success", "메일 전송 완료");
				result = new ResponseEntity<ResponseData>(json, HttpStatus.OK);
			} else {
				json = new ResponseData("fail", "아이디 또는 이메일 에러");
				result = new ResponseEntity<ResponseData>(json, HttpStatus.OK);
			}
		} catch (Exception e) {
			e.printStackTrace();
			json = new ResponseData("fail", "예외 발생");
			result = new ResponseEntity<>(HttpStatus.CONFLICT);
		}

		return result;
	}

	// 찜정보 받기
	@RequestMapping(value = "/getWishList")
	public ResponseEntity<ResponseData> getWishList(HttpServletRequest request, Model model) {
		ResponseEntity<ResponseData> result = null;
		ResponseData json = null;
		HttpSession ses = request.getSession();
		LoginDTO loginDTO = (LoginDTO) ses.getAttribute("loginMember"); // 로그인세션을 loginDTO로 받아옴
		if (loginDTO != null) { // 로그인 상태인지 확인(세션이 있다면 로그인된 상태인 것)
			try {
				int wishList[] = memberService.getWishList(loginDTO.getMember_id());
				model.addAttribute("wishList", wishList); // 모델에 찜 목록 배열 저장(페이지가 열릴때 모델에 저장되는게 아니라서 해당 코드는 페이지가 열릴때
															// 동작되도록 해야함)
				json = new ResponseData("success", "찜목록 받아옴", wishList);
				result = new ResponseEntity<ResponseData>(json, HttpStatus.OK);
			} catch (Exception e) {
				json = new ResponseData("fail", "찜목록 받아오기 실패");
				result = new ResponseEntity<ResponseData>(json, HttpStatus.OK);
			}
		} else {
			json = new ResponseData("fail", "로그인 세션 없음");
			result = new ResponseEntity<>(HttpStatus.CONFLICT);
		}

		return result;
	}

	// 찜 하기(토글 동작)
	// ajax요청 data에 찜하려는, 해제하려는 상품의 product_no를 받을수있도록 한다는 가정하에 만듦
	@RequestMapping(value = "/saveWish", method = RequestMethod.GET)
	public ResponseEntity<ResponseData> saveWish(
			@RequestParam(value = "product_no", defaultValue = "-1") int product_no, HttpServletRequest request) {
		ResponseEntity<ResponseData> result = null;
		ResponseData json = null;
		HttpSession ses = request.getSession();
		LoginDTO loginDTO = (LoginDTO) ses.getAttribute("loginMember"); // 로그인세션을 loginDTO로 받아옴
		if (loginDTO != null) { // 로그인 상태인가?
			System.out.println("로그인 상태 확인");
			if (product_no != -1) { // 상품번호가 유효한가?(제대로 받아왔는가?)
				System.out.println("상품 번호 유효");
				try {
					int tmp = memberService.saveWish(product_no, loginDTO.getMember_id()); // -1 : 에러, 0 : 찜추가, 1 : 찜취소
					if (tmp == 0) {
						System.out.println("찜 추가");
						json = new ResponseData("success", "찜");
					} else if (tmp == 1) {
						System.out.println("찜 삭제");
						json = new ResponseData("success", "찜 취소");
					} else {
						System.out.println("실패");
						json = new ResponseData("fail", "실패");
					}
					result = new ResponseEntity<ResponseData>(json, HttpStatus.OK);
				} catch (Exception e) {
					json = new ResponseData("error", "에러");
					result = new ResponseEntity<>(HttpStatus.CONFLICT);
					e.printStackTrace();
				}
			}
		}
		return result;
	}

	// 카카오 로그인(인가코드 api)
	@GetMapping("/kakao/login")
	public String kakao(HttpServletResponse response) {
		try {
			kakao.getCode(response);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return "/user/index";
	}

	// 카카오 로그인(토큰 api)
	@RequestMapping(value = "/kakao")
	public String kakaoLogin(HttpServletResponse response, Model model, HttpServletRequest request,
			@RequestParam(value = "code", defaultValue = "false") String code,
			@RequestParam(value = "state", defaultValue = "false") String state,
			@RequestParam(value = "client_secret", defaultValue = "false") String client_secret) throws Exception {
		String result = "/user/index";
		HttpSession ses = request.getSession();
		String accessToken = kakao.getAccessToken(code); // 인가코드로 토큰을 받아오기
		MemberDTO userInfo = kakao.getUserInfo(accessToken); // 토큰으로 유저정보 받아오기
		ses.setAttribute("accessToken", accessToken); // 세션에 토큰 저장
		System.out.println(userInfo);
		// 받아온 이메일로 members 테이블 조회
		LoginDTO loginMember = memberService.selectMemberByEmail(userInfo);
		// 카카오 로그인 이메일과 동일한 이메일을 찾았다면 해당 데이터로 로그인
		if (loginMember != null) {
			ses.setAttribute("loginMember", loginMember);
		} else {
			model.addAttribute("userInfo", userInfo);
			result = "/user/pages/member/signUpKakao";
		}

		return result;
	}

	// 카카오 회원가입(간편가입)
	@PostMapping(value = "/kakao/signUp")
	public String kakaoSignUp(MemberDTO memberDTO, Model model) {
		System.out.println(memberDTO);
		// 우편번호/주소/상세주소
		memberDTO.setAddress(memberDTO.getZipCode() + "/" + memberDTO.getAddress() + "/" + memberDTO.getAddress2());
		try {
			if (memberService.signUp(memberDTO) == 1) {
				System.out.println("카카오 간편가입 완료");
				LoginDTO loginDTO = new LoginDTO();
				loginDTO.setMember_id(memberDTO.getMember_id());
				loginDTO.setMember_pwd(memberDTO.getMember_pwd());
				LoginDTO loginMember = memberService.login(loginDTO); // 입력한 member_id, member_pwd를 loginDTO로 받아서 db에 조회한다.
				model.addAttribute("loginMember", loginMember); // 모델객체에 로그인 정보 저장
			} else {
				System.out.println("잘못된 접근(가입에 필요한 데이터 부족");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "/user/index";
	}
	

}
