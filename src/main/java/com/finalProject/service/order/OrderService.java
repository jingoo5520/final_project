package com.finalProject.service.order;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface OrderService {

	Map<String, String> readyKakaoPay(String name, int amount, HttpServletRequest request);

	Map<String, String> requestApprovalKakaopayPayment(String tid, String pg_token);

	Map<String, String> requestApproval(String base64SecretKey, String paymentKey, int amount, String orderId);
	
	void setPaymentModuleKey(String orderId, String key) throws Exception;
	
	String getPaymentModuleKey(String orderId);

	int getExpectedTotalPrice(String orderId);

	void saveExpectedTotalPrice(int amount, String orderId) throws Exception;

	void makePayment(String orderId, Integer amount, String payModule, String method) throws Exception;
}
