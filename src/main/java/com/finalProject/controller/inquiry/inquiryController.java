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
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.finalProject.model.LoginDTO;
import com.finalProject.model.admin.coupon.PagingInfoNewDTO;
import com.finalProject.model.inquiry.InquiryDetailDTO;
import com.finalProject.model.inquiry.InquiryImgDTO;
import com.finalProject.model.inquiry.InquiryProductDTO;
import com.finalProject.service.inquiry.InquiryService;
import com.finalProject.util.FileProcess;

@Controller
@RequestMapping("/serviceCenter")

public class inquiryController {

	@Inject
	InquiryService iService;

	@Inject
	FileProcess fp;

	// 문의 페이지 이동
	@GetMapping("/inquiries")
	public String inquiryPage(Model model, HttpServletRequest request) {
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
			@RequestParam int pageCntPerBlock, HttpServletRequest request) {
		Map<String, Object> data = new HashMap<String, Object>();

		HttpSession ses = request.getSession();
		LoginDTO loginDTO = (LoginDTO) ses.getAttribute("loginMember");
		String memberId = loginDTO.getMember_id();

		try {
			data = iService.getInquiryList(new PagingInfoNewDTO(pageNo, pagingSize, pageCntPerBlock), memberId);
		} catch (Exception e) {
			e.printStackTrace();
		}

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

}
