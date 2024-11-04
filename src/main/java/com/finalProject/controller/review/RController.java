package com.finalProject.controller.review;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.finalProject.model.LoginDTO;
import com.finalProject.model.review.ReviewDTO;
import com.finalProject.model.review.ReviewPagingInfo;
import com.finalProject.model.review.ReviewPagingInfoDTO;
import com.finalProject.service.member.MemberService;
import com.finalProject.service.review.ReviewService;
import com.mysql.cj.Session;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/review")
public class RController {

	@Autowired
	private ReviewService service;
	
	@Autowired
	private MemberService MService;

	
	// 작성 가능한 리뷰
	@GetMapping("/writableReview")
	public String WritableReview(@RequestParam(defaultValue = "1") int page, HttpServletRequest request, ReviewPagingInfoDTO pagingInfoDTO, Model model) throws Exception {
	    
	    HttpSession session = request.getSession();
	    LoginDTO loginMember = (LoginDTO) session.getAttribute("loginMember");
	    
	    System.out.println("데이터");
	    System.out.println(loginMember);

	    if (loginMember != null) {
	    	
	        // 1. 총 작성 가능한 리뷰 개수를 가져옴
	        int totalWritableReviews = service.countWritableReviews(loginMember.getMember_id());
	        
	        // 2. 페이징 정보 생성 
	        pagingInfoDTO.setTotalPostCnt(totalWritableReviews); // 이미 메서드 파라미터로 전달받았으므로 재생성 불필요
	        ReviewPagingInfo pagingInfo = new ReviewPagingInfo(pagingInfoDTO, totalWritableReviews);
	        
	        // 3. 작성 가능한 리뷰 목록 조회 및 모델에 추가
	        model.addAttribute("reviews", service.getWritableReviews(loginMember.getMember_id(), pagingInfo));
	        model.addAttribute("pagingInfo", pagingInfo);
	        
	        System.out.println("이거 뜨면 로그인 된거임");
	        System.out.println(service.getWritableReviews(loginMember.getMember_id(), pagingInfo));
	        System.out.println("로그인된 회원 ID: " + loginMember.getMember_id());
	        System.out.println("총 작성 가능한 리뷰 개수: " + totalWritableReviews);
	        System.out.println("페이징 시작 인덱스: " + pagingInfo.getStartRowIndex());
	        System.out.println("페이지당 조회 개수: " + pagingInfo.getPageSize());

	    } else {
	        System.out.println("로그인 정보 없음");
	        return "redirect:/member/viewLogin"; // 로그인 정보가 없을 경우 로그인페이지
	    }
	    
	    return "/user/pages/review/review";
	}

	
	
	// 작성 한 리뷰
	@GetMapping("/writtenByReview")
	public String WrittenByReview () {
		
		
		
		return "/user/pages/review/review"; 
	}
	
	// 리뷰 작성 페이지
	@RequestMapping ("/writeReview")
	public String WriteReview () {
		
		return "/user/pages/review/writeReview"; 
	}
	
	
	
}
