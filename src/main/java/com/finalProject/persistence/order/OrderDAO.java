package com.finalProject.persistence.order;

public interface OrderDAO {

	int getExpectedTotalPrice(String orderId);
	
	int updateExpectedTotalPrice(String orderId, int amount);

	int setPaymentModuleKey(String orderId, String key);

	Integer useCoupon(String orderId);

	boolean updateUserLevel(String orderId);

	boolean updatePoint(String orderId);
	
	boolean insertPaymentInfo(String orderId, Integer amount, String payModule, String method);

	String getPaymentModuleKey(String orderId);
	
}
