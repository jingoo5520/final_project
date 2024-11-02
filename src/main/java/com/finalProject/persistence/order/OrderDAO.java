package com.finalProject.persistence.order;

import java.util.List;

import com.finalProject.model.order.OrderMemberDTO;
import com.finalProject.model.order.OrderProductDTO;
import com.finalProject.model.order.OrderRequestDTO;

public interface OrderDAO {

	List<OrderProductDTO> selectProductInfo(List<OrderRequestDTO> requestsInfo);

	OrderMemberDTO selectMemberInfo(String memberId);

	int getExpectedTotalPrice(String orderId);
	
	int updateExpectedTotalPrice(String orderId, int amount);

	int setPaymentModuleKey(String orderId, String key);

	Integer useCoupon(String orderId);

	boolean updateUserLevel(String orderId);

	boolean updatePoint(String orderId);
	
	boolean insertPaymentInfo(String orderId, Integer amount, String payModule, String method);

	String getPaymentModuleKey(String orderId);
	
}
