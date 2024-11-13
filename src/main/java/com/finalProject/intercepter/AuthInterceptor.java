package com.finalProject.intercepter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

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
		
		if (ses.getAttribute("goingToOrderByNonMember") != null) {
			return true;
		}
				
		new RememberPath().rememberPath(request); // 호출한 페이지 주소 저장.
		if (ses.getAttribute("loginMember") == null) { // 로그인이 안된경우
			System.out.println("로그인 안됨");
			
//			// uri가 order일 경우 따로 처리
//			// sendRedirect()는 GET 매핑인데, /order요청은 POST 요청이 다시 /order GET 요청으로 보내는 방식으로 작동한다.
//			// 따라서 /order 단독으로 GET 요청을 할 일은 없다.
//			if (uri.equals("/order")) {
//				request.getRequestDispatcher("/order").forward(request, response);
//				result = false;
//			}
			
			response.sendRedirect("/member/viewLogin"); // 로그인 페이지로 이동
			result = false;
		} else { // 로그인이 되어있는 경우
			if (uri.contains("/member/auth")) { // 마이페이지 인증요청인 경우
				result = true;
				response.sendRedirect(uri); // 인증 요청한 페이지로 이동
			} else if (uri.contains("/oidsafjoihdsfoihdsaf")) {
				// working...
			} else {
				System.out.println("로그인 되있음");
				System.out.println("원래 있던 페이지 : " + uri);
				result = true;
				// 페이지에 대한 권한 인증 작업이 필요하면 밑에 추가
			}
		}

		return result;
	}

}
