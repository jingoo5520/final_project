package com.finalProject.controller.admin;

import java.util.List;

import javax.inject.Inject;

import org.springframework.dao.DuplicateKeyException;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.finalProject.model.CouponDTO;
import com.finalProject.service.CouponService;

@Controller
@RequestMapping("/admin/coupons")
public class CouponController {

	@Inject
	CouponService cService;
	
	// 쿠폰 리스트 가져오기
	@PostMapping("/getCouponList")
	@ResponseBody
	public List<CouponDTO> getCouponList() {
		String result = "";
		List<CouponDTO> list = null;

		try {
			list = cService.getCouponList();
			result = "success";
		} catch (Exception e) {
			result = "fail";
			e.printStackTrace();
		}

		
		return list;
	}

	// 쿠폰 생성
	@PostMapping("/createCoupon")
	@ResponseBody
	public ResponseEntity<String> createCoupon(@RequestParam String couponName, @RequestParam String couponType,
			@RequestParam int couponDcAmount, @RequestParam float couponDcRate) {
		String result = "";

		System.out.println("/createCoupon");

		System.out.println(couponName);
		System.out.println(couponType);
		System.out.println(couponDcAmount);
		System.out.println(couponDcRate);

		CouponDTO couponDTO = CouponDTO.builder().coupon_name(couponName).coupon_dc_type(couponType)
				.coupon_dc_amount(couponDcAmount).coupon_dc_rate(couponDcRate).build();

		try {
			cService.createCoupon(couponDTO);
			result = "success";
		} catch (DuplicateKeyException e) {
			result = "duplicated";
		} catch (Exception e) {
			result = "fail";
			e.printStackTrace();
		}

		return new ResponseEntity<String>(result, HttpStatus.OK);
	}
	
	// 쿠폰 수정
	@PostMapping("/updateCoupon")
	@ResponseBody
	public ResponseEntity<String> updateCoupon(@RequestParam int couponNo, @RequestParam String couponName, @RequestParam String couponType,
			@RequestParam int couponDcAmount, @RequestParam float couponDcRate) {
		String result = "";

		System.out.println("/updateCoupon");

		System.out.println(couponNo);
		
		

		CouponDTO couponDTO = CouponDTO.builder().coupon_no(couponNo).coupon_name(couponName).coupon_dc_type(couponType)
				.coupon_dc_amount(couponDcAmount).coupon_dc_rate(couponDcRate).build();

		try {
			cService.updateCoupon(couponDTO);
			result = "success";
		} catch (DuplicateKeyException e) {
			result = "duplicated";
		} catch (Exception e) {
			result = "fail";
			e.printStackTrace();
		}

		return new ResponseEntity<String>(result, HttpStatus.OK);
	}
	
}
