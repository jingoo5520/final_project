package com.finalProject.controller.review;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.finalProject.controller.product.PController;
import com.finalProject.service.review.ReviewService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/review")
public class RController {

//	@Autowired
//	private ReviewService serivce;
	
	@GetMapping ("c")
	public String justShowReviewPage() {
		return "/user/pages/review/review";
	}
	
	@PostMapping ("c")
	public String CRUDReview() {
		
		return "/user/pages/review/review";
	}
	
	
	
}
