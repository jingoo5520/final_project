package com.finalProject.persistence.admin.review;

import java.util.List;

import com.finalProject.model.admin.coupon.CouponDTO;
import com.finalProject.model.admin.coupon.PagingInfoNew;

public interface AdminReviewDao {

	// 리뷰 총 개수 가져오기	
	int selectTotalReviewCnt() throws Exception;

	// 리뷰 리스트 가져오기
	List<CouponDTO> selectReviewList(PagingInfoNew pi) throws Exception;

}
