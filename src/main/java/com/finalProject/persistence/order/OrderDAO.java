package com.finalProject.persistence.order;

public interface OrderDAO {

	String getOrderId(String memberId);

	int updateExpectedTotalPrice(String orderId, int amount);

	int getExpectedTotalPrice(String orderId);
	
}
