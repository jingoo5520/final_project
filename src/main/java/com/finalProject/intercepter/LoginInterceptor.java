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
import org.springframework.web.util.WebUtils;

import com.finalProject.model.LoginDTO;
import com.finalProject.service.MemberService;
import com.finalProject.util.RememberPath;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class LoginInterceptor extends HandlerInterceptorAdapter {

	private final int AUTOLOGIN_DATE = 7; // 자동 로그인 유효 기간

	@Inject
	private MemberService memberService;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		System.out.println("Login preHandle 호출");
		HttpSession ses = request.getSession();
		boolean result = true;
		LoginDTO loginDTO = null;
		log.info("preHandle()");

		if (request.getSession().getAttribute("loginMember") != null) { // 로그인이 되어있을경우
			System.out.println("로그인 된 상태로 로그인 인터셉터 동작 : 로그아웃 처리");
			ses.removeAttribute("loginMember"); // 로그인 세션 삭제(로그아웃)
		}

		// GET방식인 경우
		if (request.getMethod().toUpperCase().equals("GET")) {
			// 자동 로그인
			Cookie cookie = WebUtils.getCookie(request, "al"); // 자동로그인 쿠키를 저장
			if (cookie != null) { // 자동 로그인 쿠키가 있는 경우
				System.out.println("자동 로그인 쿠키 발견");
				String autologin_code = cookie.getValue(); // 자동로그인 쿠키의 벨류 저장
				if (memberService.getAutoLogin(autologin_code) != null) { // 자동로그인 정보가 DB에 있을경우
					System.out.println("자동 로그인할 유저 정보 확인");
					loginDTO = memberService.getAutoLogin(autologin_code); // DB에서 자동로그인 정보가 쿠키값과 일치하는 유저 데이터 받아옴
					ses.setAttribute("loginMember", loginDTO); // 로그인 세션 생성(로그인 처리)
					String rememberPath = ses.getAttribute("rememberPath") + "";
					result = false; // postHandle과 컨트롤러 서블릿 동작을 하지 않도록 false반환
					if (!rememberPath.equals("null")) { // rememberPath가 있다면
						System.out.println("rememberPath있음 : " + rememberPath);
						response.sendRedirect(rememberPath); // rememberPath로 보냄
					} else {
						System.out.println("rememeberPath없음");
						response.sendRedirect("/"); // 인덱스로 보냄
					}
				} else {
					System.out.println("자동 로그인 만료");
					cookie.setMaxAge(0); // 유효기간 0초
					response.addCookie(cookie); // 쿠키 덮어씌우기(쿠키삭제처리)
				}
			}

		} else if (request.getMethod().toUpperCase().equals("POST")) { // POST방식인 경우(로그인 버튼 눌렀을 때)
			result = true;
		}
		return result;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
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
					// db에 자동로그인 정보 update
					memberService.setAutoLogin(loginMember.getMember_id(), code, AUTOLOGIN_DATE);

				}
				String rememberPath = ses.getAttribute("rememberPath") + "";
				if (!rememberPath.equals("null")) { // rememberPath가 있다면
					response.sendRedirect(rememberPath); // rememberPath로 보냄
					System.out.println("rememberPath있음 : " + rememberPath);
				} else {
					System.out.println("rememeberPath없음");
					response.sendRedirect("/"); // 인덱스로 보냄
				}
			} else {
				System.out.println("아이디 또는 비밀번호가 일치하지 않습니다.");
				response.sendRedirect("/member/viewLogin/?status=fail");
			}
		}

	}

}
