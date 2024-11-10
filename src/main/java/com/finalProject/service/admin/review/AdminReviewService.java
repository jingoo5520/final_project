package com.finalProject.service.admin.review;

import java.util.Map;

import com.finalProject.model.admin.review.ReviewReplyDTO;
import com.finalProject.model.admin.review.ReviewSearchFilterDTO;

public interface AdminReviewService {

	// 리뷰 리스트 가져오기	
	Map<String, Object> getReviewList(ReviewSearchFilterDTO dto) throws Exception;

	// 회원 리뷰 상세보기 이동
	Map<String, Object> getReview(int reviewNo) throws Exception;

	// 리뷰 답글 작성/수정
	int writeReviewReply(ReviewReplyDTO dto) throws Exception;

	// 리뷰 삭제
	int deleteReview(int reviewNo, String reason) throws Exception;

}
