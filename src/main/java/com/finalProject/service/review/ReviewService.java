package com.finalProject.service.review;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import com.finalProject.model.review.ReviewPagingInfo;
import com.finalProject.model.review.ReviewDTO;
import com.finalProject.model.review.ReviewDetailDTO;

public interface ReviewService {

	// 작성 가능 리뷰 개수
	int countWritableReviews(String member_id) throws Exception;

	// 작성 가능 리뷰 조회
	List<ReviewDTO> getWritableReviews(String member_id, ReviewPagingInfo pagingInfo) throws Exception;

	// 작성 한 리뷰 개수
	int countWrittenReviews(String member_id) throws Exception;

	// 작성 한 리뷰 정보 조회
	List<ReviewDTO> getWrittenReviews(String member_id, ReviewPagingInfo pagingInfo) throws Exception;

	// 리뷰 생성
	void saveReview(ReviewDTO reviewDTO, HttpServletRequest request) throws Exception;

	// 상품 이미지 가져오기
	String getImageUrl(int product_no);

	// 리뷰 상세 조회
	List<ReviewDetailDTO> getReviewDetail(int review_no) throws Exception;

	// 리뷰이미지
	List<String> getReviewImages(int reviewNo) throws Exception;

}
