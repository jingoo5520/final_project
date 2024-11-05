package com.finalProject.persistence.admin.order;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.finalProject.model.admin.order.AdminCancleVO;

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

}
