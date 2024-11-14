package com.finalProject.controller.cart;

import java.util.Base64;
import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.finalProject.model.LoginDTO;
import com.finalProject.service.cart.CartService;

@ControllerAdvice
public class CartControllerAdvice {
	
	@Inject
	CartService cService;
	
	@ModelAttribute
	public void showCartItemCount(Model model, HttpSession session, HttpServletRequest request) {
		LoginDTO loginMember = (LoginDTO) session.getAttribute("loginMember");
		
		Cookie[] cookies = request.getCookies();
		
		int cartNo = 0;
		int cartItemCount = 0;
		
		if (loginMember != null) {
			String memberId = loginMember.getMember_id();
			
			cartNo = cService.getCartNo(memberId);
			
			if (cartNo != 0) {
				// 장바구니가 있다면
				cartItemCount = cService.getCartItemCount(cartNo);
			} else {
				// 장바구니가 없다면
				cartItemCount = 0;
			}
			if (cookies != null) {
				for (Cookie cookie : cookies) {
					// 쿠키로 로그인하지 않았을 때 장바구니 정보를 조회
					if (cookie.getName().equals("cartItem")) {
						// 쿠키에 cartItem이 있음
						String decodedValue = new String(Base64.getDecoder().decode(cookie.getValue()));
						String[] cookieCartItems = decodedValue.split(";");
						
						List<Integer> cartProductNos = cService.getProductNo(cartNo);
						
						int matchedProductCount = 0;
						
						for (int cartProductNo : cartProductNos) {
//							System.out.println(cartProductNo);
							
							for (String cookieCartItem : cookieCartItems) {
								int productNoOfCookie = Integer.parseInt(cookieCartItem.split(":")[0]);
								
								if (cartProductNo == productNoOfCookie) {
									matchedProductCount++;
								}
							}
						}
						cartItemCount += cookieCartItems.length - matchedProductCount;
					}
				}
			}
		} else {
			if (cookies != null) {
				for (Cookie cookie : cookies) {
					// 쿠키로 로그인하지 않았을 때 장바구니 정보를 조회
					if (cookie.getName().equals("cartItem")) {
						// 쿠키에 cartItem이 있음
						String decodedValue = new String(Base64.getDecoder().decode(cookie.getValue()));
						String[] cookieCartItems = decodedValue.split(";");
						
						cartItemCount = cookieCartItems.length;
					}
				}
			}
		}
		
		model.addAttribute("cartItemCount", cartItemCount);
	}
	
	
}
