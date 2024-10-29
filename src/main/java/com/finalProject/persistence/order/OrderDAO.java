package com.finalProject.persistence.order;

import com.finalProject.model.order.OrderMemberDTO;
import com.finalProject.model.order.OrderProductDTO;

public interface OrderDAO {

	OrderProductDTO selectProductInfo(int productNo);

	OrderMemberDTO selectMemberInfo(String memberId);

}
