package com.finalProject.controller.cart;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.finalProject.model.LoginDTO;
import com.finalProject.model.cart.CartDTO;
import com.finalProject.service.cart.CartService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class CartController {
	
	@Inject
	CartService cService;
	
	@GetMapping("/cart")
	public String cartPage(HttpSession session, Model model) {
		LoginDTO loginMember = (LoginDTO) session.getAttribute("loginMember");
		List<CartDTO> cartItems = null;
		
		if (loginMember != null) {
			System.out.println("cart : 로그인 했음, id : " + loginMember.getMember_id());
			
			// 회원의 카트정보 가져오기
			cartItems = cService.getCartList(loginMember.getMember_id());
			
			model.addAttribute("cartItems", cartItems);
		} else {
			System.out.println("cart : 로그인 안함");
		}
		
		return "user/cart/cart";
	}
}
