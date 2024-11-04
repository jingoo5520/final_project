package com.finalProject.persistence.review;

import java.util.List;

import com.finalProject.model.review.ReviewPagingInfo;
import com.finalProject.model.review.ReviewDTO;

public interface ReviewDAO {

	// 작성 가능 리뷰 개수
	int selectCountWritableReviews(String member_id) throws Exception;

	// 작성 가능 리뷰 조회
	List<ReviewDTO> selectWritableReviews(String member_id, ReviewPagingInfo pagingInfo) throws Exception;

}
