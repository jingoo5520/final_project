package com.finalProject.persistence;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.finalProject.model.OrderLevelDTO;
import com.finalProject.model.OrderMemberDTO;
import com.finalProject.model.OrderProductDTO;

@Repository
public class OrderDaoImpl implements OrderDAO {
	
	@Autowired
	private SqlSession ses;
	
	private String ns = "com.finalProject.mappers.orderMapper.";
	
	@Override
	public OrderProductDTO selectOrderProduct(int productNo) {
		return ses.selectOne(ns + "selectOrderProduct", productNo);
	}

	@Override
	public String selectOrderProductImg(int productNo) {
		return ses.selectOne(ns + "selectOrderProductImg", productNo);
	}

	@Override
	public OrderMemberDTO selectOrderMember(String memberId) {
		return ses.selectOne(ns + "selectOrderMember", memberId);
	}

	@Override
	public OrderLevelDTO selectMemberLever(int memberLevel) {
		return ses.selectOne(ns + "selectMemberLevel", memberLevel);
	}

}
