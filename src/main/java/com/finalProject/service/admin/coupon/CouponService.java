package com.finalProject.service.admin.coupon;

import java.util.List;
import java.util.Map;

import com.finalProject.model.admin.coupon.CouponDTO;
import com.finalProject.model.admin.coupon.PagingInfoNewDTO;

public interface CouponService {
	
	// 쿠폰 리스트 가져오기
	List<CouponDTO> getCouponList() throws Exception;
	Map<String, Object> getCouponList(PagingInfoNewDTO pagingInfoDTO) throws Exception;
	
	// 쿠폰 생성
	int createCoupon(CouponDTO couponDTO) throws Exception;
	
	// 쿠폰 수정
	int updateCoupon(CouponDTO couponDTO) throws Exception;
	
	// 쿠폰 삭제
	int deleteCoupon(int coupon_no) throws Exception;
	
	// 쿠폰 지급
	int payCoupon(List<String> memberIdList, int couponNo) throws Exception;
	
	// 쿠폰 지급 로그 리스트 가져오기
	Map<String, Object> getCouponPayLogList(PagingInfoNewDTO pagingInfoDTO) throws Exception;
	
	
}
