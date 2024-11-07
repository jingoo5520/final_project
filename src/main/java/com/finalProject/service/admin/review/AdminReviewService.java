package com.finalProject.service.admin.review;

import java.util.Map;

import com.finalProject.model.admin.coupon.PagingInfoNewDTO;

public interface AdminReviewService {

	// 리뷰 리스트 가져오기	
	Map<String, Object> getReviewList(PagingInfoNewDTO pagingInfoDTO) throws Exception;

	// 회원 리뷰 상세보기 이동
	Map<String, Object> getReview(int reviewNo) throws Exception;

}
