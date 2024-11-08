package com.finalProject.persistence.admin.review;

import java.util.List;

import com.finalProject.model.admin.coupon.CouponDTO;
import com.finalProject.model.admin.coupon.PagingInfoNew;
import com.finalProject.model.admin.review.AdminReviewDetailDTO;
import com.finalProject.model.admin.review.ReviewImgDTO;
import com.finalProject.model.admin.review.ReviewReplyDTO;

public interface AdminReviewDAO {

	// 리뷰 총 개수 가져오기	
	int selectTotalReviewCnt() throws Exception;

	// 리뷰 리스트 가져오기
	List<CouponDTO> selectReviewList(PagingInfoNew pi) throws Exception;

	// 리뷰 상제 정보 가져오기
	AdminReviewDetailDTO selectReview(int reviewNo) throws Exception;

	// 리뷰 이미지 가져오기
	List<ReviewImgDTO> selectReviewImages(int reviewNo) throws Exception;

	// 리뷰 답글 가져오기
	ReviewReplyDTO selectReviewReply(int reviewNo) throws Exception;

	// 리뷰 답글 작성 
	int insertReviewReply(ReviewReplyDTO dto) throws Exception;
	
	// 리뷰 답글 수정
	int updateReviewReply(ReviewReplyDTO dto) throws Exception;
}
