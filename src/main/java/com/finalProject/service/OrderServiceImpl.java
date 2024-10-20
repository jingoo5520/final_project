package com.finalProject.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.finalProject.model.OrderLevelDTO;
import com.finalProject.model.OrderMemberDTO;
import com.finalProject.model.OrderMemberVO;
import com.finalProject.model.OrderProductDTO;
import com.finalProject.model.OrderProductVO;
import com.finalProject.persistence.OrderDAO;

@Service
public class OrderServiceImpl implements OrderService {
	
	@Inject
	OrderDAO oDao;
	
	@Override
	public OrderProductVO viewProduct(int productNo){
		OrderProductDTO opDTO = oDao.selectOrderProduct(productNo);
		
		OrderProductVO orderProduct = OrderProductVO.builder()
			.orderProductName(opDTO.getProduct_name())
			.orderProductPrice(opDTO.getProduct_price())
			.orderProductImg(oDao.selectOrderProductImg(productNo))
			.orderDCType(opDTO.getProduct_dc_type())
			.orderDCAmount(opDTO.getDc_amount())
			.orderDCRate(opDTO.getDc_rate())
			.build();
		
		return orderProduct;
	}

	@Override
	public OrderMemberVO viewMember(String memberId) {
		OrderMemberDTO omDTO = oDao.selectOrderMember(memberId); // 주문자 회원 정보
		
		int omLevel = omDTO.getMember_level();
		
		OrderLevelDTO olDTO = oDao.selectMemberLever(omLevel); // 주문자의 등급 정보
		
		OrderMemberVO orderMember = OrderMemberVO.builder()
				.name(omDTO.getMember_name())
				.phoneNumber(omDTO.getPhone_number())
				.email(omDTO.getEmail())
				.address(omDTO.getAddress())
				.point(omDTO.getMember_point())
				.levelName(olDTO.getLevel_name())
				.levelDC(olDTO.getLevel_dc())
				.levelPoint(olDTO.getLevel_point())
				.build();
				
		
		return orderMember;
	}

}
