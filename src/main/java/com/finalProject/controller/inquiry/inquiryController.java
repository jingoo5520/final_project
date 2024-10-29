package com.finalProject.controller.inquiry;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.finalProject.model.admin.PagingInfoNewDTO;
import com.finalProject.model.inquiry.InquiryDetailDTO;
import com.finalProject.persistence.inquiry.InquiryImgDTO;
import com.finalProject.service.inquiry.InquiryService;
import com.finalProject.util.FileProcess;

@Controller
@RequestMapping("/member/myPage")
public class inquiryController {

	@Inject
	InquiryService iService;

	@Inject
	FileProcess fp;

	// 문의 페이지 이동
	@GetMapping("/inquiries")
	public String inquiryPage(Model model) {
		Map<String, Object> data = new HashMap<String, Object>();

		String memberId = "jingoo5520";

		try {
			data = iService.getInquiryList(new PagingInfoNewDTO(1, 10, 10), memberId);
		} catch (Exception e) {
			e.printStackTrace();
		}

		System.out.println(data);

		model.addAttribute("inquiryData", data);
		return "/user/pages/inquiries";
	}

	// 문의 작성 페이지 이동
	@GetMapping("/writeInquiry")
	public String writeInquiryPage() {

		return "/user/pages/writeInquiry";
	}

	// 문의 작성
	@PostMapping("/writeInquiry")
	public ResponseEntity<String> writeInquiry(@RequestParam("inquiryTitle") String title,
			@RequestParam("inquiryContent") String content, @RequestParam("inquiryType") String type,
			@RequestParam("productNo") String productNo, @RequestParam("files") MultipartFile[] files,
			HttpServletRequest request) {

		System.out.println(title);
		System.out.println(content);
		System.out.println(type);
		System.out.println(productNo);
		System.out.println(files);

		

		List<InquiryImgDTO> imgList = null;
		String memberId = "jingoo5520";

		int newProductNo = 0;

		if (!productNo.equals("null")) {
			newProductNo = Integer.parseInt(productNo);
		}

		InquiryDetailDTO dto = InquiryDetailDTO.builder().inquiry_title(title).inquiry_content(content)
				.inquiry_type(type).product_no(newProductNo).member_id(memberId).build();

		try {
			iService.writeInquiry(dto, files, request);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		

		String result = "";

		return new ResponseEntity<String>(result, HttpStatus.OK);
	}

}
