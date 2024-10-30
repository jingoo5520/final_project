package com.finalProject.service.order;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface OrderService {

	Map<String, String> readyKakaoPay(String name, int amount, HttpServletRequest request);

	Map<String, String> requestApprovalKakaopayPayment(String tid, String pg_token);

	Map<String, String> requestApproval(String base64SecretKey, String paymentKey, int amount, String orderId);

	String saveExpectedTotalPrice(int amount) throws Exception;

	int getExpectedTotalPrice(String orderId);

}
