package com.finalProject.service.inquiry;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;

import com.finalProject.model.admin.coupon.PagingInfoNewDTO;
import com.finalProject.model.inquiry.InquiryDetailDTO;

public interface InquiryService {

	// 문의 리스트 가져오기
	Map<String, Object> getInquiryList(PagingInfoNewDTO pagingInfoDTO, String memberId) throws Exception;
	
	// 문의 작성하기
	int writeInquiry(InquiryDetailDTO inquiryDetailDTO, MultipartFile[] files, HttpServletRequest request) throws Exception;

	// 문의 상세 가져오기
	Map<String, Object> getInquiry(int inquiryNo) throws Exception;

	// 문의 삭제
	int deleteInquiry(int inquiryNo, HttpServletRequest request) throws Exception;

	// 문의 수정
	int modifyInquiry(InquiryDetailDTO inquiryDetailDTO, MultipartFile[] files, String[] existFiles, HttpServletRequest request) throws Exception;

	
}
