package com.finalProject.persistence.order;

import java.util.List;

import com.finalProject.model.order.OrderMemberDTO;
import com.finalProject.model.order.OrderProductDTO;
import com.finalProject.model.order.OrderRequestDTO;

public interface OrderDAO {

	List<OrderProductDTO> selectProductInfo(List<OrderRequestDTO> requestsInfo);

	OrderMemberDTO selectMemberInfo(String memberId);

}
