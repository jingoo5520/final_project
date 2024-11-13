package com.finalProject.intercepter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.finalProject.model.LoginDTO;
import com.finalProject.util.RememberPath;

public class AuthInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		System.out.println("AuthInterceptor의 prehandle 동작");

		boolean result = false;

		HttpSession ses = request.getSession();
		String uri = request.getRequestURI();
		System.out.println(uri);
		new RememberPath().rememberPath(request); // 호출한 페이지 주소 저장.
		if (ses.getAttribute("loginMember") == null) { // 로그인이 안된경우
			System.out.println("로그인 안됨");
			if(uri.contains("/order")) { // 주문 요청인 경우
				System.out.println(request.getParameter("productInfos"));
				ses.setAttribute("productInfos", request.getParameter("productInfos"));
			}
			response.sendRedirect("/member/viewLogin"); // 로그인 페이지로 이동
			result = false;
		} else { // 로그인이 되어있는 경우
			if (uri.contains("/member/auth")) { // 마이페이지 인증요청인 경우
				result = true;
				response.sendRedirect(uri); // 인증 요청한 페이지로 이동
			} else {
				System.out.println("로그인 되있음");
				System.out.println("원래 있던 페이지 : " + uri);
				result = true;
				if(uri.contains("/order")) { // 주문 요청인 경우
					System.out.println(request.getParameter("productInfos"));
					ses.setAttribute("productInfos", request.getParameter("productInfos"));
				}
				// 페이지에 대한 권한 인증 작업이 필요하면 밑에 추가
				if(uri.contains("/admin")) { // 어드민 페이지인경우
					LoginDTO loginDTO = (LoginDTO) ses.getAttribute("loginMember");
					String isAdmin = loginDTO.getIs_admin();
					if(isAdmin.equals("0")) { // 해당 유저가 관리자가 아닌경우
						System.out.println(isAdmin + " : 관리자가 아님");
						response.sendRedirect("/"); // index로 이동
						result = false; // 컨트롤러 동작을 하지않음.
					}
				}
			}
		}

		return result;
	}

}
