package com.finalProject.controller.order;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.finalProject.service.order.OrderService;
import com.google.gson.Gson;

@Controller
public class OrderController {
	@Inject
	private OrderService orderService;
	
	@GetMapping("/order")
	public String order() {
		System.out.println("주문 페이지 접속");
		return "/user/pages/order/order";
	}
	
	@PostMapping("/payment/preventHack")
	public ResponseEntity<Map<String, String>> saveAmount(
			@RequestParam("value") int amount
			) {
		System.out.println("서버에 저장될 예상 결제 금액 : " + amount);
		Map<String, String> resultMap = new HashMap<>();
		try {
			String orderId = orderService.saveExpectedTotalPrice(amount);
			resultMap.put("orderId", orderId);
			resultMap.put("result", "success");
			return new ResponseEntity<Map<String, String>>(resultMap, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
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
			Model model
			) {
		// 예시 : http://localhost:8080/user/payment/success.html?orderId=MC4wODExNjkzNzY1NTg1&paymentKey=tviva20241016183611gDY62&amount=10
		System.out.println("결제 인증 성공");
		// TODO : 쿼리 파라미터의 amount 값과 requestPayment()의 amount 파라미터 값이 같은지 반드시 확인함.
		// 클라이언트에서 결제 금액을 조작하는 행위를 방지할 수 있습니다. 만약 값이 다르다면 결제를 취소하고 구매자에게 알려주세요.
		System.out.println("클라이언트에서 결제 금액을 조작했는 지 확인");
		int savedPrice = orderService.getExpectedTotalPrice(orderId);
		int queryPrice = amount;
		if (savedPrice != amount) {
			model.addAttribute("message", "결제 금액 조작의 위험이 발견되었습니다. 다시 한번 결제를 시도해주세요.");
			// TODO : 지금 로그인한 유저의 orderId로 orders 테이블 삭제하기, orderProducts의 테이블의 행들도 삭제하기
			// (입력단에서 다시 테이블 삽입시켜야 함.)
			// (입력단에서 테이블 삽입할 때 기존 아이디로 orders 테이블에 뭔가 있다면 삭제하고 다시 넣는 처리가 필요할 듯)
			return "/user/pages/order/temp_02";
		} else {
			System.out.println("결제 금액 조작 체크 통과");
		}
		// TODO : 서버에 paymentKey, amount, orderId 값을 저장하세요. 
		// paymentKey는 토스페이먼츠에서 각 주문에 발급하는 고유 키 값이에요. 결제 승인, 취소, 조회 등에 사용되기 때문에 꼭 저장해주세요.
		// TODO : paymentKey는 DB에 넣자. 세션이 종료되도 나중에 언제든지 결제 취소를 할 수 있기 때문에 DB에 저장해야 한다.
		System.out.println("orderId : " + orderId);
		System.out.println("paymentKey : " + paymentKey);
		System.out.println("amount : " + amount);
		
		// 시크릿 키, github나 클라이언트에 노출되면 안됨
		// TODO : 시크릿 키를 별도의 파일에 넣어서 관리할 것
		String secretKey = "test_sk_ma60RZblrq7opZYeabb63wzYWBn1";
		
		// 시크릿 키 인코딩
		String encodedSecretKey = Base64.getEncoder().encodeToString((secretKey + ":").getBytes());
		
		Map<String, String> result;
		result = orderService.requestApproval(encodedSecretKey, paymentKey, amount, orderId);
		// working...
		// result = approvePay(encodedSecretKey, paymentKey, amount, orderId);
		String response = result.get("response");
		int responseCode = Integer.valueOf(result.get("httpResponseCode"));
		// TODO : 결제 끝나고 이동하는 페이지 재지정할 듯
		System.out.println("응답 : " + result);
		if (responseCode != HttpURLConnection.HTTP_OK) {
			return "/user/pages/order/temp_02"; // 결제 실패
		}
		return "/user/pages/order/temp_01"; // 결제 성공
	}
	
	@GetMapping("/approveNaverPay")
	public String approveNaverPay(
			@RequestParam("resultCode") String resultCode,
			@RequestParam("paymentId") String paymentId,
			@RequestParam(value = "resultMessage", required = false) String resultMessage // resultCode가 Success이면 reaultMessage가 안옴
			) {
		System.out.println("네이버페이 resultCode : " + resultCode);
		if (resultCode.equals("Success")) {
			return "/user/pages/order/temp_01"; // 결제 성공
		} else {
			// 결제 실패시
			return "/user/pages/order/temp_02"; // 결제 실패
		}
	}
	
	// 레퍼런스 : https://velog.io/@ryuneng2/%EC%B9%B4%EC%B9%B4%EC%98%A4%ED%8E%98%EC%9D%B4-API-%EC%97%B0%EB%8F%99-%ED%8C%9D%EC%97%85%EC%B0%BD%EB%9D%84%EC%9A%B0%EA%B8%B0-%EA%B2%B0%EC%A0%9C%EC%8A%B9%EC%9D%B8-%EA%B5%AC%ED%98%84
	@PostMapping("/kakaoPay/ready")
	public ResponseEntity<Map<String, String>> readyKakaoPay(
			@RequestParam("orderId") String orderId,
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
		// *****TODO : 중요!! tid를 DB에다가 넣어야 함. 지금은 그냥 세션에 넣는데 나중에 결제 취소하려면 주문마다 았는 tid로 취소해야 함.
		session.setAttribute("tid", tid);
		
		Map<String, String> outputResponseMap = new HashMap<>();
		outputResponseMap.put("paymentURL", paymentURL);
		outputResponseMap.put("tid", tid);
		
		return new ResponseEntity<Map<String, String>>(outputResponseMap, HttpStatus.OK);
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
		model.addAttribute("pg_token", pg_token);
		// TODO ; 지금은 세션에 tid가 있지만 DB에서 조회하도록 바꿔야 함
		model.addAttribute("tid", session.getAttribute("tid"));
		return "/user/pages/order/kakaopay_payRequest"; // jsp 페이지 보여줌
	}
	
	@PostMapping("/kakaopay_payRequest")
	public ResponseEntity<Map<String, String>> payRequestForKakaopay(
			@RequestBody Map<String, Object> requestData
			) {
		System.out.println("payRequestForKakaopay에서 requestData : " + requestData);
		
		// 카카오서버에 결제 승인 요청
		Map<String, String> responseMap = 
			orderService.requestApprovalKakaopayPayment(
				(String) requestData.get("tid"), 
				(String) requestData.get("pg_token")
			);
		
		Map<String, String> outputResponseMap = new HashMap<>();
		
		
		if (responseMap.get("httpResponseCode").equals("200")) {
			outputResponseMap.put("result", "success");
			return new ResponseEntity<Map<String, String>>(outputResponseMap, HttpStatus.OK);
		} else {
			outputResponseMap.put("result", "fail");
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
	
	@PostMapping("/cancelOrder")
	public String cancelOrder(@RequestParam int orderNo, Model model) {
		System.out.println("주문취소(or 반품/환불) 페이지 접속");
		System.out.println("주문번호는 " + orderNo);
		model.addAttribute("orderNo", orderNo);
		return "/user/pages/order/cancelOrder";
	}
}
