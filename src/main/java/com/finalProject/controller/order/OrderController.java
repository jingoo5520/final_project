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

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class OrderController {
	@GetMapping("/user/order")
	public void order() {
		System.out.println("주문 페이지 접속");
	}
	
	// NOTE : 결제가 성공하면 토스 결제 모듈이 쿼리스트링을 달고 페이지로 보낸다. 
	// 보내주는 페이지의 주소는 자바스크립트에서 successUrl: window.location.origin + "/payment/success.html" 이런 식으로 설정할 수 있다.
	@GetMapping("/user/payment/success")
	public String payAuthSuccess(
			@RequestParam("orderId") String orderId,
			@RequestParam("paymentKey") String paymentKey,
			@RequestParam("amount") int amount
			) {
		// 예시 : http://localhost:8080/user/payment/success.html?orderId=MC4wODExNjkzNzY1NTg1&paymentKey=tviva20241016183611gDY62&amount=10
		System.out.println("결제 인증 성공");
		// TODO : 쿼리 파라미터의 amount 값과 requestPayment()의 amount 파라미터 값이 같은지 반드시 확인하세요. 
		// 클라이언트에서 결제 금액을 조작하는 행위를 방지할 수 있습니다. 만약 값이 다르다면 결제를 취소하고 구매자에게 알려주세요.
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
		result = approvePay(encodedSecretKey, paymentKey, amount, orderId);
		String response = result.get("response");
		int responseCode = Integer.valueOf(result.get("httpResponseCode"));
		// TODO : 결제 끝나고 리다이렉트 하는 페이지 재지정할 듯
		System.out.println("응답 : " + result);
		if (responseCode != HttpURLConnection.HTTP_OK) {
			
			return "/user/temp_02"; // 결제 실패
		}
		return "/user/temp_01"; // 결제 성공
	}
	
	@GetMapping("/user/approveNaverPay")
	public String approveNaverPay(
			@RequestParam("resultCode") String resultCode,
			@RequestParam("paymentId") String paymentId,
			@RequestParam(value = "resultMessage", required = false) String resultMessage // resultCode가 Success이면 reaultMessage가 안옴
			) {
		System.out.println("네이버페이 resultCode : " + resultCode);
		if (resultCode.equals("Success")) {
			return "/user/temp_01"; // 결제 성공
		} else {
			// 결제 실패시
			return "/user/temp_02"; // 결제 실패
		}
	}
	
	// 레퍼런스 : https://akku-dev.tistory.com/2
	// 토스에서 예제코드로 쓰는 HttpClient는 java11 버전부터 사용가능하다.
	// java8은 HttpURLConnection을 쓰거나 Apache HttpClient, okHttp등의 외부 라이브러리를 사용할 수 있다.
	// 여기서는 라이브러리 사용 안하고 HttpURLConnection를 쓰겠다.
	private Map<String, String> approvePay(String base64SecretKey, String paymentKey, int amount, String orderId) {
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
		    // 성공했을 때 응답 예시
//		    {
//		    	  "mId": "tvivarepublica",
//		    	  "lastTransactionKey": "24F04542A0CEB53E3CB52D90EE8FDB59",
//		    	  "paymentKey": "tviva20241016203037f8Ij9",
//		    	  "orderId": "MC4wMzkzNjkwMzA2MDAy",
//		    	  "orderName": "토스 티셔츠 외 2건",
//		    	  "taxExemptionAmount": 0,
//		    	  "status": "DONE",
//		    	  "requestedAt": "2024-10-16T20:30:37+09:00",
//		    	  "approvedAt": "2024-10-16T20:31:17+09:00",
//		    	  "useEscrow": false,
//		    	  "cultureExpense": false,
//		    	  "card": {
//		    	    "issuerCode": "21",
//		    	    "acquirerCode": "21",
//		    	    "number": "55213300****079*",
//		    	    "installmentPlanMonths": 0,
//		    	    "isInterestFree": false,
//		    	    "interestPayer": null,
//		    	    "approveNo": "00000000",
//		    	    "useCardPoint": false,
//		    	    "cardType": "신용",
//		    	    "ownerType": "개인",
//		    	    "acquireStatus": "READY",
//		    	    "amount": 100
//		    	  },
//		    	  "virtualAccount": null,
//		    	  "transfer": null,
//		    	  "mobilePhone": null,
//		    	  "giftCertificate": null,
//		    	  "cashReceipt": null,
//		    	  "cashReceipts": null,
//		    	  "discount": null,
//		    	  "cancels": null,
//		    	  "secret": "ps_jExPeJWYVQOqJ161ew0v849R5gvN",
//		    	  "type": "NORMAL",
//		    	  "easyPay": null,
//		    	  "country": "KR",
//		    	  "failure": null,
//		    	  "isPartialCancelable": true,
//		    	  "receipt": {
//		    	    "url": "https://dashboard.tosspayments.com/receipt/redirection?transactionId=tviva20241016203037f8Ij9&ref=PX"
//		    	  },
//		    	  "checkout": {
//		    	    "url": "https://api.tosspayments.com/v1/payments/tviva20241016203037f8Ij9/checkout"
//		    	  },
//		    	  "currency": "KRW",
//		    	  "totalAmount": 100,
//		    	  "balanceAmount": 100,
//		    	  "suppliedAmount": 91,
//		    	  "vat": 9,
//		    	  "taxFreeAmount": 0,
//		    	  "method": "카드",
//		    	  "version": "2022-11-16",
//		    	  "metadata": null
//		    	}
		    // Disconnect from the server
		    connection.disconnect();
		    resultMap.put("response", response.toString());
		} catch (IOException e) {
			System.out.println("결제 승인 실패");
			e.printStackTrace();
		}
	    return resultMap;
	}
}
