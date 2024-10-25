package com.finalProject.service.admin.coupon;

import java.util.List;
import java.util.Map;

import com.finalProject.model.admin.CouponDTO;
import com.finalProject.model.admin.PagingInfoDTO;

public interface CouponService {
	
	// 쿠폰 리스트 가져오기
	List<CouponDTO> getCouponList() throws Exception;
	Map<String, Object> getCouponList(PagingInfoDTO pagingInfoDTO) throws Exception;
	
	// 쿠폰 생성
	int createCoupon(CouponDTO couponDTO) throws Exception;
	
	// 쿠폰 수정
	int updateCoupon(CouponDTO couponDTO) throws Exception;
	
	// 쿠폰 삭제
	int deleteCoupon(int coupon_no) throws Exception;
	
	// 쿠폰 지급
	int payCoupon(List<String> memberIdList, int couponNo) throws Exception;
}
