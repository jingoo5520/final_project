package com.finalProject.controller.inquiry;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/myPage")
public class inquiryController {

	
	// 문의 작성 페이지 이동
	@GetMapping("/writeInquiry")
	public String writeInquiryPage() {
		
		return "/user/pages/writeInquiry";
	}
}
