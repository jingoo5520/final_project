package com.finalProject.persistence.admin.inquiry;

import java.util.List;

import com.finalProject.model.admin.coupon.PagingInfoNew;
import com.finalProject.model.inquiry.InquiryDetailDTO;

public interface AdminInquiryDAO {
	// 문의 총 개수 가져오기
	int getTotalInquiryCnt() throws Exception;
	
	// 관리자 - 문의 리스트 가져오기
	List<InquiryDetailDTO> selectInquiryList(PagingInfoNew pi) throws Exception;
}
