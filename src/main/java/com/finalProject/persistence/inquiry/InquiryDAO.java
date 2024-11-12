package com.finalProject.persistence.inquiry;

import java.util.List;

import com.finalProject.model.admin.coupon.PagingInfoNew;
import com.finalProject.model.admin.inquiry.InquiryReplyDTO;
import com.finalProject.model.inquiry.InquiryDTO;
import com.finalProject.model.inquiry.InquiryDetailDTO;
import com.finalProject.model.inquiry.InquiryImgDTO;
import com.finalProject.model.inquiry.InquiryProductDTO;

public interface InquiryDAO {

	// 총 문의 개수 가져오기
	int getTotalInquiryCnt(String memberId) throws Exception;

	// 유저 뷰 문의 리스트 가져오기
	List<InquiryDTO> selectInquiryList(PagingInfoNew pi, String memberId) throws Exception;

	// 문의 작성
	int insertInquiry(InquiryDetailDTO inquiryDetailDTO) throws Exception;

	// 작성된 문의 번호 가져오기
	int selectMaxInquiryNo() throws Exception;

	// 문의 작성시 이미지 저장
	int insertInquiryImages(List<InquiryImgDTO> list) throws Exception;

	// 문의 상세 가져오기
	InquiryDetailDTO selectInquiry(int inquiryNo) throws Exception;

	// 문의 상세 이미지 가져오기
	List<InquiryImgDTO> selectInquiryImages(int inquiryNo) throws Exception;

	// 문의 이미지 삭제
	int deleteInquiryImages(int inquiryNo) throws Exception;

	// 문의 삭제
	int deleteInquiry(int inquiryNo) throws Exception;

	// 문의 수정
	int updateInquiry(InquiryDetailDTO inquiryDetailDTO) throws Exception;

	// 문의 이미지 부분 삭제
	int deleteInquiryImage(int inquiry_image_no) throws Exception;

	// 문의 답글 가져오기
	InquiryReplyDTO selectInquiryReply(int inquiryNo) throws Exception;

	// 주문 상품 리스트 가져오기
	List<InquiryProductDTO> selectOrderedProducts(String memberId) throws Exception;
	
	
}
