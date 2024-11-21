package com.finalProject.controller.admin.inquiry;

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
import com.finalProject.model.admin.coupon.PagingInfoNewDTO;
import com.finalProject.model.admin.inquiry.InquiryReplyDTO;
import com.finalProject.model.admin.inquiry.InquirySearchFilterDTO;
import com.finalProject.service.admin.inquiry.AdminInquiryService;

@Controller
@RequestMapping("/admin/inquiry")
public class AdminInquiryController {

	@Inject
	AdminInquiryService aiService;

	// 문의 페이지 이동
	@GetMapping("/adminInquiries")
	public String inquiryPage(Model model, HttpServletRequest request) {
		Map<String, Object> data = new HashMap<String, Object>();

		try {
			data = aiService.getInquiryList(new PagingInfoNewDTO(1, 5, 10));
		} catch (Exception e) {
			e.printStackTrace();
		}

		System.out.println(data);

		model.addAttribute("inquiryData", data);

		return "/admin/pages/inquiry/adminInquiries";
	}

	// 문의 리스트 가져오기
	@GetMapping("/getInquiries")
	@ResponseBody
	public Map<String, Object> getInquiries(@RequestParam int pageNo, @RequestParam int pagingSize,
			@RequestParam int pageCntPerBlock) {
		Map<String, Object> data = new HashMap<String, Object>();

		try {
			data = aiService.getInquiryList(new PagingInfoNewDTO(pageNo, pagingSize, pageCntPerBlock));
		} catch (Exception e) {
			e.printStackTrace();
		}

		return data;
	}

	// 문의 리스트 가져오기
	@PostMapping("/getFilteredInquiries")
	@ResponseBody
	public Map<String, Object> getFilteredInquiries(@ModelAttribute InquirySearchFilterDTO dto) {
		Map<String, Object> data = new HashMap<String, Object>();
		
		try {
			data = aiService.getFilterdInquiryList(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return data;
	}

	// 회원 문의 상세보기 이동
	@GetMapping("/adminInquiryDetail")
	public String inquiryDetailPage(@RequestParam(value = "inquiryNo") int inquiryNo, Model model) {
		Map<String, Object> inquiry = null;

		try {
			inquiry = aiService.getInquiry(inquiryNo);

		} catch (Exception e) {
			e.printStackTrace();
		}

		model.addAttribute("inquiryDetail", inquiry.get("inquiryDetail"));
		model.addAttribute("inquiryImgList", inquiry.get("inquiryImgList"));
		model.addAttribute("inquiryReply", inquiry.get("inquiryReply"));

		return "/admin/pages/inquiry/adminInquiryDetail";
	}

	// 문의 답글 저장, 수정
	@PostMapping("/saveInquiryReply")
	public ResponseEntity<String> saveInquiryReply(@RequestParam("inquiryNo") int inquiryNo,
			@RequestParam("replyContent") String replyContent, @RequestParam("inquiryReplyNo") int inquiryReplyNo,
			HttpServletRequest request) {
		String result = "";

		HttpSession ses = request.getSession();
		LoginDTO loginDTO = (LoginDTO) ses.getAttribute("loginMember");
		String memberId = loginDTO.getMember_id();

		System.out.println("reply: " + inquiryReplyNo);

		InquiryReplyDTO dto = InquiryReplyDTO.builder().inquiry_reply_no(inquiryReplyNo).inquiry_no(inquiryNo)
				.reply_content(replyContent).admin_id(memberId).build();

		System.out.println(dto);

		try {
			aiService.writeInquiryReply(dto);
			result = "success";
		} catch (Exception e) {
			e.printStackTrace();
			result = "fail";
		}

		return new ResponseEntity<String>(result, HttpStatus.OK);
	}

}
