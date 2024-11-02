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
	public int getExpectedTotalPrice(String orderId) {
		return ses.selectOne(ns + "selectExpectedTotalPrice", orderId);
	}
	
	@Override
	public int updateExpectedTotalPrice(String orderId, int amount) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("orderId", orderId);
		params.put("amount", amount);
		return ses.update(ns + "updateExpectedTotalPrice", params);
	}
	
	@Override
	public int setPaymentModuleKey(String orderId, String key) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("orderId", orderId);
		params.put("key", key);
		return ses.update(ns + "updatePaymentModuleKey", params);
	}
	
	@Override
	public String getPaymentModuleKey(String orderId) {
		return ses.selectOne(ns + "selectPaymentModuleKey", orderId);
	}
	
	@Override
	public Integer useCoupon(String orderId) {
		Integer couponNo = ses.selectOne(ns + "selectCouponNoOfOrder", orderId);
		if (couponNo == null) {return null;}
		Map<String, Object> params = new HashMap<>();
		params.put("orderId", orderId);
		params.put("couponNo", couponNo);
		return ses.insert(ns + "insertToCouponUsed", params);
	}
	
	@Override
	public boolean updatePoint(String orderId) {
		// 포인트 차감
		Map<String, Object> params = new HashMap<>();
		params.put("orderId", orderId);
		if (ses.insert(ns + "insertToPointUsed", params) != 1) {
			return false;
		};
		if (ses.update(ns + "subtractUserPoint", params) != 1) {
			return false;
		};
		// 최종 결제 금액으로 인한 포인트 적립
		if (ses.update(ns + "addUserPoint", params) != 1) {
			return false;
		};
		return true;
	}
	
	@Override
	public boolean updateUserLevel(String orderId) {
		if (ses.update(ns + "updateUserLevel", orderId) != 1) {
			return false;
		}
		return true;
	}
	
	@Override
	public boolean insertPaymentInfo(String orderId, Integer amount, String payModule, String method) {
		Map<String, Object> params = new HashMap<>();
		params.put("orderId", orderId);
		params.put("amount", amount);
		params.put("moduleName", payModule);
		if (method != null && method.equals("가상계좌")) {
			params.put("status", "A");
		} else { // 카카오페이, 네이버페이 포함
			params.put("status", "S");
		}
		// NOTE : 결제 테이블의 deposit_name, deposit_bank, deposit_account는 추후에 환불받을 때 입금해야 하는 계좌이다.
		// 회원이 환불 신청할 때 작성하는 폼에서 받아와야 함
		params.put("deposit_name", null);
		params.put("deposit_bank", null);
		params.put("deposit_account", null);
		
		if (ses.insert(ns + "insertPaymentInfo", params) != 1) {
			return false;
		}
		return true;
	}
}
