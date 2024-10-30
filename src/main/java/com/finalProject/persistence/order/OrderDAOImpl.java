package com.finalProject.persistence.order;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

@Repository
public class OrderDAOImpl implements OrderDAO {
	@Inject
	private SqlSession ses;

	private String ns = "com.finalProject.mappers.orderMapper.";

	@Override
	public String getOrderId(String memberId) {
		String result = null;
		result = ses.selectOne(ns + "selectOrderId", memberId);
		return result;
	}
	
	@Override
	public int updateExpectedTotalPrice(String orderId, int amount) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("orderId", orderId);
		params.put("amount", amount);
		return ses.update(ns + "updateExpectedTotalPrice", params);
	}

	@Override
	public int getExpectedTotalPrice(String orderId) {
		return ses.selectOne(ns + "selectExpectedTotalPrice", orderId);
	}
}
