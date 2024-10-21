package com.finalProject.persistence;

import java.util.List;

import com.finalProject.model.CouponDTO;

public interface CouponDAO {

	// 쿠폰 리스트 가져오기
	List<CouponDTO> selectCouponList() throws Exception;
		
	// 쿠폰 생성
	int insertCoupon(CouponDTO couponDTO) throws Exception;

	// 쿠폰 수정
	int updateCoupon(CouponDTO couponDTO) throws Exception;
}
