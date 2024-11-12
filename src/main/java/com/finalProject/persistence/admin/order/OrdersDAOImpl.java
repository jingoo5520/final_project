package com.finalProject.persistence.admin.order;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.finalProject.model.admin.order.AdminCancleVO;
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

}
