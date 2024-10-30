package com.finalProject.persistence.inquiry;

import java.util.List;

import com.finalProject.model.admin.coupon.PagingInfoNew;
import com.finalProject.model.inquiry.InquiryDTO;

public interface InquiryDAO {

	// 총 문의 개수 가져오기
	int getTotalInquiryCnt() throws Exception;

	// 유저 뷰 문의 리스트 가져오기
	List<InquiryDTO> selectInquiryList(PagingInfoNew pi, String memberId) throws Exception;
}
