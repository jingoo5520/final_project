package com.finalProject.controller.order;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.finalProject.model.LoginDTO;
import com.finalProject.model.order.OrderMemberDTO;
import com.finalProject.model.order.OrderProductVO;
import com.finalProject.model.order.OrderRequestDTO;
import com.finalProject.service.order.OrderService;

@Controller
@RequestMapping("/order")
public class OrderController {
	
	@Inject
	OrderService oService;
	
	@PostMapping("")
	public String orderPage(OrderRequestDTO orDTO, Model model, HttpSession session) {
		// 세션에서 login정보 가져오기
		LoginDTO loginMember = (LoginDTO) session.getAttribute("loginMember");
		
		System.out.println("상품 : " + orDTO.getProductNo() + ", 수량 : " + orDTO.getQuantity());
		int productNo = orDTO.getProductNo();
		int quantity = orDTO.getQuantity();
		

		
		// 바인딩한 productNo로 상품 정보 조회
		// 상품이름, 상품가격, 상품이미지, 상품할인정보
		OrderProductVO orderProduct = oService.getProductInfo(productNo, quantity);
		
		System.out.println(orderProduct.toString());
		
		model.addAttribute("orderProduct", orderProduct);
		
		if (loginMember != null) { // 로그인 했는지 안했는지 구분
			System.out.println("order 로그인 상태, 회원 id : " + loginMember.getMember_id());
			
			String memberId = loginMember.getMember_id();
			
			// 로그인 했을 경우 회원아이디로 주문자 정보 조회
			OrderMemberDTO orderMember = oService.getMemberInfo(memberId);
			
			System.out.println(orderMember.toString());
			
			model.addAttribute("orderMember", orderMember);
			
		} else {
			System.out.println("order 로그인 하지 않음");
		}
		
		return "/user/order/order";
	}
}
