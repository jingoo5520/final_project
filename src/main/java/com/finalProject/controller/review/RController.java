package com.finalProject.controller.review;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.finalProject.model.LoginDTO;
import com.finalProject.model.review.PointEarnedDTO;
import com.finalProject.model.review.ReviewDTO;
import com.finalProject.model.review.ReviewDetailDTO;
import com.finalProject.model.review.ReviewPagingInfo;
import com.finalProject.model.review.ReviewPagingInfoDTO;
import com.finalProject.service.review.ReviewService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/review")
public class RController {

	@Autowired
	private ReviewService service;
	
	// 작성 가능한 리뷰
	@GetMapping("/writableReview")
	public String WritableReview(@RequestParam(defaultValue = "1") int page, HttpServletRequest request, ReviewPagingInfoDTO pagingInfoDTO, Model model) throws Exception {
	    
	    HttpSession session = request.getSession();
	    LoginDTO loginMember = (LoginDTO) session.getAttribute("loginMember");
	    
//	    System.out.println("데이터");
//	    System.out.println(loginMember);

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
	        
//	        System.out.println("C이거 뜨면 로그인 된거임");
//	        System.out.println(writableReviews);
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
//		System.out.println(loginMember);
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
	        
//	        System.out.println("가능 충 데이터 : " + writtenReviews);
//	        System.out.println("C로그인된 회원 ID: " + loginMember.getMember_id());
	        System.out.println("C총 작성한 리뷰 개수: " + totalWrittenReviews);
	    } else {
	        System.out.println("로그인 정보 없음");
	        return "redirect:/member/viewLogin"; // 로그인 정보가 없을 경우 로그인페이지
	    }
	    
	    return "/user/pages/review/review"; // 작성한 리뷰 페이지로 이동
	}
	
//     리뷰 작성 페이지 표시 (GET 요청)
    @GetMapping("/writeReview")
    public String showWriteReviewPage(HttpServletRequest request, Model model, @RequestParam int product_no, @RequestParam String product_name) {
    	
        HttpSession session = request.getSession();
        LoginDTO loginMember = (LoginDTO) session.getAttribute("loginMember");

        if (loginMember != null) {

        	String image_url = service.getImageUrl(product_no);
        	
            model.addAttribute("product_no", product_no);
            model.addAttribute("product_name", product_name);
            model.addAttribute("image_url", image_url);
            model.addAttribute("member_id", loginMember.getMember_id());
            
            return "/user/pages/review/writeReview"; // 리뷰 작성 페이지 반환
        } else {
        	
            return "redirect:/member/viewLogin"; // 로그인 정보가 없을 경우 로그인 페이지로 리다이렉트
        }
    }
    
    // 리뷰 저장
    @PostMapping("/writeReview")
    public ResponseEntity<String> submitReview(HttpServletRequest request, ReviewDTO reviewDTO, PointEarnedDTO pointDTO) {
        HttpSession session = request.getSession();
        LoginDTO loginMember = (LoginDTO) session.getAttribute("loginMember");

        // 로그인 되어있지 않을 때
        if (loginMember == null) {
        	return new ResponseEntity<> ("로그인 되지 않았습니다.", HttpStatus.UNAUTHORIZED);
        }
        
        reviewDTO.setMember_id(loginMember.getMember_id()); // 로그인한 사용자 ID 설정	
        
			try {
				
				service.saveReview(reviewDTO, request, pointDTO);

			    
				return new ResponseEntity<>("리뷰 저장 완료", HttpStatus.OK);
				
			} catch (Exception e) {
				
				e.printStackTrace();
				return new ResponseEntity<>("리뷰 저장 실패", HttpStatus.INTERNAL_SERVER_ERROR);
			}
    }
    
    
    // 리뷰 상세 조회
    @GetMapping("/reviewDetail") 
    	public String reviewDetail (HttpServletRequest request, Model model, @RequestParam int reviewNo ) throws Exception {
        HttpSession session = request.getSession();
        LoginDTO loginMember = (LoginDTO) session.getAttribute("loginMember");
    	
        // 리뷰 기본정보 가져오기
        List<ReviewDetailDTO> reviewDetail = service.getReviewDetail(reviewNo);
        
        // 리뷰 이미지 리스트 가져오기
		List<String> reviewImages = service.getReviewImages(reviewNo);
        
        System.out.println(reviewDetail);
        
        if (loginMember == null) {
        	return "redirect:/member/viewLogin"; // 로그인 정보가 없을 경우 로그인 페이지로 리다이렉트
        }
        
    	if (loginMember != null) {
    		model.addAttribute("reviewImages", reviewImages); // 이미지 리스트를 JSP로 전달
    		model.addAttribute("reviews", reviewDetail);
    	}
    	return "/user/pages/review/reviewDetail";
    }
    

    // 수정페이지 이동
	@GetMapping("/modifyReview")
	public String modifyReviewPage(@RequestParam(value = "reviewNo") int reviewNo, Model model, HttpServletRequest request) throws Exception {
		
        HttpSession session = request.getSession();
        LoginDTO loginMember = (LoginDTO) session.getAttribute("loginMember");
        
        // 리뷰 기본정보 가져오기
        List<ReviewDetailDTO> reviewDetail = service.getReviewDetail(reviewNo);
        
        // 리뷰 이미지 리스트 가져오기
		List<String> reviewImages = service.getReviewImages(reviewNo);
		

		
    	if (loginMember != null) {
    		model.addAttribute("reviewImages", reviewImages);
    		model.addAttribute("reviews", reviewDetail); // 이미지 리스트를 JSP로 전달
    		// model.addAttribute("existFileList", existFileList);
    	}

		return "/user/pages/review/modifyReview";
	}
    
	@GetMapping("/getImgs")
	@ResponseBody
	public ResponseEntity<List<String>> getImgs (@RequestParam (value = "reviewNo") int reviewNo){
		List<String> existFileList = null;
		
		// 리뷰 이미지 리스트 가져오기
		try {
			existFileList = service.getExistFileList(reviewNo);
		} catch (Exception e) {
			
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
		}
		
		return ResponseEntity.ok(existFileList);
	}
	
	
    // 수정 데이터
    @PostMapping("/modifyReview")
    public ResponseEntity<String> modifyReview(
    		@RequestParam("reviewNo") int reviewNo,@RequestParam("reviewTitle") String reviewTitle,
            @RequestParam("reviewContent") String reviewContent,@RequestParam("reviewScore") int reviewScore,
            @RequestParam(value = "files", required = false) MultipartFile[] files,@RequestParam(value = "existFiles", required = false) List<String> existFiles,
            @RequestParam(value = "removedFiles", required = false) List<String> removedFiles, HttpServletRequest request) throws Exception {
    	
        HttpSession session = request.getSession();
        LoginDTO loginMember = (LoginDTO) session.getAttribute("loginMember");

        // 로그인 여부 및 권한 확인
        if (loginMember == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인 후 이용해주세요.");
        }

        // 수정 불가 조건 확인
        if (service.hasAdminReply(reviewNo)) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("관리자 답글이 있는 리뷰는 수정할 수 없습니다.");
        }

        System.out.println("files: " + files);
	    System.out.println("existFiles: " + existFiles);
	    System.out.println("removedFiles: " + removedFiles);
        
        
        
        try {
            // 서비스에 데이터 전달
        	service.modifyReview(reviewNo, reviewTitle, reviewContent, reviewScore);
        	
        	// 리뷰 이미지
        	service.modifyReviewImg(reviewNo, files, existFiles, removedFiles, request);
            return ResponseEntity.ok("수정 성공");
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("수정 실패");
        }
    }
    
    @PostMapping("/deleteReview")
    public ResponseEntity<String> deleteReview(@RequestParam("reviewNo") int reviewNo, HttpServletRequest request) {
        HttpSession session = request.getSession();
        LoginDTO loginMember = (LoginDTO) session.getAttribute("loginMember");
        
        if (loginMember == null) {
        	return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("로그인 후 이용해주세요");
        }
        
        try {
			service.deleteReview(reviewNo, request);
			return ResponseEntity.ok("리뷰 삭제 완료");
			
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("리뷰 삭제 실패");
		}
    	
    }
	
	
}
