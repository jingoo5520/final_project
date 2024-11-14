package com.finalProject.persistence.order;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import com.finalProject.model.order.OrderMemberDTO;
import com.finalProject.model.order.OrderProductDTO;
import com.finalProject.model.order.OrderRequestDTO;
import com.finalProject.model.order.PaymentRequestDTO;
import com.finalProject.model.order.ProductCancelRequestDTO;
import com.finalProject.model.order.ProductDiscountCalculatedDTO;
import com.finalProject.model.order.ProductDiscountDTO;

public interface OrderDAO {

	List<OrderProductDTO> selectProductInfo(List<OrderRequestDTO> requestsInfo);

	OrderMemberDTO selectMemberInfo(String memberId);

	int getExpectedTotalPrice(String orderId);
	
	int updateExpectedTotalPriceWithDeliveryCost(String orderId, int amount);

	int setPaymentModuleKey(String orderId, String key);
	
	int getPrice(int productNo);

	int selectDeliveryCost(String orderId);
	
	Integer useCoupon(String orderId, String couponCode);

	boolean updateUserLevel(String orderId);

	boolean updatePoint(String orderId);
	
	String makeOrder(PaymentRequestDTO request, boolean isMember) throws Exception;
	
	void deletePaidProductsFromCart(String memberId);
	
	boolean insertPaymentInfo(String orderId, Integer amount, String payModule, String method);

	String getPaymentModuleKey(String orderId);

	void deleteOrder(String orderId);

	int makeGuest(PaymentRequestDTO request, String orderId);

	List<String> getOrderIdList(String memberId);
	
	List<String> getOrderIdList(String name, String phoneNumber, String email);

	List<OrderProductDTO> getProductList(String orderId);

	Map<String, Object> getOrderInfo(String orderId);

	void updateOrderStatus(String payMethod, String orderId) throws Exception;

	int makeCancel(String orderId, List<ProductCancelRequestDTO> list, String cancelType, String cancelReason);
	
	void updateAccountInfo(String orderId, String depositName, String depositBank, String depoistAccount);
	
	List<ProductDiscountDTO> getDiscountInfoByProduct(String orderId, HttpSession session);

	int updateRefundPriceByProduct(List<ProductDiscountCalculatedDTO> productDiscountCalculated);

	void updateOrderStatusAuto();

}
