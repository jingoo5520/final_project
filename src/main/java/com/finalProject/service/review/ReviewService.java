package com.finalProject.service.review;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;

import com.finalProject.model.review.ReviewPagingInfo;
import com.finalProject.model.review.PointEarnedDTO;
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
	void saveReview(ReviewDTO reviewDTO, HttpServletRequest request, PointEarnedDTO pointDTO) throws Exception;

	// 상품 이미지 가져오기
	String getImageUrl(int product_no);

	// 리뷰 상세 조회
	List<ReviewDetailDTO> getReviewDetail(int review_no) throws Exception;

	// 리뷰이미지
	List<String> getReviewImages(int reviewNo) throws Exception;

	// 관리자 답글이 있는경우 수정 불가
	boolean hasAdminReply(int reviewNo) throws Exception;

	// 수정 데이터 전달
	void modifyReview(int reviewNo, String reviewTitle, String reviewContent, int reviewScore) throws Exception;

	// 수정 이미지 데이터
	void modifyReviewImg(int reviewNo, MultipartFile[] files, List<String> existFiles, List<String> removedFiles,
			HttpServletRequest request) throws Exception;

	// 기존에 이미지 리스트
	List<String> getExistFileList(int reviewNo) throws Exception;

	// 리뷰 삭제
	void deleteReview(int reviewNo, HttpServletRequest request)  throws Exception;



}