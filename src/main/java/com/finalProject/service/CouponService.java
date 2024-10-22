package com.finalProject.service;

import java.util.List;
import java.util.Map;

import com.finalProject.model.CouponDTO;
import com.finalProject.model.PagingInfoDTO;

public interface CouponService {
	
	// 쿠폰 리스트 가져오기
	Map<String, Object> getCouponList(PagingInfoDTO pagingInfoDTO) throws Exception;
	
	// 쿠폰 생성
	int createCoupon(CouponDTO couponDTO) throws Exception;
	
	// 쿠폰 수정
	int updateCoupon(CouponDTO couponDTO) throws Exception;
	
	// 쿠폰 삭제
	int deleteCoupon(int coupon_no) throws Exception;
}
