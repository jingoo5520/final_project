package com.finalProject.service.admin.review;

import java.util.Map;

import com.finalProject.model.admin.coupon.PagingInfoNewDTO;
import com.finalProject.model.admin.review.ReviewReplyDTO;

public interface AdminReviewService {

	// 리뷰 리스트 가져오기	
	Map<String, Object> getReviewList(PagingInfoNewDTO pagingInfoDTO) throws Exception;

	// 회원 리뷰 상세보기 이동
	Map<String, Object> getReview(int reviewNo) throws Exception;

	// 리뷰 답글 작성/수정
	int writeReviewReply(ReviewReplyDTO dto) throws Exception;

}
