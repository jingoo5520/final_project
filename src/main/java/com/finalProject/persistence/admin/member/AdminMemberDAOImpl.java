package com.finalProject.persistence.admin.member;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.finalProject.model.admin.coupon.PagingInfoNew;
import com.finalProject.model.admin.member.MemberManageDTO;
import com.finalProject.model.admin.member.MemberSearchFilterDTO;

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
	public List<MemberManageDTO> selectAllMembers(PagingInfoNew pi) throws Exception {
		return ses.selectList(ns + "selectAllMembers", pi);
	}

	@Override
	public List<MemberManageDTO> selectFilteredMembers(MemberSearchFilterDTO memberSearchFilterDTO, PagingInfoNew pi) throws Exception {
		
		System.out.println(memberSearchFilterDTO);
		System.out.println(pi);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("memberSearchFilterDTO", memberSearchFilterDTO);
		map.put("pi", pi);
		
		return ses.selectList(ns + "selectFilteredMembers", map);
	}

	

	

}
