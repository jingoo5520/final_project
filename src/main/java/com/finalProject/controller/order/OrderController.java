package com.finalProject.controller.order;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.finalProject.model.LoginDTO;
import com.finalProject.model.OrderMemberVO;
import com.finalProject.model.OrderProductVO;
import com.finalProject.service.OrderService;

@Controller
public class OrderController {
	
	@Inject
	private OrderService oService;
	
	@GetMapping("/order")
	public String orderPage(@RequestParam("quantity") int quantity, @RequestParam("productNo") int productNo ,Model model, HttpSession session) {
		LoginDTO loginMember = (LoginDTO) session.getAttribute("loginMember");
		
			System.out.println("수량 : " + quantity + ", 상품번호 : " + productNo);
		
		OrderProductVO orderProduct = oService.viewProduct(productNo); // 주문 상품 번호로 상품 정보 출력
		
			System.out.println(orderProduct.toString());
			
			model.addAttribute("orderProduct", orderProduct);
		
		if (loginMember != null) { // 로그인 했는지 안했는지 구분
			System.out.println("order 로그인 상태, 회원 id : " + loginMember.getMember_id());
			
			String memberId = loginMember.getMember_id();
			
			OrderMemberVO orderMember = oService.viewMember(memberId); // 회원 id로 주문자 정보 출력
			
			System.out.println(orderMember.toString());
			
			model.addAttribute("orderMember", orderMember);
			
		} else {
			System.out.println("order 로그인 하지 않음");
		}
		
		return "/user/order/order";
	}
}
