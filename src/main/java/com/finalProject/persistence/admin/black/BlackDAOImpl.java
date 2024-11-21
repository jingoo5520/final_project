package com.finalProject.persistence.admin.black;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.finalProject.model.admin.black.BlackInsertDTO;
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

	@Override
	public int getSearchTotalPostCnt(Map<String, Object> mapperMap) {
		// TODO Auto-generated method stub
		return ses.selectOne(ns + "getSearchAllMember", mapperMap);
	}

	@Override
	public void updateStatusMember(String memberId) {
		ses.delete(ns + "updateStatusMember", memberId);

	}

	@Override
	public int blackMember(Map<String, List<String>> map) {

		return ses.update(ns + "blackMember", map);

	}

	@Override
	public void insertBlackMembers(Map<String, Object> map) {
		ses.insert(ns + "insertBlack", map);
	}

	@Override
	public int blackCancelMember(String memberId) {
		// TODO Auto-generated method stub
		return ses.update(ns + "updateBlackMember", memberId);
	}

	@Override
	public int deleteBlackMember(String memberId) {
		// TODO Auto-generated method stub
		return ses.delete(ns + "deleteBlackMember", memberId);
	}

}
