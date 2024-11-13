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
import com.finalProject.model.admin.order.ModifyCancelStatusDTO;

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

		return ses.update(ns + "updateCancelCompleteDate", cancelList);
	}

	@Override
	public int insertRefund(ModifyCancelStatusDTO modifyCancelStatusDTO) {
		// TODO Auto-generated method stub
		return ses.update(ns + "insertRefund", modifyCancelStatusDTO);
	}

	@Override
	public String getOrderIdByCancelNo(List<Integer> cancelList) {
		// TODO Auto-generated method stub
		return ses.selectOne(ns + "getOrderIdByCancelNo", cancelList);
	}

	@Override
	public AdminPayOrdererVO getExpectPayAmount(String orderId) {
		// TODO Auto-generated method stub
		return ses.selectOne(ns + "getExpectPayAmount", orderId);
	}

	@Override
	public int returnPoint(int assigned_point, String orderer_id) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("point", assigned_point);
		map.put("member_id", orderer_id);
		return ses.insert(ns + "returnPoint", map);
	}

	@Override
	public void returnMemberPoint(int assigned_point, String orderer_id) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("point", assigned_point);
		map.put("member_id", orderer_id);
		ses.update(ns + "returnMemberPoint", map);
	}

}
