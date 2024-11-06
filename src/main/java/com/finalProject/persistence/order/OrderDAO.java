package com.finalProject.persistence.order;

import java.util.List;
import java.util.Map;

import com.finalProject.model.order.OrderMemberDTO;
import com.finalProject.model.order.OrderProductDTO;
import com.finalProject.model.order.OrderRequestDTO;
import com.finalProject.model.order.PaymentRequestDTO;

public interface OrderDAO {

	List<OrderProductDTO> selectProductInfo(List<OrderRequestDTO> requestsInfo);

	OrderMemberDTO selectMemberInfo(String memberId);

	int getExpectedTotalPrice(String orderId);
	
	int updateExpectedTotalPrice(String orderId, int amount);

	int setPaymentModuleKey(String orderId, String key);
	
	int getPrice(int productNo);

	int selectDeliveryCost(String orderId);
	
	Integer useCoupon(String orderId);

	boolean updateUserLevel(String orderId);

	boolean updatePoint(String orderId);
	
	String makeOrder(PaymentRequestDTO request, boolean isMember) throws Exception;
	
	boolean insertPaymentInfo(String orderId, Integer amount, String payModule, String method);

	String getPaymentModuleKey(String orderId);

	void deleteOrder(String orderId);

	int makeGuest(PaymentRequestDTO request, String orderId);

	List<String> getOrderIdList(String memberId);

	List<OrderProductDTO> getProductList(String orderId);

	Map<String, Object> getOrderInfo(String orderId);

	void updateOrderStatus(String payMethod, String orderId) throws Exception;

}
