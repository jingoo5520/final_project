package com.finalProject.service.order;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.finalProject.model.order.CancelOrderRequestDTO;
import com.finalProject.model.order.OrderMemberDTO;
import com.finalProject.model.order.OrderProductDTO;
import com.finalProject.model.order.OrderProductsDTO;
import com.finalProject.model.order.OrderRequestDTO;
import com.finalProject.model.order.PaymentRequestDTO;

public interface OrderService {
	
	List<OrderProductDTO> getProductInfo(List<OrderRequestDTO> requestsInfo);

	OrderMemberDTO getMemberInfo(String memberId);
	
	Map<String, String> requestApprovalNaverpayPayment(String paymentId);
	
	Map<String, String> requestApprovalNaverpayCancel(String paymentId, String cancelReason, Integer cancelAmount);

	Map<String, String> readyKakaoPay(String name, int amount, HttpServletRequest request);

	Map<String, String> requestApprovalKakaopayPayment(String tid, String pg_token);
	
	Map<String, String> requestApprovalKakaopayCancel(String paymentId, String cancelReason, Integer cancelAmount);

	Map<String, String> requestApproval(String base64SecretKey, String paymentKey, int amount, String orderId);
	
	void setPaymentModuleKey(String orderId, String key) throws Exception;
	
	String getPaymentModuleKey(String orderId);

	int getExpectedTotalPrice(String orderId);
	
	void deleteOrder(String orderId);
	
	void makePayment(String orderId, Integer amount, String payModule, String method, HttpSession session) throws Exception;
	
	Map<String, Object> makeOrder(PaymentRequestDTO request, boolean isMember, HttpSession session) throws Exception;
	
	void makeGuest(PaymentRequestDTO request, String orderId);

	List<OrderProductsDTO> getOrderListOfMember(String memberId);

	void cancelOrder(CancelOrderRequestDTO request) throws Exception;

}
