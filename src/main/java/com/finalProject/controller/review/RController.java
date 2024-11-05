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
	        
	        pagingInfoDTO.setPageNo(page);
	        pagingInfoDTO.setPageSize(3); // 한 페이지당 3개의 게시물만 보이도록 설정
	        pagingInfoDTO.setTotalPostCnt(totalWritableReviews);
	        
	        ReviewPagingInfo pagingInfo = new ReviewPagingInfo(pagingInfoDTO, totalWritableReviews);
	        
	        // 2. 조회가능 리뷰
	        List<ReviewDTO> writableReviews = service.getWritableReviews(loginMember.getMember_id(), pagingInfo);
	        
	        // 3. 작성 가능한 리뷰 목록 조회 및 모델에 추가
	        model.addAttribute("writtenReviews", writableReviews);
	        model.addAttribute("pagingInfo", pagingInfo);
	        
	        // 조건부 렌더링
	        model.addAttribute("currentPath", "/review/writableReview");
	        
	        System.out.println("C이거 뜨면 로그인 된거임");
	        System.out.println(writableReviews);
	        System.out.println("C로그인된 회원 ID: " + loginMember.getMember_id());
	        System.out.println("C총 작성 가능한 리뷰 개수: " + totalWritableReviews);

	    } else {
	        System.out.println("로그인 정보 없음");
	        return "redirect:/member/viewLogin"; // 로그인 정보가 없을 경우 로그인페이지
	    }
	    
	    return "/user/pages/review/review";
	}

	
	
	// 작성 한 리뷰
	@GetMapping("/writtenByReview")
	public String WrittenByReview (@RequestParam(defaultValue = "1") int page, HttpServletRequest request, ReviewPagingInfoDTO pagingInfoDTO, Model model) throws Exception {
		
	    HttpSession session = request.getSession();
	    LoginDTO loginMember = (LoginDTO) session.getAttribute("loginMember");
		
	    if (loginMember != null) {
	    	
	        // 1. 총 작성한 리뷰 개수를 가져옴
	        int totalWrittenReviews = service.countWrittenReviews(loginMember.getMember_id());
	        
	        pagingInfoDTO.setPageNo(page);
	        pagingInfoDTO.setPageSize(3); // 한 페이지당 3개의 게시물만 보이도록 설정
	        pagingInfoDTO.setTotalPostCnt(totalWrittenReviews);
	        
	        ReviewPagingInfo pagingInfo = new ReviewPagingInfo(pagingInfoDTO, totalWrittenReviews);
	        
	        // 2. 작성한 리뷰 조회
	        List<ReviewDTO> writtenReviews = service.getWrittenReviews(loginMember.getMember_id(), pagingInfo);
	        
	        // 3. 작성한 리뷰 목록 조회 및 모델에 추가
	        model.addAttribute("writableReviews", writtenReviews);
	        model.addAttribute("pagingInfo", pagingInfo);
	        
	        
	        // 조건부 렌더링
	        model.addAttribute("currentPath", "/review/writtenByReview");
	        
	        System.out.println("가능 충 데이터 : " + writtenReviews);
	        System.out.println("C로그인된 회원 ID: " + loginMember.getMember_id());
	        System.out.println("C총 작성한 리뷰 개수: " + totalWrittenReviews);
	    } else {
	        System.out.println("로그인 정보 없음");
	        return "redirect:/member/viewLogin"; // 로그인 정보가 없을 경우 로그인페이지
	    }
	    
	    return "/user/pages/review/review"; // 작성한 리뷰 페이지로 이동
	}
	
	// 리뷰 작성 페이지
	@RequestMapping ("/writeReview")
	public String WriteReview () {
		
		return "/user/pages/review/writeReview"; 
	}
	
	
	
}
