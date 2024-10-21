package com.finalProject.service;

import java.util.List;

import com.finalProject.model.CouponDTO;

public interface CouponService {
	
	// 쿠폰 리스트 가져오기
	List<CouponDTO> getCouponList() throws Exception;
	
	// 쿠폰 생성
	int createCoupon(CouponDTO couponDTO) throws Exception;
	
	// 쿠폰 수정
	int updateCoupon(CouponDTO couponDTO) throws Exception;
}
