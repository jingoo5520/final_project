package com.finalProject.persistence.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.finalProject.model.admin.MemberManageDTO;
import com.finalProject.model.admin.MemberSearchFilterDTO;
import com.finalProject.model.admin.PagingInfo;

@Repository
public class AdminMemberDAOImpl implements AdminMemberDAO {

	@Inject
	private SqlSession ses;

	private static String ns = "com.finalProject.mappers.adminMemberMapper.";
	
	@Override
	public int getTotalMemberCnt() throws Exception {
		return ses.selectOne(ns + "selectMemberCnt");
	}
	
	@Override
	public int getTotalFilterdMemberCnt(MemberSearchFilterDTO memberSearchFilterDTO) throws Exception {
		
		return ses.selectOne(ns + "selectFilteredMemberCnt", memberSearchFilterDTO);
	}
	
	@Override
	public List<MemberManageDTO> selectAllMembers(PagingInfo pi) throws Exception {
		return ses.selectList(ns + "selectAllMembers", pi);
	}

	@Override
	public List<MemberManageDTO> selectFilteredMembers(MemberSearchFilterDTO memberSearchFilterDTO, PagingInfo pi) throws Exception {
		
		System.out.println(memberSearchFilterDTO);
		System.out.println(pi);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("memberSearchFilterDTO", memberSearchFilterDTO);
		map.put("pi", pi);
		
		return ses.selectList(ns + "selectFilteredMembers", map);
	}

	

	

}
