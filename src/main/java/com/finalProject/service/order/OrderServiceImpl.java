package com.finalProject.service.order;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.finalProject.model.order.OrderMemberDTO;
import com.finalProject.model.order.OrderProductDTO;
import com.finalProject.model.order.OrderProductVO;
import com.finalProject.persistence.order.OrderDAO;

@Service
public class OrderServiceImpl implements OrderService {

	@Inject
	OrderDAO oDAO;
	
	@Override
	public OrderProductVO getProductInfo(int productNo, int quantity) {
		OrderProductDTO opDTO = oDAO.selectProductInfo(productNo);
		
		return OrderProductVO.builder()
				.productNo(productNo)
				.productName(opDTO.getProduct_name())
				.quantity(quantity)
				.price(opDTO.getProduct_price())
				.dcType(opDTO.getProduct_dc_type())
				.dcRate(opDTO.getDc_rate())
				.dcAmount(opDTO.getDc_amount())
				.productImg(opDTO.getImage_main_url())
				.build();
	}

	@Override
	public OrderMemberDTO getMemberInfo(String memberId) {
		
		return oDAO.selectMemberInfo(memberId);
	}

}
