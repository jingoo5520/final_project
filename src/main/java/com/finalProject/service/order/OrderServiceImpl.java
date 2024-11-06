package com.finalProject.service.order;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.file.FileSystems;
import java.sql.Timestamp;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.finalProject.model.order.OrderMemberDTO;
import com.finalProject.model.order.OrderProductDTO;
import com.finalProject.model.order.OrderProductsDTO;
import com.finalProject.model.order.OrderRequestDTO;
import com.finalProject.model.order.PaymentRequestDTO;
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
	public String makeOrder(PaymentRequestDTO request, boolean isMember) throws Exception {
		System.out.println("orders 테이블 행 삽입 전 회원/비회원 확인. 회원? : " + isMember);
		String orderId = orderDAO.makeOrder(request, isMember);
		this.saveExpectedTotalPrice(calculateTotalPrice(request, orderId, isMember), orderId); // 예상결제금액 저장
		return orderId;
	}
	
	private int calculateTotalPrice(PaymentRequestDTO request, String orderId, boolean isMember) {
		int total = 0;
		for (OrderRequestDTO product : request.getProductsInfo()) {
			System.out.println("product : " + product.toString());
			total += (orderDAO.getPrice(product.getProductNo()) * product.getQuantity());
		}
		total += orderDAO.selectDeliveryCost(orderId);
		if (isMember == true) {
			OrderMemberDTO memberInfo = orderDAO.selectMemberInfo(request.getOrdererId());
			total = (int) (total * (1f - memberInfo.getLevel_dc()));
			// TODO : 쿠폰 할인 적용해야 함
		}
		return total;
	}
	
	@Override
	public void makeGuest(PaymentRequestDTO request, String orderId) {
		if (orderDAO.makeGuest(request, orderId) != 1) {
			throw new DataAccessException("비회원 정보 생성 실패") {};
		}
	}
	
	@Override
	@Transactional(rollbackFor={Exception.class})
	public void makePayment(String orderId, Integer amount, String payModule, String method, HttpSession session) throws Exception {
		// NOTE : 이 트랜잭션에서 예외가 발생해도 이미 생성된 orders의 테이블의 행은 삭제되지 않음
		// 그러므로 컨트롤러의 catch 블록에서 orders 테이블의 행을 삭제함
		
		boolean isMember = session.getAttribute("loginMember") == null ? false : true;
		
		if (isMember == true) {
			// 유저정보 업데이트 : 쿠폰 사용, 포인트 적립, 회원등급 수정
			// 쿠폰 사용
			if (orderDAO.useCoupon(orderId) != 1) {
				throw new DataAccessException("쿠폰 사용 실패") {};
			};
			// 포인트 적립
			if (orderDAO.updatePoint(orderId) != true) {
				throw new DataAccessException("포인트 적립 실패") {}; 
			};
			// 회원등급 수정
			if (orderDAO.updateUserLevel(orderId) != true) {
				throw new DataAccessException("회원등급 수정 실패") {}; 
			};
		}
		
		if (orderDAO.insertPaymentInfo(orderId, amount, payModule, method) != true) {
			throw new DataAccessException("결제 정보 생성 실패") {}; 
		}
		try {
			orderDAO.updateOrderStatus(method, orderId);
		} catch (Exception e) {
			
		}
		// TODO : 장바구니에서 결제한 물품 삭제
	}
	
	@Override
	@Transactional(rollbackFor={Exception.class})
	public void saveExpectedTotalPrice(int amount, String orderId) throws Exception {
		if (orderDAO.updateExpectedTotalPrice(orderId, amount) != 1) {
			throw new DataAccessException("DB 조작 실패") {};
		}
	}
	
	@Override
	@Transactional(rollbackFor={Exception.class})
	public void setPaymentModuleKey(String orderId, String key) throws Exception {
		if (orderDAO.setPaymentModuleKey(orderId, key) != 1) {
			throw new DataAccessException("DB 조작 실패") {};
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
		    String jsonInputString = String.format(
		    			"{\"paymentKey\":\"%s\",\"amount\":%d,\"orderId\":\"%s\"}", paymentKey, amount, orderId
		    		);
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
		    //   "virtualAccount": {
		    //			    "accountNumber": "X5909014050733",
			//			    "accountType": "일반",
			//			    "bankCode": "06",
			//			    "customerName": "dsfsdf",
			//			    "dueDate": "2024-10-26T15:59:03+09:00",
			//			    "expired": false,
			//			    "settlementStatus": "INCOMPLETED",
			//			    "refundStatus": "NONE",
			//			    "refundReceiveAccount": null
			//			  },
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
	// 레퍼런스 : https://velog.io/@ryuneng2/%EC%B9%B4%EC%B9%B4%EC%98%A4%ED%8E%98%EC%9D%B4-API-%EC%97%B0%EB%8F%99-%ED%8C%9D%EC%97%85%EC%B0%BD%EB%9D%84%EC%9A%B0%EA%B8%B0-%EA%B2%B0%EC%A0%9C%EC%8A%B9%EC%9D%B8-%EA%B5%AC%ED%98%84
	public Map<String, String> readyKakaoPay(String name, int amount, HttpServletRequest request) {
		Map<String, String> resultMap = new HashMap<>();
	    String baseUrl = String.format("%s://%s:%d%s", 
	            request.getScheme(),           // http or https
	            request.getServerName(),       // localhost or actual server domain
	            request.getServerPort(),       // 8080 or actual port
	            request.getContextPath());     // application context
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
		    String jsonInputString = String.format("{"
		    		+ "\"cid\": \"TC0ONETIME\","
		    		+ "\"partner_order_id\": \"partner_order_id\","
		    		+ "\"partner_user_id\": \"partner_user_id\","
		    		+ "\"item_name\": \"%s\","
		    		+ "\"quantity\": 1,"
		    		+ "\"total_amount\": %d,"
		    		+ "\"vat_amount\": 0,"
		    		+ "\"tax_free_amount\": 0,"
		    		+ "\"approval_url\": \"%s/kakaopay_payRequest\","
		    		+ "\"fail_url\": \"http://localhost:8080/user/temp_02\","
		    		+ "\"cancel_url\": \"http://localhost:8080/user/temp_03\""	
					+ "}", name, amount, baseUrl);
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
		    String jsonInputString = String.format("{"
		    		+ "\"cid\": \"TC0ONETIME\","
		    		+ "\"partner_order_id\": \"partner_order_id\","
		    		+ "\"partner_user_id\": \"partner_user_id\","
		    		+ "\"tid\": \"%s\","
		    		+ "\"pg_token\": \"%s\""
					+ "}", tid, pg_token);
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
			System.out.println("orderInfo.order_id : " + (String) orderInfo.get("order_id"));
			System.out.println("orderInfo : " + orderInfo);
			System.out.println("orderInfo.order_status : " + (String) orderInfo.get("order_status"));
			Timestamp time = (Timestamp) orderInfo.get("order_date");
			order.setOrderDate( time.toLocalDateTime().format(DateTimeFormatter.ofPattern("yyyy.MM.dd")) );
			Map<String, String> dict = new HashMap<>();
			dict.put("1", "결제대기");
			dict.put("2", "결제완료");
			dict.put("3", "상품준비중");
			dict.put("4", "배송준비중");
			dict.put("5", "배송중");
			dict.put("6", "배송완료");
			order.setOrderStatus(dict.get((String) orderInfo.get("order_status")));
			List<OrderProductDTO> products = orderDAO.getProductList(orderId);
			System.out.println("products : " + products);
			order.setProducts(products);
			System.out.println("order : " + order);
			result.add(order);
		}
		return result;
	}

}
