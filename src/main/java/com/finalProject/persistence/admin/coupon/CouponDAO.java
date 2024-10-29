package com.finalProject.persistence.admin.coupon;

import java.util.List;

import com.finalProject.model.admin.CouponDTO;
import com.finalProject.model.admin.CouponPayDTO;
import com.finalProject.model.admin.PagingInfoNew;

public interface CouponDAO {

	// 총 쿠폰 개수 가져오기
	int getTotalCouponCnt() throws Exception;
	
	// 쿠폰 리스트 가져오기
	List<CouponDTO> selectCouponList() throws Exception;
	List<CouponDTO> selectCouponList(PagingInfoNew pi) throws Exception;
	
	// 쿠폰 정보 가져오기
	CouponDTO selectCoupon(int couponNo) throws Exception;
		
	// 쿠폰 생성
	int insertCoupon(CouponDTO couponDTO) throws Exception;

	// 쿠폰 수정
	int updateCoupon(CouponDTO couponDTO) throws Exception;
	
	// 쿠폰 삭제
	int deleteCoupon(int coupon_no) throws Exception;

	// 쿠폰 지급
	int insertCouponPayLogs(List<CouponPayDTO> list) throws Exception;
}
