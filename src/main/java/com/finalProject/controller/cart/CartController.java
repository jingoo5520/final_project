package com.finalProject.controller.cart;

import java.util.ArrayList;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

import javax.inject.Inject;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.finalProject.model.LoginDTO;
import com.finalProject.model.cart.CartDTO;
import com.finalProject.model.cart.CartMemberLevelDTO;
import com.finalProject.model.cart.CookieCartDTO;
import com.finalProject.model.cart.CookieCartVO;
import com.finalProject.service.cart.CartService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller

public class CartController {
	
	@Inject
	CartService cService;
	
	
	@GetMapping("/cart")
	public String cartPage(HttpSession session, Model model, HttpServletRequest request, HttpServletResponse response) {
		LoginDTO loginMember = (LoginDTO) session.getAttribute("loginMember");
		List<CartDTO> cartList = new ArrayList<>();
		List<CookieCartVO> cookieCartList = new ArrayList<>();
		Map<String, Object> cMap = new HashMap<>();
		
		int cartNo = 0;
		
		Cookie[] cookies = request.getCookies();
		
		String decodedValue = "";
		
		String[] cookieCartItems = null;
		
		if (loginMember != null) {
			String memberId = loginMember.getMember_id();
			
			// 로그인 했을 경우 회원아이디로 주문자 정보 조회
			CartMemberLevelDTO cartMemberLevelInfo = cService.getLevelInfo(memberId);
			
			model.addAttribute("levelInfo", cartMemberLevelInfo);
			
			// 장바구니 번호 가져오기
			cartNo = cService.getCartNo(memberId);
			
			if (cartNo == 0) {
				// 장바구니가 없다면
				cService.addCartList(memberId);
			
			} else {
				// 장바구니가 있다면
				cartList = cService.getCartList(cartNo);
				
				if (cookies != null) {
					// 쿠키에 담긴 상품이 있다면
					for (Cookie cookie : cookies) {
						if (cookie.getName().equals("cartItem")) {
							decodedValue = new String(Base64.getDecoder().decode(cookie.getValue()));
							cookieCartItems = decodedValue.split(";");
							
							// set을 생성해 cookie의 productNo와 cart의 productNo를 비교
							Set<Integer> cartProductNos = cartList.stream()
							    .map(CartDTO::getProduct_no)
							    .collect(Collectors.toSet());

							for (String cookieValue : cookieCartItems) {
							    int productNoOfCookie = Integer.parseInt(cookieValue.split(":")[0]);
							    int quantityOfCookie = Integer.parseInt(cookieValue.split(":")[1]);

							    cMap.put("cartNo", cartNo);
							    cMap.put("productNo", productNoOfCookie);
							    cMap.put("quantity", quantityOfCookie);

							    if (cartProductNos.contains(productNoOfCookie)) {
							        // 쿠키의 상품이 장바구니에 있는 경우 수량 업데이트
							        cService.mergeQuantityExistCookie(cMap);
							    } else {
							        // 쿠키의 상품이 장바구니에 없는 경우 상품 추가
							        cService.addCartItem(cartNo, productNoOfCookie, quantityOfCookie, memberId);
							    }
							}
							
							// 회원의 카트정보 다시 가져오기
							cartList = cService.getCartList(cartNo);
							
							// 쿠키 지우기
							removeCookie(response);
						}
					}
				}
			}
			
		} else {
			if (cookies != null) {
				for (Cookie cookie : cookies) {
					// 쿠키로 로그인하지 않았을 때 장바구니 정보를 조회
					if (cookie.getName().equals("cartItem")) {
						// 쿠키에 cartItem이 있음
						decodedValue = new String(Base64.getDecoder().decode(cookie.getValue()));
						cookieCartItems = decodedValue.split(";");
						
						for (String cartItem : cookieCartItems) {
							int productNoOfCookie = Integer.parseInt(cartItem.split(":")[0]);
							int quantityOfCookie = Integer.parseInt(cartItem.split(":")[1]);
							
							CookieCartDTO cookieCartDTO = cService.getProductInfoOfCookieCart(productNoOfCookie);
							
							CookieCartVO cookieCartVO = new CookieCartVO().builder()
									.product_no(cookieCartDTO.getProduct_no())
									.product_name(cookieCartDTO.getProduct_name())
									.product_price(cookieCartDTO.getProduct_price())
									.image_main_url(cookieCartDTO.getImage_main_url())
									.product_count(quantityOfCookie)
									.build();
							
							cookieCartList.add(cookieCartVO);
						}
						
					}
				}
			}
		
		
		}
		
		model.addAttribute("cookieCartItems", cookieCartList);
		model.addAttribute("cartItems", cartList);
		
		return "user/pages/cart/cart";
	}


	private void removeCookie(HttpServletResponse response) {
		Cookie deletecookie = new Cookie("cartItem", null);
		deletecookie.setMaxAge(0);
		deletecookie.setPath("/");
		response.addCookie(deletecookie);
	}
	
	
	@PostMapping("/updateQuantity")
	public  ResponseEntity<String> updateQuantity(@RequestParam("productNo") int productNo, @RequestParam("quantity") int quantity, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		ResponseEntity<String> result = null;
		Cookie[] cookies = request.getCookies();
		LoginDTO loginMember = (LoginDTO) session.getAttribute("loginMember");
		Map<String, Object> cMap = new HashMap<>();
		
		if (loginMember != null) {
			
			cMap.put("memberId", loginMember.getMember_id());
			cMap.put("productNo", productNo);
			cMap.put("quantity", quantity);
			
			if (cService.applyQuantity(cMap) != 0) {
				// update 성공
				return result = new ResponseEntity<String>(HttpStatus.OK);
			} else {
				// update 실패
				return result = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
			}
			
		} else {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals("cartItem")) {
					// 쿠키에 cartItem이 있음
					String decodedValue = new String(Base64.getDecoder().decode(cookie.getValue()));
					
					String[] cartItems = decodedValue.split(";");
					String updateValue = "";
					String newValue = "";
					for (String cartItem : cartItems) {
						int productNoOfCookie = Integer.parseInt(cartItem.split(":")[0]);
						
						if (productNoOfCookie == productNo) {
							updateValue = productNo + ":" + quantity;
							newValue = decodedValue.replace(cartItem, updateValue);
							
							// 기존의 쿠키 update
							createCookie(response, newValue);
						}
					}
				} 
			}
			
			return result = new ResponseEntity<String>(HttpStatus.OK);
		}
		
	}
	
	@PostMapping("/removeCartItem")
	public ResponseEntity<String> removeCartItem(@RequestParam("productNo") int productNo,
			HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		ResponseEntity<String> result = null;
		Cookie[] cookies = request.getCookies();
		LoginDTO loginMember = (LoginDTO) session.getAttribute("loginMember");
		Map<String, Object> cMap = new HashMap<>();
		
		List<Integer> productNos = new ArrayList<Integer>();
		productNos.add(productNo);
		
		if (loginMember != null) {
			
			if (removeProduct(loginMember, productNos, cMap) == 0) {
				return result = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
			}
			
			return result = new ResponseEntity<String>(HttpStatus.OK);
			
		} else {
			System.out.println("cart : 로그인 안함");
			
			removeProductOfCookie(productNos, response, cookies);
			
			return result = new ResponseEntity<String>(HttpStatus.OK);
		}
		
	}
	
	@PostMapping("/removeCheckedItems")
    public ResponseEntity<String> removeCheckedItems(@RequestBody List<Integer> productNos, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
        ResponseEntity<String> result = null;
        Cookie[] cookies = request.getCookies();
        LoginDTO loginMember = (LoginDTO) session.getAttribute("loginMember");
        Map<String, Object> cMap = new HashMap<>();

		if (loginMember != null) {
			
			if (removeProduct(loginMember, productNos, cMap) == 0) {
				return result = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
			}
			
		} else {
			removeProductOfCookie(productNos, response, cookies);
		}
        
        return result = new ResponseEntity<String>(HttpStatus.OK);
    }
	
	private int removeProduct(LoginDTO loginMember, List<Integer> productNos, Map<String, Object> cMap) {
		cMap.put("memberId", loginMember.getMember_id());
		cMap.put("productNos", productNos);
		if(cService.removeCartItem(cMap) == 0) {
			return 0;
		}
		return 1;
	}

	private void removeProductOfCookie(List<Integer> productNos, HttpServletResponse response, Cookie[] cookies) {
		for (Cookie cookie : cookies) {
			if (cookie.getName().equals("cartItem")) {
				// 쿠키에 cartItem이 있음
				String decodedValue = new String(Base64.getDecoder().decode(cookie.getValue()));
				
				String[] cartItems = decodedValue.split(";");
				
				String removeValue = "";
				
				for (int productNo : productNos) {
					for (String cartItem : cartItems) {
						if (cartItem.contains(productNo + ":")) {
							int quantity = Integer.parseInt(cartItem.split(":")[1]);
							
							removeValue = productNo + ":" + quantity;
						}
					}
					
					// 2. 해당 상품 쿠키 삭제
					
					if (decodedValue.contains(removeValue + ";")) {
						// 상품이 쿠키밸류 시작이거나 중간이라면
						decodedValue = decodedValue.replace(removeValue + ";", "");
					} else if (decodedValue.contains(";" + removeValue)) {
						// 상품이 쿠키밸류 마지막이라면
						decodedValue = decodedValue.replace(";" + removeValue, "");
					} else {
						// 상품이 1개일 경우
						decodedValue = decodedValue.replace(removeValue, "");
						// 기존의 쿠키 update
					}
					
				}
				if (!decodedValue.equals("")) {
					createCookie(response, decodedValue);
				} else {
					// 쿠키에 남은 상품이 없을 때 쿠키 지우기
					removeCookie(response);
				}
				
			} 
		}
	}

	@PostMapping("/addCartItem")
	public ResponseEntity<String> addCartItem(@RequestParam("productNo") int productNo, @RequestParam(value = "quantity", required = false, defaultValue = "1") int quantity, HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		ResponseEntity<String> result = null;
		
		Cookie[] cookies = request.getCookies();
		
		String cookieValue = productNo + ":" + quantity; 
		
		LoginDTO loginMember = (LoginDTO) session.getAttribute("loginMember");
		
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
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals("cartItem")) {
					// 쿠키에 cartItem이 있음
					String decodedValue = new String(Base64.getDecoder().decode(cookie.getValue()));
					
					String[] cartItems = decodedValue.split(";");
					String newValue = "";
					for (String cartItem : cartItems) {
						int productNoOfCookie = Integer.parseInt(cartItem.split(":")[0]);
						int quantityOfCookie = Integer.parseInt(cartItem.split(":")[1]);
						String updateValue = "";
						
						if (productNoOfCookie == productNo) {
							// 이미 상품이 쿠키에 저장되어 있다면 기존 수량 + 입력수량
							int newQuantity = quantityOfCookie + quantity;
							updateValue = productNoOfCookie + ":" + newQuantity;
							newValue = decodedValue.replace(cartItem, updateValue);
						} else {
							// 상품이 없다면 쿠키 밸류의 상품 추가
							newValue = decodedValue + ";" + cookieValue;
						}
					}
					
					// 기존의 쿠키 update
					createCookie(response, newValue);
					
				} else {
					// 새로운 쿠키 생성
					createCookie(response, cookieValue);
				}
			}
			
			return result = new ResponseEntity<String>(HttpStatus.OK);
		}
		
	}


	private void createCookie(HttpServletResponse response, String cookieValue) {
		String encodedCookieValue = Base64.getEncoder().encodeToString(cookieValue.getBytes());
		Cookie cookie = new Cookie("cartItem", encodedCookieValue);
		cookie.setMaxAge(60 * 60 * 24); // 7일
		cookie.setPath("/");
		
		response.addCookie(cookie);
	}
	
}
