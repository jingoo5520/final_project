package com.finalProject.service.order;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.finalProject.model.order.OrderMemberDTO;
import com.finalProject.model.order.OrderProductVO;

public interface OrderService {

	OrderProductVO getProductInfo(int productNo, int quantity);

	OrderMemberDTO getMemberInfo(String memberId);
	
	Map<String, String> readyKakaoPay(String name, int amount, HttpServletRequest request);

	Map<String, String> requestApprovalKakaopayPayment(String tid, String pg_token);

	Map<String, String> requestApproval(String base64SecretKey, String paymentKey, int amount, String orderId);
	
}
