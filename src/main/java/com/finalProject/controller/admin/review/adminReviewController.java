package com.finalProject.controller.admin.review;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.finalProject.model.LoginDTO;
import com.finalProject.model.admin.review.ReviewReplyDTO;
import com.finalProject.model.admin.review.ReviewSearchFilterDTO;
import com.finalProject.service.admin.review.AdminReviewService;

@Controller
@RequestMapping("/admin/review")
public class adminReviewController {

	@Inject
	AdminReviewService arService;

	// 리뷰 페이지 이동
	@GetMapping("/adminReviews")
	public String reviewPage() {
		return "/admin/pages/review/adminReviews";
	}

	// 리뷰 리스트 가져오기
	@PostMapping("/getReviewList")
	@ResponseBody
	public Map<String, Object> getReviewList(@ModelAttribute ReviewSearchFilterDTO dto) {
		Map<String, Object> data = new HashMap<String, Object>();

		try {
			data = arService.getReviewList(dto);
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

		System.out.println(review);

		model.addAttribute("reviewDetail", review.get("reviewDetail"));
		model.addAttribute("reviewImages", review.get("reviewImages"));
		model.addAttribute("reviewReply", review.get("reviewReply"));

		return "/admin/pages/review/adminReviewDetail";
	}

	// 리뷰 답글 저장, 수정
	@PostMapping("/saveReviewReply")
	public ResponseEntity<String> saveReviewReply(@RequestParam("reviewNo") int reviewNo,
			@RequestParam("replyContent") String replyContent, @RequestParam("reviewTitle") String reviewTitle,
			@RequestParam("reviewReplyNo") int reviewReplyNo, @RequestParam("productNo") int productNo,
			HttpServletRequest request) {
		String result = "";

		HttpSession ses = request.getSession();
		LoginDTO loginDTO = (LoginDTO) ses.getAttribute("loginMember");
		String memberId = loginDTO.getMember_id();

		String replyTitle = "[Re] " + reviewTitle;

		ReviewReplyDTO dto = ReviewReplyDTO.builder().product_no(productNo).member_id(memberId)
				.review_no(reviewReplyNo).review_ref(reviewNo).review_title(replyTitle).review_content(replyContent)
				.build();

		try {
			arService.writeReviewReply(dto);
			result = "success";
		} catch (Exception e) {
			e.printStackTrace();
			result = "fail";
		}

		return new ResponseEntity<String>(result, HttpStatus.OK);
	}

	// 리뷰 삭제
	@PostMapping("/deleteReview")
	@ResponseBody
	public ResponseEntity<String> deleteCoupon(@RequestParam int reviewNo, @RequestParam String reason) {
		String result = "";

		try {
			arService.deleteReview(reviewNo, reason);
			result = "success";
		} catch (Exception e) {
			result = "fail";
			e.printStackTrace();
		}

		return new ResponseEntity<String>(result, HttpStatus.OK);
	}

}
