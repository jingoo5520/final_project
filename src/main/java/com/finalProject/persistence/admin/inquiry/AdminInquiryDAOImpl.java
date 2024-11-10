package com.finalProject.persistence.admin.inquiry;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.finalProject.model.admin.coupon.PagingInfoNew;
import com.finalProject.model.admin.inquiry.InquiryReplyDTO;
import com.finalProject.model.admin.inquiry.InquirySearchFilterDTO;
import com.finalProject.model.inquiry.InquiryDetailDTO;
import com.finalProject.model.inquiry.InquiryImgDTO;

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

	@Override
	public InquiryDetailDTO selectInquiry(int inquiryNo) throws Exception {
		return ses.selectOne(ns + "selectInquiry", inquiryNo);
	}

	@Override
	public InquiryReplyDTO selectInquiryReply(int inquiryNo) throws Exception {
		return ses.selectOne(ns + "selectInquiryReply", inquiryNo);
	}

	@Override
	public List<InquiryImgDTO> selectInquiryImages(int inquiryNo) throws Exception {
		return ses.selectList(ns + "selectInquiryImgList", inquiryNo);
	}

	@Override
	public int insertInquiryReply(InquiryReplyDTO dto) throws Exception {
		return ses.insert(ns + "insertInquiryReply", dto);
	}

	@Override
	public int updateInquiryReply(InquiryReplyDTO dto) throws Exception {
		return ses.insert(ns + "updateInquiryReply", dto);
	}

	@Override
	public int updateInquiryStatus(int inquiryNo) throws Exception {
		return ses.update(ns + "updateInquiryStatus", inquiryNo);
	}

	@Override
	public int getTotalFilterdInquiryCnt(InquirySearchFilterDTO dto) throws Exception {
		return ses.selectOne(ns + "selectFilteredMemberCnt", dto);
	}

	@Override
	public List<InquiryDetailDTO> selectFilteredInquiryList(InquirySearchFilterDTO dto, PagingInfoNew pi) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("dto", dto);
		params.put("pi", pi);
		
		return ses.selectList(ns + "selectFilteredInquiryList", params);
	}
} 

