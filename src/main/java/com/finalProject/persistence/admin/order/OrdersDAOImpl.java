package com.finalProject.persistence.admin.order;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.finalProject.model.admin.order.AdminCancleVO;
import com.finalProject.model.admin.order.AdminPayOrdererVO;
import com.finalProject.model.admin.order.AdminPaymentVO;

@Repository
public class OrdersDAOImpl implements OrdersDAO {

	@Autowired
	private SqlSession ses;

	private String ns = "com.finalProject.mappers.adminCancleMapper.";

	@Override
	public List<AdminCancleVO> getAllCancle(Map<String, Integer> pageMap) {
		return ses.selectList(ns + "getAllCancle", pageMap);
	}

	@Override
	public int getTotalPostCnt() {

		return ses.selectOne(ns + "getCountAllCancle");
	}

	@Override
	public List<AdminCancleVO> getTopCancle() {

		return ses.selectList(ns + "getTopCancle");
	}

	@Override
	public List<AdminCancleVO> getSearchFilter(Map<String, Object> resultMap) {

		return ses.selectList(ns + "searchCancel", resultMap);
	}

	@Override
	public int getSearchTotalPostCnt(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return ses.selectOne(ns + "getCountSearchCancle", map);
	}

	@Override
	public AdminPaymentVO getPaymentModuleKeyByOrderId(List<Integer> list) {
		// TODO Auto-generated method stub
		return ses.selectOne(ns + "getPaymentModuleKeyByOrderId", list);
	}

	@Override
	public List<AdminCancleVO> getListByOrderId(String orderId) {

		return ses.selectList(ns + "getListByOrderId", orderId);
	}

	@Override
	public int RestractByCancelNo(String cancelNo) {

		return ses.update(ns + "restractByCancelNo", cancelNo);
	}

	@Override
	public int updateCancelCompleteDate(List<Integer> cancelList) {
		Map<String, Object> params = new HashMap<>();
		params.put("cancelList", cancelList);
		return ses.update(ns + "updateCancelCompleteDate", params);
	}

	@Override
	public int insertRefund(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return ses.update(ns + "insertRefund", map);
	}

	@Override
	public String getOrderIdByCancelNo(List<Integer> cancelList) {
		// TODO Auto-generated method stub
		Map<String, Object> params = new HashMap<>();
		params.put("cancelList", cancelList);
		return ses.selectOne(ns + "getOrderIdByCancelNo", params);
	}

	@Override
	public AdminPayOrdererVO getExpectPayAmount(String orderId) {
		// TODO Auto-generated method stub
		return ses.selectOne(ns + "getExpectPayAmount", orderId);
	}

	@Override
	public int refundPoint(int assigned_point, String orderer_id) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("point", assigned_point);
		map.put("member_id", orderer_id);
		return ses.insert(ns + "refundPoint", map);
	}

	@Override
	public void returnMemberPoint(int assigned_point, String orderer_id) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("point", assigned_point);
		map.put("member_id", orderer_id);
		ses.update(ns + "returnMemberPoint", map);
	}

	@Override
	public int refundEarnedPoint(int use_point, String orderer_id) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("usePoint", use_point);
		map.put("member_id", orderer_id);
		return ses.insert(ns + "refundEarnedPoint", map);
	}

	@Override
	public void deleteUseCoupon(int coupon_no) {
		// TODO Auto-generated method stub
		ses.delete(ns + "deleteUseCoupon", coupon_no);
	}

	@Override
	public void refundMemberUsePoint(int use_point, String orderer_id) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("usePoint", use_point);
		map.put("member_id", orderer_id);

		ses.update(ns + "refundMemberUsePoint", map);
	}

	@Override
	public float memberLevelPoint(String orderId) {
		// TODO Auto-generated method stub
		return ses.selectOne(ns + "memberLevelPoint", orderId);
	}

	@Override
	public int restractPoint(String orderId, int stealPoint) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("memberId", orderId);
		map.put("stealPoint", stealPoint);
		return ses.insert(ns + "restractPoint", map);
	}

	@Override
	public void restractPointMember(String orderId, int stealPoint) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("memberId", orderId);
		map.put("stealPoint", stealPoint);
		ses.update(ns + "restractPointMember", map);
	}

	@Override
	public String findMemberId(String orderId) {

		return ses.selectOne(ns + "findMemberId", orderId);
	}

}
