package com.finalProject.controller.benefit;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/member/myPage")
public class BenefitController {
	
	// 마이페이지 - 포인트 페이지 이동
	@GetMapping("/points")
	public String pointsPage() {
		return "/user/pages/benefit/points";
	}
	
	// 마이페이지 - 쿠폰 페이지 이동
	@GetMapping("/coupons")
	public String couponsPage() {
		return "/user/pages/benefit/coupons";
	}
}
