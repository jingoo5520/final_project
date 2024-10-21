package com.finalProject.controller.admin;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.finalProject.model.CouponDTO;
import com.finalProject.service.CouponService;


@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Inject
	CouponService cService;
	
	// 관리자 페이지 이동
	@GetMapping("/")
	public String adminPage() {
		System.out.println("to admin index page");
		return "/admin/index";
	}

	// 쿠폰 관리 - 쿠폰 페이지 이동
	@GetMapping("/coupons")
	public String couponPage(Model model) {
		// 이동시 쿠폰 리스트를 가져오며
		String result = "";
		List<CouponDTO> list = null;

		try {
			list = cService.getCouponList();
			result = "success";
		} catch (Exception e) {
			result = "fail";
			e.printStackTrace();
		}

		System.out.println(list);
		
		model.addAttribute("couponList", list);
		return "/admin/pages/coupons";
	}

	// 쿠폰 관리 - 쿠폰 사용 내역 페이지 이동
	@GetMapping("/couponUseLog")
	public String couponUseLogPage() {
		return "/admin/pages/couponUseLog";
	}
	
	// 쿠폰 관리 - 쿠폰 지급 페이지 이동
		@GetMapping("/couponPay")
		public String couponPayPage() {
			return "/admin/pages/couponPay";
		}
}
