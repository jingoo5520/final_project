package com.finalProject.intercepter;

import java.io.IOException;
import java.util.Map;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.finalProject.model.LoginDTO;
import com.finalProject.service.MemberService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class LoginInterceptor extends HandlerInterceptorAdapter {

	private final int AUTOLOGIN_DATE = 7; // 자동 로그인 유효 기간

	@Inject
	private MemberService memberService;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {
		System.out.println("Login preHandle 호출");
		boolean result = false;
		LoginDTO loginDTO = null;
		log.info("preHandle()");

		// 자동 로그인
		Cookie[] cookies = request.getCookies(); // 쿠키 가져오기
		if (cookies != null) { // 쿠키가 있을경우
			for (Cookie cookie : cookies) {
				// 자동 로그인 쿠키가 있을경우
				if (cookie.getName().equals("al")) {
					System.out.println("자동 로그인 쿠키 발견");
					String autologin_code = cookie.getValue();
					try {
						// 자동로그인 정보가 DB에 있을경우
						if (memberService.getAutoLogin(autologin_code) != null) {
							System.out.println("자동 로그인할 유저 정보 확인");
							HttpSession ses = request.getSession();
							loginDTO = memberService.getAutoLogin(autologin_code);
							ses.setAttribute("loginMember", loginDTO); // 로그인 세션 생성
							result = false; // postHandle과 컨트롤러 서블릿 동작을 하지 않도록 false반환
							// 여기에 sendRidirect(원래 있던 페이지) 로 동작하도록 만들어야함.
						}
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			}
		}

		// 로그인 버튼을 눌렀을 때
		if (request.getMethod().toUpperCase().equals("POST")) {
			result = true;
		}
		return result;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws IOException {
		System.out.println("Login postHandle 호출");

		HttpSession ses = request.getSession();

		if (request.getMethod().toUpperCase().equals("POST")) {
			Map<String, Object> model = modelAndView.getModel();
			LoginDTO loginMember = (LoginDTO) model.get("loginMember");
			if (loginMember != null) { // 로그인시도하는 member정보가 db에 있을 경우 로그인(세션생성)
				ses.setAttribute("loginMember", loginMember);
				System.out.println(loginMember.getMember_name() + "님 로그인");
				Object autologin = model.get("autologin");

				if (autologin != null) { // 자동로그인에 체크한 경우
					String code = UUID.randomUUID().toString();
					Cookie cookie = new Cookie("al", code); // 쿠키객체 생성
					cookie.setMaxAge(60 * 60 * 24 * AUTOLOGIN_DATE); // 쿠키 유효기간 설정
					cookie.setPath("/"); // 모든 경로에서 사용 가능
					response.addCookie(cookie); // 만든 쿠키 저장
					try {
						// db에 자동로그인 정보 update
						memberService.setAutoLogin(loginMember.getMember_id(), code, AUTOLOGIN_DATE);
					} catch (Exception e) {
						e.printStackTrace();
					}
				}

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
