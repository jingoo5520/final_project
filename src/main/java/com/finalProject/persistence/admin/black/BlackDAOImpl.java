package com.finalProject.persistence.admin.black;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.finalProject.model.admin.black.BlackMemberVO;
import com.finalProject.model.admin.product.PagingInfo;

@Repository
public class BlackDAOImpl implements BlackDAO {
	@Autowired
	private SqlSession ses;

	private String ns = "com.finalProject.mappers.blackMapper.";

	@Override
	public int getTotalPostCnt() {

		return ses.selectOne(ns + "countMember");
	}

	@Override
	public List<BlackMemberVO> getAllMember(PagingInfo pi) {
		// TODO Auto-generated method stub

		return ses.selectList(ns + "getAllMember", pi);
	}

	@Override
	public List<BlackMemberVO> getSearchMember(Map<String, Object> mapperMap) {

		return ses.selectList(ns + "getSearchMember", mapperMap);
	}

}
