package com.finalProject.persistence.order;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.finalProject.model.order.OrderMemberDTO;
import com.finalProject.model.order.OrderProductDTO;

@Repository
public class OrderDAOImpl implements OrderDAO {
	
	@Inject
	SqlSession ses;

	private String ns = "com.finalProject.mappers.orderMapper.";
	
	@Override
	public OrderProductDTO selectProductInfo(int productNo) {
		// 상품 정보 조회
		return ses.selectOne(ns + "selectProductInfo", productNo);
	}

	@Override
	public OrderMemberDTO selectMemberInfo(String memberId) {
		// 주문 회원 조회
		return ses.selectOne(ns + "selectMemberInfo", memberId);
	}
	
	// ++ 쿠폰테이블

}
