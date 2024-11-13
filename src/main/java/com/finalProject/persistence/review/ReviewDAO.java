package com.finalProject.persistence.review;

import java.util.List;
import com.finalProject.model.review.ReviewDTO;
import com.finalProject.model.review.ReviewDetailDTO;
import com.finalProject.model.review.ReviewPagingInfo;

public interface ReviewDAO {

	// 작성 가능 리뷰 개수
	int selectCountWritableReviews(String member_id) throws Exception;

	// 작성 가능 리뷰 조회
	List<ReviewDTO> selectWritableReviews(String member_id, ReviewPagingInfo pagingInfo) throws Exception;

	// 작성 한 리뷰 개수
	int selectCountWrittenReviews(String member_id) throws Exception;

	// 작성 한 리뷰 조회
	List<ReviewDTO> selectWrittenReviews(String member_id, ReviewPagingInfo pagingInfo) throws Exception;

    // 리뷰 데이터 저장
    void insertReview(ReviewDTO reviewDTO) throws Exception;

    // 리뷰 이미지 정보 저장
    void insertReviewImages(List<ReviewDTO> imageList) throws Exception;

	// 이미지
	String getImage(int product_no);

	// 리뷰 상세 정보
	List<ReviewDetailDTO> selectReviewDetail(int review_no) throws Exception;

	// 리뷰 이미지
	List<String> selectReviewImage(int reviewNo) throws Exception;

	// 관리자 답글 판별
	boolean checkAdminReply(int reviewNo) throws Exception;

	// 리뷰 수정
	void updateReview(ReviewDTO reviewDTO) throws Exception;
	
	// 리뷰 이미지 삭제
	void deleteReviewImage(String imageUrl) throws Exception;

	// 리뷰 이미지 추가
	void modifyinsertReviewImage(ReviewDTO reviewImageDTO) throws Exception;

	// 원래 있던 파일 리스트
	List<String> selectExistFileList(int reviewNo) throws Exception;



}
