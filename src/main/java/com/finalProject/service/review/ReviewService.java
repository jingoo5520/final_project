package com.finalProject.service.review;

import java.util.List;

import com.finalProject.model.review.ReviewPagingInfo;
import com.finalProject.model.review.ReviewDTO;

public interface ReviewService {

	// 작성 가능 리뷰 개수
	int countWritableReviews(String member_id) throws Exception;

	// 작성 가능 리뷰 조회
	List<ReviewDTO> getWritableReviews(String member_id, ReviewPagingInfo pagingInfo) throws Exception;

}
