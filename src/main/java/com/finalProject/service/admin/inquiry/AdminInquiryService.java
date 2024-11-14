package com.finalProject.service.admin.inquiry;

import java.util.Map;

import com.finalProject.model.admin.coupon.PagingInfoNewDTO;
import com.finalProject.model.admin.inquiry.InquiryReplyDTO;
import com.finalProject.model.admin.inquiry.InquirySearchFilterDTO;

public interface AdminInquiryService {

	// 문의 리스트 가져오기
	Map<String, Object> getInquiryList(PagingInfoNewDTO pagingInfoDTO) throws Exception;

	// 문의 상세 내용 가져오기
	Map<String, Object> getInquiry(int inquiryNo) throws Exception;

	// 문의 답글 작성
	int writeInquiryReply(InquiryReplyDTO dto) throws Exception;

	// 문의 리스트 가져오기(필터)
	Map<String, Object> getFilterdInquiryList(InquirySearchFilterDTO dto) throws Exception;
}
