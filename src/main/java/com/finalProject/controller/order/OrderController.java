package com.finalProject.controller.order;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.finalProject.model.DeliveryDTO;
import com.finalProject.model.DeliveryVO;
import com.finalProject.model.LoginDTO;
import com.finalProject.model.UseCouponDTO;
import com.finalProject.model.order.OrderMemberDTO;
import com.finalProject.model.order.OrderProductDTO;
import com.finalProject.model.order.OrderProductsDTO;
import com.finalProject.model.order.OrderRequestDTO;
import com.finalProject.model.order.PaymentRequestDTO;
import com.finalProject.service.member.MemberService;
import com.finalProject.service.order.OrderService;
import com.google.gson.Gson;

@Controller
public class OrderController {
	@Inject
	private OrderService orderService;
	
	@Inject
	private MemberService memberService;
	
	static private Gson gson = new Gson();
	
	@GetMapping("/order")
	public String showOrderPage(Model model) {
		
		if (!model.containsAttribute("orderProductList")) {
			return "/user/pages/warning";
		}
		
	    return "/user/pages/order/order";
	}
	
	@PostMapping("/order")
	public String orderPage(@RequestParam String productInfos, RedirectAttributes redirectAttributes, HttpSession session) {
		// 세션에서 login정보 가져오기
		LoginDTO loginMember = (LoginDTO) session.getAttribute("loginMember");
		
	    ObjectMapper objectMapper = new ObjectMapper();
	    List<OrderRequestDTO> requestsInfo;

	    try {
	        requestsInfo = objectMapper.readValue(productInfos, new TypeReference<List<OrderRequestDTO>>() {});
		
	        // productsInfo를 사용하여 DB 조회 및 처리
	        for (OrderRequestDTO orDTO : requestsInfo) {
	        	System.out.println(orDTO.toString());
	            System.out.println("Product No: " + orDTO.getProductNo());
	            System.out.println("Quantity: " + orDTO.getQuantity());
	        
	            System.out.println("상품 : " + orDTO.getProductNo() + ", 수량 : " + orDTO.getQuantity());
	        }
	        
	        List<OrderProductDTO> orderProductList = orderService.getProductInfo(requestsInfo);
	        
	        for (OrderProductDTO orderProduct : orderProductList) {
	        	System.out.println(orderProduct.toString());
	        }
	        
	    	// 바인딩한 productNo로 상품 정보 조회
	 		// 상품이름, 상품가격, 상품이미지, 상품할인정보
	        redirectAttributes.addFlashAttribute("orderProductList", orderProductList);
	 		
	 		if (loginMember != null) { // 로그인 했는지 안했는지 구분
	 			System.out.println("order 로그인 상태, 회원 id : " + loginMember.getMember_id());
	 			String memberId = loginMember.getMember_id();
	 			// 로그인 했을 경우 회원아이디로 주문자 정보 조회
	 			OrderMemberDTO orderMember = orderService.getMemberInfo(memberId);
	 			System.out.println(orderMember.toString());
	 			redirectAttributes.addFlashAttribute("orderMember", orderMember);
	 		} else {
	 			// TODO : 로그인하지 않았을 때 비회원의 ID를 알아야 함
	 			System.out.println("order 로그인 하지 않음");
	 		}
	 		
	    } catch (IOException e) {
	        e.printStackTrace();
	    }
        
        
 		return "redirect:/order";
    }
	
	// 사용자가 설정한 데이터를 가지고 주문 테이블 튜플 생성
	@PostMapping("/orderProducts")
	public ResponseEntity<Map<String, String>> processPayment(@RequestBody PaymentRequestDTO paymentRequest, HttpSession session) {
	
		if (!paymentRequest.getSaveDeliveryType().equals("none")) {
		
			DeliveryVO deliveryVO = DeliveryVO.builder()
											  .deliveryAddress(paymentRequest.getDeliveryAddress())
											  .deliveryName(paymentRequest.getDeliveryName())
											  .memberId(paymentRequest.getOrdererId())
											  .isMain("M")
											  .build();
		
			if (paymentRequest.getSaveDeliveryType().contains("saveDelivery")) {
				// 배송지 저장
				System.out.println("배송지 저장 탭임");
				System.out.println(deliveryVO.toString());
		
				try {
					memberService.saveDelivery(deliveryVO);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		
			if (paymentRequest.getSaveDeliveryType().contains("saveAddress")) {
				// 회원 정보 주소 수정
				System.out.println("회원 주소 정보 수정 탭임");
				System.out.println(deliveryVO.toString());
		
				try {
					if (memberService.updateAddress(deliveryVO)) {
						System.out.println("회원 정보 수정 완료");
					} else {
						System.out.println("수정 안됨");
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
	
		} else {
			System.out.println("동작하면 안돼.");
		}
	
		// paymentRequest 객체를 사용하여 결제 처리 로직을 구현
		System.out.println("payment request : " + paymentRequest);
		Map<String, String> resultMap = new HashMap<>();
			try {
	        	boolean isMember = session.getAttribute("loginMember") == null ? false : true; // 로그인 여부로 회원, 비회원 여부 알아내기
				session.setAttribute("orderId", orderService.makeOrder(paymentRequest, isMember)); // 비회원은 orderId가 "non_member"이다.
				String orderId = (String) session.getAttribute("orderId");
				System.out.println("세션에 저장된 orderId : " + orderId);
				if (isMember == false) {
					orderService.makeGuest(paymentRequest, orderId);
				}
				resultMap.put("result", "success");
				resultMap.put("message", "Payment processed successfully");
				resultMap.put("orderId", orderId);
				resultMap.put("totalPrice", String.valueOf(orderService.getExpectedTotalPrice(orderId)));
				return ResponseEntity.ok(resultMap);
			} catch (Exception e) {
				e.printStackTrace();
				resultMap.put("result", "fail");
				resultMap.put("message", "주문 생성 실패");
				return ResponseEntity.badRequest().body(resultMap);
		}        
	}
	
	@PostMapping("/getDeliveryList")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> getDeliveryList(@RequestParam("memberId") String memberId) {
		List<DeliveryDTO> deliveryList = null;
	
		try {
			deliveryList = memberService.getDeliveryList(memberId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		Map<String, Object> response = new HashMap<>();
		response.put("status", "success");
		response.put("deliveryList", deliveryList);
		
		return ResponseEntity.ok(response);
	}
	
	
	@PostMapping("getCouponList")
	@ResponseBody
	public ResponseEntity<Map<String, Object>> getCouponList(@RequestParam("memberId") String memberId) {
		List<UseCouponDTO> couponList = null;
		LocalDateTime now = LocalDateTime.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
		String currentTime = now.format(formatter);
		
		try {
			couponList = memberService.getCouponList(memberId, currentTime);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		Map<String, Object> response = new HashMap<>();
		response.put("status", "success");
		response.put("couponList", couponList);
		
		return ResponseEntity.ok(response);
	}

	// 테스트용, 배포 환경에서는 사용되면 안됨
	@PostMapping("/payment/test/saveOrderId")
	public void saveOrderIdToSession(@RequestParam("orderId") String orderId, HttpSession session) {
		System.out.println("orderId " + orderId + " 가 서버 세션에 저장됨");
		session.setAttribute("orderId", orderId);
	}
	
	// deprecated : /orderProducts에서 예상금액 칼럼을 채워넣음
	@PostMapping("/payment/saveExpectedTotalPrice")
	public ResponseEntity<Map<String, String>> saveAmount(
			@RequestParam("value") int amount,
			HttpSession session
			) {
		System.out.println("서버에 저장될 예상 결제 금액 : " + amount);
		String orderId = (String) session.getAttribute("orderId");
		Map<String, String> resultMap = new HashMap<>();
		try {
			orderService.saveExpectedTotalPrice(amount, orderId);
			resultMap.put("orderId", orderId);
			resultMap.put("result", "success");
			return new ResponseEntity<Map<String, String>>(resultMap, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			orderService.deleteOrder(orderId); // orders 테이블에서 행 삭제
			resultMap.put("result", "fail");
			return new ResponseEntity<Map<String, String>>(resultMap, HttpStatus.BAD_REQUEST);
		}
	}
	
	// NOTE : 결제가 성공하면 토스 결제 모듈이 쿼리스트링을 달고 페이지로 보낸다. 
	// 보내주는 페이지의 주소는 자바스크립트에서 successUrl: window.location.origin + "/payment/success.html" 이런 식으로 설정할 수 있다.
	@GetMapping("/payment/success")
	public String payAuthSuccess(
			@RequestParam("orderId") String orderId,
			@RequestParam("paymentKey") String paymentKey,
			@RequestParam("amount") int amount,
			Model model,
			HttpSession session
			) {
		// 예시 : http://localhost:8080/user/payment/success.html?orderId=MC4wODExNjkzNzY1NTg1&paymentKey=tviva20241016183611gDY62&amount=10
		System.out.println("결제 인증 성공");
		System.out.println("클라이언트에서 결제 금액을 조작했는 지 확인");
		// NOTE : DB 조작이 일어나지만 select문이므로 트랜잭션 처리하지 않았음. 예외 발생 시 함수가 중지됨.
		int savedPrice = orderService.getExpectedTotalPrice(orderId);
		int queryPrice = amount;
		System.out.println("savedPrice : " + savedPrice);
		System.out.println("queryPrice : " + amount);
		if (savedPrice != amount) {
			model.addAttribute("message", "결제 금액 조작의 위험이 발견되었습니다. 다시 한번 결제를 시도해주세요.");
			orderService.deleteOrder(orderId); // orders 테이블에서 행 삭제
			// TODO : 지금 로그인한 유저의 orderId로 orders 테이블 삭제하기, orderProducts의 테이블의 행들도 삭제하기
			// (입력단에서 다시 테이블 삽입시켜야 함.)
			// (입력단에서 테이블 삽입할 때 기존 아이디로 orders 테이블에 뭔가 있다면 삭제하고 다시 넣는 처리가 필요할 듯)
			// TODO : 실패 페이지 깔끔하게 다시 만들어야 함
			return "/user/pages/order/temp_02";
		} else {
			System.out.println("결제 금액 조작 체크 통과");
		}
		
		// paymentKey는 토스페이먼츠에서 각 주문에 발급하는 고유 키 값이에요. 결제 승인, 취소, 조회 등에 사용되기 때문에 꼭 저장해주세요.
		System.out.println("orderId : " + orderId);
		System.out.println("paymentKey : " + paymentKey);
		System.out.println("amount : " + amount);
		// paymentKey를 DB에 저장(결제취소 등에 쓰임)
		// NOTE : 트랜잭션 처리 되므로 예외 발생시 결제 키 update가 취소되고 함수가 중지됨.
		try {
			orderService.setPaymentModuleKey(orderId, paymentKey);
		} catch (Exception e) {
			model.addAttribute("message", "잘못된 요청입니다. 다시 한번 시도해주세요.");
			orderService.deleteOrder(orderId);
			// TODO : 실패 페이지 깔끔하게 다시 만들어야 함
			return "/user/pages/order/temp_02";
		}
		
		// TODO : 이 아래의 부분은 트랜잭션 처리해야 함. 
		// NOTE : 오류가 발생 시 현재 로그인된 멤버의 orders 테이블 행을 삭제한다. 
		// 그리고 뷰에서 결제하기 버튼을 누르면 orders 테이블 행을 처음부터 다시 만들어서 삽입한다.
		// TODO : 시크릿 키, github나 클라이언트에 노출되면 안됨. 시크릿 키를 별도의 파일에 넣어서 관리할 것		
		
		try {
			String secretKey = "test_sk_ma60RZblrq7opZYeabb63wzYWBn1";
			// 시크릿 키 인코딩
			String encodedSecretKey = Base64.getEncoder().encodeToString((secretKey + ":").getBytes());
			Map<String, String> result;
			// 토스 서버에 결제승인 요청 보냄
			result = orderService.requestApproval(encodedSecretKey, paymentKey, amount, orderId);
			String response = result.get("response");
			// 응답 JSON문자열을 자바 맵으로 파싱
			Map<String, Object> responseMap = gson.fromJson(response, Map.class);
			int responseCode = Integer.valueOf(result.get("httpResponseCode"));
			// TODO : 결제 끝나고 이동하는 페이지 깔끔하게 다시 만들어야 함.
			System.out.println("토스서버의 결제승인응답 : " + result);
			if (responseCode == HttpURLConnection.HTTP_OK) {
				System.out.println("결제방법 : " + responseMap.get("method").toString());
				// DB에 업데이트, 트랜잭션 처리됨.
				orderService.makePayment(
						orderId,
						(int) Float.parseFloat(responseMap.get("totalAmount").toString()),
						"T",
						responseMap.get("method").toString(),
						session
					);
				return "/user/pages/order/temp_01"; // 결제 성공
			}
		} catch (Exception e) {
			e.printStackTrace();
			orderService.deleteOrder(orderId); // orders 테이블에서 행 삭제
			return "/user/pages/order/temp_02"; // 결제 실패
		}
		return "/user/pages/order/temp_02"; // 결제 실패
	}
	
	@GetMapping("/approveNaverPay")
	public String approveNaverPay(
			@RequestParam("resultCode") String resultCode,
			@RequestParam("paymentId") String paymentId,
			@RequestParam(value = "resultMessage", required = false) String resultMessage, // resultCode가 Success이면 reaultMessage가 안옴
			HttpSession session
			) {
		System.out.println("네이버페이 resultCode : " + resultCode);
		if (!resultCode.equals("Success")) {
			return "/user/pages/order/temp_02"; // 결제 실패
		}
		
		String orderId = (String) session.getAttribute("orderId");
		try {
			// 트랜잭션 처리
			orderService.setPaymentModuleKey(orderId, paymentId);
			orderService.makePayment(
					orderId,
					orderService.getExpectedTotalPrice(orderId),
					"N", // 네이버페이
					null, 
					session
				);
			return "/user/pages/order/temp_01"; // 결제 성공
		} catch (Exception e) {
			e.printStackTrace();
			orderService.deleteOrder(orderId); // orders 테이블에서 행 삭제
			return "/user/pages/order/temp_02"; // 결제 실패
		}
	}
	
	// 레퍼런스 : https://velog.io/@ryuneng2/%EC%B9%B4%EC%B9%B4%EC%98%A4%ED%8E%98%EC%9D%B4-API-%EC%97%B0%EB%8F%99-%ED%8C%9D%EC%97%85%EC%B0%BD%EB%9D%84%EC%9A%B0%EA%B8%B0-%EA%B2%B0%EC%A0%9C%EC%8A%B9%EC%9D%B8-%EA%B5%AC%ED%98%84
	@PostMapping("/kakaoPay/ready")
	public ResponseEntity<Map<String, String>> readyKakaoPay(
			@RequestParam("amount") int amount,
			HttpServletRequest request,
			HttpSession session
	) {
		System.out.println("카카오페이 결제창 요청");
		// TODO : 주문의 상품들 이름 요약해서 (예 : 티셔츠 외) 받기
		Map<String, String> responseMap = orderService.readyKakaoPay("목걸이 외", amount, request);
		String jsonString = responseMap.get("response");
		Gson gson = new Gson();
		Map<String, Object> jsonMap = gson.fromJson(jsonString, Map.class);
		// NOTE : 무조건 PC로부터 사이트를 접속한다고 가정
		String paymentURL = (String) jsonMap.get("next_redirect_pc_url");
		// 카카오페이 개발자센터 예제 코드 참조 : https://developers.kakaopay.com/docs/payment/online/reference#sample-source
		System.out.println("paymentURL : " + paymentURL);
		String tid = (String) jsonMap.get("tid"); // tid는 카카오페이가 발급하는 고유 주문번호이다.
		System.out.println("tid : " + tid);
		String orderId = (String) session.getAttribute("orderId");
		try {
			orderService.setPaymentModuleKey(orderId, tid);
			Map<String, String> outputResponseMap = new HashMap<>();
			outputResponseMap.put("result", "success");
			outputResponseMap.put("paymentURL", paymentURL);
			outputResponseMap.put("tid", tid);
			return new ResponseEntity<Map<String, String>>(outputResponseMap, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
			orderService.deleteOrder(orderId); // orders 테이블에서 행 삭제
			Map<String, String> outputResponseMap = new HashMap<>();
			outputResponseMap.put("result", "fail");
			return new ResponseEntity<Map<String, String>>(outputResponseMap, HttpStatus.BAD_REQUEST);
		}
	}
	
	// NOTE : ajax로 "/user/kakaoPay/ready" 요청을 보내기 때문에 pc_kakaopay_ready.jsp를 바로 못 보여준다. 따라서 이 방법을 썼다.
	// TODO : 이 메소드 삭제해도 될 듯
	@GetMapping("/pc_kakaopay_ready")
	public String showKakaoPayReadyPage() {
		return "/user/pages/order/pc_kakaopay_ready"; // TODO 쿼리스트링으로 URL 붙이면 될 듯?
	}
	
	@GetMapping("/kakaopay_payRequest")
	public String showKakaoPayApprovalPage(
			@RequestParam("pg_token") String pg_token,
			HttpSession session,
			Model model
			) {
		String orderId = (String) session.getAttribute("orderId");
		model.addAttribute("pg_token", pg_token);		
		model.addAttribute("tid", orderService.getPaymentModuleKey(orderId));
		return "/user/pages/order/kakaopay_payRequest"; // jsp 페이지 보여줌
	}
	
	@PostMapping("/kakaopay_payRequest")
	public ResponseEntity<Map<String, String>> payRequestForKakaopay(
			@RequestBody Map<String, Object> requestData,
			HttpSession session
			) {
		System.out.println("payRequestForKakaopay에서 requestData : " + requestData);
		
		// 카카오서버에 결제 승인 요청
		Map<String, String> responseMap = 
			orderService.requestApprovalKakaopayPayment(
				(String) requestData.get("tid"), 
				(String) requestData.get("pg_token")
			);
		Map<String, String> outputResponseMap = new HashMap<>();
		String orderId = (String) session.getAttribute("orderId");

		if (responseMap.get("httpResponseCode").equals("200")) {
			try {
				orderService.makePayment(
						orderId,
						orderService.getExpectedTotalPrice(orderId),
						"K", // 카카오페이
						null, 
						session
					);
				outputResponseMap.put("result", "success");
				return new ResponseEntity<Map<String, String>>(outputResponseMap, HttpStatus.OK);
			} catch (Exception e) {
				e.printStackTrace();
				outputResponseMap.put("result", "fail");
				orderService.deleteOrder(orderId); // orders 테이블에서 행 삭제
				return new ResponseEntity<Map<String, String>>(outputResponseMap, HttpStatus.BAD_REQUEST);
			}
		} else {
			outputResponseMap.put("result", "fail");
			orderService.deleteOrder(orderId); // orders 테이블에서 행 삭제
			return new ResponseEntity<Map<String, String>>(outputResponseMap, HttpStatus.BAD_REQUEST);
		}
	}
	
	// 임시 성공 페이지
	@GetMapping("/pages/order/temp_01")
	public String showSuccessPage() {
		return "/user/pages/order/temp_01";
	}
	
	// 임시 실패 페이지
	@GetMapping("/pages/order/temp_02")
	public String showFailPage() {
		return "/user/pages/order/temp_02";
	}
	
	// 임시 취소 페이지
	@GetMapping("/pages/order/temp_03")
	public String showCancelPage() {
		return "/user/pages/order/temp_03";
	}
	
	@GetMapping("/orderList")
	public String showOrderListPage() {
		return "/user/pages/order/orderList";
	}
	
	@GetMapping("/cancelOrder")
	public String cancelOrder(@RequestParam int orderNo, Model model) {
		System.out.println("주문취소(or 반품/환불) 페이지 접속");
		System.out.println("주문번호는 " + orderNo);
		model.addAttribute("orderNo", orderNo);
		return "/user/pages/order/cancelOrder";
	}
	
	// 회원의 모든 주문과 주문마다의 상품을 반환
	@GetMapping("/orderProducts")
	@ResponseBody
	public List<OrderProductsDTO> getOrderProducts(
			@RequestParam("memberId") String memberId) {
		return orderService.getOrderListOfMember(memberId);
	}
	
	
	@GetMapping("/cancelAPItest")
	public String cancelAPItest() {
		return "/user/pages/order/cancelAPItest";
	}
	
	@GetMapping("/getLoginedId")
	@ResponseBody
	public String getLoginedId(HttpSession session) {
		LoginDTO loginDTO = (LoginDTO) session.getAttribute("loginMember");
		return loginDTO.getMember_id();
	}
	
//	@GetMapping("/cancelAPItest/")
//	public String cancelAPItest() {
//		return "/user/pages/order/cancelAPItest";
//	}
	
}
