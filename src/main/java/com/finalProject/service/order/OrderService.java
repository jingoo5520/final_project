package com.finalProject.service.order;

import com.finalProject.model.order.OrderMemberDTO;
import com.finalProject.model.order.OrderProductVO;

public interface OrderService {

	OrderProductVO getProductInfo(int productNo, int quantity);

	OrderMemberDTO getMemberInfo(String memberId);
	
}
