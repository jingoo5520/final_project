package com.finalProject.persistence.inquiry;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.finalProject.model.admin.coupon.PagingInfoNew;
import com.finalProject.model.admin.inquiry.InquiryReplyDTO;
import com.finalProject.model.inquiry.InquiryDTO;
import com.finalProject.model.inquiry.InquiryDetailDTO;
import com.finalProject.model.inquiry.InquiryImgDTO;
import com.finalProject.model.inquiry.InquiryProductDTO;

@Repository
public class InquiryDAOImpl implements InquiryDAO {

	@Inject
	private SqlSession ses;

	private static String ns = "com.finalProject.mappers.inquiryMapper.";

	@Override
	public int getTotalInquiryCnt(String memberId) throws Exception {
		return ses.selectOne(ns + "selectInquiryCnt", memberId);
	}

	@Override
	public List<InquiryDTO> selectInquiryList(PagingInfoNew pi, String memberId) throws Exception {

		System.out.println(pi);

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("member_id", memberId);
		map.put("pi", pi);

		return ses.selectList(ns + "selectAllInquiryWithPi", map);
	}

	@Override
	public int insertInquiry(InquiryDetailDTO inquiryDetailDTO) throws Exception {
		return ses.insert(ns + "insertInquiry", inquiryDetailDTO);
	}

	@Override
	public int selectMaxInquiryNo() throws Exception {
		return ses.selectOne(ns + "selectMaxInquiryNo");
	}

	@Override
	public int insertInquiryImages(List<InquiryImgDTO> list) throws Exception {
		return ses.insert(ns + "insertInquiryImages", list);
	}

	@Override
	public InquiryDetailDTO selectInquiry(int inquiryNo) throws Exception {
		return ses.selectOne(ns + "selectInquiry", inquiryNo);
	}

	@Override
	public List<InquiryImgDTO> selectInquiryImages(int inquiryNo) throws Exception {
		return ses.selectList(ns + "selectInquiryImgList", inquiryNo);
	}

	@Override
	public int deleteInquiryImages(int inquiryNo) throws Exception {
		return ses.delete(ns + "deleteInquiryImages", inquiryNo);
	}

	@Override
	public int deleteInquiry(int inquiryNo) throws Exception {
		return ses.delete(ns + "deleteInquiry", inquiryNo);
	}

	@Override
	public int updateInquiry(InquiryDetailDTO inquiryDetailDTO) throws Exception {
		return ses.update(ns + "updateInquiry", inquiryDetailDTO);
	}

	@Override
	public int deleteInquiryImage(int inquiry_image_no) throws Exception {
		return ses.delete(ns + "deleteInquiryImage", inquiry_image_no);
	}

	@Override
	public InquiryReplyDTO selectInquiryReply(int inquiryNo) throws Exception {
		return ses.selectOne(ns + "selectInquiryReply", inquiryNo);
	}

	@Override
	public List<InquiryProductDTO> selectOrderedProducts(String memberId) throws Exception {
		return ses.selectList(ns + "selectOrderedProducts", memberId);
	}

}
