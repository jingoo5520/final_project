package com.finalProject.persistence.inquiry;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.finalProject.model.admin.coupon.PagingInfoNew;
import com.finalProject.model.inquiry.InquiryDTO;

@Repository
public class InquiryDAOImpl implements InquiryDAO {

	@Inject
	private SqlSession ses;

	private static String ns = "com.finalProject.mappers.inquiryMapper.";
	
	@Override
	public int getTotalInquiryCnt() throws Exception {
		return ses.selectOne(ns + "selectInquiryCnt");
	}

	@Override
	public List<InquiryDTO> selectInquiryList(PagingInfoNew pi, String memberId) throws Exception {
		
		System.out.println(pi);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("member_id", memberId);
		map.put("pi", pi);
		
		return ses.selectList(ns + "selectAllInquiryWithPi", map);
	}

}
