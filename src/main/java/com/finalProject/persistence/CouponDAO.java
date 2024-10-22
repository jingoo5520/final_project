package com.finalProject.persistence;

import java.util.List;

import com.finalProject.model.CouponDTO;
import com.finalProject.model.PagingInfo;

public interface CouponDAO {

	// 총 쿠폰 개수 가져오기
	int getTotalCouponCnt() throws Exception;
	
	// 쿠폰 리스트 가져오기
	List<CouponDTO> selectCouponList(PagingInfo pi) throws Exception;
		
	// 쿠폰 생성
	int insertCoupon(CouponDTO couponDTO) throws Exception;

	// 쿠폰 수정
	int updateCoupon(CouponDTO couponDTO) throws Exception;
	
	// 쿠폰 삭제
	int deleteCoupon(int coupon_no) throws Exception;
}
