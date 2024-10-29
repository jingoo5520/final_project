package com.finalProject.service.order;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.finalProject.model.order.OrderMemberDTO;
import com.finalProject.model.order.OrderProductDTO;
import com.finalProject.model.order.OrderProductVO;
import com.finalProject.model.order.OrderRequestDTO;

public interface OrderService {
	
	List<OrderProductDTO> getProductInfo(List<OrderRequestDTO> requestsInfo);

	OrderMemberDTO getMemberInfo(String memberId);
	
	Map<String, String> readyKakaoPay(String name, int amount, HttpServletRequest request);

	Map<String, String> requestApprovalKakaopayPayment(String tid, String pg_token);

	Map<String, String> requestApproval(String base64SecretKey, String paymentKey, int amount, String orderId);

}
