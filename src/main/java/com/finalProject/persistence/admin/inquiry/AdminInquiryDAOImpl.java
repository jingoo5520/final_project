package com.finalProject.persistence.admin.inquiry;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.finalProject.model.admin.coupon.PagingInfoNew;
import com.finalProject.model.inquiry.InquiryDetailDTO;

@Repository
public class AdminInquiryDAOImpl implements AdminInquiryDAO {

	@Inject
	private SqlSession ses;
	
	private static String ns = "com.finalProject.mappers.adminInquiryMapper.";

	@Override
	public int getTotalInquiryCnt() throws Exception {
		return ses.selectOne(ns + "selectInquiryCnt");
	}

	@Override
	public List<InquiryDetailDTO> selectInquiryList(PagingInfoNew pi) throws Exception {
		return ses.selectList(ns + "selectAllInquiryWithPi", pi);
	}
	
	
}
