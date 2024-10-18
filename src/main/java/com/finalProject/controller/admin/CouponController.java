package com.finalProject.controller.admin;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
		} catch (Exception e) {
			result = "fail";
			e.printStackTrace();
		}

		return new ResponseEntity<String>(result, HttpStatus.OK);
	}

}
