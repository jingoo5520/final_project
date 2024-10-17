package com.finalProject.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AdminController {
	// 관리자 페이지 이동
	@GetMapping("/admin")
	public String adminPage() {
		System.out.println("to admin index page");
		return "/admin/index";
	}

	// 쿠폰 관리 - 쿠폰 페이지 이동
	@GetMapping("/admin/coupons")
	public String couponPage() {
		return "/admin/pages/coupons";
	}

	// 쿠폰 관리 - 쿠폰 사용 내역 페이지 이동
	@GetMapping("/admin/couponUseLog")
	public String couponUseLogPage() {
		return "/admin/pages/couponUseLog";
	}
}
