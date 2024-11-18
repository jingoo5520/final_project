package com.finalProject.controller.inquiry;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.finalProject.model.LoginDTO;
import com.finalProject.model.admin.coupon.PagingInfoNewDTO;
import com.finalProject.model.admin.notices.NoticeDTO;
import com.finalProject.model.inquiry.InquiryDetailDTO;
import com.finalProject.model.inquiry.InquiryImgDTO;
import com.finalProject.model.inquiry.InquiryProductDTO;
import com.finalProject.service.admin.notices.UserNoticeService;
import com.finalProject.service.inquiry.InquiryService;
import com.finalProject.util.FileProcess;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/serviceCenter")

public class inquiryController {

	@Inject
	InquiryService iService;
	
	@Inject
	UserNoticeService nService;

	@Inject
	FileProcess fp;

	// 문의 페이지 이동
	/*
	 * @RequestMapping("/**") public String errorPage(Model model,
	 * HttpServletRequest request) throws Exception { throw new
	 * Exception("잘못된 경로입니다."); }
	 * 
	 * @ExceptionHandler(Exception.class) public String handleError() { // 예외가 발생하면
	 * warningPage로 포워딩 System.out.println("제발"); return "warningPage"; }
	 */

	@GetMapping("/inquiries")
	public String inquiryPage(Model model, HttpServletRequest request) throws Exception {
		Map<String, Object> data = new HashMap<String, Object>();

		HttpSession ses = request.getSession();
		LoginDTO loginDTO = (LoginDTO) ses.getAttribute("loginMember");
		String memberId = loginDTO.getMember_id();

		try {
			data = iService.getInquiryList(new PagingInfoNewDTO(1, 5, 10), memberId);
		} catch (Exception e) {
			e.printStackTrace();
		}

		System.out.println(data);

		model.addAttribute("inquiryData", data);
		return "/user/pages/inquiry/inquiries";
	}

	// 문의 작성 페이지 이동
	@GetMapping("/writeInquiry")
	public String writeInquiryPage() {

		return "/user/pages/inquiry/writeInquiry";
	}

	// 문의 상세보기 페이지 이동
	@GetMapping("/inquiryDetail")
	public String inquiryDetailPage(@RequestParam(value = "inquiryNo") int inquiryNo, Model model) {
		Map<String, Object> inquiry = null;

		try {
			inquiry = iService.getInquiry(inquiryNo);

		} catch (Exception e) {
			e.printStackTrace();
		}

		System.out.println("inquiry.get(\"inquiryReply\"): " + inquiry.get("inquiryReply"));

		model.addAttribute("inquiryDetail", inquiry.get("inquiryDetail"));
		model.addAttribute("inquiryImgList", inquiry.get("inquiryImgList"));
		model.addAttribute("inquiryReply", inquiry.get("inquiryReply"));

		return "/user/pages/inquiry/inquiryDetail";
	}

	// 문의 수정 페이지 이동
	@GetMapping("/modifyInquiry")
	public String modifyInquiryPage(@RequestParam(value = "inquiryNo") int inquiryNo, Model model) {
		Map<String, Object> inquiry = null;
		ObjectMapper objectMapper = new ObjectMapper();
		String inquiryImgList = "";

		try {
			inquiry = iService.getInquiry(inquiryNo);
			inquiryImgList = objectMapper.writeValueAsString(inquiry.get("inquiryImgList"));
		} catch (Exception e) {
			e.printStackTrace();
		}

		model.addAttribute("inquiryDetail", inquiry.get("inquiryDetail"));
		System.out.println("get " + inquiry.get("inquiryDetail"));

		model.addAttribute("inquiryImgList", inquiryImgList);

		return "/user/pages/inquiry/modifyInquiry";
	}

	// 문의 리스트 가져오기
	@GetMapping("/getInquiries")
	@ResponseBody
	public Map<String, Object> getInquiries(@RequestParam int pageNo, @RequestParam int pagingSize,
			@RequestParam int pageCntPerBlock, HttpServletRequest request) throws Exception {
		Map<String, Object> data = new HashMap<String, Object>();

		HttpSession ses = request.getSession();
		LoginDTO loginDTO = (LoginDTO) ses.getAttribute("loginMember");
		String memberId = loginDTO.getMember_id();

		data = iService.getInquiryList(new PagingInfoNewDTO(pageNo, pagingSize, pageCntPerBlock), memberId);

		return data;
	}

	// 주문 상품 리스트 가져오기
	@GetMapping("/getOrderedProducts")
	@ResponseBody
	public List<InquiryProductDTO> getOrderedProducts(HttpServletRequest request) {
		List<InquiryProductDTO> list = null;

		HttpSession ses = request.getSession();
		LoginDTO loginDTO = (LoginDTO) ses.getAttribute("loginMember");
		String memberId = loginDTO.getMember_id();

		try {
			list = iService.getOrderdProducts(memberId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	// 문의 작성
	@PostMapping("/writeInquiry")
	public ResponseEntity<String> writeInquiry(@RequestParam("inquiryTitle") String title,
			@RequestParam("inquiryContent") String content, @RequestParam("inquiryType") String type,
			@RequestParam("productNo") String productNo, @RequestParam("files") MultipartFile[] files,
			HttpServletRequest request) {

		String result = "";

		List<InquiryImgDTO> imgList = null;
		HttpSession ses = request.getSession();
		LoginDTO loginDTO = (LoginDTO) ses.getAttribute("loginMember");
		String memberId = loginDTO.getMember_id();

		int newProductNo = 0;

		if (!productNo.equals("null")) {
			newProductNo = Integer.parseInt(productNo);
		}

		InquiryDetailDTO dto = InquiryDetailDTO.builder().inquiry_title(title).inquiry_content(content)
				.inquiry_type(type).product_no(newProductNo).member_id(memberId).build();

		try {
			iService.writeInquiry(dto, files, request);
			result = "success";
		} catch (Exception e) {
			e.printStackTrace();
			result = "fail";
		}
		return new ResponseEntity<String>(result, HttpStatus.OK);
	}

	// 문의 삭제
	@PostMapping("/deleteInquiry")
	public ResponseEntity<String> deleteInquiry(@RequestParam("inquiryNo") int inquiryNo, HttpServletRequest request) {
		String result = "fail";

		try {
			if (iService.deleteInquiry(inquiryNo, request) == 1) {
				result = "success";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return new ResponseEntity<String>(result, HttpStatus.OK);
	}

	// 문의 수정
	@PostMapping("/modifyInquiry")
	public ResponseEntity<String> modifyInquiry(@RequestParam("inquiryNo") int inquiryNo,
			@RequestParam("inquiryTitle") String title, @RequestParam("inquiryContent") String content,
			@RequestParam("inquiryType") String type, @RequestParam("productNo") String productNo,
			@RequestParam(value = "files", required = false) MultipartFile[] files,
			@RequestParam(value = "existFiles", required = false) String[] existFiles, HttpServletRequest request) {

		String result = "";

		List<InquiryImgDTO> imgList = null;
		HttpSession ses = request.getSession();
		LoginDTO loginDTO = (LoginDTO) ses.getAttribute("loginMember");
		String memberId = loginDTO.getMember_id();

		int newProductNo = 0;

		if (!productNo.equals("null")) {
			newProductNo = Integer.parseInt(productNo);
		}

		InquiryDetailDTO dto = InquiryDetailDTO.builder().inquiry_no(inquiryNo).inquiry_title(title)
				.inquiry_content(content).inquiry_type(type).product_no(newProductNo).member_id(memberId).build();

		try {
			iService.modifyInquiry(dto, files, existFiles, request);
			result = "success";
		} catch (Exception e) {
			e.printStackTrace();
			result = "fail";
		}
		return new ResponseEntity<String>(result, HttpStatus.OK);
	}
	
    // 공지사항 목록 조회
    @GetMapping("/notices")
    public String showUserNoticePage(@RequestParam(defaultValue = "1") int page,Model model) {
        log.info("공지사항 목록 요청을 처리합니다."); // 요청 로그 추가
        int pagingSize = 10; // 한 페이지에 보여줄 게시글 수
        int startRowIndex = (page - 1) * pagingSize; // 시작 인덱스
        
        // 총 게시글 수 가져오기
        int totalPostCount = 0;
        try {
            totalPostCount = nService.getTotalPostCnt(); // 총 게시글 수 조회
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "총 게시글 리스팅 실패");
        }
        
        int totalPages = (int) Math.ceil((double) totalPostCount / pagingSize); // 총 페이지 수 계산

        // 페이지 유효성 체크
        if (page > totalPages && totalPages > 0) {
            page = totalPages; // 요청한 페이지가 총 페이지 수보다 크면 마지막 페이지로 설정
        }

        List<NoticeDTO> notices = null;
        try {
            notices = nService.getAllNotices(pagingSize, startRowIndex); // 공지사항 조회
            model.addAttribute("notices", notices);
        } catch (Exception e) {
            e.printStackTrace();
            model.addAttribute("error", "공지 목록 리스팅 실패");
        }

        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages); // 총 페이지 수 추가
        model.addAttribute("pagingSize", pagingSize);
        model.addAttribute("totalPostCount", totalPostCount); // 총 게시글 수 추가

        return "/user/pages/notices/serviceCenterNotice"; // JSP 파일 경로
    }

    // 공지사항 상세 조회
    @GetMapping("/userViewNoticeDetail/{noticeNo}")
    public String getNoticeDetail(@PathVariable("noticeNo") int noticeNo, Model model) {
        NoticeDTO notices;
		try {
			notices = nService.getNoticeDetail(noticeNo);
			model.addAttribute("notices", notices);
			return "user/pages/notices/serviceCenterNoticeDetail";
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("error", "상세 조회 실패");
			return "errorPage";
		}
    }
   
}
