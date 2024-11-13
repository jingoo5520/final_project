package com.finalProject.persistence.admin.inquiry;

import java.util.List;

import com.finalProject.model.admin.coupon.PagingInfoNew;
import com.finalProject.model.admin.inquiry.InquiryReplyDTO;
import com.finalProject.model.admin.inquiry.InquirySearchFilterDTO;
import com.finalProject.model.inquiry.InquiryDetailDTO;
import com.finalProject.model.inquiry.InquiryImgDTO;

public interface AdminInquiryDAO {
	// 문의 총 개수 가져오기
	int getTotalInquiryCnt() throws Exception;

	// 관리자 - 문의 리스트 가져오기
	List<InquiryDetailDTO> selectInquiryList(PagingInfoNew pi) throws Exception;

	// 문의 상세 가져오기
	InquiryDetailDTO selectInquiry(int inquiryNo) throws Exception;

	// 문의 상세 이미지 가져오기
	List<InquiryImgDTO> selectInquiryImages(int inquiryNo) throws Exception;

	// 문의 답글 가져오기
	InquiryReplyDTO selectInquiryReply(int inquiryNo) throws Exception;

	// 문의 답글 작성
	int insertInquiryReply(InquiryReplyDTO dto) throws Exception;

	// 문의 답글 수정
	int updateInquiryReply(InquiryReplyDTO dto) throws Exception;

	// 문의 답글 작성 후 문의 상태 변경
	int updateInquiryStatus(int inquiryNo) throws Exception;

	// 문의 총 개수 가져오기(필터)
	int getTotalFilterdInquiryCnt(InquirySearchFilterDTO dto) throws Exception;

	// 문의 리스트 가져오기(필터)
	List<InquiryDetailDTO> selectFilteredInquiryList(InquirySearchFilterDTO dto, PagingInfoNew pi);
}
