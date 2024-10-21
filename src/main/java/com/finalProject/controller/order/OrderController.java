package com.finalProject.controller.order;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.finalProject.model.LoginDTO;

@Controller
@RequestMapping("/order")
public class OrderController {
	
	@GetMapping("")
	public String orderPage(@RequestParam("quantity") int quantity, @RequestParam("productNo") int productNo ,Model model, HttpSession session) {
		LoginDTO loginMember = (LoginDTO) session.getAttribute("loginMember");
		
			System.out.println("수량 : " + quantity + ", 상품번호 : " + productNo);
		
		if (loginMember != null) { // 로그인 했는지 안했는지 구분
			System.out.println("order 로그인 상태, 회원 id : " + loginMember.getMember_id());
			
			String memberId = loginMember.getMember_id();
			
		} else {
			System.out.println("order 로그인 하지 않음");
		}
		
		return "/user/order/order";
	}
}
