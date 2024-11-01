package com.finalProject.service.admin.inquiry;

import java.util.Map;

import com.finalProject.model.admin.coupon.PagingInfoNewDTO;

public interface AdminInquiryService {

	// 문의 리스트 가져오기
	Map<String, Object> getInquiryList(PagingInfoNewDTO pagingInfoDTO) throws Exception;
	
	
}
