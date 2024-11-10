package com.finalProject.service.order;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Timestamp;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.finalProject.model.order.CancelOrderRequestDTO;
import com.finalProject.model.order.OrderMemberDTO;
import com.finalProject.model.order.OrderProductDTO;
import com.finalProject.model.order.OrderProductsDTO;
import com.finalProject.model.order.OrderRequestDTO;
import com.finalProject.model.order.PaymentRequestDTO;
import com.finalProject.model.order.ProductDiscountCalculatedDTO;
import com.finalProject.model.order.ProductDiscountDTO;
import com.finalProject.persistence.order.OrderDAO;

@Service
public class OrderServiceImpl implements OrderService {
	@Inject
	private OrderDAO orderDAO;

	@Override
	public void deleteOrder(String orderId) {
		orderDAO.deleteOrder(orderId);
	}

	@Override
	public Map<String, Object> makeOrder(PaymentRequestDTO request, boolean isMember, HttpSession session)
			throws Exception {
		Map<String, Object> result = new HashMap<>();
		System.out.println("orders 테이블 행 삽입 전 회원/비회원 확인. 회원? : " + isMember);
		String orderId = orderDAO.makeOrder(request, isMember);
		Integer expectedTotalPrice = this.setExpectedPrices(request, orderId, isMember, session);
		result.put("orderId", orderId);
		result.put("expectedTotalPrice", expectedTotalPrice);
		return result;
	}

	// 총 예상결제금액과 상품별 금액, 상품별 포인트를 설정한다.
	private int setExpectedPrices(PaymentRequestDTO request, String orderId, boolean isMember, HttpSession session)
			throws Exception {
		int expectedTotalPrice = 0;
		List<ProductDiscountDTO> discountInfo = orderDAO.getDiscountInfoByProduct(orderId, session);
		List<ProductDiscountCalculatedDTO> productDiscountCalculated = new ArrayList<>();

		for (int i = 0; i < request.getProductsInfo().size(); i++) {
			productDiscountCalculated.add(new ProductDiscountCalculatedDTO().builder()
					.orderproduct_no(discountInfo.get(i).getOrderproduct_no()).build()); // orderProduct_no 설정
			ProductDiscountDTO p = discountInfo.get(i);
			expectedTotalPrice += (p.getProductPrice() * p.getOrderCount() *
			// 총 % 할인 (쿠폰 할인 + 멤버 등급 할인 + 상품 자체 할인)
					(1 - (p.getMultipliedDiscountByCoupon() + p.getMultipliedDiscountByMemberLevel()
							+ p.getDiscountByItem())));
			System.out.println(
					"아이템의 % 할인 : " + p.getProductPrice() * p.getOrderCount() * (p.getMultipliedDiscountByCoupon()
							+ p.getMultipliedDiscountByMemberLevel() + p.getDiscountByItem()));
		}
		// 절대값 할인 (쿠폰 할인 + 포인트 할인)
		expectedTotalPrice -= (discountInfo.get(0).getSumDiscountByCoupon()
				+ discountInfo.get(0).getSumDiscountByPoint());
		System.out.println("절대값 할인 : "
				+ (discountInfo.get(0).getSumDiscountByCoupon() + discountInfo.get(0).getSumDiscountByPoint()));
		// 이 시점에서 expectedTotalPrice는 할인이 모두 적용된 값 (택배값 미포함)

		// 가중치 계산
		int denominator = 0;
		for (ProductDiscountDTO p : discountInfo) {
			denominator += (p.getProductPrice() * p.getOrderCount() * (1 - p.getDiscountByItem()));
		} // 상품 자체 할인이 적용된 금액을 가중치의 분모로 활용
		Iterator<ProductDiscountCalculatedDTO> iter = productDiscountCalculated.iterator();
		for (ProductDiscountDTO p : discountInfo) {
			double weight = (p.getProductPrice() * p.getOrderCount() * (1 - p.getDiscountByItem())) / denominator;
			iter.next().setWeight(weight); // 가중치 설정
		}

		for (int i = 0; i < request.getProductsInfo().size(); i++) {
			if (i == 0) { // 리스트의 첫번째 요소이면
				int remainedPoint = discountInfo.get(i).getSumDiscountByPoint();
				int allocatedPoint = (int) Math.round(productDiscountCalculated.get(i).getWeight() * remainedPoint);
				productDiscountCalculated.get(i).setRemainedPoint(remainedPoint - allocatedPoint);
				productDiscountCalculated.get(i).setRefundPoint(allocatedPoint);
				System.out.println("remainedPoint : " + remainedPoint);
				System.out.println("allocatedPoint : " + allocatedPoint);
			} else if (i != request.getProductsInfo().size() - 1) {
				int remainedPoint = productDiscountCalculated.get(i - 1).getRemainedPoint();
				int allocatedPoint = (int) Math.round(
						productDiscountCalculated.get(i).getWeight() * discountInfo.get(i).getSumDiscountByPoint());
				productDiscountCalculated.get(i).setRemainedPoint(remainedPoint - allocatedPoint);
				productDiscountCalculated.get(i).setRefundPoint(allocatedPoint);
				System.out.println("remainedPoint : " + remainedPoint);
				System.out.println("allocatedPoint : " + allocatedPoint);
			} else { // 리스트의 마지막 요소이면
				int allocatedPoint = productDiscountCalculated.get(i - 1).getRemainedPoint();
				productDiscountCalculated.get(i).setRemainedPoint(0);
				productDiscountCalculated.get(i).setRefundPoint(allocatedPoint);
				System.out.println("allocatedPoint : " + allocatedPoint);
			}
		} // 할당된 포인트의 합이 무조건 discountInfo.get(i).getSumDiscountByPoint()과 같아지게 계산됨

		for (int i = 0; i < request.getProductsInfo().size(); i++) {
			if (i == 0) { // 리스트의 첫번째 요소이면
				int remainedPrice = expectedTotalPrice;
				int allocatedPrice = (int) Math
						.round(productDiscountCalculated.get(i).getWeight() * expectedTotalPrice);
				productDiscountCalculated.get(i).setRemainedPrice(remainedPrice - allocatedPrice);
				productDiscountCalculated.get(i).setRefundPrice(allocatedPrice);
				System.out.println("remainedPrice : " + remainedPrice);
				System.out.println("allocatedPrice : " + allocatedPrice);
			} else if (i != request.getProductsInfo().size() - 1) {
				int remainedPrice = productDiscountCalculated.get(i - 1).getRemainedPrice();
				int allocatedPrice = (int) Math
						.round(productDiscountCalculated.get(i).getWeight() * expectedTotalPrice);
				productDiscountCalculated.get(i).setRemainedPrice(remainedPrice - allocatedPrice);
				productDiscountCalculated.get(i).setRefundPrice(allocatedPrice);
				System.out.println("remainedPrice : " + remainedPrice);
				System.out.println("allocatedPrice : " + allocatedPrice);
			} else { // 리스트의 마지막 요소이면
				int allocatedPrice = productDiscountCalculated.get(i - 1).getRemainedPrice();
				productDiscountCalculated.get(i).setRefundPrice(allocatedPrice);
				productDiscountCalculated.get(i).setRemainedPrice(0);
				System.out.println("allocatedPrice : " + allocatedPrice);
			}
		}

		System.out.println("productDiscountCalculated : " + productDiscountCalculated);
		orderDAO.updateExpectedTotalPriceWithDeliveryCost(orderId, expectedTotalPrice); // 배송비를 더해서 DB에 저장
		orderDAO.updateRefundPriceByProduct(productDiscountCalculated);
		return orderDAO.getExpectedTotalPrice(orderId);
	}

	@Override
	public void makeGuest(PaymentRequestDTO request, String orderId) {
		if (orderDAO.makeGuest(request, orderId) != 1) {
			throw new DataAccessException("비회원 정보 생성 실패") {
			};
		}
	}

	@Override
	@Transactional(rollbackFor = { Exception.class })
	public void makePayment(String orderId, Integer amount, String payModule, String method, HttpSession session)
			throws Exception {
		// NOTE : 이 트랜잭션에서 예외가 발생해도 이미 생성된 orders의 테이블의 행은 삭제되지 않음
		// 그러므로 컨트롤러의 catch 블록에서 orders 테이블의 행을 삭제함
		System.out.println("makePayment 함수 실행, method 매개변수 : " + method);

		boolean isMember = session.getAttribute("loginMember") == null ? false : true;

		if (isMember == true) {
			// 유저정보 업데이트 : 쿠폰 사용, 포인트 적립, 회원등급 수정
			// 쿠폰 사용
			if (orderDAO.useCoupon(orderId) != 1) {
				throw new DataAccessException("쿠폰 사용 실패") {
				};
			}
			;
			// 포인트 적립
			if (orderDAO.updatePoint(orderId) != true) {
				throw new DataAccessException("포인트 적립 실패") {
				};
			}
			;
			// 회원등급 수정
			if (orderDAO.updateUserLevel(orderId) != true) {
				throw new DataAccessException("회원등급 수정 실패") {
				};
			}
			;
		}

		if (orderDAO.insertPaymentInfo(orderId, amount, payModule, method) != true) {
			throw new DataAccessException("결제 정보 생성 실패") {
			};
		}

		orderDAO.updateOrderStatus(method, orderId);

		// TODO : 장바구니에서 결제한 물품 삭제
	}

	@Override
	@Transactional(rollbackFor = { Exception.class })
	public void setPaymentModuleKey(String orderId, String key) throws Exception {
		if (orderDAO.setPaymentModuleKey(orderId, key) != 1) {
			throw new DataAccessException("DB 조작 실패") {
			};
		}
	}

	@Override
	public String getPaymentModuleKey(String orderId) {
		return orderDAO.getPaymentModuleKey(orderId);
	}

	@Override
	public int getExpectedTotalPrice(String orderId) {
		return orderDAO.getExpectedTotalPrice(orderId);
	}

	@Override
	public List<OrderProductDTO> getProductInfo(List<OrderRequestDTO> requestsInfo) {

		return orderDAO.selectProductInfo(requestsInfo);
	}

	@Override
	public OrderMemberDTO getMemberInfo(String memberId) {

		return orderDAO.selectMemberInfo(memberId);
	}

	// 레퍼런스 : https://akku-dev.tistory.com/2
	// 토스에서 예제코드로 쓰는 HttpClient는 java11 버전부터 사용가능하다.
	// java8은 HttpURLConnection을 쓰거나 Apache HttpClient, okHttp등의 외부 라이브러리를 사용할 수 있다.
	// 여기서는 라이브러리 사용 안하고 HttpURLConnection를 쓰겠다.
	@Override
	public Map<String, String> requestApproval(String base64SecretKey, String paymentKey, int amount, String orderId) {
		Map<String, String> resultMap = new HashMap<>();

		try {
			// Create a URL object for the desired URL
			URL url = new URL("https://api.tosspayments.com/v1/payments/confirm");
			// Open a connection to the URL using the HttpURLConnection class
			HttpURLConnection connection = (HttpURLConnection) url.openConnection();
			// Set the request method to GET
			connection.setRequestMethod("POST");
			// Add any headers you want to send with the request
			connection.setRequestProperty("Authorization", "Basic " + base64SecretKey);
			connection.setRequestProperty("Content-Type", "application/json");
			// OutputStream으로 POST 데이터를 넘겨주겠다는 옵션.
			connection.setDoOutput(true);
			// InputStream으로 서버로 부터 응답을 받겠다는 옵션.
			connection.setDoInput(true);
			// Connect to the server
			connection.connect();
			// Make JsonInputString
			String jsonInputString = String.format("{\"paymentKey\":\"%s\",\"amount\":%d,\"orderId\":\"%s\"}",
					paymentKey, amount, orderId);
			System.out.println("결제 승인 API 요청에 들어갈 json : " + jsonInputString);
			OutputStream os = connection.getOutputStream();
			byte[] input = jsonInputString.getBytes();
			os.write(input, 0, input.length);

			// 응답 코드 확인
			int responseCode = connection.getResponseCode();
			resultMap.put("httpResponseCode", String.valueOf(responseCode));
			StringBuilder response = new StringBuilder();
			if (responseCode == HttpURLConnection.HTTP_OK) {
				// Read the response from the server
				BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
				String line;
				while ((line = reader.readLine()) != null) {
					response.append(line);
				}
				reader.close();
			} else {
				// 서버로부터 에러 읽기
				BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getErrorStream(), "utf-8"));
				String line;
				while ((line = reader.readLine()) != null) {
					response.append(line.trim());
				}
				reader.close();
			}
			// 응답 결과
			System.out.println("응답 결과 : " + response.toString());
			// TODO : 무통장입금으로 결제방법을 지정하면 응답에
			// "virtualAccount": {
			// "accountNumber": "X5909014050733",
			// "accountType": "일반",
			// "bankCode": "06",
			// "customerName": "dsfsdf",
			// "dueDate": "2024-10-26T15:59:03+09:00",
			// "expired": false,
			// "settlementStatus": "INCOMPLETED",
			// "refundStatus": "NONE",
			// "refundReceiveAccount": null
			// },
			// 이런 데이터가 포함된다. bankCode마다 은행종류 잇으니까 은행 종류하고 입금할 가상계좌번호 결제 완료 뷰페이지에 표시해야 함
			// Disconnect from the server
			connection.disconnect();
			resultMap.put("response", response.toString());
		} catch (IOException e) {
			System.out.println("결제 승인 실패");
			e.printStackTrace();
		}
		return resultMap;
	}

	@Override
	public Map<String, String> requestApprovalNaverpayPayment(String paymentId) {
		Map<String, String> resultMap = new HashMap<>();
		try {
			// Create a URL object for the desired URL
			URL url = new URL("https://dev.apis.naver.com/naverpay-partner/naverpay/payments/v2.2/apply/payment");
			// Open a connection to the URL using the HttpURLConnection class
			HttpURLConnection connection = (HttpURLConnection) url.openConnection();
			// Set the request method to GET
			connection.setRequestMethod("POST");
			// Add any headers you want to send with the request
			// TODO : 내 네이버페이 키는 별도의 파일에 보관 요망
			connection.setRequestProperty("X-Naver-Client-Id", "HN3GGCMDdTgGUfl0kFCo");
			connection.setRequestProperty("X-Naver-Client-Secret", "ftZjkkRNMR");
			connection.setRequestProperty("X-NaverPay-Chain-Id", "S2VnY2NSaHlhb3V");
			connection.setRequestProperty("X-NaverPay-Idempotency-Key", UUID.randomUUID().toString());
			connection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
			connection.setDoOutput(true);
			connection.setDoInput(true);
			// Connect to the server
			connection.connect();

			String postParams = "paymentId=" + paymentId;
			OutputStream os = connection.getOutputStream();
			byte[] input = postParams.getBytes();
			os.write(input, 0, input.length);

			// 응답 코드 확인
			int responseCode = connection.getResponseCode();
			resultMap.put("httpResponseCode", String.valueOf(responseCode));
			StringBuilder response = new StringBuilder();
			if (responseCode == HttpURLConnection.HTTP_OK) {
				// Read the response from the server
				BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
				String line;
				while ((line = reader.readLine()) != null) {
					response.append(line);
				}
				reader.close();
			} else {
				// 서버로부터 에러 읽기
				BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getErrorStream(), "utf-8"));
				String line;
				while ((line = reader.readLine()) != null) {
					response.append(line.trim());
				}
				reader.close();
			}
			// 응답 결과
			System.out.println("응답 결과 : " + response.toString());
			// Disconnect from the server
			connection.disconnect();
			resultMap.put("response", response.toString());
		} catch (IOException e) {
			System.out.println("네이버페이 결제 준비 실패");
			e.printStackTrace();
		}
		return resultMap;
	}

	@Override
	public Map<String, String> requestApprovalNaverpayCancel(String paymentId, String cancelReason,
			Integer cancelAmount) {
		Map<String, String> resultMap = new HashMap<>();
		try {
			// Create a URL object for the desired URL
			URL url = new URL("https://dev.apis.naver.com/naverpay-partner/naverpay/payments/v1/cancel");
			// Open a connection to the URL using the HttpURLConnection class
			HttpURLConnection connection = (HttpURLConnection) url.openConnection();
			// Set the request method to GET
			connection.setRequestMethod("POST");
			// Add any headers you want to send with the request
			// TODO : 내 네이버페이 키는 별도의 파일에 보관 요망
			connection.setRequestProperty("X-Naver-Client-Id", "HN3GGCMDdTgGUfl0kFCo");
			connection.setRequestProperty("X-Naver-Client-Secret", "ftZjkkRNMR");
			connection.setRequestProperty("X-NaverPay-Chain-Id", "S2VnY2NSaHlhb3V");
			connection.setRequestProperty("X-NaverPay-Idempotency-Key", UUID.randomUUID().toString());
			connection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
			connection.setDoOutput(true);
			connection.setDoInput(true);
			// Connect to the server
			connection.connect();

			String postParams = String.format(
					"paymentId=%s&cancelAmount=%d&taxScopeAmount=%d&taxExScopeAmount=%d&cancelReason=%s&cancelRequester=%s",
					paymentId, cancelAmount, cancelAmount, 0, cancelReason, "2" // 가맹점 관리자
			);
			OutputStream os = connection.getOutputStream();
			byte[] input = postParams.getBytes();
			os.write(input, 0, input.length);

			// 응답 코드 확인
			int responseCode = connection.getResponseCode();
			resultMap.put("httpResponseCode", String.valueOf(responseCode));
			StringBuilder response = new StringBuilder();
			if (responseCode == HttpURLConnection.HTTP_OK) {
				// Read the response from the server
				BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
				String line;
				while ((line = reader.readLine()) != null) {
					response.append(line);
				}
				reader.close();
			} else {
				// 서버로부터 에러 읽기
				BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getErrorStream(), "utf-8"));
				String line;
				while ((line = reader.readLine()) != null) {
					response.append(line.trim());
				}
				reader.close();
			}
			// 응답 결과
			System.out.println("응답 결과 : " + response.toString());
			// Disconnect from the server
			connection.disconnect();
			resultMap.put("response", response.toString());
		} catch (IOException e) {
			System.out.println("네이버페이 결제 취소 실패");
			e.printStackTrace();
		}
		return resultMap;
	}

	@Override
	public Map<String, String> requestApprovalKakaopayCancel(String paymentId, String cancelReason,
			Integer cancelAmount) {
		Map<String, String> resultMap = new HashMap<>();
		try {
			// Create a URL object for the desired URL
			URL url = new URL("https://open-api.kakaopay.com/online/v1/payment/cancel");
			// Open a connection to the URL using the HttpURLConnection class
			HttpURLConnection connection = (HttpURLConnection) url.openConnection();
			// Set the request method to GET
			connection.setRequestMethod("POST");
			// Add any headers you want to send with the request
			// TODO : 내 네이버페이 키는 별도의 파일에 보관 요망
			connection.setRequestProperty("Authorization", "SECRET_KEY DEV13F237E02B1F92076F010653B0F0AFFB6B814");
			connection.setRequestProperty("Content-Type", "application/json");
			connection.setDoOutput(true);
			connection.setDoInput(true);
			// Connect to the server
			connection.connect();

		    ObjectMapper mapper = new ObjectMapper();
		    ObjectNode json = mapper.createObjectNode();
		    json.put("cid", "TC0ONETIME");
		    json.put("tid", paymentId);
		    json.put("cancel_amount", cancelAmount);
		    json.put("cancel_tax_free_amount", 0);
		    json.put("payload", cancelReason);
		    String jsonInputString = mapper.writeValueAsString(json);
		    
//		    String jsonInputString = String.format("{"
//		    		+ "\"cid\": \"TC0ONETIME\","
//		    		+ "\"tid\": \"%s\","
//		    		+ "\"cancel_amount\": %d,"
//		    		+ "\"cancel_tax_free_amount\": 0,"
//		    		+ "\"payload\": \"%s\""
//					+ "}", paymentId, cancelAmount, cancelReason);
		    
		    System.out.println("paymentId : " + paymentId);
		    System.out.println("cancelAmount : " + cancelAmount);
		    System.out.println("cancelReason : " + cancelReason);
		    System.out.println("jsonInputString : " + jsonInputString);

//	          String jsonInputString = String.format("{"
//	                + "\"cid\": \"TC0ONETIME\","
//	                + "\"tid\": \"%s\","
//	                + "\"cancel_amount\": %d,"
//	                + "\"cancel_tax_free_amount\": 0,"
//	                + "\"payload\": \"%s\""
//	               + "}", paymentId, cancelAmount, cancelReason);

			OutputStream os = connection.getOutputStream();
			byte[] input = jsonInputString.getBytes();
			os.write(input, 0, input.length);

			// 응답 코드 확인
			int responseCode = connection.getResponseCode();
			resultMap.put("httpResponseCode", String.valueOf(responseCode));
			StringBuilder response = new StringBuilder();
			if (responseCode == HttpURLConnection.HTTP_OK) {
				// Read the response from the server
				BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
				String line;
				while ((line = reader.readLine()) != null) {
					response.append(line);
				}
				reader.close();
			} else {
				// 서버로부터 에러 읽기
				BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getErrorStream(), "utf-8"));
				String line;
				while ((line = reader.readLine()) != null) {
					response.append(line.trim());
				}
				reader.close();
			}
			// 응답 결과
			System.out.println("응답 결과 : " + response.toString());
			// Disconnect from the server
			connection.disconnect();
			resultMap.put("response", response.toString());
		} catch (IOException e) {
			System.out.println("카카오페이 결제 취소 실패");
			e.printStackTrace();
		}
		return resultMap;
	}

	@Override
	// 레퍼런스 :
	// https://velog.io/@ryuneng2/%EC%B9%B4%EC%B9%B4%EC%98%A4%ED%8E%98%EC%9D%B4-API-%EC%97%B0%EB%8F%99-%ED%8C%9D%EC%97%85%EC%B0%BD%EB%9D%84%EC%9A%B0%EA%B8%B0-%EA%B2%B0%EC%A0%9C%EC%8A%B9%EC%9D%B8-%EA%B5%AC%ED%98%84
	public Map<String, String> readyKakaoPay(String name, int amount, HttpServletRequest request) {
		Map<String, String> resultMap = new HashMap<>();
		String baseUrl = String.format("%s://%s:%d%s", request.getScheme(), // http or https
				request.getServerName(), // localhost or actual server domain
				request.getServerPort(), // 8080 or actual port
				request.getContextPath()); // application context
		System.out.println("baseUrl : " + baseUrl);

		try {
			// Create a URL object for the desired URL
			URL url = new URL("https://open-api.kakaopay.com/online/v1/payment/ready");
			// Open a connection to the URL using the HttpURLConnection class
			HttpURLConnection connection = (HttpURLConnection) url.openConnection();
			// Set the request method to GET
			connection.setRequestMethod("POST");
			// Add any headers you want to send with the request
			// TODO : 내 카카오페이 개발자 시크릿 키이므로 별도의 파일에 보관 요망
			connection.setRequestProperty("Authorization", "SECRET_KEY DEV13F237E02B1F92076F010653B0F0AFFB6B814");
			connection.setRequestProperty("Content-Type", "application/json");
			// OutputStream으로 POST 데이터를 넘겨주겠다는 옵션.
			connection.setDoOutput(true);
			// InputStream으로 서버로 부터 응답을 받겠다는 옵션.
			connection.setDoInput(true);
			// Connect to the server
			connection.connect();
			// Make JsonInputString
//		    String jsonInputString = String.format(
//		    			"{\"paymentKey\":\"%s\",\"amount\":%d,\"orderId\":\"%s\"}", paymentKey, amount, orderId
//		    		);
			// TODO : approval_url, fail_url, cancel_url에 알맞은 주소를 입력해야 함
			String jsonInputString = String.format("{" + "\"cid\": \"TC0ONETIME\","
					+ "\"partner_order_id\": \"partner_order_id\"," + "\"partner_user_id\": \"partner_user_id\","
					+ "\"item_name\": \"%s\"," + "\"quantity\": 1," + "\"total_amount\": %d," + "\"vat_amount\": 0,"
					+ "\"tax_free_amount\": 0," + "\"approval_url\": \"%s/kakaopay_payRequest\","
					+ "\"fail_url\": \"http://localhost:8080/user/temp_02\","
					+ "\"cancel_url\": \"http://localhost:8080/user/temp_03\"" + "}", name, amount, baseUrl);
			System.out.println("결제 준비 API 요청에 들어갈 json : " + jsonInputString);
			OutputStream os = connection.getOutputStream();
			byte[] input = jsonInputString.getBytes();
			os.write(input, 0, input.length);

			// 응답 코드 확인
			int responseCode = connection.getResponseCode();
			resultMap.put("httpResponseCode", String.valueOf(responseCode));
			StringBuilder response = new StringBuilder();
			if (responseCode == HttpURLConnection.HTTP_OK) {
				// Read the response from the server
				BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
				String line;
				while ((line = reader.readLine()) != null) {
					response.append(line);
				}
				reader.close();
			} else {
				// 서버로부터 에러 읽기
				BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getErrorStream(), "utf-8"));
				String line;
				while ((line = reader.readLine()) != null) {
					response.append(line.trim());
				}
				reader.close();
			}

			// 응답 결과
			System.out.println("응답 결과 : " + response.toString());
			// Disconnect from the server
			connection.disconnect();
			resultMap.put("response", response.toString());
		} catch (IOException e) {
			System.out.println("결제 준비 실패");
			e.printStackTrace();
		}
		return resultMap;
	}

	@Override
	public Map<String, String> requestApprovalKakaopayPayment(String tid, String pg_token) {
		Map<String, String> resultMap = new HashMap<>();

		try {
			// Create a URL object for the desired URL
			URL url = new URL("https://open-api.kakaopay.com/online/v1/payment/approve");
			// Open a connection to the URL using the HttpURLConnection class
			HttpURLConnection connection = (HttpURLConnection) url.openConnection();
			// Set the request method to GET
			connection.setRequestMethod("POST");
			// Add any headers you want to send with the request
			// TODO : 내 카카오페이 개발자 시크릿 키이므로 별도의 파일에 보관 요망
			connection.setRequestProperty("Authorization", "SECRET_KEY DEV13F237E02B1F92076F010653B0F0AFFB6B814");
			connection.setRequestProperty("Content-Type", "application/json");
			// OutputStream으로 POST 데이터를 넘겨주겠다는 옵션.
			connection.setDoOutput(true);
			// InputStream으로 서버로 부터 응답을 받겠다는 옵션.
			connection.setDoInput(true);
			// Connect to the server
			connection.connect();
			// Make JsonInputString
			// TODO : approval_url, fail_url, cancel_url에 알맞은 주소를 입력해야 함
			String jsonInputString = String.format("{" + "\"cid\": \"TC0ONETIME\","
					+ "\"partner_order_id\": \"partner_order_id\"," + "\"partner_user_id\": \"partner_user_id\","
					+ "\"tid\": \"%s\"," + "\"pg_token\": \"%s\"" + "}", tid, pg_token);
			System.out.println("결제 요청 API 요청에 들어갈 json : " + jsonInputString);
			OutputStream os = connection.getOutputStream();
			byte[] input = jsonInputString.getBytes();
			os.write(input, 0, input.length);

			// 응답 코드 확인
			int responseCode = connection.getResponseCode();
			resultMap.put("httpResponseCode", String.valueOf(responseCode));
			StringBuilder response = new StringBuilder();
			if (responseCode == HttpURLConnection.HTTP_OK) {
				// Read the response from the server
				BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
				String line;
				while ((line = reader.readLine()) != null) {
					response.append(line);
				}
				reader.close();
			} else {
				// 서버로부터 에러 읽기
				BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getErrorStream(), "utf-8"));
				String line;
				while ((line = reader.readLine()) != null) {
					response.append(line.trim());
				}
				reader.close();
			}

			// 응답 결과
			System.out.println("응답 결과 : " + response.toString());
			// Disconnect from the server
			connection.disconnect();
			resultMap.put("response", response.toString());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return resultMap;
	}

	@Override
	public List<OrderProductsDTO> getOrderListOfMember(String memberId) {
		List<OrderProductsDTO> result = new ArrayList<>();
		List<String> orders = orderDAO.getOrderIdList(memberId);
		System.out.println(memberId + "의 order id 리스트 : " + orders);
		for (String orderId : orders) {
			OrderProductsDTO order = new OrderProductsDTO();
			order.setOrderId(orderId);
			Map<String, Object> orderInfo = orderDAO.getOrderInfo(orderId);
			// System.out.println("orderInfo.order_id : " + (String)
			// orderInfo.get("order_id"));
			// System.out.println("orderInfo : " + orderInfo);
			// System.out.println("orderInfo.order_status : " + (String)
			// orderInfo.get("order_status"));
			Timestamp time = (Timestamp) orderInfo.get("order_date");
			order.setOrderDate(time.toLocalDateTime().format(DateTimeFormatter.ofPattern("yyyy.MM.dd")));
			Map<String, String> dict = new HashMap<>();
			dict.put("1", "결제대기");
			dict.put("2", "결제완료");
			dict.put("3", "상품준비중");
			dict.put("4", "배송준비중");
			dict.put("5", "배송중");
			dict.put("6", "배송완료");
			order.setOrderStatus(dict.get((String) orderInfo.get("order_status")));
			List<OrderProductDTO> products = orderDAO.getProductList(orderId);
			// System.out.println("products : " + products);
			order.setProducts(products);
			System.out.println("order : " + order);
			result.add(order);
		}
		return result;
	}

	@Override
	@Transactional(rollbackFor = { Exception.class })
	public void cancelOrder(CancelOrderRequestDTO request) throws Exception {
		if (orderDAO.makeCancel(request.getOrderId(), request.getProducts(), request.getCancelType(),
				request.getCancelReason()) != request.getProducts().size()) {
			throw new DataAccessException("취소 정보 삽입 실패") {
			};
		}
		orderDAO.updateAccountInfo(request.getOrderId(), request.getAccountOwner(), request.getAccountBank(),
				request.getAccountNumber());
	}

	// working...
	// public getCancelProcessStatus(String orderId, String )
}
