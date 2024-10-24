package com.finalProject.controller.cart;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
		
		int cartNo = 0;
		
		if (loginMember != null) {
			String memberId = loginMember.getMember_id();
			
			// 장바구니 번호 가져오기
			cartNo = cService.getCartNo(memberId);
			
			if (cartNo == 0) {
				// 장바구니가 없다면
				cService.addCartList(memberId);
			
			} else {
				// 장바구니가 있다면
				// 회원의 카트정보 가져오기
				cartItems = cService.getCartList(cartNo);
			}
			
			model.addAttribute("cartItems", cartItems);
			
		} else {
			
			System.out.println("cart : 로그인 안함");
		}
		
		return "user/cart/cart";
	}
	
	
	@PostMapping("/updateQuantity")
	public  ResponseEntity<String> updateQuantity(@RequestParam("productNo") int productNo, @RequestParam("quantity") int quantity, HttpSession session) {
		ResponseEntity<String> result = null;
		
		LoginDTO loginMember = (LoginDTO) session.getAttribute("loginMember");
		Map<String, Object> cMap = new HashMap<>();
		
		if (loginMember != null) {
			
			cMap.put("memberId", loginMember.getMember_id());
			cMap.put("productNo", productNo);
			cMap.put("quantity", quantity);
			
			if (cService.applyQuantity(cMap) != 0) {
				System.out.println("update 성공적");
				return result = new ResponseEntity<String>(HttpStatus.OK);
			} else {
				System.out.println("update 안됨");
				return result = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
			}
			
			
		} else {
			System.out.println("cart : 로그인 안함");
			
			return result = new ResponseEntity<String>(HttpStatus.UNAUTHORIZED);
		}
		
	}
	
	@PostMapping("/removeCartItem")
	public ResponseEntity<String> removeCartItem(@RequestParam("productNo") int productNo, HttpSession session) {
		ResponseEntity<String> result = null;
		
		LoginDTO loginMember = (LoginDTO) session.getAttribute("loginMember");
		Map<String, Object> cMap = new HashMap<>();
		
		if (loginMember != null) {
			
			cMap.put("memberId", loginMember.getMember_id());
			cMap.put("productNo", productNo);
			
			if (cService.removeCartItem(cMap) != 0) {
				System.out.println("delete 성공적");
				return result = new ResponseEntity<String>(HttpStatus.OK);
			} else {
				System.out.println("delete 안됨");
				return result = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
			}
			
			
		} else {
			System.out.println("cart : 로그인 안함");
			
			return result = new ResponseEntity<String>(HttpStatus.UNAUTHORIZED);
		}
		
	}
	
	@PostMapping("/addCartItem")
	public ResponseEntity<String> addCartItem(@RequestParam("productNo") int productNo, @RequestParam(value = "quantity", required = false, defaultValue = "1") int quantity, HttpSession session) {
		ResponseEntity<String> result = null;
		
		LoginDTO loginMember = (LoginDTO) session.getAttribute("loginMember");
		Map<String, Object> cMap = new HashMap<>();
		
		int cartNo = 0;
		
		if (loginMember != null) {
			String memberId = loginMember.getMember_id();
			
			// 장바구니 번호 가져오기
			cartNo = cService.getCartNo(memberId);
			
			if (cartNo == 0) {
				// 장바구니가 없다면
				cService.addCartIteminNewList(memberId, productNo, quantity);
			} else {
				// 장바구니가 있다면
				cService.addCartItem(cartNo, productNo, quantity, memberId);
			}
			
			return result = new ResponseEntity<String>(HttpStatus.OK);
			
		} else {
			System.out.println("cart : 로그인 안함");
			
			return result = new ResponseEntity<String>(HttpStatus.UNAUTHORIZED);
		}
		
	}
	
}
