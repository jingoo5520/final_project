package com.finalProject.controller.admin.review;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.finalProject.model.admin.coupon.PagingInfoNewDTO;
import com.finalProject.model.admin.review.AdminReviewDTO;
import com.finalProject.service.admin.review.AdminReviewService;

@Controller
@RequestMapping("/admin/review")
public class adminReviewController {

	@Inject
	AdminReviewService arService;

	// 리뷰 페이지 이동
	@GetMapping("/reviews")
	public String reviewPage() {
		return "/admin/pages/review/adminReviews";
	}

	// 리뷰 리스트 가져오기
	@GetMapping("/getReviewList")
	@ResponseBody
	public Map<String, Object> getCouponList(@RequestParam int pageNo, @RequestParam int pagingSize,
			@RequestParam int pageCntPerBlock) {
		Map<String, Object> data = new HashMap<String, Object>();

		try {
			data = arService.getReviewList(new PagingInfoNewDTO(pageNo, pagingSize, pageCntPerBlock));
		} catch (Exception e) {
			e.printStackTrace();
		}

		return data;
	}

	// 리뷰 상세보기 페이지 이동
	@GetMapping("/adminReviewDetail")
	public String adminReviewDetailPage(@RequestParam(value = "reviewNo") int reviewNo, Model model) {
		Map<String, Object> review = null;

		try {
			review = arService.getReview(reviewNo);

		} catch (Exception e) {
			e.printStackTrace();
		}

//		System.out.println("inquiry.get(\"inquiryReply\"): " + inquiry.get("inquiryReply"));
//
//		model.addAttribute("inquiryDetail", inquiry.get("inquiryDetail"));
//		model.addAttribute("inquiryImgList", inquiry.get("inquiryImgList"));
//		model.addAttribute("inquiryReply", inquiry.get("inquiryReply"));

		return "/admin/pages/review/adminReviewDetail";
	}

}
